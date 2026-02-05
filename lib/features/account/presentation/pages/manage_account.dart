import 'package:crunchbox/features/product/presentation/widgets/animated_background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/account_bloc.dart';

class ManageAccount extends StatefulWidget {
  const ManageAccount({super.key});

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'My Account',
          style: TextStyle(
            fontFamily: 'Beyno',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
            onPressed: () {
              context.read<AccountBloc>().add(AccountLogoutRequested());
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          AnimatedBackgroundGradient(context: context),
          Column(
            children: [
              Image.asset('assets/default_image.jpg', width: 250, height: 250),
              SizedBox(height: 10),
              Text('Username'),
              SizedBox(height: 20),
              ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text('Orders'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.pin_drop_outlined),
                    title: Text('Manage Addresses'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit Profile'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text('About Us'),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
