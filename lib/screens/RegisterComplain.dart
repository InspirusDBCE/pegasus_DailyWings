import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/roundedButton.dart';
import '../components/constants.dart';
//import 'package:firebase_database/firebase_database.dart';

class RegisterComplaint extends StatefulWidget {
  @override
  _RegisterComplaintState createState() => _RegisterComplaintState();
}

class _RegisterComplaintState extends State<RegisterComplaint> {
  String jobName;
  String date;
  String location;
  String time;
  String jobDescription;
  String status;

  saveToDatabase() async {
    status='Registered Work';
    final databaseReference = Firestore.instance;
    DocumentReference ref = await databaseReference.collection("Complaints").add({
      "jobName": jobName,
      "date": date,
      "location": location,
      "time": time,
      "jobDescription": jobDescription,
      "status": status
    });
    print(ref.documentID);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF4E3758),
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF3E3758),
        //title: Text('Register Complaint'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  color: Color(0xFF796A92),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 100.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Register Your Work',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),),
                              ),
                            ),
                            TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  jobName = value;
                                },
                                decoration: constant_textfield.copyWith(
                                    hintText: 'Job Name')),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  date = value;
                                },
                                decoration: constant_textfield.copyWith(
                                    hintText: 'Date')),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  location = value;
                                },
                                decoration: constant_textfield.copyWith(
                                    hintText: 'Location')),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  time = value;
                                },
                                decoration: constant_textfield.copyWith(
                                    hintText: 'Time')),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  jobDescription = value;
                                },
                                decoration: constant_textfield.copyWith(
                                    hintText: 'Job Description')),
                            SizedBox(
                              height: 20.0,
                            ),
                            RoundedButton(
                              title: 'POST',
                              colur: Color(0xFF4E3758),
                              onPressed: saveToDatabase,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
