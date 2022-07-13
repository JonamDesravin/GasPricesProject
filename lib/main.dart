import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
void main() {
  runApp(GasPriceCalc());
}
class GasPriceCalc extends StatefulWidget {
  const GasPriceCalc({Key? key}) : super(key: key);
  @override
  State<GasPriceCalc> createState() => _GasPriceCalcState();
}
class _GasPriceCalcState extends State<GasPriceCalc> {
  double pricePerGallon = 0.0;
  double gallonsPumped = 0.0;
  double priceToPay = 0.0;
  String dropdownValue = "";
  LinkedHashMap<String, double> gasPricesMap = LinkedHashMap<String, double>();
  @override
  void initState() {
    gasPricesMap.putIfAbsent("Regular 87", () => 4.44);
    gasPricesMap.putIfAbsent("Premium 93", () => 4.70);
    gasPricesMap.putIfAbsent("Super 95", () => 5.20);
    gasPricesMap.putIfAbsent("Supreme 97", () => 5.90);
    gasPricesMap.putIfAbsent("Ethanol E85", () => 4.10);
    dropdownValue = gasPricesMap.isEmpty ? "" : gasPricesMap.keys.first;
    pricePerGallon = gasPricesMap.isEmpty
        ? 0.0
        : gasPricesMap[gasPricesMap.keys.first] ?? 0.0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gas Price Calculator",
      home: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black, //
          backgroundColor: Color(0xFFD6F21D),
          title: Text("Gas Price Calculator"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DisplayText("Amount you owe at the pump"),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Text(
                "\$ ${(gallonsPumped * pricePerGallon).toStringAsFixed(2)}",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            DisplayText(
              "Input the gallons to fill",
              fontSize: 30.0,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2, color: Colors.black)),
                    child: IconButton(
                        onPressed: () {
                          print("Minus Button Pressed");
                          setState(() {
                            gallonsPumped = (gallonsPumped <= 0.0)
                                ? 0.0
                                : gallonsPumped - 0.1;
                          });
                        },
                        icon: Icon(FontAwesomeIcons.minus)),
                  ),
                  Text(
                    "${gallonsPumped.toStringAsFixed(2)}", // To display 2 digits after decimal
                    style:
                    TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2, color: Colors.black)),
                    child: IconButton(
                        onPressed: () {
                          print("Plus Button Pressed");
                          setState(() {
                            if (gallonsPumped < 30)
                              gallonsPumped = gallonsPumped + 0.1;
                          });
                        },
                        icon: Icon(FontAwesomeIcons.plus)),
                  ),
                ],
              ),
            ),
            DisplayText("Select the Gasoline Grade"),
            Center(
              child: DropdownButton<String>(
                value: dropdownValue,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    pricePerGallon = gasPricesMap[dropdownValue] ?? 0.0;
                  });
                },
                items: gasPricesMap.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            DisplayText("Todays price of ${dropdownValue} gasoline"),
            DisplayText(
              "\$ ${pricePerGallon.toStringAsFixed(2)}",
              fontSize: 40.0,
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
//Class : Display text.
class DisplayText extends StatelessWidget {
  String _textToDisplay; //Attribute: The text value to display
  double fontSize; // Font size is a public attribute
  DisplayText(this._textToDisplay, {this.fontSize = 20.0});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        _textToDisplay,
        style: TextStyle(
          fontSize: this.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}