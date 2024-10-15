import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessageApp extends StatefulWidget {
  
  const MessageApp({super.key});

  @override
  State<MessageApp> createState() => _MessageState();
}

class _MessageState extends State<MessageApp> {
  Map payload = {};
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    if(data is RemoteMessage){
      payload = data.data;
    }
    if(data is NotificationResponse){
      payload = jsonDecode(data.payload!);
    }
    return Scaffold(
      appBar: AppBar(title: Text('Welcome ji welcome aap yaha a gye ho'),),
      body: Center(
        child: Text(payload.toString()),
      ),
    );
  }
}