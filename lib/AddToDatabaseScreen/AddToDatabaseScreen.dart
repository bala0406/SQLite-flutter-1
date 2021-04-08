import 'package:assignment_1/AddToDatabaseScreen/AddToDatabaseViewModel.dart';
import 'package:assignment_1/Models/UserModel.dart';
import 'package:assignment_1/res/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

class AddToDatabaseScreen extends StatefulWidget {
  final Database database;
  AddToDatabaseScreen(this.database);
  @override
  _AddToDatabaseScreenState createState() => _AddToDatabaseScreenState();
}

class _AddToDatabaseScreenState extends State<AddToDatabaseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController bioFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: ChangeNotifierProvider(
        create: (context) => AddToDatabaseViewModel(),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add to Database",
                  style:
                      TextStyle(color: Styles.primaryFontColor, fontSize: 40),
                ),
                SizedBox(
                  height: 48,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: TextFormField(
                      controller: nameFieldController,
                      validator: (text) {
                        if (text.isEmpty) {
                          return "name is empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Styles.inputFieldColor,
                          filled: true,
                          labelText: "Name",
                          labelStyle:
                              TextStyle(color: Styles.primaryFontColor)),
                      style: TextStyle(
                          fontSize: 20, color: Styles.primaryFontColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: TextFormField(
                      controller: bioFieldController,
                      validator: (text) {
                        if (text.isEmpty) {
                          return "bio is empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      maxLength: 100,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 12),
                          counterStyle: TextStyle(
                              color: Styles.primaryFontColor, fontSize: 12),
                          fillColor: Styles.inputFieldColor,
                          filled: true,
                          border: InputBorder.none,
                          labelText: "Bio",
                          labelStyle:
                              TextStyle(color: Styles.primaryFontColor)),
                      style: TextStyle(
                          fontSize: 20, color: Styles.primaryFontColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Consumer<AddToDatabaseViewModel>(
                    builder: (context, viewModel, child) {
                      return MaterialButton(
                        height: 56,
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await viewModel.addToDatabase(
                                widget.database,
                                UserModel(
                                    name: nameFieldController.text,
                                    bio: bioFieldController.text));
                            nameFieldController.clear();
                            bioFieldController.clear();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Styles.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                        color: Styles.buttonColor,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
