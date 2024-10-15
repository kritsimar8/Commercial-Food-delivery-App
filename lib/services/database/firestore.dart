import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class FirestoreService{
  final CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  final CollectionReference UserData = FirebaseFirestore.instance.collection('UserData');
  
  Future<void> saveOrderToDatabase(String receipt) async{
    await orders.add({
      'date': DateTime.now(),
      'order':receipt,
    });
  }
  Future<void> saveUserData(String durationstart,String durationend,List foodduration , Map<String, dynamic> tapMap , String ordervalue,String address,List totalitem,List addonlist) async{
    
     final jsonTapMap = jsonEncode(tapMap);
    final jsonTotalItem = jsonEncode(totalitem);
    final jsonAddon = jsonEncode(addonlist);
    final jsonFoodDuration = jsonEncode(foodduration);
    await UserData.add({
      'DurationStart': durationstart,
      'DurationEnd':durationend,
      'FoodDuration':jsonFoodDuration,
      'TapCount':jsonTapMap,
      'TotalPrice':ordervalue,
      'ClientAddress':address,
      'TotalFoodOrdered':jsonTotalItem,
      'SelectedAddons':jsonAddon,
    });
  }
}

// DurationStart, DurationEnd, FoodDuration, _CategoryCount, TotalPrice, ClientAddress, TotalFoodOrdered, SelectedAddons