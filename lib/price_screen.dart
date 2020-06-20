import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
//const List<String> currencyList = ['USD', 'EUR', 'THB'];

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

List<DropdownMenuItem<String>> dropDrowList = [];

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> outputList = [];

    //for (int i = 0; i < currencyList.length; i++) {

    //   outputList.add(
    //     DropdownMenuItem(
    //       child: Text(currencyList[i]),
    //       value: currencyList[i],
    //     ),
    //   );

    // You can also use " For in" in this case which will return the samething.
    for (String currency in currenciesList) {
      outputList.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );

      //print(currencyList[i]);
    }
    //return ;
    return DropdownButton<String>(
      value: selectedCurrency,
      dropdownColor: Colors.black,
      items: outputList,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
            print(value);
          },
        );
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> pickerList = [];
    for (String currency in currenciesList) {
      pickerList.add(Text(currency));

      //print(currencyList[i]);
    }
    //return pickerList;
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      scrollController: FixedExtentScrollController(initialItem: 20),
      children: pickerList,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      print('this is ios');
      return iOSPicker();
    } else if (Platform.isAndroid) {
      print('this is android');
      return androidDropDownButton();
    }
  }

  String selectedCurrency = 'USD';

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.pink[200],
            width: 20,
            //color: Colors.lightBlue,
            //child: androidDropDownButton(),
            child: getPicker(),
          )
          //child:
        ],
      ),
    );
  }
}
