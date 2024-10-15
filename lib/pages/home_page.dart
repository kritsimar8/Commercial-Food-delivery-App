import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/my_current_location.dart';
import 'package:food_ordering_app/components/my_description_box.dart';
import 'package:food_ordering_app/components/my_drawer.dart';
import 'package:food_ordering_app/components/my_food_tile.dart';
import 'package:food_ordering_app/components/my_sliver_app_bar.dart';
import 'package:food_ordering_app/components/my_tab_bar.dart';
import 'package:food_ordering_app/models/food.dart';
import 'package:food_ordering_app/models/restaurant.dart';
import 'package:food_ordering_app/pages/food_page.dart';
import 'package:food_ordering_app/pages/testingPage2.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime? _startTime;
  DateTime? _endTime;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    final ResturantProvider = Provider.of<Restaurant>(context, listen: false);
    final DatabaseService _databaseService = DatabaseService.instance;
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);
      DateTime? lastTime;
      Duration? duration;
      String previousCategory;
      return ListView.builder(
          itemCount: categoryMenu.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final food = categoryMenu[index];
            FoodCategory foodItem = categoryMenu[index].category;
            String FoodView = foodItem.toString().split('.')[1];
            // print(foodItem.toString().split('.')[1]);

            _startTime = DateTime.now();
            final formatDate = DateFormat('HH:mm:ss').format(_startTime!);
            String formattedTime = formatDate.toString();
  
            String FoodViewPayload = "$FoodView - $formattedTime";
            ResturantProvider.FoodDuration.add(FoodViewPayload);
            print("$FoodView - $formattedTime");
            // _databaseService.addFoodDuration(FoodViewPayload);
            //storing category timing in map and pushing in local storage.
            return (FoodTile(
                food: food,
                onTap: () {
                  print(food.name);
                 
                  final MyMap = Provider.of<Restaurant>(context, listen: false);

                  MyMap.FoodCounter(food.name);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodPage(food: food)));
                }));
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:Theme.of(context).colorScheme.surface ,
      drawer: MyDrawer(),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                MySliverAppBar(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Divider(
                        indent: 25,
                        endIndent: 25,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      MyCurrentLocation(),
                      const MyDescriptionBox(),
                    ],
                  ),
                  title: MyTabBar(tabController: _tabController),
                ),
              ],
          body: Consumer<Restaurant>(
              builder: (context, restaurant, child) => TabBarView(
                    controller: _tabController,
                    children: getFoodInThisCategory(restaurant.menu),
                  ))),
    );
  }
}
