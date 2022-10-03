import 'dart:convert';

import 'package:crunchbox/creds/creds.dart';
import 'package:crunchbox/model/response.dart';
import 'package:crunchbox/pages/myaccount.dart';
import 'package:crunchbox/themes/colors.dart';
import 'package:crunchbox/utils/api_endpoints.dart';
import 'package:crunchbox/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Woocommerce Api
  ManageCredentials creds = ManageCredentials();

  // Drawer Global Key initialization.
  final GlobalKey<ScaffoldState> _openDrawer = GlobalKey<ScaffoldState>();

  // Empty lists.
  List<Products> productsList = [];
  List<Category> categoryList = [];

  // HTTP API call to fetch Products
  Future<List<Products>> getAllProducts() async {
    final response = await http.get(Uri.parse(creds.baseUrl +
        endpointProducts +
        creds.consumerKey +
        creds.consumerSecret));
    if (response.statusCode == 200) {
      return productsList = (json.decode(response.body) as List)
          .map((json) => Products.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // HTTP Call to fetch categories
  // Future<List<Category>> getAllCategory() async {
  //   final response = await http.get(Uri.parse(creds.baseUrl +
  //       endpointCategory +
  //       creds.consumerKey +
  //       creds.consumerSecret +
  //       categoryAttributesPerPage));
  //   if (response.statusCode == 200) {
  //     return categoryList = (json.decode(response.body) as List)
  //         .map((json) => Category.fromJson(json))
  //         .toList();
  //   } else {
  //     throw Exception('Failed to load categories.');
  //   }
  // }
  // Future Builder with products

  // Building body with fetched data from api call and
  // representing it in a GridView.builder.
  FutureBuilder<List<Products>> buildFutureBuilder() {
    return FutureBuilder(
        future: getAllProducts(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return Center(child: Text('Error: ${snapshots.error}'));
          } else if (snapshots.hasData) {
            return GridView.builder(
                itemCount: productsList.isEmpty ? 0 : productsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8.0,
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.fastfood),
                      title: Text(snapshots.data![index].name!),
                      subtitle: Text('₹ ${snapshots.data![index].price}'),
                    ),
                  );
                });
          } else if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Container();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _openDrawer,
      appBar: AppBar(
        foregroundColor: kShrineAltYellow,
        backgroundColor: kShrineAltDarkGrey,
        // Categories of food in a drawer menu style.
        leading: IconButton(
            icon: Icon(Icons.restaurant_menu),
            onPressed: () {
              _openDrawer.currentState!.openDrawer();
            }),
        title: Text(
          widget.title!,
          style: TextStyle(fontFamily: 'Beyno', fontSize: 22.0),
        ),
        actions: <Widget>[
          // My account page icon.
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyAccount(
                            id: null,
                          )));
            },
          ),
        ],
        centerTitle: true,
      ),
      backgroundColor: kShrineAltYellow,
      drawer: CustomDrawer(),
      body: buildFutureBuilder(),
    );
  }
}
