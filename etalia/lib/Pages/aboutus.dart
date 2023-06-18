// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, duplicate_ignore, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// ignore: must_be_immutable
// values of the soil nutrients

// value of the constant elevation and height
double elev = 2.0;
const double ht = 10.0;

class Developer extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _Developer createState() => _Developer();
}

class _Developer extends State<Developer> {
  final ref = FirebaseDatabase.instance.ref('user');
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
          // ignore: unused_local_variable
          // ignore: unused_local_variable
          Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
          // nitrogenNum = map['NitrogenNum'] ?? '';
        }
        return ListView(
          children: <Widget>[
            // ignore: avoid_unnecessary_containers
            Container(
              child: Data_Schedule(),
            ),
          ],
        );
      },
    );
  }
}

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
                  'About Et. Alia:',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
            const SizedBox(
              height: ht,
            ),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              elevation: elev,
              color: Color.fromARGB(255, 0, 150, 108),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.055,),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.15,
                            backgroundImage: AssetImage(
                                "assets/developer/No.jpg"), // No matter how big it is, it won't overflow
                          ),
                        ),
                        Text(
                          'Justine Marie Adrias',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      
                    Text(
                      '',
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
            const SizedBox(
              height: ht,
            ),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              elevation: elev,
              color: Color.fromARGB(255, 0, 150, 108),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.055,),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.15,
                            backgroundImage: AssetImage(
                                "assets/developer/No.jpg"), // No matter how big it is, it won't overflow
                          ),
                        ),
                        Text(
                          'Jamar Angana',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      
                    Text(
                      '',
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
            const SizedBox(
              height: ht,
            ),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              elevation: elev,
              color: Color.fromARGB(255, 0, 150, 108),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.055,),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.15,
                            backgroundImage: AssetImage(
                                "assets/developer/No.jpg"), // No matter how big it is, it won't overflow
                          ),
                        ),
                        Text(
                          'Mary-Ann Manlosa',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      
                    Text(
                      '',
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
            const SizedBox(
              height: ht,
            ),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              elevation: elev,
              color: Color.fromARGB(255, 0, 150, 108),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.055,),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.15,
                            backgroundImage: AssetImage(
                                "assets/developer/No.jpg"), // No matter how big it is, it won't overflow
                          ),
                        ),
                        Text(
                          'Merily Palencia',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      
                    Text(
                      '',
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
            const SizedBox(
              height: ht,
            ),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              elevation: elev,
              color: Color.fromARGB(255, 0, 150, 108),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.055,),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.15,
                            backgroundImage: AssetImage(
                                "assets/developer/No.jpg"), // No matter how big it is, it won't overflow
                          ),
                        ),
                        Text(
                          'Karl Villaverde',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      
                    Text(
                      '',
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
      ),
    );
  }
}
