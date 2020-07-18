import 'package:flutter/material.dart';

class CoinRow extends StatelessWidget {

  List data = [];
  String exchangeName;
  String buyKeyName;
  String sellKeyName;

  CoinRow({
    this.data,
    this.exchangeName,
    this.buyKeyName,
    this.sellKeyName

    });

  @override
  Widget build(BuildContext context) {
    return   Container(            
                          // color: Colors.white,
              height: 80.0,
              child :  Column(
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
                    child: new Text(exchangeName, style: TextStyle(fontSize: 18)),
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
                            new Text("Buy : "), new Text(""+data[0]['$buyKeyName'].toString(),style: TextStyle(color: Colors.green)),
                          ],
                        ),
                        
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: new Row(
                            children: <Widget>[
                              new Text("Sell : "), new Text(""+data[0]['$sellKeyName'].toString(),style: TextStyle(color: Colors.red)),
                            ],
                          )
                          
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
                  
                ],
              )
            );
  }
}