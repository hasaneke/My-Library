import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.palette),
                ),
                title: Text(
                  'Change theme',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
