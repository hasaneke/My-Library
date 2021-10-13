import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_library/database.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final DatabaseController databaseController = Get.find();
  @override
  Widget build(BuildContext context) {
    Map<String, RxString> values = {
      'title': RxString(''),
      'short_exp': RxString(''),
      'long_exp': RxString(''),
    };
    final String path = Get.arguments as String;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          foregroundColor: Colors.black,
          elevation: 0,
          title: Text('add_card'.tr),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: BorderSide(color: Colors.black54),
                      ),
                      color: context.theme.scaffoldBackgroundColor,
                      elevation: 4,
                      child: TextFormField(
                        onSaved: (value) {
                          values['title'] = RxString(value!);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'title'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          FaIcon(FontAwesomeIcons.camera, size: 35),
                          Icon(
                            Icons.photo_album,
                            size: 35,
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: BorderSide(color: Colors.black54),
                      ),
                      color: context.theme.scaffoldBackgroundColor,
                      elevation: 4,
                      child: TextFormField(
                        onSaved: (value) {
                          values['short_exp'] = RxString(value!);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Short Explanation'),
                      ),
                    ),
                    Container(
                      height: 360,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: BorderSide(color: Colors.black54),
                        ),
                        color: context.theme.scaffoldBackgroundColor,
                        elevation: 4,
                        child: TextFormField(
                          onSaved: (value) {
                            values['long_exp'] = RxString(value!);
                          },
                          maxLines: null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Long Explanation'),
                        ),
                      ),
                    ),
                    Obx(
                      () => databaseController.isItemLoading.value
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                _formKey.currentState!.save();
                                final DatabaseController databaseController =
                                    Get.find();
                                databaseController.addCard(values, path);
                              },
                              child: Text(
                                'add'.tr,
                                style: TextStyle(
                                    color: context.textTheme.bodyText1!.color,
                                    fontSize: 17),
                              )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
