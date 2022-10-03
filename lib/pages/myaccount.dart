import 'dart:convert';

import 'package:crunchbox/themes/colors.dart';
import 'package:crunchbox/pages/customers.dart';
import 'package:crunchbox/creds/creds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum AccountSettings { Orders, EditProfile, ManageAddress, Customers }

class MyAccount extends StatefulWidget {
  final int? id;

  MyAccount({Key? key, required this.id}) : super(key: key);

  @override
  MyAccountState createState() {
    return new MyAccountState();
  }
}

class MyAccountState extends State<MyAccount> {
  final ManageCredentials manageCredentials = ManageCredentials();

  // TODO: Redundant api call fetch account details from homepage context.
  // Future getCustomerProfile() async {
  //   final res = await http.get(Uri.parse(manageCredentials.baseUrl +
  //       'customers/${widget.id}?' +
  //       manageCredentials.consumerKey +
  //       manageCredentials.consumerSecret));
  //   if (res.statusCode == 200) {
  //     var jsonData = json.decode(res.body);
  //     print(jsonData['first_name']);
  //   } else {
  //     print(res.statusCode);
  //   }
  //   return json.decode(res.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: kShrineAltYellow,
        centerTitle: true,
        backgroundColor: kShrineAltDarkGrey,
        title: Text('My Account', style: TextStyle(fontFamily: 'Beyno')),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            // Profile Image.
            Center(
              child: Container(
                width: 160.0,
                height: 160.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      colorFilter:
                          ColorFilter.mode(Colors.amber, BlendMode.overlay),
                      image: AssetImage('assets/default_image.jpg'),
                      fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Account details and setting options. TODO: Uncomment this.
            // FutureBuilder(
            //   future: getCustomerProfile(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Text(snapshot.error as String);
            //     } else if (snapshot.connectionState ==
            //         ConnectionState.waiting) {
            //       return Center(
            //           child: CircularProgressIndicator(
            //               valueColor:
            //                   AlwaysStoppedAnimation<Color>(kShrineAltYellow)));
            //     }
            //     return Text(
            //         '${(snapshot.data as dynamic)['first_name']} ${(snapshot.data as dynamic)['last_name']}',
            //         style: TextStyle(fontSize: 24.0, fontFamily: 'Beyno'));
            //   },
            // ),
            SizedBox(height: 16.0),
            Divider(),
            // Settings List
            ListTile(
              leading: Icon(
                Icons.shopping_basket,
                color: kShrineAltYellow,
              ),
              title: Text(
                'Orders',
                style: TextStyle(fontFamily: 'Beyno', color: kShrineAltYellow),
                textScaleFactor: 1.3,
              ),
              onTap: () {
                // TODO: getCustomerProfile();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.mode_edit, color: kShrineAltYellow),
              title: Text('Edit Profile',
                  style:
                      TextStyle(color: kShrineAltYellow, fontFamily: 'Beyno'),
                  textScaleFactor: 1.3),
              onTap: () {},
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.local_shipping, color: kShrineAltYellow),
                title: Text(
                  'Manage Address',
                  style:
                      TextStyle(color: kShrineAltYellow, fontFamily: 'Beyno'),
                  textScaleFactor: 1.3,
                ),
                onTap: () {}),
            Divider(),
            ListTile(
                leading: Icon(Icons.local_shipping, color: kShrineAltYellow),
                title: Text(
                  'Customers',
                  style:
                      TextStyle(color: kShrineAltYellow, fontFamily: 'Beyno'),
                  textScaleFactor: 1.3,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Customers()));
                })
          ],
        ),
      ),
    );
  }
}
