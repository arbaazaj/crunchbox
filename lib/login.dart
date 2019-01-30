import 'dart:convert';

import 'package:crunchbox/create_account.dart';
import 'package:crunchbox/model/response.dart';
import 'package:flutter/material.dart';
import 'package:crunchbox/colors.dart';
import 'package:crunchbox/myaccount.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final baseUrl = "https://crworld.xyz/wp-json/wc/v3/";
  final consumerKey =
      "consumer_key=ck_a6dd2423f9846648d5943da635f6f1335ad812e4";
  final consumerSecret =
      "&consumer_secret=cs_58abf2aacfcc931a1b864df17ae727e522532821";

  final loginEndpoint = 'customers?';

  final emailController = TextEditingController();
  final passController = TextEditingController();

  List<CustomersModel> listOfCustomers = [];

  Future<List<CustomersModel>> login(String email, String password) async {
    final response =
        await http.get(baseUrl + loginEndpoint + consumerKey + consumerSecret);
    if (response.statusCode == 200) {
      listOfCustomers = (json.decode(response.body) as List)
          .map((json) => CustomersModel.fromJson(json))
          .toList();
      print(response.body);

      for (var i in listOfCustomers.map((data) {
        if (email == data.email) {
          int customerId = data.id;
          print('Email Matched ${data.id}');
          Future<CustomersModel> getCustomerData() async {
            final res = await http.get(baseUrl +
                'customers/$customerId?' +
                consumerKey +
                consumerSecret);
            if (res.statusCode == 200) {
              var jsonData = json.decode(res.body);
              int id = jsonData['id'];
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyAccount(id: id)));
              print(jsonData);
            }
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
              FlatButton(
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
              RaisedButton(
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
              RaisedButton(
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

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(accentColor: color),
    );
  }
}
