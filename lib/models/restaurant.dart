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
        name: "Bacon Cheeseburger",
        description:
            " a hamburger topped with strips of cooked bacon. ",
        imagePath: "lib/images/burgers/burger1.png",
        price: 1.49,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]),
    Food(
        name: "BBQ chicken burger",
        description:
            " Grilled chicken, Mozza cheese, Grilled Onion, Lettuce, Mayo, BBQ sauce ",
        imagePath: "lib/images/burgers/burger2.png",
        price: 1.69,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]),
    // Food(
    //     name: "Crispy chicken burger",
    //     description:
    //         " Crispy chicken, chedder cheese, grilled onion & tomatoes, Lettuce, pickles, Garlic sauce, mayo, Chipotle sauce",
    //     imagePath: "lib/images/burgers/burger3.jpg",
    //     price: 1.29,
    //     category: FoodCategory.burgers,
    //     availableAddons: [
    //       Addon(name: "Extra cheese", price: 0.99),
    //       Addon(name: "Bacon", price: 1.99),
    //       Addon(name: "Avocado", price: 2.99),
    //     ]),
    Food(
        name: "Spicy Tandoori burger",
        description:
            "Tandoori chicken, chedder cheese, Grilled onion & tomatoes , Lettuce ,Garlic sauce,Mayo , tandoori hot Sauce",
        imagePath: "lib/images/burgers/burger5.png",
        price: 2.09,
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
      name: "Paneer Salad",
      description:
          "Paneer Salad. A flavor packed, vegetarian indian salad made with pan fried paneer & vegetables tossed in a lemon, honey ginger dressing.",
      imagePath: "lib/images/salads/salad2.png",
      price: 9.99,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Grilled chicken", price: 0.99),
        Addon(name: "Anchovies", price: 1.49),
        Addon(name: "Extra Parmesan", price: 1.99),
      ],
    ),
    Food(
      name: "Grilled chicken Salad",
      description:
          "This grilled chicken salad is tender marinated chicken that’s grilled to perfection then served over lettuce with bacon, avocado, corn, blue cheese and tomatoes. ",
      imagePath: "lib/images/salads/salad3.png",
      price: 10.99,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Grilled chicken", price: 0.99),
        Addon(name: "Anchovies", price: 1.49),
        Addon(name: "Extra Parmesan", price: 1.99),
      ],
    ),
    Food(
      name: "Quinoa Salad",
      description:
          "This Mediterranean Quinoa Salad recipe is packed with crunchy bell peppers, crisp cucumbers, and the briny flavors of feta and kalamata olives.",
      imagePath: "lib/images/salads/salad4.png",
      price: 6.99,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Grilled chicken", price: 0.99),
        Addon(name: "Anchovies", price: 1.49),
        Addon(name: "Extra Parmesan", price: 1.99),
      ],
    ),
    Food(
      name: "Egg Salad",
      description:
          "Egg salad is made of chopped hard-boiled eggs, mayonnaise, mustard, minced celery and onion, salt, black pepper and paprika. ",
      imagePath: "lib/images/salads/salad5.png",
      price: 6.99,
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
        name: "Chicken Nuggets",
        description:
            "Chicken nuggets are bite-sized pieces of chicken that are coated with breading or batter and then baked or deep-fried",
        imagePath: "lib/images/sides/chickennuggets.png",
        price: 4.79,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Extra Garlic", price: 0.99),
          Addon(name: "Mozzerella cheese", price: 1.49),
          Addon(name: "Marinara Dip", price: 1.99),
        ]),
    Food(
        name: "Chicken wings",
        description:
            "These Fried chicken wings are marinated in Cajun Spices, then coated in seasoned flour and deep fried to golden brown perfection. ",
        imagePath: "lib/images/sides/chickenwings.png",
        price: 4.79,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Extra Garlic", price: 0.99),
          Addon(name: "Mozzerella cheese", price: 1.49),
          Addon(name: "Marinara Dip", price: 1.99),
        ]),
    Food(
        name: "Garlic bread",
        description:
            "Garlic bread is a toasted bread dish that typically includes garlic, butter or olive oil, and sometimes other ingredients like herbs or cheese",
        imagePath: "lib/images/sides/garlicbread.png",
        price: 4.79,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Extra Garlic", price: 0.99),
          Addon(name: "Mozzerella cheese", price: 1.49),
          Addon(name: "Marinara Dip", price: 1.99),
        ]),
    Food(
        name: "French fries",
        description:
            "French fries are made by cutting potatoes into even strips, drying them, and frying them in deep fat. They are often salted and served with ketchup, mayonnaise, vinegar, or barbecue sauce",
        imagePath: "lib/images/sides/frenchfries.png",
        price: 4.79,
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
      name: "Choclate Cupcake",
      description: " The combination of a rich and moist chocolate butter cake topped with a rich and creamy chocolate butter frosting is irresistible",
      imagePath: "lib/images/deserts/cupcake.png",
      price: 2.99,
      category: FoodCategory.deserts,
      availableAddons: [
        Addon(name: "Vanilla Ice cream", price: 0.99),
        Addon(name: "Hot Fudge", price: 1.49),
        Addon(name: "Whipped Cream", price: 1.99),
      ],
    ),
    Food(
      name: "Choclate donut",
      description: " The Chocolate Doughnut is a classic and beloved pastry. It featured a ring-shaped fried dough base that is coated in a rich, Chocolate-flavored glaze or icing.",
      imagePath: "lib/images/deserts/donut.png",
      price: 2.99,
      category: FoodCategory.deserts,
      availableAddons: [
        Addon(name: "Vanilla Ice cream", price: 0.99),
        Addon(name: "Hot Fudge", price: 1.49),
        Addon(name: "Whipped Cream", price: 1.99),
      ],
    ),
    // Food(
    //   name: "Pineapple Sundae",
    //   description: "These Grilled Pineapple Ice Cream Sundaes are a sweet summertime dessert! The brown sugar grilled pineapple serves as the warm base of the sundae, topped with creamy vanilla ice cream, whipped cream, caramel sauce, toasted coconut and a cherry! ",
    //   imagePath: "lib/images/deserts/pinnaple-sundae.png",
    //   price: 4.99,
    //   category: FoodCategory.deserts,
    //   availableAddons: [
    //     Addon(name: "Vanilla Ice cream", price: 0.99),
    //     Addon(name: "Hot Fudge", price: 1.49),
    //     Addon(name: "Whipped Cream", price: 1.99),
    //   ],
    // ),
    Food(
      name: "Strawberry Sundae",
      description: "A sweet and slightly tart strawberry sauce is paired with vanilla ice cream and garnished with even more fresh strawberries and your favorite toppings!",
      imagePath: "lib/images/deserts/sundae.png",
      price: 4.99,
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
    Food(
        name: "Cocacola",
        description:
            "carbonated water, sugar, natural caramel color (class iv), acidity regulators (phosphoric acid), kola concentrate, caffeine. contains caffeine 24 mg/serving.",
        imagePath: "lib/images/drinks/pepsi.png",
        price: 1.49,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Protien Powder", price: 0.99),
          Addon(name: "Almond Milk", price: 1.49),
          Addon(name: "chia Seeds", price: 1.99),
        ]),
    Food(
        name: "Mix-fruit juice",
        description:
            "Mixed fruit juice is a juice made from liquid squeezed out from fruits that includes apple, apricot, pineapple, watermelon, mango and banana",
        imagePath: "lib/images/drinks/mix-fruit.png",
        price: 2.49,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Protien Powder", price: 0.99),
          Addon(name: "Almond Milk", price: 1.49),
          Addon(name: "chia Seeds", price: 1.99),
        ]),
    Food(
        name: "Cold coffee",
        description:
            "Made by brewing coffee hot and then pouring it over ice or into cold milk.",
        imagePath: "lib/images/drinks/coldcoffee.png",
        price: 2.49,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Protien Powder", price: 0.99),
          Addon(name: "Almond Milk", price: 1.49),
          Addon(name: "chia Seeds", price: 1.99),
        ]),
    Food(
        name: "Rainbow drink",
        description:
            "Made with Bacardi White Rum, McGuinness Blue Curaçao, orange juice, and Red Powerade, this cocktail adds a splash of color to any occasion.",
        imagePath: "lib/images/drinks/rainbow.png",
        price: 2.49,
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
  List<String> get foodList=> FoodDuration;
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
    //  FirestoreService db = FirestoreService();
   
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
    // the below 2 lines of codes are the for storing local storage in the firebase database. 
    // _databaseService.addFinalSession(DurationStart, DurationEnd, FoodDuration, _CategoryCount, TotalPrice, ClientAddress, TotalFoodOrdered, SelectedAddons);
    // db.saveUserData(DurationStart, DurationEnd, FoodDuration, _CategoryCount, TotalPrice, ClientAddress, TotalFoodOrdered, SelectedAddons);
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
