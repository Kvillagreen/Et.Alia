// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, duplicate_ignore, duplicate_ignore, non_constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Services/back_service.dart';
import 'package:ionicons/ionicons.dart';

// ignore: must_be_immutable
// values of the soil nutrients
var nitrogenNum;
var potassiumNum;
var phosphorusNum;
var moistureNum;

var nitrogenVal = 0;
var potassiumVal = 0;
var phosphorusVal = 0;
var moistureVal = 0;
// ignore: non_constant_identifier_names
// ignore: non_constant_identifier_names
String Date = "";
String Time = "";

String Accnt = "";
// value of the constant elevation and height
double elev = 2.0;
const double ht = 7.0;
const double rd = 25;
bool notifier = false;

class UserMonitor extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _UserMonitor createState() => _UserMonitor();
}

class _UserMonitor extends State<UserMonitor> {
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

          nitrogenNum = map['NitrogenNum'] ?? '';
          potassiumNum = map['PotassiumNum'] ?? '';
          phosphorusNum = map['PhosphorusNum'] ?? '';
          moistureNum = map['MoistureNum'] ?? '';

          Date = map['Dates'] ?? '';
          Time = map['Time'] ?? '';

          nitrogenVal = (nitrogenNum ~/ 2);
          potassiumVal = (potassiumNum ~/ 2);
          phosphorusVal = (phosphorusNum ~/ 2);
          moistureVal = (moistureNum ~/ 2);
        }
        return ListView(
          children: <Widget>[
            // ignore: avoid_unnecessary_containers
            Container(
              child: Data_Monitor(),
            ),
          ],
        );
      },
    );
  }
}

class Nitrogen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      color: Color.fromARGB(255, 0, 150, 108),
      child: Center(
        child: CircularPercentIndicator(
          animateFromLastPercent: true,
          radius: MediaQuery.of(context).size.height * 0.13,
          lineWidth: MediaQuery.of(context).size.height * 0.03,
          animation: true,
          animationDuration: 2500,
          percent: nitrogenNum / 100,
          linearGradient: LinearGradient(
            colors: const [
              Color(0xFF9e4843),
              Color(0xFFca5953),
              Color(0xFFe4857c),
              Color(0xFFd99088),
            ],
          ),
          center: Text("Nitrogen: \n$nitrogenNum%",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class Phosphorus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      color: Color.fromARGB(255, 0, 150, 108),
      child: Center(
        child: CircularPercentIndicator(
          animateFromLastPercent: true,
          radius: MediaQuery.of(context).size.height * 0.13,
          lineWidth: MediaQuery.of(context).size.height * 0.03,
          animation: true,
          animationDuration: 2500,
          percent: phosphorusNum / 100,
          linearGradient: LinearGradient(
            colors: const [
              Color(0xFF26733c),
              Color(0xFF2a9c4f),
              Color(0xFF2a9c4f),
              Color(0xFF77c285),
            ],
          ),
          center: Text("Phosphorus: \n$phosphorusNum%",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class Potassium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      color: Color.fromARGB(255, 0, 150, 108),
      child: Center(
        child: CircularPercentIndicator(
          animateFromLastPercent: true,
          radius: MediaQuery.of(context).size.height * 0.13,
          lineWidth: MediaQuery.of(context).size.height * 0.03,
          animation: true,
          animationDuration: 2500,
          percent: potassiumNum / 100,
          linearGradient: LinearGradient(
            colors: const [
              Color.fromARGB(255, 240, 197, 58),
              Color.fromARGB(255, 238, 191, 49),
              Color.fromARGB(255, 226, 207, 66),
              Color(0xFFffff91),
            ],
          ),
          center: Text("Potassium: \n$potassiumNum%",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class Moisture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      color: Color.fromARGB(255, 0, 150, 108),
      child: Center(
        child: CircularPercentIndicator(
          animateFromLastPercent: true,
          linearGradient: LinearGradient(
            colors: const [
              Color.fromARGB(255, 19, 153, 206),
              Color.fromARGB(255, 9, 167, 230),
              Color.fromARGB(255, 90, 183, 219),
              Color.fromARGB(255, 113, 192, 223),
            ],
          ),
          radius: MediaQuery.of(context).size.height * 0.13,
          lineWidth: MediaQuery.of(context).size.height * 0.03,
          animation: true,
          animationDuration: 2500,
          percent: moistureNum / 100,
          center: Text("Moisture: \n$moistureNum%",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class Data_Monitor extends StatelessWidget {
  final List<Widget> nutrients = [
    Nitrogen(),
    Phosphorus(),
    Potassium(),
    Moisture(),
  ];

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
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: elev,
              shadowColor: Colors.black54,
              color: Color.fromARGB(255, 0, 150, 108),
              child: ListTile(
                dense: true,
                visualDensity: VisualDensity(vertical: -3),
                title: Text('Realtime Data: ',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                    textAlign: TextAlign.center),
                subtitle: Text('as of $Time',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                    textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(
              height: ht,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  height: MediaQuery.of(context).size.height * 0.350,
                ),
                itemCount: 4,
                itemBuilder: (context, index, realIndex) {
                  final nutrient = nutrients[index];
                  return nutrient;
                },
              ),
            ),
            const SizedBox(
              height: ht,
            ),
            Row(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  elevation: elev,
                  shadowColor: Colors.black54,
                  color: Color.fromARGB(255, 9, 167, 230),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: const [
                          Color(0xFF9e4843),
                          Color(0xFFca5953),
                          Color(0xFFe4857c),
                          Color(0xFFd99088),
                        ],
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.435,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        CircleAvatar(
                            radius: rd,
                            backgroundColor: Colors.white,
                            child: Text('N',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.035,
                                  color: Color(0xFF9e4843),
                                ),
                                textAlign: TextAlign.center)
                            /*backgroundImage: AssetImage(
                              "assets/images/potassium.jpg"), // No matter how big it is, it won't overflow
                        */
                            ),
                        Text(
                          'Nitrogen',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Value: $nitrogenVal Kg/L',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.025,
                ),
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  elevation: elev,
                  shadowColor: Colors.black54,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: const [
                          Color(0xFF26733c),
                          Color(0xFF2a9c4f),
                          Color(0xFF2a9c4f),
                          Color(0xFF77c285),
                        ],
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.435,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        CircleAvatar(
                            radius: rd,
                            backgroundColor: Colors.white,
                            child: Text('P',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.035,
                                  color: Color(0xFF26733c),
                                ),
                                textAlign: TextAlign.center)
                            /*backgroundImage: AssetImage(
                              "assets/images/potassium.jpg"), // No matter how big it is, it won't overflow
                        */
                            ),
                        Text(
                          'Phosphorus',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Value: $phosphorusVal Kg/L',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: ht,
            ),
            Row(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  elevation: elev,
                  shadowColor: Colors.black54,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: const [
                          Color.fromARGB(255, 240, 197, 58),
                          Color.fromARGB(255, 238, 191, 49),
                          Color.fromARGB(255, 226, 207, 66),
                          Color(0xFFffff91),
                        ],
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.435,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        CircleAvatar(
                            radius: rd,
                            backgroundColor: Colors.white,
                            child: Text('K',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.035,
                                  color: Color.fromARGB(255, 240, 197, 58),
                                ),
                                textAlign: TextAlign.center)
                            /*backgroundImage: AssetImage(
                              "assets/images/potassium.jpg"), // No matter how big it is, it won't overflow
                        */
                            ),
                        Text(
                          'Potassium',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Value: $potassiumVal Kg/L',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.025,
                ),
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  elevation: elev,
                  shadowColor:
                      Colors.black54, //Color.fromARGB(199, 228, 102, 123),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: const [
                          Color.fromARGB(255, 19, 153, 206),
                          Color.fromARGB(255, 9, 167, 230),
                          Color.fromARGB(255, 90, 183, 219),
                          Color.fromARGB(255, 113, 192, 223),
                        ],
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.435,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        CircleAvatar(
                            radius: rd,
                            backgroundColor: Colors.white,
                            child: Text('M',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.035,
                                  color: Color.fromARGB(255, 19, 153, 206),
                                ),
                                textAlign: TextAlign
                                    .center) // No matter how big it is, it won't overflow
                            ),
                        Text(
                          'Moisture',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Value: $moistureVal Kg/L',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
