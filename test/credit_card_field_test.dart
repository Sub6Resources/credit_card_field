import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:credit_card_field/credit_card_field.dart';

void main() {
  testWidgets('test to make sure widgets build', (tester) async {
    TextEditingController expirationController = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: <Widget>[
              CreditCardFormField(),
              CVVFormField(),
              ExpirationFormField(controller: expirationController),
            ],
          ),
        ),
      ),
    );

    await tester.ensureVisible(find.byType(CreditCardFormField));
    await tester.ensureVisible(find.byType(ExpirationFormField));
    await tester.ensureVisible(find.byType(CVVFormField));
  });

  testWidgets('test the expiration form field', (tester) async {
    TextEditingController expirationController = TextEditingController();
    Key key = Key("expiration");

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExpirationFormField(key: key, controller: expirationController),
        )
      )
    );

    await tester.enterText(find.byKey(key), "1");
    expect(expirationController.text, "1M/YY");
    await tester.enterText(find.byKey(key), "10");
    expect(expirationController.text, "10/YY");
    await tester.enterText(find.byKey(key), "102");
    expect(expirationController.text, "10/2Y");
    await tester.enterText(find.byKey(key), "1020");
    expect(expirationController.text, "10/20");

    //Add an additional digit to make sure the widget ignores it.
    await tester.enterText(find.byKey(key), "10202");
    expect(expirationController.text, "10/20");
  });
}
