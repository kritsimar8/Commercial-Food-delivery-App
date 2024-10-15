
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_ordering_app/pages/notification_services.dart';
import 'package:food_ordering_app/pages/testingPage2.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
 
  
  final DatabaseService _databaseService = DatabaseService.instance;
  NotificationServices  notificationServices = NotificationServices();

  String? _task = null;

  
 
  

  @override 
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value){
      print('device token');
      print(value);
    });
   
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _databaseService.getLastId(),
              child: Text('Click here',
              style: TextStyle(
                color: Colors.red
              ),),
            )
          ],
        ),
      )

    );
  }
  Widget _addTaskButton() {
    return FloatingActionButton(onPressed: (){
      showDialog(context: context, builder: (_)=> AlertDialog(
        title: const Text('add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value){
                setState(() {
                  _task= value;
                });
              },
            ),
            MaterialButton(onPressed: (){
              if(_task == null || _task =="") return;
              // _databaseService.addTask(_task!,_task!);
              setState(() {
                _task=null;
              });
              Navigator.pop(context);
            },
            child: const Text(
              "Done",
              style: TextStyle(
                color: Colors.red
              ),
            ),
            )
          ],
        ),
      ));
    },
    child: const Icon(Icons.add),
    );
  }
  Widget _tasksList(){
    return FutureBuilder(future: _databaseService.getTask(), builder: (context,snapshot){
      return Container();
    });
  }
}








