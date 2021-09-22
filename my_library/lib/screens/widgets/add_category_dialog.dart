import 'package:flutter/material.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: 'Title'),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Pick a color'),
          SizedBox(
            height: 10,
          ),
          Wrap(
            direction: Axis.horizontal,
            children: [
              colorButton(Colors.yellow),
              colorButton(Colors.red),
              colorButton(Colors.orange),
              colorButton(Colors.blue)
            ],
          ),
        ],
      ),
    );
  }

  MaterialButton colorButton(MaterialColor color) {
    return MaterialButton(
      onPressed: () {},
      shape: CircleBorder(),
      color: color,
    );
  }
}
