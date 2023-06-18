// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, duplicate_ignore, duplicate_ignore, unused_local_variable, must_be_immutable, prefer_const_literals_to_create_immutables, non_constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:weekday_selector/weekday_selector.dart';
import '../Services/back_service.dart';


// value of the constant elevation and height
double elev = 2.0;
const double ht = 10.0;
List <String> noneWeek=['','','','','','',''];
// for fertilizer
bool isInstructionViewFert = true;
bool checkerFert = false;
List<bool> valuesFert = [false, false, false, false, false, false, false];
String TimeFert = "";
// for fertilizer
bool isInstructionViewWat = true;
bool checkerWat = false;
List<bool> valuesWat = [false, false, false, false, false, false, false];
String TimeWat = "";
int num = 0;
bool mon = false,
    tue = false,
    wed = false,
    thur = false,
    fri = false,
    sat = false,
    sun = false;
String TimeWatFin = '';
String TimeFertFin = '';
bool? timefert;

class UserSchedule extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _UserSchedule createState() => _UserSchedule();
}

class _UserSchedule extends State<UserSchedule> {
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
          final data = snapshot.data?.snapshot.value as Map;
          isInstructionViewFert = data['FertilizerButton'] ?? false;
          isInstructionViewWat = data['WateringButton'] ?? false;
          TimeWat = data['TimeWat'] ?? '';
          TimeFert = data['TimeFert'] ?? '';

          if (isInstructionViewFert == true) {
            final valuesFert = <bool>[
              false,
              false,
              false,
              false,
              false,
              false,
              false
            ];
          }
          if (isInstructionViewWat == true) {
            final valuesWat = <bool>[
              false,
              false,
              false,
              false,
              false,
              false,
              false
            ];
          }
          return ListView(
            children: <Widget>[
              // ignore: avoid_unnecessary_containers
              Container(
                child: Data_Schedule(),
              ),
            ],
          );
        }
      },
    );
  }
}

final timeControllerFert = TextEditingController();
final timeControllerWat = TextEditingController();

// ignore: camel_case_types
class Data_Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        heightFactor: 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /* 
            
            Fertilization
            
            
            
            
            
            
            */
            const SizedBox(height: ht),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              elevation: elev,
              shadowColor: Colors.black54,
              color: (isInstructionViewFert == true
                  ? Color.fromARGB(255, 29, 124, 97)
                  : Color.fromARGB(255, 0, 150, 108)),
              child: Center(
                heightFactor: 2,
                widthFactor: MediaQuery.of(context).size.width * 0.0175,
                child: Text(
                  'Fertilization:',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
            const SizedBox(height: ht),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              elevation: elev,
              shadowColor: Colors.black54,
              color: (isInstructionViewFert == true
                  ? Color.fromARGB(255, 29, 124, 97)
                  : Color.fromARGB(255, 0, 150, 108)),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Column(
                      children: <Widget>[
                        IntrinsicWidth(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.65,
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05),
                                alignment: Alignment.topLeft,
                                child: Text('Schedule:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: (isInstructionViewFert == true
                                            ? Colors.black
                                            : Colors.white),
                                        fontWeight: FontWeight.w100),
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.01),
                                width: MediaQuery.of(context).size.width * 0.25,
                                alignment: Alignment.centerRight,
                                child: Switch(
                                  value: checkerFert,
                                  activeTrackColor:
                                      Color.fromARGB(255, 0, 120, 100),
                                  activeColor: Colors.white70,
                                  inactiveThumbColor: Colors.white10,
                                  inactiveTrackColor: Colors.black54,
                                  onChanged: (value) {
                                    final ref =
                                        FirebaseDatabase.instance.ref(Uid);
                                    if (checkerFert == true) {
                                      checkerFert = false;
                                      isInstructionViewFert = true;
                                    } else {
                                      checkerFert = true;
                                      isInstructionViewFert = false;
                                    }
                                    FirebaseDatabase.instance
                                        .ref()
                                        .child(Uid)
                                        .update(
                                      {
                                        "FertilizerButton":
                                            isInstructionViewFert
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: ht),
                        AbsorbPointer(
                          absorbing: isInstructionViewFert,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.015,
                              right: MediaQuery.of(context).size.height * 0.015,
                            ),
                            child: Center(
                              child: TextField(
                                cursorColor: Colors.white,
                                readOnly: true,
                                style: TextStyle(
                                    color: (isInstructionViewFert == true
                                        ? Colors.black
                                        : Colors.white)),
                                controller: timeControllerFert,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: (isInstructionViewFert == true
                                            ? Colors.black
                                            : Colors.white)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: (isInstructionViewFert == true
                                            ? Colors.black
                                            : Colors.white)),
                                  ),
                                  label: Text('Set: $TimeFert'),
                                  hintText: 'Set: $TimeFert',
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: (isInstructionViewFert == true
                                          ? Colors.black
                                          : Colors.white)),
                                  hintStyle: TextStyle(
                                      color: (isInstructionViewFert == true
                                          ? Colors.black
                                          : Colors.white)),
                                ),
                                onTap: () async {
                                  var time = await showTimePicker(
                                      useRootNavigator: false,
                                      context: context,
                                      initialTime: TimeOfDay.now());
                                  if (time != null) {
                                    FirebaseDatabase.instance.ref(Uid);
                                    TimeFert = time.format(context);
                                    timeControllerFert.text = "Set: $TimeFert";
                                    FirebaseDatabase.instance
                                        .ref()
                                        .child(Uid)
                                        .update({"TimeFert": TimeFert});
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: ht * 2),
                        AbsorbPointer(
                          absorbing: isInstructionViewFert,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.015,
                              right: MediaQuery.of(context).size.height * 0.015,
                            ),
                            child: WeekdaySelector(
                              color: Colors.white,
                              selectedFillColor: (isInstructionViewFert == true
                                  ? Color.fromARGB(255, 56, 105, 65)
                                  : Color.fromARGB(255, 5, 78, 57)),
                              fillColor: (isInstructionViewFert == true
                                  ? Color.fromARGB(255, 33, 61, 45)
                                  : Color.fromARGB(255, 13, 141, 105)),
                              onChanged: (int v) {
                                print(v);
                                final ref =
                                    FirebaseDatabase.instance.ref(Uid);
                                if (valuesFert[v % 7] == false) {
                                  valuesFert[v % 7] = true;
                                } else {
                                  valuesFert[v % 7] = false;
                                }
                                FirebaseDatabase.instance
                                    .ref()
                                    .child(Uid)
                                    .update({"dayValueFert": valuesFert});
                              },
                              selectedElevation: 1,
                              elevation: 1,
                              disabledElevation: 0,
                              values: valuesFert,
                            ),
                          ),
                        ),
                        const SizedBox(height: ht),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /* 
            
            Wateringgg
            
            
            
            
            
            
            */
            const SizedBox(height: ht),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              elevation: elev,
              shadowColor: Colors.black54,
              color: (isInstructionViewWat == true
                  ? Color.fromARGB(255, 29, 124, 97)
                  : Color.fromARGB(255, 0, 150, 108)),
              child: Center(
                heightFactor: 2,
                widthFactor: MediaQuery.of(context).size.width * 0.0175,
                child: Text(
                  'Watering:',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
            const SizedBox(height: ht),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              elevation: elev,
              shadowColor: Colors.black54,
              color: (isInstructionViewWat == true
                  ? Color.fromARGB(255, 29, 124, 97)
                  : Color.fromARGB(255, 0, 150, 108)),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Column(
                      children: <Widget>[
                        IntrinsicWidth(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.65,
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05),
                                alignment: Alignment.topLeft,
                                child: Text('Schedule:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: (isInstructionViewWat == true
                                            ? Colors.black
                                            : Colors.white),
                                        fontWeight: FontWeight.w100),
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.01),
                                width: MediaQuery.of(context).size.width * 0.25,
                                alignment: Alignment.centerRight,
                                child: Switch(
                                  value: checkerWat,
                                  activeTrackColor:
                                      Color.fromARGB(255, 0, 120, 100),
                                  activeColor: Colors.white70,
                                  inactiveThumbColor: Colors.white10,
                                  inactiveTrackColor: Colors.black54,
                                  onChanged: (value) {
                                    final ref =
                                        FirebaseDatabase.instance.ref(Uid);
                                    if (checkerWat == true) {
                                      checkerWat = false;
                                      isInstructionViewWat = true;
                                    } else {
                                      checkerWat = true;
                                      isInstructionViewWat = false;
                                    }
                                    FirebaseDatabase.instance
                                        .ref()
                                        .child(Uid)
                                        .update(
                                      {"WateringButton": isInstructionViewWat},
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: ht),
                        AbsorbPointer(
                          absorbing: isInstructionViewWat,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.015,
                              right: MediaQuery.of(context).size.height * 0.015,
                            ),
                            child: Center(
                              child: TextField(
                                cursorColor: Colors.white,
                                readOnly: true,
                                style: TextStyle(
                                    color: (isInstructionViewWat == true
                                            ? Colors.black
                                            : Colors.white)),
                                controller: timeControllerWat,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: (isInstructionViewWat == true
                                            ? Colors.black
                                            : Colors.white)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: (isInstructionViewWat == true
                                            ? Colors.black
                                            : Colors.white)),
                                  ),
                                  label: Text('Set: $TimeWat'),
                                  hintText: 'Set: $TimeWat',
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: (isInstructionViewWat == true
                                          ? Colors.black
                                          : Colors.white)),
                                  hintStyle: TextStyle(
                                      color: (isInstructionViewWat == true
                                          ? Colors.black
                                          : Colors.white)),
                                ),
                                onTap: () async {
                                  var time = await showTimePicker(
                                      useRootNavigator: false,
                                      context: context,
                                      initialTime: TimeOfDay.now());
                                  if (time != null) {
                                    FirebaseDatabase.instance.ref(Uid);
                                    TimeWat = time.format(context);
                                    timeControllerWat.text = 'Set: $TimeWat';
                                    FirebaseDatabase.instance
                                        .ref()
                                        .child(Uid)
                                        .update({"TimeWat": TimeWat});
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: ht * 2),
                        AbsorbPointer(
                          absorbing: isInstructionViewWat,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.015,
                              right: MediaQuery.of(context).size.height * 0.015,
                            ),
                            child: WeekdaySelector(
                              color: Colors.white,
                              selectedFillColor: (isInstructionViewWat == true
                                  ? Color.fromARGB(255, 56, 105, 65)
                                  : Color.fromARGB(255, 5, 78, 57)),
                              fillColor: (isInstructionViewWat == true
                                  ? Color.fromARGB(255, 33, 61, 45)
                                  : Color.fromARGB(255, 13, 141, 105)),
                              onChanged: (int v) {
                                final ref =
                                    FirebaseDatabase.instance.ref(Uid);
                                if (valuesWat[v % 7] == false) {
                                  valuesWat[v % 7] = true;
                                } else {
                                  valuesWat[v % 7] = false;
                                }
                                FirebaseDatabase.instance
                                    .ref()
                                    .child(Uid)
                                    .update({"dayValueWat": valuesWat});
                              },
                              selectedElevation: 1,
                              elevation: 1,
                              disabledElevation: 0,
                              values: valuesWat,
                            ),
                          ),
                        ),
                        const SizedBox(height: ht),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
