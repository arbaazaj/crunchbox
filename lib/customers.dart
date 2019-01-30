import 'dart:convert';

import 'package:crunchbox/creds/creds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crunchbox/model/response.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  final String baseUrl = "https://crworld.xyz/wp-json/wc/v3/";
  final String consumerKey =
      "consumer_key=ck_a6dd2423f9846648d5943da635f6f1335ad812e4";
  final String consumerSecret =
      "&consumer_secret=cs_58abf2aacfcc931a1b864df17ae727e522532821";

  final customersEndpoint = 'customers?';

  List<CustomersModel> customersList = [];

  Future<List<CustomersModel>> getAllCustomers() async {
    final res = await http
        .get(baseUrl + customersEndpoint + consumerKey + consumerSecret);

    if (res.statusCode == 200) {
      return customersList = (json.decode(res.body) as List)
          .map((json) => CustomersModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to get customers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CustomersModel>>(
          future: getAllCustomers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: customersList == null ? 0 : customersList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].firstName + ' ' + snapshot.data[index].lastName),
                      subtitle: Text(snapshot.data[index].email),
                    );
              });
            }
            return Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            ));
          }),
    );
  }
}
