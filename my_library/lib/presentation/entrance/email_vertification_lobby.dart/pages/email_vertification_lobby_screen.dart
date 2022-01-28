import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/presentation/entrance/email_vertification_lobby.dart/controllers/email_lobby_controller.dart';

// ignore: use_key_in_widget_constructors
class EmailVertificationLobbyScreen
    extends GetView<EmailVertificationLobbyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app, color: Colors.black),
          onPressed: () {
            controller.signOut();
          },
        ),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Waiting for e-mail vertification...',
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 25,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 14,
          ),
          TextButton(
              onPressed: controller.sendEmailVertification,
              child: const Text('Send request again',
                  style: TextStyle(color: Colors.purple, fontSize: 17)))
        ],
      )),
    );
  }
}
