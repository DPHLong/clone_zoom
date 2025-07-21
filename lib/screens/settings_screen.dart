import 'package:clone_zoom/resources/auth_methods.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await AuthMethods().signOutUser();
              Navigator.of(context).pushReplacementNamed('/welcome');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
