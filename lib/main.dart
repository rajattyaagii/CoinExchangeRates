import 'dart:async';
import 'dart:convert';
import 'package:coinexchangerate/best_coin_row.dart';
import 'package:coinexchangerate/coin_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Coin Exchange Rates",
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.light,

      ),
      home: MyApplication(),
      
    );
  }
}

Future<List> res() async{
    var url = "http://5de286fe81d1f60014789ff7.mockapi.io/cointest";
    http.Response response = await http.get(url);
    var responseBody = json.decode(response.body);
    return responseBody;
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
    setState(() {
      const oneSecond = const Duration(seconds: 20);
      new Timer.periodic(oneSecond, (Timer t) => setState((){}));
    });
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
        
        future: res(), 
        builder: (context,snapshot){
          
          if(snapshot.hasData){
            
            if(snapshot.data != null){
              var mydata = snapshot.data;
                return  TabBarView(
                children: <Widget>[
                
                  new SingleChildScrollView(
                    child: new Column(
                      children: <Widget>[
                        BestCoinRow(bestBuy: "best_btc_buy",bestSell: "best_btc_sell",bestBuyFrom: "best_btc_buy_from",bestSellTo: "best_btc_sell_to",data: mydata,),

                        
         
                        CoinRow(data: mydata,exchangeName: "BUYUCOIN" ,buyKeyName: "buyucoin_btc_buy",sellKeyName: "buyucoin_btc_sell",),
                        
                        CoinRow(data: mydata,exchangeName: "COINOME" ,buyKeyName: "coinome_btc_buy",sellKeyName: "coinome_btc_sell",),
                        
                        
                        CoinRow(data: mydata,exchangeName: "COINDELTA" ,buyKeyName: "coindelta_btc_buy",sellKeyName: "coindelta_btc_sell",),
                        
                        
                        CoinRow(data: mydata,exchangeName: "COINSECURE" ,buyKeyName: "coinsecure_btc_buy",sellKeyName: "coinsecure_btc_sell",),
                        
                        
                        CoinRow(data: mydata,exchangeName: "KOINEX" ,buyKeyName: "koinex_btc_buy",sellKeyName: "koinex_btc_sell",),
                        
                        
                        CoinRow(data: mydata,exchangeName: "POCKETBITS" ,buyKeyName: "pocketbits_btc_buy",sellKeyName: "pocketbits_btc_sell",),
                        
                    
                        CoinRow(data: mydata,exchangeName: "UNOCOIN" ,buyKeyName: "unocoin_btc_buy",sellKeyName: "unocoin_btc_sell",),
                        
                       
                        CoinRow(data: mydata,exchangeName: "ZEBPAY" ,buyKeyName: "zebpay_btc_buy",sellKeyName: "zebpay_btc_sell",),

                      ],
                    ),
                  ),
        //---------------------------------------------------------Second Tab--------------------------------------------------------------------//
                  new SingleChildScrollView(
                    child: new Column(
                      children: <Widget>[
                        BestCoinRow(bestBuy: "best_eth_buy",bestSell: "best_eth_sell",bestBuyFrom: "best_eth_buy_from",bestSellTo: "best_eth_sell_to",data: mydata,),
                        
                      
                      CoinRow(data: mydata,exchangeName: "COINDELTA" ,buyKeyName: "coindelta_eth_buy",sellKeyName: "coindelta_eth_sell",),
                        
                        
                        CoinRow(data: mydata,exchangeName: "ETHEXINDIA" ,buyKeyName: "ethex_eth_buy",sellKeyName: "ethex_eth_sell",),
                        
                        
                        CoinRow(data: mydata,exchangeName: "KOINEX" ,buyKeyName: "koinex_eth_buy",sellKeyName: "koinex_eth_sell",),
                        
                      ],
                    ),
                  ),
        //-------------------------------------------------------------------Third Tab---------------------------------------------------------
                  new SingleChildScrollView(
                    child: new Column(
                      children: <Widget>[
                        BestCoinRow(bestBuy: "best_bch_buy",bestSell: "best_bch_sell",bestBuyFrom: "best_bch_buy_from",bestSellTo: "best_bch_sell_to",data: mydata,),
                        
                        
                        CoinRow(data: mydata,exchangeName: "COINDELTA" ,buyKeyName: "coindelta_bch_buy",sellKeyName: "coindelta_bch_sell",),
                       
                        
                        CoinRow(data: mydata,exchangeName: "KOINEX" ,buyKeyName: "koinex_bch_buy",sellKeyName: "koinex_bch_sell",),
                        
                      ],
                    ),
                  ),
        //---------------------------------------------------------------Fourth Tab Starts here----------------------------------------------------------
                  new SingleChildScrollView(
                    child: new Column(
                      children: <Widget>[
                        BestCoinRow(bestBuy: "best_ltc_buy",bestSell: "best_ltc_sell",bestBuyFrom: "best_ltc_buy_from",bestSellTo: "best_ltc_sell_to",data: mydata,),
                      
                      
                      CoinRow(data: mydata,exchangeName: "COINDELTA" ,buyKeyName: "coindelta_ltc_buy",sellKeyName: "coindelta_ltc_sell",),
                        
                     
                        CoinRow(data: mydata,exchangeName: "COINOME" ,buyKeyName: "coinome_ltc_buy",sellKeyName: "coinome_ltc_buy",),
                        
                       
                        CoinRow(data: mydata,exchangeName: "KOINEX" ,buyKeyName: "koinex_ltc_buy",sellKeyName: "koinex_ltc_sell",),
                        
                      ],
                    ),
                  ),
        //----------------------------------------------Fifth Tab starts here----------------------------------------------------------------
                  new SingleChildScrollView(
                    child: new Column(
                      children: <Widget>[
                        BestCoinRow(bestBuy: "best_xrp_buy",bestSell: "best_xrp_sell",bestBuyFrom: "best_xrp_buy_from",bestSellTo: "best_xrp_sell_to",data: mydata,),
                      
         
                        CoinRow(data: mydata,exchangeName: "BTXINDIA" ,buyKeyName: "btcx_xrp_buy",sellKeyName: "btcx_xrp_sell",),
                        
                       
                        CoinRow(data: mydata,exchangeName: "COINDELTA" ,buyKeyName: "coindelta_xrp_buy",sellKeyName: "coindelta_xrp_sell",),
                        
                        
                        CoinRow(data: mydata,exchangeName: "KOINEX" ,buyKeyName: "koinex_xrp_buy",sellKeyName: "koinex_xrp_sell",),
                        
                      ],
                    ),
                  ),
              ],
              controller: tabController,
            );
            }
            else if(snapshot.connectionState == ConnectionState.waiting)
            {
              CircularProgressIndicator();
            }
          
          
          }
          
          else if (!snapshot.data) {
            CircularProgressIndicator();
          }
          else{
            CircularProgressIndicator();
          }
          
          // else if (snapshot.hasError) {
          //   return new Text("${snapshot.error}");
          // }
          
      },
    ),
      
    );
  }
}

