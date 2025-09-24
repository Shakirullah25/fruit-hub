import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/model/combo_details.dart';
import 'package:fruit_salad_combo/screens/add_to_basket_screen.dart';
import 'package:fruit_salad_combo/screens/authentication_screen.dart';
import 'package:fruit_salad_combo/screens/welcome_screen.dart';

void main() {
  // Dummy comboDetails for testing
  final comboDetails = ComboDetails(
    imgPath: "lib/assets/Berry-blast.png",
    fruitName: "Apple",
    fruitPrice: "₦500",
    description: "Fresh apple combo",
    shortName: "AppleCombo",
  );

  testWidgets("Increment button increases quantity", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: Size(405, 844),
        builder: (context, child) {
          return MaterialApp(
            home: AddToBasketScreen(comboDetails: comboDetails),
          );
        },
      ),
    );

    await tester.pumpAndSettle();

    // Initial quantity should be 1
    expect(find.text("1"), findsOneWidget);

    // Tap increment
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Quantity should now be 2
    expect(find.text("2"), findsOneWidget);
  });

  testWidgets("Decrement button decreases quantity but not below 1", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: AddToBasketScreen(comboDetails: comboDetails)),
    );

    // Initial quantity
    expect(find.text("1"), findsOneWidget);

    // Tap decrement (should stay at 1)
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text("1"), findsOneWidget);

    // Tap increment, then decrement → back to 1
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text("2"), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text("1"), findsOneWidget);
  });

  testWidgets("Pressing let's contine button navigates to the auth screen", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: Size(405, 844),
        builder: (context, child) {
          return MaterialApp(home: WelcomeScreen());
        },
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key(MyStrings.letsContinue)));
    await tester.pumpAndSettle();
    //await tester.pump();

    expect(find.byType(AuthenticationScreen), findsOneWidget);
  });
}
