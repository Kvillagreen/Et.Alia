// ignore_for_file: sort_child_properties_last, prefer_const_constructors, duplicate_ignore, deprecated_member_use, unused_import, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Pages/homepage.dart';
import 'Services/back_service.dart';

String AccntId = '';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then(
    (value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top]).then(
    (_) => runApp(FirstApp()),
  );
}

class FirstApp extends StatelessWidget {
  FirstApp({Key? key}) : super(key: key);

  final ref = FirebaseDatabase.instance.ref('checker');
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EtAlia',
      theme: ThemeData(fontFamily: 'Tienne'),
      home: Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.webp"),
                alignment: Alignment.center,
                opacity: 0.8,
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
                  Color.fromARGB(255, 0, 107, 71),
                  Color.fromARGB(255, 5, 131, 87),
                  Color.fromARGB(255, 5, 167, 113),
                  Color.fromARGB(255, 7, 226, 153),
                ],
              ),
            ),
            child: CheckPoint(),
          ),
        ),
      ),
    );
  }
}

class CheckPoint extends StatefulWidget {
  const CheckPoint({Key? key}) : super(key: key);
  @override
  State<CheckPoint> createState() => _LogoPage();
}

class _LogoPage extends State<CheckPoint> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 2, 107, 72),
          title: Text(
            'Greenery',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Device id is incorrect!',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontSize: 12),
                ),
                SizedBox(height: 8),
                Text(
                  'Please input the correct device id',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontSize: 12),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Ok',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TextEditingController UidController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: (Color.fromARGB(50, 255, 255, 255)),
      child: ListView(
        // ignore: duplicate_ignore, duplicate_ignore, duplicate_ignore
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            height: (MediaQuery.of(context).size.height) * 0.2,
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0),
              //: (MediaQuery.of(context).size.height) * 0.3,
              child: const Text(
                'Greenery',
                style: TextStyle(
                    color: Color.fromARGB(255, 34, 139, 34),
                    fontWeight: FontWeight.w500,
                    fontSize: 45),
              )), // ignore: duplicate_ignore, duplicate_ignore
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0),
              margin: EdgeInsets.only(top: 5),
              // height: (MediaQuery.of(context).size.height) * 0.3,
              child: const Text(
                '"Life is better through agriculture."',
                style: TextStyle(
                    color: Color.fromARGB(255, 34, 139, 34),
                    fontWeight: FontWeight.w500,
                    fontSize: 10),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.075,
          ),
          // ignore: duplicate_ignore, duplicate_ignore
          /*Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.01,
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.025),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Text(
                      'Device Id:',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 34, 139, 34),
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: TextField(
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 34, 139, 34),
                        fontWeight: FontWeight.w500),
                    cursorColor: Color.fromARGB(255, 34, 139, 34),
                    textAlign: TextAlign.left,
                    controller: UidController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: (Color.fromARGB(255, 34, 139, 34))),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: (Color.fromARGB(255, 34, 139, 34))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          */
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
          ),
          Container(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
            // ignore: duplicate_ignore, duplicate_ignore
            child: ElevatedButton(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.20,
                child: Center(
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              onPressed: () async {
                //AccntId = UidController.text.toString();
                AccntId = 'user';
                WidgetsFlutterBinding.ensureInitialized();
                await Firebase.initializeApp();
                DatabaseReference ref =
                    FirebaseDatabase.instance.ref('checker');
                DatabaseEvent event = await ref.once();
                if ((event.snapshot.value as Map)[AccntId] == true) {
                  initializeService();
                  FirebaseDatabase.instance.ref().child(Uid).update(
                    {"Notifier": true},
                  );
                  notify = 1;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                } else {
                  _showMyDialog();
                }
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
        ],
      ),
    );
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
