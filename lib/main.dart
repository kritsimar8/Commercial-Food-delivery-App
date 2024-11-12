import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/firebase_options.dart';
import 'package:food_ordering_app/models/restaurant.dart';
import 'package:food_ordering_app/pages/home_page.dart';
import 'package:food_ordering_app/pages/notification_services.dart';
import 'package:food_ordering_app/pages/testingPage.dart';
import 'package:food_ordering_app/pages/testingPage2.dart';
import 'package:food_ordering_app/services/auth/auth_gate.dart';
import 'package:food_ordering_app/services/auth/login_register.dart';
import 'package:food_ordering_app/themes/theme_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
final navigatorKey = GlobalKey<NavigatorState>();


  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  // runApp(MaterialApp(home: SessionTrackingApp(),));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => Restaurant()),
  ], 
  child: SessionTrackingApp()));
  // runApp(MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // navigatorKey: navigatorKey,
      home: TestingPage()
         
      );
     
    
  }
}

class SessionTrackingApp extends StatefulWidget {
  @override
  _SessionTrackingAppState createState() => _SessionTrackingAppState();
}

class _SessionTrackingAppState extends State<SessionTrackingApp>
    with WidgetsBindingObserver {
  DateTime? _sessionStartTime;
  DateTime? _sessionEndTime;
  bool StartDurationStored= false;

  
  String? _currentFunction = '';

  @override
  void initState() {
    super.initState();
   
    WidgetsBinding.instance.addObserver(this);
    
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Clean up observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // DateTime? _sessionStartTime;
    final DatabaseService _databaseService = DatabaseService.instance;
    final DurationTime = Provider.of<Restaurant>(context, listen: false);
    DateTime? _sessionEndTime;
    if (state == AppLifecycleState.resumed) {
      // App has resumed, start tracking session
      _sessionStartTime = DateTime.now();
      print(_sessionStartTime);
      String formattedTime =_sessionStartTime.toString();
      if(StartDurationStored == false){
        DurationTime.DurationStart= formattedTime;
        StartDurationStored = true;
      }
      // final formatDate = DateFormat('HH:mm:ss').format(_sessionStartTime);
        // adding start duration 
      print(
          "App Resumed: $_currentFunction Session started at $_sessionStartTime");
          // print(dateTime.runtimeType);
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // App has paused (backgrounded) or detached (closed), stop tracking
      _sessionEndTime = DateTime.now();
      String formattedTime = _sessionEndTime.toString();
      DurationTime.DurationEnd=formattedTime;
      
      
      // final formatEndDate = DateFormat('HH:mm:ss').format(_sessionEndTime);
         // adding end duration 
      print("App Paused/Detached: Session ended at $_sessionEndTime");
     

      _calculateSessionDuration(_sessionStartTime,_sessionEndTime);
    }
  }

  void _calculateSessionDuration(DateTime? _sessionStartTime,  DateTime? _sessionEndTime) {
  Duration _sessionDuration = Duration.zero;
  
  print('$_sessionStartTime,$_sessionEndTime');
    if (_sessionStartTime != null && _sessionEndTime != null) {
      final sessionDuration = _sessionEndTime!.difference(_sessionStartTime!);
   
        _sessionDuration = sessionDuration;
   
      print("Session Duration: $_sessionDuration");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return AuthGate();
      }),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
