import '../modal/coininfo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class CoinListView extends StatefulWidget {
  @override
  createState() => new CoinListViewState();
}

class CoinListViewState extends State<CoinListView> {
  List<CoinInfo> _listCoin = new List<CoinInfo>();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('coinlist').snapshots().listen((data) {
      data.documents.forEach((doc) {
        CoinInfo coinItem = new CoinInfo();
        coinItem.id = doc["id"];
        coinItem.marketCapUSD = doc["marketCapUSD"];
        coinItem.img = doc["img"];
        coinItem.name = doc["name"];
        coinItem.priceChange1H = doc["priceChange1H"];
        coinItem.priceChange24H = doc["priceChange24H"];
        coinItem.priceChange7D = doc["priceChange7D"];
        coinItem.priceUSD = doc["priceUSD"];
        coinItem.rank = doc["rank"];
        coinItem.symbolText = doc["symbolText"];
        coinItem.volumeUSD = doc["volumeUSD"];
        setState(() {
          _listCoin.add(coinItem);
          if (isLoading) {
            isLoading = false;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : new ListView.builder(
            itemCount: _listCoin.length,
            itemBuilder: (BuildContext ctx, int index) {
              return new Card(
                  child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  new Expanded(
                    child: new Container(
                      alignment: Alignment.centerLeft,
                      margin: new EdgeInsets.all(8.0),
                      padding: new EdgeInsets.all(8.0),
                      height: 80,
                      child: _getBasicInfo(_listCoin[index]),
                    ),
                    flex: 2,
                  ),
                  new Expanded(
                    child: (new Container(
                      alignment: Alignment.centerRight,
                      margin: new EdgeInsets.all(8.0),
                      padding: new EdgeInsets.all(8.0),
                      height: 80,
                      child: _getPriceChangeInfo(_listCoin[index]),
                    )),
                    flex: 2,
                  ),
                ],
              ));
            });
  }

  Column _getBasicInfo(CoinInfo coinInfo) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Expanded(
          child: new Image.memory(
            base64.decode(coinInfo.img),
            width: 36,
            height: 36,
          ),
          flex: 5,
        ),
        new Expanded(
          child: new RichText(
              text: new TextSpan(
            text: 'Price:  ' + coinInfo.priceUSD,
            style:
                new TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          )),
          flex: 2,
        )
      ],
    );
  }

  Column _getPriceChangeInfo(CoinInfo coinInfo) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          child: new RichText(
              text: new TextSpan(
                  text: coinInfo.priceChange1H + " 1H",
                  style: _getPriceTextStyle(coinInfo.priceChange1H))),
          flex: 2,
        ),
        new Expanded(
          child: new RichText(
              text: new TextSpan(
                  text: coinInfo.priceChange24H + " 24H",
                  style: _getPriceTextStyle(coinInfo.priceChange24H))),
          flex: 2,
        ),
        new Expanded(
          child: new RichText(
              text: new TextSpan(
                  text: coinInfo.priceChange7D + " 7D",
                  style: _getPriceTextStyle(coinInfo.priceChange7D))),
          flex: 2,
        )
      ],
    );
  }

  TextStyle _getPriceTextStyle(String price) {
    price = price.replaceAll("%", "");
    try {
      if (double.parse(price) > 0) {
        return new TextStyle(
            color: Colors.green, fontWeight: FontWeight.normal);
      } else {
        return new TextStyle(color: Colors.red, fontWeight: FontWeight.normal);
      }
    } catch (err) {
      return new TextStyle(color: Colors.black, fontWeight: FontWeight.normal);
    }
  }
}
