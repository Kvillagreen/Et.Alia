// ignore_for_file: prefer_const_constructors, duplicate_ignore, sort_child_properties_last, unused_import, prefer_final_fields, prefer_const_literals_to_create_immutables
import 'dart:developer';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'monitor.dart';
import 'aboutus.dart';
import 'control.dart';
import 'schedule.dart';
import 'more.dart';
import 'prototype.dart';
import '../main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../Services/back_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String? categoryValue;
int notify = 1;
int rev = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigatorBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    UserMonitor(), // monitor
    UserSchedule(), // schedule
    UserControl(), // control   // connection
    Developer(), // about us
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void updateUI() {
    setState(() {
      final service = FlutterBackgroundService();
      if (notify == 0) {
        notify = 1;
        initializeService();
        flutterLocalNotificationsPlugin.show(
            9,
            "Greenery",
            "Background service is turned on",
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: 'Greenery Notification',
                    importance: Importance.high,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher')));
      } else {
        notify = 0;
        service.invoke('stopService');
        flutterLocalNotificationsPlugin.show(
            9,
            "Greenery",
            "Background service is turned off",
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: 'Greenery Notification',
                    importance: Importance.high,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher')));
      }
      rev = notify;
    });
  }

  final ref = FirebaseDatabase.instance.ref(Uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: Color.fromARGB(255, 2, 138, 93),
        leading: Builder(
          builder: (context) => IconButton(
            padding: EdgeInsets.only(bottom: 5),
            iconSize: MediaQuery.of(context).size.height * 0.06,
            icon: Icon(Ionicons.menu_outline),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Greenery',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            enableFeedback: false,
            tooltip: '',
            color: Color.fromARGB(255, 2, 107, 72),
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (choice) => choiceAction(choice, context),
            itemBuilder: (BuildContext context) {
              return Constants.choices.map(
                (String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ).toList();
            },
          )
        ],
      ),
      drawer: Drawer(
        key: _scaffoldKey,
        semanticLabel: 'Greenery',
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 9, 168, 115),
        width: MediaQuery.of(context).size.width * 0.75,
        child:
            ListView(physics: const NeverScrollableScrollPhysics(), children: [
          Material(
            borderOnForeground: false,
            animationDuration: Duration(seconds: 6),
            surfaceTintColor: Color.fromARGB(255, 6, 114, 78),
            child: Container(
              color: Color.fromARGB(255, 6, 114, 78),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Center(
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.1,
                  backgroundColor: Colors.white.withOpacity(0),
                  foregroundColor: Colors.white.withOpacity(0),
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'History',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: Text(
              '\tNitrogen Value: ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Daily 3',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.35),
          /*
          Container(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
            // ignore: duplicate_ignore, duplicate_ignore
            child: ElevatedButton(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.20,
                child: Center(
                  child: const Text(
                    'LogOut',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              onPressed: () async {
                final service = FlutterBackgroundService();
                service.invoke('stopService');
                await Firebase.initializeApp();
                DatabaseReference ref = FirebaseDatabase.instance.ref('checker');
                DatabaseEvent event = await ref.once();
                FirebaseDatabase.instance.ref().child(Uid).update(
                  {"Notifier": false},
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirstApp(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 34, 139, 34),
                onPrimary: Color.fromARGB(255, 53, 94, 59),
                shadowColor: Color.fromARGB(255, 22, 29, 13),
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
          */
        ]),
      ),
      body: _pages[_selectedIndex],
      backgroundColor: Color.fromARGB(255, 30, 189, 136),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 2, 138, 93),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        selectedIconTheme: IconThemeData(
          color: Colors.white,
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.white54,
        ),
        currentIndex: _selectedIndex,
        onTap: _navigatorBar,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            activeIcon: Icon(Ionicons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.calendar_number_outline),
            activeIcon: Icon(Ionicons.calendar_number),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.game_controller_outline),
            activeIcon: Icon(Ionicons.game_controller),
            label: 'Control',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.people_outline),
            activeIcon: Icon(Ionicons.people),
            label: 'About Us',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 2, 138, 93),
        onPressed: () async {
          updateUI();
        },
        child: (notify == 0 ? Icon(Ionicons.play) : Icon(Ionicons.stop)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class Constants {
  static const String Prototype = 'Prototype';
  static const String More = 'More';

  static const List<String> choices = <String>[
    Prototype,
    More,
  ];
}

void choiceAction(String choice, BuildContext context) {
  if (choice == Constants.Prototype) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Prototype()),
    );
  } else if (choice == Constants.More) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const More()),
    );
  }
}
