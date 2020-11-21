//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:first_app/screens/RegisterComplain.dart';
import 'package:first_app/screens/WorkerPost.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Posts> postsList = [];
  final databaseReference = Firestore.instance;

  Future getPosts() async {
    QuerySnapshot qn =
        await databaseReference.collection("Complaints").getDocuments();
    qn.documents.forEach((element) {
      print(element.data);
      Posts posts = new Posts(
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

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          //color: Color(0xFF4E3758),
          child: ListView.builder(
              itemCount: postsList.length,
              itemBuilder: (_, index) {
                return Doc(
                    postsList[index].jobName,
                    postsList[index].date,
                    postsList[index].location,
                    postsList[index].time,
                    postsList[index].jobDescription,
                    postsList[index].status);
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF8998BF),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return RegisterComplaint();
          }));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Posts {
  String jobName, date, location, time, jobDescription, status;
  Posts(this.jobName, this.date, this.location, this.time, this.jobDescription,
      this.status);
}

//Card Widget to display the Event set by user as a post to the rest of the users

Widget Doc(String jobName, String date, String location, String time,
    String jobDescription, String status) {
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
                  Icon(Icons.arrow_forward_ios, color: Colors.white)
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
            Text(
              'Status: ' + status ?? 'Description',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ));
}
