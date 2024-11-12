
import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatefulWidget{
   MyCurrentLocation({super.key});

  @override
  State<MyCurrentLocation> createState() => _MyCurrentLocationState();
}

class _MyCurrentLocationState extends State<MyCurrentLocation> {
  final TextEditingController textController = TextEditingController();

  void openLocationSearchBox(BuildContext context){
    showDialog(
      context:context,
      builder:(context)=> AlertDialog(
        title:Text("Your Location"),
        content:TextField(
          decoration: const InputDecoration(hintText:"Search address..")
        ),
        actions:[
          MaterialButton(
          onPressed:()=>Navigator.pop(context),
          child:const Text('cancel'),
          ),
          MaterialButton(
            onPressed:(){
              String newAddress = textController.text;
              context.read<Restaurant>().updateDeliveryAddress(newAddress);
            Navigator.pop(context);
            },
            child:const Text('Save')
         
          ),
        ]
      )
    );

  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child:Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Text("Deliver now",
        style:TextStyle(color:Theme.of(context).colorScheme.primary)
        ),
       GestureDetector(
        onTap:()=>openLocationSearchBox(context),
        child: Row(
          children:[
            Consumer<Restaurant>(builder: (context,restaurant,child)=>
            Text(
              restaurant.deliveryAddress,
            style:TextStyle(
              color:Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.bold,
            ),
            ),),

            Icon(Icons.keyboard_arrow_down_rounded),
          ],
        )
       )

      ]
    )
    );
  }
}