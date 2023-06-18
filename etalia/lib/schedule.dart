// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserSchedule extends StatefulWidget {
  @override
  _UserSchedule createState() => _UserSchedule();
}

class _UserSchedule extends State<UserSchedule> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text(
              "Loading",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListView(
              children: <Widget>[
                GridView.count(
                  crossAxisCount: 3,
                  physics:
                      NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                  shrinkWrap: true, // You won't see infinite size error
                  children: <Widget>[
                    Container(
                      height: 24,
                      color: Colors.green,
                    ),
                    Container(
                      height: 24,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
