import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/roundedButton.dart';

class WorkersPage extends StatefulWidget {
  @override
  _WorkersPageState createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  List<Posts> postsList = [];
  final databaseReference = Firestore.instance;

  getPosts() async {
    QuerySnapshot qn =
        await databaseReference.collection("Complaints").getDocuments();
    qn.documents.forEach((element) {
      print(element.data);
      print(element.documentID);
      Posts posts = new Posts(
          element.documentID,
          element.data['jobName'],
          element.data['date'],
          element.data['location'],
          element.data['time'],
          element.data['jobDescription'],
          element.data['status']);
      postsList.add(posts);
    });
    setState(() {});
    print(postsList.length);
  }

  updateStatus(id) {
    databaseReference
        .collection('Complaints')
        .document(id)
        .updateData({'status': 'Work Assigned'});
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xFF049560),
        body: Container(
            //color: Color(0xFF4E3758),
            child:
                /*  postsList.length == 0
                ? new Text("No events")
                : new  */
                ListView.builder(
                    itemCount: postsList.length,
                    itemBuilder: (_, index) {
                      return Doc(
                          postsList[index].id,
                          postsList[index].jobName,
                          postsList[index].date,
                          postsList[index].location,
                          postsList[index].time,
                          postsList[index].jobDescription,
                          postsList[index].status);
                    })));
  }
}

//posts class

class Posts {
  String jobName, date, location, time, jobDescription, status;
  String id;
  Posts(this.id, this.jobName, this.date, this.location, this.time,
      this.jobDescription, this.status);
}

//Card Widget to display the Event set by user as a post to the rest of the users

Widget Doc(String id, String jobName, String date, String location, String time,
    String jobDescription, String status) {
  print(id);
  return Card(
      margin: EdgeInsets.all(20.0),
      elevation: 10.0,
      color: Color(0xFF796A92),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
              child: Row(
                children: <Widget>[
                  Icon(Icons.bookmark_border, color: Colors.white)
                ],
              ),
            ),
            Text(
              jobName ?? 'Description',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Date: ' + date ?? 'Description',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Location: ' + location ?? 'Description',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Time: ' + time ?? 'Description',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Job Description: ' + jobDescription ?? 'Description',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 10.0,
            ),
            RoundedButton(
              title: 'Take Up Task',
              colur: Color(0xFF4E3758),
              onPressed: () {
                Firestore.instance
                    .collection('Complaints')
                    .document(id)
                    .updateData({'status': 'Work Assigned'});
              },
            )
          ],
        ),
      ));
}
