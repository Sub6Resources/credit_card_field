import 'package:flutter/material.dart';
import 'package:credit_card_field/credit_card_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Card Form Field Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Credit Card Form Field Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController creditCardController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expirationController = TextEditingController();


  void _submit() {
    Map<String, dynamic> cardJson = {
      'number': creditCardController.text,
      'cvv': cvvController.text,
      'exp_month': int.tryParse(expirationController.text.substring(0, 2)),
      'exp_year': int.tryParse(expirationController.text.substring(3, 5)),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              CreditCardFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Credit Card Number",
                ),
                controller: creditCardController,
              ),
              SizedBox(height: 8),
              CVVFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "CVV",
                ),
                controller: cvvController,
              ),
              SizedBox(height: 8),
              ExpirationFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Card Expiration",
                  hintText: "MM/YY",
                ),
                controller: expirationController,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        tooltip: 'Submit',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
