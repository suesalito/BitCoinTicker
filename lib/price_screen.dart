//import 'dart:html';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'dart:convert';
//const List<String> currencyList = ['USD', 'EUR', 'THB'];

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

List<DropdownMenuItem<String>> dropDrowList = [];
Map<String, double> rate = {};

void setupMap() {
  double x = 10;
  for (String s in cryptoList) {
    rate['$s'] = x;
    x += 1;
    print(rate['$s']);
  }
  print(rate);
}

class _PriceScreenState extends State<PriceScreen> {
  List<Widget> cardCryptoList() {
    List<Widget> returnList = [];
    for (String cryptoName in cryptoList) {
      returnList.add(Padding(
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
              '1 $cryptoName = ${rate[cryptoName]}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
    }
    return returnList;
  }

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
        print(currenciesList[selectedIndex]);
        selectedCurrency = currenciesList[selectedIndex];
        print('Selected Currency is $selectedCurrency');
        getDataFromInput();
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
  String priceBTC = 'Loading....';

  Future getCoinExRate(String url) async {
    // http.Response response =
    //     await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey');

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      print('Cannot get the exchange rate.');
    }
  }

  void getDataInitWithUSD() async {
//     const apikey = '?apikey=BAE2F07A-6116-4268-9E27-FBF1FF142D82';
// const defaultapi = 'https://rest.coinapi.io/v1/exchangerate/BTC/';
    String inputUrl = '$defaultapi$selectedCurrency$apikey';
    print(inputUrl);
    var coinData = await getCoinExRate(inputUrl);
    print(coinData['rate']);
    priceBTC = coinData['rate'].toStringAsFixed(3);
    print(priceBTC);
    setState(() {
      priceBTC = '${coinData['rate'].toStringAsFixed(3)} $selectedCurrency';
    });
  }

  void getDataFromInput() async {
//     const apikey = '?apikey=BAE2F07A-6116-4268-9E27-FBF1FF142D82';
// const defaultapi = 'https://rest.coinapi.io/v1/exchangerate/BTC/';
    setState(() {
      priceBTC = 'Loading...';
    });
    String inputUrl = '$defaultapi$selectedCurrency$apikey';
    var coinData = await getCoinExRate(inputUrl);
    print(coinData['rate']);
    priceBTC = coinData['rate'].toStringAsFixed(3);
    print(priceBTC);
    setState(() {
      priceBTC = '${coinData['rate'].toStringAsFixed(3)} $selectedCurrency';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setupMap();
    //getDataInitWithUSD();
    super.initState();
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
        //children: cardCryptoList(),
        children: <Widget>[
          Column(
            children: cardCryptoList(),
            // children: <Widget>[
            //   Padding(
            //     padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            //     child: Card(
            //       color: Colors.lightBlueAccent,
            //       elevation: 5.0,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //       child: Padding(
            //         padding:
            //             EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            //         child: Text(
            //           '1 BTC = $priceBTC',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             fontSize: 20.0,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),

            // ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.pink[200],
            width: 20,
            //color: Colors.lightBlue,
            //child: androidDropDownButton(),
            //child: getPicker(),
            // you can also call to create child with short condition trick as
            child: Platform.isIOS ? iOSPicker() : androidDropDownButton(),
          )
          //child:
        ],
      ),
    );
  }
}
