import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/components/my_button.dart';
import 'package:food_ordering_app/components/my_food_tile.dart';
import 'package:food_ordering_app/components/my_receipt.dart';
import 'package:food_ordering_app/firebase_options.dart';
import 'package:food_ordering_app/main.dart';
import 'package:food_ordering_app/models/food.dart';
import 'package:food_ordering_app/pages/food_page.dart';
import 'package:food_ordering_app/pages/home_page.dart';
import 'package:food_ordering_app/pages/testingPage.dart';
import 'package:integration_test/integration_test.dart';
import 'package:food_ordering_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end test', () {
    testWidgets(
        'This is a basic test from selecting a food item adding it in the card paying through credit card and then getting a receipt',
        (WidgetTester tester) async {
      // await tester.pumpWidget(app.main());
      // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      await app.main();
      await tester.pumpAndSettle();

     




      
     
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 3));


       final tabController =
          tester.widget<TabBar>(find.byType(TabBar)).controller!;
      for (int i = 0; i < tabController.length; i++) {
        await tester.tap(find.text(FoodCategory.values[i].name));
        await tester.pumpAndSettle();
        expect(find.byType(FoodTile), findsWidgets);
      }

      await tester.tap(find.text('burgers'));
      await tester.pumpAndSettle();

      // Assuming the first item in Burgers is selected
      final burgerItemFinder = find.byType(FoodTile).first;
      await tester.tap(burgerItemFinder);
      await tester.pumpAndSettle();
      expect(find.byType(FoodPage), findsOneWidget);
      expect(find.text('Add to cart'), findsOneWidget);

      final button = find.widgetWithText(MyButton, 'Add to cart');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();

      final openCartButton = find.byIcon(Icons.shopping_cart);
      await tester.tap(openCartButton);

      await tester.pumpAndSettle();
      // expect(openCartButton, findsOneWidget);

      final button2 = find.widgetWithText(MyButton, 'Go to checkout');

      await tester.tap(button2);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(Key('cardNumberKey')), '1111111111111111');
      await tester.enterText(find.byKey(Key('expiryDateKey')), '12/25');
      await tester.enterText(find.byKey(Key('cardHolderKey')), 'Simar singh');
      await tester.enterText(find.byKey(Key('cvvCodeKey')), '123');

      await tester.tap(find.text('Pay Now'));
      await tester.pumpAndSettle();
      // await Future.delayed(const Duration(seconds: 3));
      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      expect(find.byType(MyReceipt), findsOneWidget);

      //  final addToCartButton = find.byType(MyButton);

      // final backButton = find.byTooltip('Back'); // Default tooltip for AppBar back button
      // await tester.tap(backButton);
      // await tester.pumpAndSettle();
      // expect(find.byType(HomePage), findsOneWidget);

      // await FoodPage(food: ExampleType[0]);
      // await tester.pumpAndSettle();
      // expect(find.byType(FoodTile), findsOneWidget);
      // expect(find.byType(MyButton), findsOneWidget);
      //  await Future.delayed(const Duration(seconds: 3));

      // final Findingtext = find.text('helloji');
      // expect(find.text('helloji'), findsOneWidget);

    });
  });
}


