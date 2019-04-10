import 'package:flutter/material.dart';
import 'package:cryptomarket/assets/StringAssets.dart';
import 'view/coin_list_view.dart';

class CryptoApp extends StatefulWidget {
  @override
  CryptoAppState createState() => CryptoAppState();
}

class CryptoAppState extends State<CryptoApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: StringAssets.appName,
      home: Scaffold(
        appBar: _appBar,
        bottomNavigationBar: _bottomBar,
        body: Container(
          // Add box decoration
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            color: Colors.white,
          ),
          child: Center(
            child: new CoinListView(),
          ),
        ),
      ),
    );
  }
}

final _bottomBar = Container(
  height: 55.0,
  child: BottomAppBar(
    color: Colors.blue,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.account_balance_wallet, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.monetization_on, color: Colors.white),
          onPressed: () {},
        ),
      ],
    ),
  ),
);

final _appBar = AppBar(title: Text(StringAssets.appName), actions: <Widget>[
  IconButton(
    icon: Icon(Icons.search),
    color: Colors.white,
    onPressed: () {
      // TODO
    },
  ),
  IconButton(
    icon: Icon(Icons.sort),
    color: Colors.white,
    onPressed: () {
      // TODO
    },
  ),
  IconButton(
    icon: Icon(Icons.favorite),
    color: Colors.white,
    onPressed: () {
      // TODO
    },
  ),
  IconButton(
    icon: Icon(Icons.list),
    color: Colors.white,
    onPressed: () {
      // TODO
    },
  ),
]);

void main() {
  runApp(CryptoApp());
}
