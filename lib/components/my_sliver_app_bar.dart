

import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/cart_page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MySliverAppBar extends StatefulWidget{
  final Widget child;
  final Widget title;

  const MySliverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  State<MySliverAppBar> createState() => _MySliverAppBarState();
}

class _MySliverAppBarState extends State<MySliverAppBar> {
 
  Razorpay? _razorpay;
      

  void _handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: "SUCCESS PAYENT: ${response.paymentId}",timeInSecForIosWeb: 4); 
  }
  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: "ERROR PAYMENT: ${response.code} - ${response.message}",timeInSecForIosWeb: 4); 
  }
  void _handlePaymentWallet(ExternalWalletResponse response){
     Fluttertoast.showToast(msg: " EXTERNAL_WALLET : ${response.walletName}",timeInSecForIosWeb: 4); 
  }
   @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentWallet);
   
    super.initState();
  }
  void makePayment() async{
    var options = {
      'key':'rzp_test_wMEfN8rsuwz0T4',
      'amount':2000,
      'name':'krit',
      'description':'iphone 15',
      'prefill':{'contact': '+9599388031','email':'kritsimarsingh@gmail.com'},
    };
    try{
      _razorpay?.open(options);
    }catch(e){
      debugPrint(e.toString());
    }
  }
 
  @override 
  Widget build(BuildContext context){
   
    return SliverAppBar(
      expandedHeight:340,
      collapsedHeight:120,
      floating:false,
      pinned:true,
      actions:[
       
           IconButton(onPressed:() => makePayment(), icon: Icon(Icons.wallet)),
        
            SizedBox(width: 20,),
            IconButton(
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context)=>const CartPage(),
                  )
                );
              },
              icon:Icon(Icons.shopping_cart),
            ),
          ],
        

      
      backgroundColor:Theme.of(context).colorScheme.surface,
      foregroundColor:Theme.of(context).colorScheme.inversePrimary,
      title:const Text("Sunset Dinner"),
      flexibleSpace:FlexibleSpaceBar(
        background:Padding(
          padding:const EdgeInsets.only(bottom:50.0),
          child:widget.child,
        ),
        title:widget.title,
        centerTitle:true,
        titlePadding: const EdgeInsets.only(left:0,right:0,top:0),
        expandedTitleScale:1,
      )

    );
  }
}