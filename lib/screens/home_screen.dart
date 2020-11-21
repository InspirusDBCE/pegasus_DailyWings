// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_app/screens/chat_screen.dart';
import 'package:first_app/screens/user_screen.dart';
import 'package:first_app/screens/WorkerPost.dart';

// void main() => runApp(NavDrawerExample());

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const drawerHeader = UserAccountsDrawerHeader(
    //   accountName: Text('User Name'),
    //   accountEmail: Text('user.name@email.com'),

    // final drawerItems = ListView(
    //   children: <Widget>[
    //     drawerHeader,
    //     ListTile(title: const Text('To page 1'),
    //         // onTap: () => Navigator.of(context).push(_NewPage(1)),
    //         ),
    //     ListTile(title: const Text('To page 2'),
    //         // onTap: () => Navigator.of(context).push(_NewPage(2)),
    //         ),
    //     ListTile(
    //       title: const Text('other drawer item'),
    //       // onTap: () {},
    //     ),
    //   ],
    // );

    return MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF3E3758)),
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xFF796A92),
                  title: Text('Daily Wings'),
                  bottom: TabBar(
                    tabs: [
                      Tab(text: "Employer"),
                      Tab(text: "Worker"),
                      Tab(text: "Chats")
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    UserPage(),
                    WorkersPage(),
                    ChatScreen(),
                  ],
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'name of user',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        decoration: BoxDecoration(color: Color(0xFF8998BF)),
                      ),
                      ListTile(title: Text('Emaiid : ')),
                      ListTile(title: Text('Phone no. : ')),
                      ListTile(title: Text('Address : ')),
                      IconButton(
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          FirebaseAuth.instance.signOut();
                        },
                      ),
                    ],
                  ),
                ))));
  }
}
