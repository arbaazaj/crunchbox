import 'package:crunchbox/pages/login.dart';
import 'package:crunchbox/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      MaterialButton(
                        shape: Border.all(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: kShrineAltYellow),
                        colorBrightness: Brightness.dark,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
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
          // TODO: Undo this later
          // Expanded(
          //   child: FutureBuilder(
          //     future: getAllCategory(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.active:
          //           return Container();
          //         case ConnectionState.none:
          //           return Container();
          //         case ConnectionState.waiting:
          //           return Center(child: CircularProgressIndicator());
          //         case ConnectionState.done:
          //           return ListView.builder(
          //             shrinkWrap: true,
          //             itemCount: categoryList.length,
          //             itemBuilder: (context, index) {
          //               return ListTile(
          //                 title: Text((snapshot.data as dynamic)[index].name),
          //                 leading: Icon(Icons.category),
          //                 onTap: () {
          //                   print((snapshot.data as dynamic)[index].name);
          //                 },
          //               );
          //             },
          //           );
          //       }
          //       //return Container();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}