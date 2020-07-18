import 'package:flutter/material.dart';

class BestCoinRow extends StatelessWidget {

  List data = [];
  String bestBuy;
  String bestSell;
  String bestBuyFrom;
  String bestSellTo;


  BestCoinRow({
    this.data,
    this.bestBuy,
    this.bestSell,
    this.bestBuyFrom,
    this.bestSellTo
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.teal[200],
      height: 100.0,
      child : new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
            child: new SizedBox(height: 10.0,),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
            child: new Text("BEST PRICES",style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
            child: new SizedBox(height: 10.0,),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Text("Buy : "), new Text(""+data[0]['$bestBuy'].toString(),style: TextStyle(color: Colors.green))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: new Row(
                    children: <Widget>[
                      new Text("Sell : "), new Text(""+data[0]['$bestSell'].toString(),style: TextStyle(color: Colors.red))
                    ],
                  ),
                ) 
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
            child: new SizedBox(height: 10.0,),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              new Row(
                children: <Widget>[
                    new Text("From : ",), new Text(""+data[0]['$bestBuyFrom'].toString())
                ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: new Row(
                    children: <Widget>[
                      new Text("To : ",), new Text(""+data[0]['$bestSellTo'].toString())
                    ],
                ),
                )
              ],
          ),
          ),
        ],
      )
    );
  }
}