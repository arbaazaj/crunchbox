import 'dart:convert';

import 'package:crunchbox/colors.dart';
import 'package:crunchbox/create_account.dart';
import 'package:crunchbox/creds/creds.dart';
import 'package:crunchbox/model/response.dart';
import 'package:crunchbox/myaccount.dart';
import 'package:crunchbox/utils/accentColorOverride.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ManageCredentials creds = ManageCredentials();

  final loginEndpoint = 'customers?';

  final emailController = TextEditingController();
  final passController = TextEditingController();

  List<CustomersModel> listOfCustomers = [];

  Future<List<CustomersModel>> login(String email, String password) async {
    final response = await http.get(Uri.parse(creds.baseUrl +
        loginEndpoint +
        creds.consumerKey +
        creds.consumerSecret));
    if (response.statusCode == 200) {
      listOfCustomers = (json.decode(response.body) as List)
          .map((json) => CustomersModel.fromJson(json))
          .toList();
      print(response.body);

      for (var i in listOfCustomers.map((data) {
        if (email == data.email) {
          int? customerId = data.id;
          print('Email Matched ${data.id}');
          Future<CustomersModel?> getCustomerData() async {
            final res = await http.get(Uri.parse(creds.baseUrl +
                'customers/$customerId?' +
                creds.consumerKey +
                creds.consumerSecret));
            if (res.statusCode == 200) {
              var jsonData = json.decode(res.body);
              int? id = jsonData['id'];
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyAccount(id: id)));
              print(jsonData);
            }
            return null;
          }

          getCustomerData();
        }
      }));
    } else {
      print(response.body);
    }
    return listOfCustomers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Image.asset(
              'assets/logo.png',
              height: 200.0,
            ),
          ),
          AccentColorOverride(
            color: kShrineAltYellow,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'E-mail', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(height: 16.0),
          AccentColorOverride(
            color: kShrineAltYellow,
            child: TextField(
              obscureText: true,
              controller: passController,
              decoration: InputDecoration(
                  labelText: 'Password', border: OutlineInputBorder()),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              MaterialButton(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  onPressed: () {
                    emailController.clear();
                    passController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontFamily: 'Beyno'),
                  )),
              MaterialButton(
                  color: kShrineAltYellow,
                  textColor: kShrineBrown900,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () {
                    login(emailController.text, passController.text);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontFamily: 'Beyno', fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 45.0),
                  child: Text(
                    'Or',
                    textScaleFactor: 1.3,
                    style: TextStyle(fontFamily: 'Beyno'),
                  )),
            ],
          ),
          ButtonBar(
            children: <Widget>[
              MaterialButton(
                color: kShrineAltDarkGrey,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0))),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontFamily: 'Beyno',
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateAccount()));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
