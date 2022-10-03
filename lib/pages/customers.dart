import 'package:crunchbox/creds/creds.dart';
import 'package:crunchbox/model/response.dart';
import 'package:crunchbox/themes/colors.dart';
import 'package:flutter/material.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  final ManageCredentials creds = ManageCredentials();

  final customersEndpoint = 'customers?';

  List<CustomersModel> customersList = [];

  // Future<List<CustomersModel>> getAllCustomers() async {
  //   final res = await http.get(Uri.parse(creds.baseUrl +
  //       customersEndpoint +
  //       creds.consumerKey +
  //       creds.consumerSecret));
  //
  //   if (res.statusCode == 200) {
  //     return customersList = (json.decode(res.body) as List)
  //         .map((json) => CustomersModel.fromJson(json))
  //         .toList();
  //   } else {
  //     throw Exception('Failed to get customers');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kShrineAltYellow,
      appBar: AppBar(
        foregroundColor: kShrineAltYellow,
        backgroundColor: kShrineAltDarkGrey,
        title: Text('Customers'),
        centerTitle: true,
      ),
      //
      body: Center(child: Text('Hello world')),
    );
  }
}
