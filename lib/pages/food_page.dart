import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/my_button.dart';
import 'package:food_ordering_app/models/food.dart';
import 'package:food_ordering_app/models/restaurant.dart';
import 'package:food_ordering_app/pages/testingPage2.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};

  FoodPage({
    super.key,
    required this.food,
  }) {
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    Navigator.pop(context);

    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseService _databaseService = DatabaseService.instance;

    // print(MyMap.CategoryCount);

    return Consumer<Restaurant>(
        builder: (context, restaurant, child) => Stack(children: [
              Scaffold(
                  body: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                    Image.asset(widget.food.imagePath, height: 300),
                    Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.food.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            Text('\$' + widget.food.price.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            const SizedBox(height: 10),
                            Text(
                              widget.food.description,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(height: 10),
                            Text("Add-ons",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(height: 10),
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        widget.food.availableAddons.length,
                                    itemBuilder: (context, index) {
                                      Addon addon =
                                          widget.food.availableAddons[index];
                                      return CheckboxListTile(
                                        title: Text(addon.name),
                                        subtitle: Text(
                                          '\$${addon.price}',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        value: widget.selectedAddons[addon],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            widget.selectedAddons[addon] =
                                                value!;
                                          });
                                        },
                                      );
                                    }))
                          ],
                        )),
                    MyButton(
                        onTap: () {
                          addToCart(widget.food, widget.selectedAddons);
                          // _databaseService.getTask();
                        },
                        text: 'Add to cart'),
                    const SizedBox(height: 25),
                  ]))),
              SafeArea(
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    margin: const EdgeInsets.only(left: 25, top: 25),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
