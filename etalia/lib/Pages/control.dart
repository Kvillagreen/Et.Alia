// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, duplicate_ignore, duplicate_ignore, unused_local_variable, sort_child_properties_last, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Services/back_service.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

// ignore: must_be_immutable
String endText = 'Start Service';
// value of the constant elevation and height
double elev = 2.0;
const double ht = 10.0;

double Water_value = 0;

double Fertilizer_value = 0;

class UserControl extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _UserControl createState() => _UserControl();
}

class _UserControl extends State<UserControl> {
  final ref = FirebaseDatabase.instance.ref(Uid);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'Loading..',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          );
        } else {
          Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
          Fertilizer_value = map['FertilizeTime'].toDouble() ?? 0.0;
          Water_value = map['WateringTime'].toDouble() ?? 0.0;
        }
        return ListView(
          children: <Widget>[
            // ignore: avoid_unnecessary_containers
            Container(
              child: Data_Control(),
            ),
          ],
        );
      },
    );
  }
}

class Data_Control extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _Data_Control createState() => _Data_Control();
}

// ignore: camel_case_types
class _Data_Control extends State<Data_Control> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        heightFactor: 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: ht),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              elevation: elev,
              shadowColor: Colors.black54,
              color: Color.fromARGB(255, 0, 150, 108),
              child: Center(
                heightFactor: 2,
                widthFactor: MediaQuery.of(context).size.width * 0.0175,
                child: Text(
                  'Control:',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color.fromARGB(255, 0, 150, 108),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        left: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: Text(
                        'Watering:',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: elev,
                          shape: const CircleBorder(),
                          backgroundColor: Color.fromARGB(255, 12, 77, 39)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.25,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Icon(
                          Ionicons.water,
                          size: MediaQuery.of(context).size.width * 0.15,
                        ),
                      ),
                      onPressed: () {
                        final ref = FirebaseDatabase.instance.ref(Uid);
                        if (Water_value > 0) {
                          flutterLocalNotificationsPlugin.show(
                              10,
                              "Greenery",
                              "Watering crops for $Water_value Seconds",
                              NotificationDetails(
                                  android: AndroidNotificationDetails(
                                      channel.id, channel.name,
                                      channelDescription:
                                          'Greenery Notification',
                                      importance: Importance.high,
                                      color: Colors.blue,
                                      playSound: true,
                                      icon: '@mipmap/ic_launcher')));
                          FirebaseDatabase.instance.ref().child(Uid).update(
                            {"WateringTime": Water_value},
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: ht,
                    ),
                    Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.075,
                          ),
                          Text('Time: ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center),
                          Center(
                            child: Slider(
                              min: 0,
                              max: 10,
                              value: Water_value,
                              divisions: 5,
                              label: '$Water_value Seconds',
                              inactiveColor: Colors.white,
                              secondaryActiveColor: Colors.black,
                              thumbColor: Color.fromARGB(255, 5, 95, 70),
                              activeColor: Color.fromARGB(255, 5, 95, 70),
                              onChanged: (value) {
                                setState(() {
                                  Water_value = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color.fromARGB(255, 0, 150, 108),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        left: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: Text(
                        'Fertilize:',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: elev,
                          shape: const CircleBorder(),
                          backgroundColor: Color.fromARGB(255, 12, 77, 39)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.25,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Icon(
                          Ionicons.bag_remove,
                          size: MediaQuery.of(context).size.width * 0.15,
                        ),
                      ),
                      onPressed: () {
                        final ref = FirebaseDatabase.instance.ref(Uid);
                        if (Fertilizer_value > 0 ) {
                          flutterLocalNotificationsPlugin.show(
                              10,
                              "Greenery",
                              "Fertilizing crops for $Fertilizer_value Seconds",
                              NotificationDetails(
                                  android: AndroidNotificationDetails(
                                      channel.id, channel.name,
                                      channelDescription:
                                          'Greenery Notification',
                                      importance: Importance.high,
                                      color: Colors.blue,
                                      playSound: true,
                                      icon: '@mipmap/ic_launcher')));
                          FirebaseDatabase.instance.ref().child(Uid).update(
                            {"FertilizeTime": Fertilizer_value},
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: ht,
                    ),
                    Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.075,
                          ),
                          Text('Time: ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center),
                          Center(
                            child: Slider(
                              min: 0,
                              max: 10,
                              value: Fertilizer_value,
                              divisions: 5,
                              label: '$Fertilizer_value Seconds',
                              inactiveColor: Colors.white,
                              secondaryActiveColor: Colors.black,
                              thumbColor: Color.fromARGB(255, 5, 95, 70),
                              activeColor: Color.fromARGB(255, 5, 95, 70),
                              onChanged: (value) {
                                setState(() {
                                  Fertilizer_value = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
