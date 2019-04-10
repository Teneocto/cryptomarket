import "package:flutter/material.dart";

class CoinListItem extends StatefulWidget {
  @override
  createState() => new CoinListViewState();
}

class CoinListViewState extends State<CoinListItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 0.8),
      decoration: BoxDecoration(color: Colors.white70),
    );
  }
}