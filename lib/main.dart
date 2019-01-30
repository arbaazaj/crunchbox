import 'dart:convert';
import 'dart:math' as math;

import 'package:crunchbox/login.dart';
import 'package:crunchbox/model/response.dart';
import 'package:crunchbox/myaccount.dart';
import 'package:flutter/material.dart';

import 'package:crunchbox/colors.dart';
import 'package:crunchbox/cut_corners_border.dart';

import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crunch Box',
      theme: _buildShrineTheme(),
      home: MyHomePage(
        title: 'Crunch Box',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Woocommerce Api
  final baseUrl = "https://crworld.xyz/wp-json/wc/v3/";
  final consumerKey =
      "consumer_key=ck_a6dd2423f9846648d5943da635f6f1335ad812e4";
  final consumerSecret =
      "&consumer_secret=cs_58abf2aacfcc931a1b864df17ae727e522532821";
  final endpointCategory = "products/categories?";
  final categoryAttributesPerPage = "&per_page=15";
  final categoryAttributesSubCat = "&parent=30";
  final categoryAttributesDisplay = "&display=subcategories";
  final endpointProducts = "products?";
  List<Products> productsList = [];
  List<Category> categoryList = [];

  // HTTP Call to fetch Products
  Future<List<Products>> getAllProducts() async {
    final response = await http
        .get(baseUrl + endpointProducts + consumerKey + consumerSecret);
    if (response.statusCode == 200) {
      return productsList = (json.decode(response.body) as List)
          .map((json) => Products.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // HTTP Call to fetch categories
  Future<List<Category>> getAllCategory() async {
    final response = await http.get(baseUrl +
        endpointCategory +
        consumerKey +
        consumerSecret +
        categoryAttributesPerPage);
    if (response.statusCode == 200) {
      return categoryList = (json.decode(response.body) as List)
          .map((json) => Category.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories.');
    }
  }

  // Random Color Generator
  Color randomColors() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1.0);
  }

  // Future Builder with products
  FutureBuilder<List<Products>> buildFutureBuilder() {
    return FutureBuilder(
        future: getAllProducts(),
        builder: (context, snapshots) {

          if (snapshots.hasError) {
            return Center(child: Text('Error: ${snapshots.error}'));
          } else if (snapshots.hasData) {
            return GridView.builder(
                itemCount: productsList == null ? 0 : productsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8.0,
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.fastfood),
                      title: Text(snapshots.data[index].name),
                      subtitle: Text('₹ ${snapshots.data[index].price}'),
                    ),
                  );
                });
          } else if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          /*
              return ListView.builder(
                  itemCount: productsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(snapshots.data[index].name[0]),
                      ),
                      title: Text(snapshots.data[index].name),
                      subtitle: Text('₹ ${snapshots.data[index].price}'),
                      trailing: IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            print(
                                'Item "${snapshots.data[index].name}" added, Pay ₹ ${snapshots.data[index].price}');
                          }),
                      onTap: () {},
                    );
                  });
                  */
        });
  }

  // Drawer with categories
  Drawer buildDrawer() {

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Crunch Box',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: kShrineAltYellow,
                      decoration: TextDecoration.underline,
                      wordSpacing: 2.0,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.5
                        ..colorFilter =
                            ColorFilter.mode(kShrineAltYellow, BlendMode.darken)
                        ..color = Colors.white,
                      fontSize: 26.0,
                      fontFamily: 'Beyno'),
                ),
                Text(
                  'Menu',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: kShrineAltYellow,
                      fontSize: 18.0,
                      fontFamily: 'Beyno',
                      decoration: TextDecoration.underline),
                ),
                SizedBox(height: 6.0),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                        shape: Border.all(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: kShrineAltYellow),
                        colorBrightness: Brightness.dark,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Beyno',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getAllCategory(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    return null;
                  case ConnectionState.none:
                    return null;
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data[index].name),
                          leading: Icon(Icons.category),
                          onTap: () {
                            print(snapshot.data[index].name);
                          },
                        );
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _openDrawer = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _openDrawer,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.restaurant_menu), onPressed: () {
          _openDrawer.currentState.openDrawer();
        }),
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Beyno',
            color: kShrineAltYellow,
            fontSize: 22.0,
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.account_circle), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccount()));
          })
        ],
        centerTitle: true,
      ),
      backgroundColor: kShrineAltYellow,
      drawer: buildDrawer(),
      body: buildFutureBuilder(),
    );
  }
}


// Custom Theme

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    accentColor: kShrineAltDarkGrey,
    primaryColor: kShrineAltDarkGrey,
    buttonColor: kShrineAltYellow,
    scaffoldBackgroundColor: kShrineAltDarkGrey,
    cardColor: kShrineAltDarkGrey,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(color: kShrineAltYellow),
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(),
    ),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        //fontFamily: 'Beyno',
        displayColor: kShrineSurfaceWhite,
        bodyColor: kShrineSurfaceWhite,
      );
}
