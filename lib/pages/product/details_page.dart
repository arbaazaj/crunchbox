import 'dart:convert';

import 'package:crunchbox/creds/creds.dart';
import 'package:crunchbox/model/cart.dart';
import 'package:crunchbox/model/response.dart';
import 'package:crunchbox/pages/product/add_to_cart.dart';
import 'package:crunchbox/themes/colors.dart';
import 'package:crunchbox/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  final int productId;
  final String productName;

  ProductPage({Key? key, required this.productId, required this.productName})
      : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ManageCredentials creds = ManageCredentials();
  List<CartItem> addToCart = [];
  late Product product;

  Future<Product> getProduct() async {
    int id = widget.productId;
    if (id.toString().isNotEmpty) {
      final response = await http.get(Uri.parse(creds.baseUrl +
          endpointSingleProduct +
          '${widget.productId}?' +
          creds.consumerKey +
          creds.consumerSecret));

      if (response.statusCode == 200) {
        product = Product.fromJson(json.decode(response.body));
      }
    } else {
      Center(
          child: Text('Something went wrong go back',
              textScaleFactor: 1.7, style: TextStyle(color: kShrineAltYellow)));
    }
    return product;
  }

  var items = ['Half', 'Full'];
  var itemSelected = 'Half';
  var price = 230;

  _buildFooterButtons() {
    return <Widget>[
      MaterialButton(
        elevation: 6.0,
        color: kShrineBrown900,
        onPressed: () {
          CartItem cartItem = product as CartItem;
          addToCart.add(cartItem);

          GetStorage box = GetStorage();
          box.write(product.id.toString(), product);

          print(addToCart.length);
          print(box.getValues());

          //Get.to(() => AddToCart(cartList: addToCart));
        },
        child: Text(
          'Add to Cart',
          style: TextStyle(color: kShrineAltYellow),
        ),
        padding: EdgeInsets.all(16.0),
      ),
      MaterialButton(
        elevation: 6.0,
        color: kShrineAltYellow,
        onPressed: () {},
        child: Text(
          'Buy Now',
          style:
              TextStyle(color: kShrineAltDarkGrey, fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.all(16.0),
      )
    ];
  }

  FutureBuilder<Product> buildFutureBuilder() {
    return FutureBuilder<Product>(
      future: getProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (snapshot.hasData) {
          var product = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // AspectRatio(
                //   aspectRatio: 10.10 / 8,
                //   child: Carousel(
                //     dotSize: 5.0,
                //     dotColor: kShrineAltYellow,
                //     dotBgColor: Colors.transparent,
                //     overlayShadow: true,
                //     overlayShadowColors: kShrineAltDarkGrey,
                //     images: [
                //       AssetImage('assets/default_image.jpg'),
                //       AssetImage('assets/default_image.jpg'),
                //       AssetImage('assets/default_image.jpg'),
                //       AssetImage('assets/default_image.jpg'),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        product.images[0].productImageSrc,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              product.name,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 24.0, color: kShrineAltYellow),
                            ),
                            // DropdownButton(
                            //   items: items.map((String value) {
                            //     return DropdownMenuItem(
                            //       child: Text(value),
                            //       value: value,
                            //     );
                            //   }).toList(),
                            //   onChanged: (value) {
                            //     setState(() {
                            //       if (value == 'Full') {
                            //         price = 360;
                            //       } else {
                            //         price = 230;
                            //       }
                            //       itemSelected = value.toString();
                            //     });
                            //   },
                            //   value: itemSelected,
                            // ),
                          ],
                        ),
                      ),
                      Divider(),
                      Text(
                        'Price: \$${product.price}',
                        textScaleFactor: 1.3,
                        style: TextStyle(color: kShrineAltYellow),
                      ),
                      Divider(),
                      Text(
                        'Description',
                        textScaleFactor: 1.4,
                        style: TextStyle(color: kShrineAltYellow),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(product.shortDescription),
                      Divider(),
                      Text(
                        'Payment Mode',
                        textScaleFactor: 1.4,
                        style: TextStyle(color: kShrineAltYellow),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        '💵 Cash On Delivery',
                        textScaleFactor: 1.1,
                      ),
                      Divider(),
                      Text(
                        'Place Order via Call',
                        textScaleFactor: 1.4,
                        style: TextStyle(color: kShrineAltYellow),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                        child: MaterialButton(
                          padding: const EdgeInsets.all(8.0),
                          color: kShrineBrown900,
                          highlightColor: kShrineAltYellow,
                          onPressed: () {},
                          shape: BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0))),
                          child: Text(
                            'Call Now',
                            textScaleFactor: 1.2,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kShrineAltYellow),
            ),
          );
        }
        return Center(
            child: Text(
          'Something went wrong go back',
          textScaleFactor: 1.7,
          style: TextStyle(
            color: kShrineAltYellow,
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kShrineAltDarkGrey,
      persistentFooterButtons: _buildFooterButtons(),
      appBar: AppBar(
        backgroundColor: kShrineAltDarkGrey,
        foregroundColor: kShrineAltYellow,
        centerTitle: true,
        title: Text(
          widget.productName,
          textScaleFactor: 1.2,
          style: TextStyle(fontFamily: 'Beyno', color: kShrineAltYellow),
        ),
      ),
      body: buildFutureBuilder(),
    );
  }
}
