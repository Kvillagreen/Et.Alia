// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

// Top-level static methods
String Uid = AccntId;
var nitrogenNum;
var phosphorusNum;
var moistureNum;
var potassiumNum;

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DatabaseReference refer = FirebaseDatabase.instance.ref('user');
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      print('setAsForegroundService');
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      print('setAsBackgroundService');
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      DatabaseEvent event = await refer.once();
      nitrogenNum = (event.snapshot.value as Map)["NitrogenNum"] ?? 100;
      phosphorusNum = (event.snapshot.value as Map)["PhosphorusNum"] ?? 100;
      moistureNum = (event.snapshot.value as Map)["MoistureNum"] ?? 100;
      potassiumNum = (event.snapshot.value as Map)["PotassiumNum"] ?? 100;
      /*FirebaseDatabase.instance.ref().child(Uid).update(
        {"Notifier": true},
      );*/
      if (nitrogenNum <= 20) {
        flutterLocalNotificationsPlugin.show(
            0,
            "Insufficient Nitrogen",
            "Nitrogen: $nitrogenNum",
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: 'Greenery Notification',
                    importance: Importance.high,
                    color: Colors.blue,
                    playSound: true,
                    onlyAlertOnce :true,
                    icon: '@mipmap/ic_launcher')));
      }
      if (potassiumNum <= 20) {
        flutterLocalNotificationsPlugin.show(
            1,
            "Insufficient Potassium",
            "Potassium: $potassiumNum",
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: 'Greenery Notification',
                    importance: Importance.high,
                    color: Colors.blue,
                    playSound: true,
                    onlyAlertOnce :true,
                    icon: '@mipmap/ic_launcher')));
      }
      if (phosphorusNum <= 20) {
        flutterLocalNotificationsPlugin.show(
            2,
            "Insufficient Phosphorus",
            "Phosphorus:$phosphorusNum",
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: 'Greenery Notification',
                    importance: Importance.high,
                    color: Colors.blue,
                    playSound: true,
                    onlyAlertOnce :true,
                    icon: '@mipmap/ic_launcher')));
      }
      if (moistureNum <= 20) {
        flutterLocalNotificationsPlugin.show(
            3,
            "Insufficient Water",
            "Water: $moistureNum",
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: 'Greenery Notification',
                    importance: Importance.high,
                    color: Colors.blue,
                    playSound: true,
                    onlyAlertOnce :true,
                    icon: '@mipmap/ic_launcher')));
      }
      service.invoke('update');
    },
  );
}

bool onBackground(ServiceInstance serviceInstance) {
  return true;
}

Future<void> initializeService() async {
  Uid = AccntId;
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStartOnBoot: true,
      autoStart: true,
      isForegroundMode: true,
      initialNotificationTitle: 'Greenery',
      initialNotificationContent: 'Application is running in background',
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onBackground,
    ),
  );
  service.startService();
}
