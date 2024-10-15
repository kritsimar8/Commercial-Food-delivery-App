
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_ordering_app/pages/message.dart';

class NotificationServices{
   final FirebaseMessaging messaging = FirebaseMessaging.instance;
   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

   requestNotificationPermission() async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permission');
    }else if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted provisiona permission');
    }
    else{
      print('user denied permission');
    }
  }
  Future<String> getDeviceToken() async{
    String? token = await messaging.getToken();
    return token!;
  }
   void initLocalNotificationPermission( BuildContext context, RemoteMessage message) async {
  var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');


    final initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
    );
    // _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload){
        handleMessage(context, message);
      }
    );
  }
  static void onNotificationTap(NotificationResponse NotificationResponse){}

   firebaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message){
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
      print(message.data.toString());
      print(message.data['type']);
      print(message.data['id']);
      initLocalNotificationPermission(context,message);
      // showNotification(message);

      if(Platform.isAndroid){
        initLocalNotificationPermission(context, message);
        showNotification(message);
      }else{
        showNotification(message);
      }
     
    });
  }
  Future<void> showNotification(RemoteMessage message)async{
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(1000000).toString(),
       'High Importance Notifications',
       importance: Importance.max
       );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker'
      );
    
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails
    );
    Future.delayed(Duration.zero,(){
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails
        );
    });
  }

  void isTokenRefresh() async{
    messaging.onTokenRefresh.listen((event){
      event.toString();
      print('refresh');
    });
  }
  Future<void> setupInteractMessage(BuildContext context) async{
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null){
      handleMessage(context, initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event){
      handleMessage(context, event);
    });
  }
  void handleMessage(BuildContext context,RemoteMessage message){
    if(message.data['type'] =='TheOne'){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MessageApp()));
    }
  } 



}