import 'package:crunchbox/colors.dart';
import 'package:crunchbox/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool accountCreated = false;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final baseUrl = "https://crworld.xyz/wp-json/wc/v3/";
  final consumerKey =
      "consumer_key=ck_a6dd2423f9846648d5943da635f6f1335ad812e4";
  final consumerSecret =
      "&consumer_secret=cs_58abf2aacfcc931a1b864df17ae727e522532821";
  final customersEndpoint = 'customers?';

  Future createAccount() async {
    var data = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text
    };

    final req = await http.post(
        baseUrl + customersEndpoint + consumerKey + consumerSecret,
        body: data,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        });
    print(req.statusCode);
    if (req.statusCode == 201 || req.statusCode == 200) {
      firstNameController.text = '';
      lastNameController.text = '';
      usernameController.text = '';
      emailController.text = '';
      passwordController.text = '';
      print(req.body);
    } else {
      throw 'Failed to create account';
    }
  }

  final GlobalKey<State> progress = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account',
            style: TextStyle(fontFamily: 'Beyno', color: kShrineAltYellow)),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          return Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                AccentColorOverride(
                  color: kShrineAltYellow,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: firstNameController,
                    decoration: InputDecoration(
                        labelText: 'First Name', border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(height: 16.0),
                AccentColorOverride(
                  color: kShrineAltYellow,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: lastNameController,
                    decoration: InputDecoration(
                        labelText: 'Last Name', border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(height: 16.0),
                AccentColorOverride(
                  color: kShrineAltYellow,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: usernameController,
                    decoration: InputDecoration(
                        labelText: 'Username', border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(height: 16.0),
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
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(height: 16.0),
                RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    color: kShrineAltYellow,
                    textColor: kShrineBrown900,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Create Account',
                          style: TextStyle(
                              fontFamily: 'Beyno', fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                    onPressed: () {
                      FutureBuilder(
                          future: createAccount(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(snapshot.error);
                            } else if (snapshot.hasData) {
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Account Done')));
                            }
                          });
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget circularProgress() {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
  );
}
