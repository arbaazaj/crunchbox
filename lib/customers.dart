import 'dart:convert';

import 'package:crunchbox/creds/creds.dart';
import 'package:crunchbox/model/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  ManageCredentials creds = ManageCredentials();

  final customersEndpoint = 'customers?';

  List<CustomersModel> customersList = [];

  Future<List<CustomersModel>> getAllCustomers() async {
    final res = await http.get(Uri.parse(creds.baseUrl +
        customersEndpoint +
        creds.consumerKey +
        creds.consumerSecret));

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
                child: Text(snapshot.error as String),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: customersList == null ? 0 : customersList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].firstName! +
                          ' ' +
                          snapshot.data![index].lastName!),
                      subtitle: Text(snapshot.data![index].email!),
                    );
                  });
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            ));
          }),
    );
  }
}
