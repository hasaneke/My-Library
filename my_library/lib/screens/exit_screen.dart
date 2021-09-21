import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class ExitScreen extends StatelessWidget {
  const ExitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: const Center(
        child: FaIcon(FontAwesomeIcons.doorOpen),
      ),
    );
  }
}
