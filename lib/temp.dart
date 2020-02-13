import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Coin Exchange Rates",
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,

      ),
      home: MyApplication(),
      
    );
  }
}

Future<String> loadAsset() async{
  
    return await rootBundle.loadString('assets/json/coinprice.json');
  }



Timer timer;

class MyApplication extends StatefulWidget {
  @override
  _MyApplicationState createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> with SingleTickerProviderStateMixin {

  TabController tabController;

  

  @override
  void initState()
  {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => loadAsset());
    tabController = new TabController(length: 5,vsync: this);
    
  }

  @override
  void dispose()
  {
    tabController.dispose();
    timer?.cancel();
    super.dispose();
  }

  List data;

 

  @override
  Widget build(BuildContext context) {

    Timer.periodic(Duration(seconds: 2), (Timer t) => loadAsset());

    return Scaffold(
      appBar: AppBar(
        title: new Text("CoinExchangeRates", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        bottom:  new TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(
              icon: Container(
                child: Image(
                  image: AssetImage('assets/images/btc.png'),
                  fit: BoxFit.cover,
                ),
                height: 30,
                width: 30, 
              ),
              text: "BTC",
            ),
            new Tab(
              icon: Container(
                child: Image(
                  image: AssetImage('assets/images/eth.png'),
                  fit: BoxFit.cover,
                ),
                height: 30,
                width: 30,               
              ),
              text: "ETH",
            ),
            new Tab(
              icon: Container(
                child: Image(
                  image: AssetImage('assets/images/bch.png'),
                  fit: BoxFit.cover,
                ),
                height: 30,
                width: 30, 
              ),
              text: "BCH",
            ),
            new Tab(
              icon: Container(
                child: Image(
                  image: AssetImage('assets/images/ltc.png'),
                  fit: BoxFit.cover,
                ),
                height: 30,
                width: 30, 
              ),
              text: "LTC",
            ),
            new Tab(
              icon: Container(
                child: Image(
                  image: AssetImage('assets/images/xrp.png'),
                  fit: BoxFit.cover,
                ),
                height: 30,
                width: 30, 
              ),
              text: "XRP",
            ),
          ],
        ),

        
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[

            new UserAccountsDrawerHeader(
              accountName: new Text("Coin Exchane Rates",style: TextStyle(color: Colors.black)),
              accountEmail: new Text("bhaintoodevs@gmail.com",style: TextStyle(color: Colors.black)),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.png')
              ),
            ),

            new ListTile(
              title: new Text("Notifications"),
              // trailing: new Icon(Icons.arrow_upward),
            ),
            new ListTile(
              title: new Text("Bugs & Suggestions"),
              // trailing: new Icon(Icons.arrow_downward),
            ),
            // new Divider(),
            new ListTile(
              title: new Text("Rate Us"),
              // trailing: new Icon(Icons.close),
              // onTap: () => Navigator.of(context).pop(), //To Close Nav bar on tap
            ),
             new ListTile(
              title: new Text("Get Reward"),
              // trailing: new Icon(Icons.arrow_downward),
            ),
             new ListTile(
              title: new Text("About Us"),
              // trailing: new Icon(Icons.arrow_downward),
            ),
          ],
        ),
      ),

       

      body: new FutureBuilder(
        
        future: loadAsset(), //DefaultAssetBundle.of(context).loadString('assets/json/coinprice.json'), //-------------JSON IMPORT HERE-----------------
        builder: (context,snapshot){
          //DECODE JSON-------------------------------#####################################
          var mydata = json.decode(snapshot.data.toString());
          
          return  TabBarView(
            children: <Widget>[
            new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                new Container(
                  color: Colors.teal[900],
                  height: 100.0,
                  child : new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: new SizedBox(height: 20.0,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: new Text("BEST PRICES",style: TextStyle(fontSize: 18),),
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
                                 new Text("Buy : "), new Text(""+mydata[0]['best_btc_buy'].toString(),style: TextStyle(color: Colors.green),)  
                              ],
                            ),
                           
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['best_btc_sell'].toString(),style: TextStyle(color: Colors.red),),
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
                            new Text("From : "+mydata[0]['best_btc_buy_from'].toString(),),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Text("To : "+mydata[0]['best_btc_sell_to'].toString(),),
                            )
                          ],
                      ),
                      ),
                    ],
                  )
                ),
  //------------------------ BuyuCoin starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("BUYUCOIN", style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['buyucoin_btc_buy'].toString(),style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['buyucoin_btc_sell'].toString(),style: TextStyle(color: Colors.red)),
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
                ),
                //------------------------ Coinome starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("COINOME", style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['coinome_btc_buy'].toString(),style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['coinome_btc_sell'].toString(),style: TextStyle(color: Colors.red)),
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
                ),
                //------------------------ CoinDeLta starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("COINDELTA",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['coindelta_btc_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                   new Text("Sell : "), new Text(""+mydata[0]['coindelta_btc_sell'].toString(),style: TextStyle(color: Colors.red)),
                                ]
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
                      
                    ],
                  )
                ),
                //------------------------ CoinSecure starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("COINSECURE",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['coinsecure_btc_buy'].toString(),style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[ 
                              new Text("Sell : "), new Text(""+mydata[0]['coinsecure_btc_sell'].toString(),style: TextStyle(color: Colors.red)),

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
                      
                    ],
                  )
                ),
                //------------------------ Koinex starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("KOINEX",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['koinex_btc_buy'].toString(),style: TextStyle(color: Colors.green)),
                             ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['koinex_btc_sell'].toString(),style: TextStyle(color: Colors.red)),
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
                ),
                //------------------------ PocketBits starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("POCKETBITS",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['pocketbits_btc_buy'].toString(),style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['pocketbits_btc_sell'].toString(),style: TextStyle(color: Colors.red)),
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
                ),
                //------------------------ UnoCoin starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("UNOCOIN",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['unocoin_btc_buy'].toString(),style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['unocoin_btc_sell'].toString(),style: TextStyle(color: Colors.red)),
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
                ),
                //------------------------ Zebpay starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("ZEBPAY",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['zebpay_btc_buy'].toString(),style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['zebpay_btc_sell'].toString(),style: TextStyle(color: Colors.red)),
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
                      
                    ],
                  )
                ),
                
              ],
            ),
          ),
//---------------------------------------------------------Second Tab--------------------------------------------------------------------//
          new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new Container(
                  color: Colors.teal[900],
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
                                new Text("Buy : "), new Text(""+mydata[0]['best_eth_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: 
                              new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['best_eth_sell'].toString(),style: TextStyle(color: Colors.red))
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
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                             children: <Widget>[
                                new Text("From : ",), new Text(""+mydata[0]['best_eth_buy_from'].toString())
                             ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                   new Text("To : ",), new Text(""+mydata[0]['best_eth_sell_to'].toString())
                                ],
                              )
                            )
                          ],
                      ),
                      ),
                    ],
                  )
                ),
              //------------------------ CoinDelta starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("COINDELTA",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['coindelta_eth_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['coindelta_eth_sell'].toString(),style: TextStyle(color: Colors.red))
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
                ),
                //------------------------ Ethexindia starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("ETHEXINDIA",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['ethex_eth_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                           
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['ethex_eth_sell'].toString(),style: TextStyle(color: Colors.red))
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
                ),
                //------------------------ Koinex starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("KOINEX",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['koinex_eth_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                           
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['koinex_eth_sell'].toString(),style: TextStyle(color: Colors.red))
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
                ), 
              ],
            ),
          ),
//-------------------------------------------------------------------Third Tab---------------------------------------------------------
          new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new Container(
                  color: Colors.teal[900],
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
                                new Text("Buy : "), new Text(""+mydata[0]['best_bch_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['best_bch_sell'].toString(),style: TextStyle(color: Colors.red))
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
                                new Text("From : ",), new Text(""+mydata[0]['best_bch_buy_from'].toString())
                             ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("To : ",), new Text(""+mydata[0]['best_bch_sell_to'].toString())
                                ],
                            ),
                            )
                          ],
                      ),
                      ),
                    ],
                  )
                ),
                //----------------------------------- CoinDelta starts here------------------------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("COINDELTA",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['coindelta_bch_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['coindelta_bch_sell'].toString(),style: TextStyle(color: Colors.red))
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
                      
                    ],
                  )
                ),
                //------------------------ Coinome starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("COINOME",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['coinome_bch_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['coinome_bch_sell'].toString(),style: TextStyle(color: Colors.red))
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
                      
                    ],
                  )
                ),
                //------------------------ Koinex starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("KOINEX",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['koinex_bch_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['koinex_bch_sell'].toString(),style: TextStyle(color: Colors.red))
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
                      
                    ],
                  )
                ), 
              ],
            ),
          ),
//---------------------------------------------------------------Fourth Tab Starts here----------------------------------------------------------
          new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
               new Container(
                  color: Colors.teal[900],
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
                                new Text("Buy : "), new Text(""+mydata[0]['best_ltc_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['best_ltc_sell'].toString(),style: TextStyle(color: Colors.red))
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
                                new Text("From : ",), new Text(""+mydata[0]['best_ltc_buy_from'].toString())
                             ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("To : ",), new Text(""+mydata[0]['best_ltc_sell_to'].toString())
                                ],
                            ),
                            )
                          ],
                      ),
                      ),
                    ],
                  )
                ),
              //------------------------ CoinDelta starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("COINDELTA",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['coindelta_ltc_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['coindelta_ltc_sell'].toString(),style: TextStyle(color: Colors.red))
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
                      
                    ],
                  )
                ),
                //------------------------ Coinome starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("COINOME",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['coinome_ltc_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['coinome_ltc_buy'].toString(),style: TextStyle(color: Colors.red))
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
                      
                    ],
                  )
                ),
                //------------------------ Koinex starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("KOINEX",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['koinex_ltc_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['koinex_ltc_sell'].toString(),style: TextStyle(color: Colors.red))
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
                      
                    ],
                  )
                ), 
              ],
            ),
          ),
//----------------------------------------------Fifth Tab starts here----------------------------------------------------------------
          new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
               new Container(
                  color: Colors.teal[900],
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
                                new Text("Buy : "), new Text(""+mydata[0]['best_xrp_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['best_xrp_sell'].toString(),style: TextStyle(color: Colors.red))
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
                                new Text("From : ",), new Text(""+mydata[0]['best_xrp_buy_from'].toString())
                             ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("To : ",), new Text(""+mydata[0]['best_xrp_sell_to'].toString())
                                ],
                            ),
                            )
                          ],
                      ),
                      ),
                    ],
                  )
                ),
  //------------------------ BTXindia starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("BTXINDIA",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['btcx_xrp_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['btcx_xrp_sell'].toString(),style: TextStyle(color: Colors.red))
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
                      
                    ],
                  )
                ),
                //------------------------ Coindelta starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("COINDELTA",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['coindelta_xrp_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['coindelta_xrp_sell'].toString(),style: TextStyle(color: Colors.red))
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
                      
                    ],
                  )
                ),
                //------------------------ Koinex starts here------------------------------//
                new Container(            
                  // color: Colors.white,
                  height: 80.0,
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
                        child: new Text("KOINEX",style: TextStyle(fontSize: 18)),
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
                                new Text("Buy : "), new Text(""+mydata[0]['koinex_xrp_buy'].toString(),style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text("Sell : "), new Text(""+mydata[0]['koinex_xrp_sell'].toString(),style: TextStyle(color: Colors.red))
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
                      
                    ],
                  )
                ), 
              ],
            ),
          ),
        ],
        controller: tabController,
      );
          
      },
    ),
      
    );
  }
}

// class NewPage extends StatelessWidget {
//   final String title;
//   NewPage(this.title);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: new Center(
//         child: new Text(title),
//       ),

//     );
//   }
// }