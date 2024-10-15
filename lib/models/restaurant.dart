import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/cart_item.dart';
import 'package:food_ordering_app/models/food.dart';
import 'package:food_ordering_app/pages/testingPage2.dart';
import 'package:food_ordering_app/services/database/firestore.dart';
import 'package:intl/intl.dart';

class Restaurant extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;
  final List<Food> _menu = [
    Food(
        name: "Classic Cheeseburger",
        description:
            "A Juicy chicken patty with melted cheddar,lettuce,tomato with a hint of onion and pickle",
        imagePath: "lib/images/burgers/burger6.png",
        price: 0.99,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]),
    Food(
      name: "Caesar Salad",
      description:
          "Crisp romaine lettuce,parmesan cheese,croutons and Caesar dressing.",
      imagePath: "lib/images/salads/salad.png",
      price: 7.99,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Grilled chicken", price: 0.99),
        Addon(name: "Anchovies", price: 1.49),
        Addon(name: "Extra Parmesan", price: 1.99),
      ],
    ),
    Food(
        name: "Garlic Bread",
        description:
            "Warm and tasty garlic bread,topped with melted butter and parsley",
        imagePath: "lib/images/sides/sides.png",
        price: 4.49,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Extra Garlic", price: 0.99),
          Addon(name: "Mozzerella cheese", price: 1.49),
          Addon(name: "Marinara Dip", price: 1.99),
        ]),
    Food(
      name: "Choclate Brownie",
      description: "Rich and fudgy choclate brownie with chunks of choclate.",
      imagePath: "lib/images/deserts/cake.png",
      price: 5.99,
      category: FoodCategory.deserts,
      availableAddons: [
        Addon(name: "Vanilla Ice cream", price: 0.99),
        Addon(name: "Hot Fudge", price: 1.49),
        Addon(name: "Whipped Cream", price: 1.99),
      ],
    ),
    Food(
        name: "Smoothie",
        description:
            "A blend of fresh fruits and yogurt, perfect for a healthy boost",
        imagePath: "lib/images/drinks/strawberryshake.png",
        price: 4.49,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Protien Powder", price: 0.99),
          Addon(name: "Almond Milk", price: 1.49),
          Addon(name: "chia Seeds", price: 1.99),
        ]),
  ];

  String DurationStart="";
  String DurationEnd="";
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;
  Map<String, int> _CategoryCount = {};
  List<String> FoodDuration=[];

  Map get CategoryCount => _CategoryCount;
  

  void FoodCounter(String foodName) {
    if (CategoryCount.containsKey(foodName)) {
      int TapCount = CategoryCount[foodName];
      CategoryCount[foodName] = TapCount + 1;
      
    } else {
      CategoryCount[foodName] = 1;
    }
    // _databaseService.addNoOfTaps(_CategoryCount);
    print(CategoryCount);
    //update categorycount added to local storage
  }

  final List<CartItem> _cart = [];
  String _deliveryAddress = 'Ashok Vihar';

  void addToCart(Food food, List<Addon> selectedAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;

      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
    });
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(
        CartItem(
          food: food,
          selectedAddons: selectedAddons,
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
  }

  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }
  

  String displayCartReceipt() {
     FirestoreService db = FirestoreService();
   
    // addons String storage
    String TotalPrice = getTotalPrice().toString();
    // _databaseService.addOrderValue(TotalPrice);
    String ClientAddress = deliveryAddress;
    // _databaseService.addAddress(ClientAddress);
    List<String> TotalFoodOrdered=[];      
    List<String> SelectedAddons=[]; 

    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt");
    receipt.writeln();

    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-----------");

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name}- ${_formatPrice(cartItem.food.price)}");
      TotalFoodOrdered.add("${cartItem.quantity} x ${cartItem.food.name}");
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt
            .writeln("    Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
            SelectedAddons.add(" ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }
    // _databaseService.addTotalItemsBought(TotalFoodOrdered);
    // _databaseService.addAddons(SelectedAddons);
    _databaseService.addFinalSession(DurationStart, DurationEnd, FoodDuration, _CategoryCount, TotalPrice, ClientAddress, TotalFoodOrdered, SelectedAddons);
      db.saveUserData(DurationStart, DurationEnd, FoodDuration, _CategoryCount, TotalPrice, ClientAddress, TotalFoodOrdered, SelectedAddons);
    receipt.writeln("-----------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivering to: $deliveryAddress");

    return receipt.toString();
  }

  String _formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }

  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(",");
  }
}
