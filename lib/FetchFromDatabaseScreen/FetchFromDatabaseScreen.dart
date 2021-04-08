import 'package:assignment_1/FetchFromDatabaseScreen/FetchFromDatabaseViewModel.dart';
import 'package:assignment_1/res/Styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

class FetchFromDatabaseScreen extends StatefulWidget {
  final Database database;
  FetchFromDatabaseScreen(this.database);
  @override
  _FetchFromDatabaseScreenState createState() =>
      _FetchFromDatabaseScreenState();
}

class _FetchFromDatabaseScreenState extends State<FetchFromDatabaseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => FetchFromDatabaseViewModel(),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Fetch from Database",
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
                  child: Consumer<FetchFromDatabaseViewModel>(
                    builder: (context, viewModel, child) {
                      return MaterialButton(
                        height: 56,
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            viewModel.retriveFromDatabase(
                                widget.database, nameFieldController.text);
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text(
                          "Get",
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
                Consumer<FetchFromDatabaseViewModel>(
                    builder: (context, viewModel, child) {
                  return viewModel.results != null
                      ? (viewModel.results.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  itemCount: viewModel.results.length == null
                                      ? 0
                                      : viewModel.results.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Styles.inputFieldColor,
                                        ),
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  viewModel.results[index]["id"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Styles.buttonColor,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                    viewModel.results[index]
                                                        ["name"],
                                                    style: TextStyle(
                                                        color: Styles
                                                            .primaryFontColor,
                                                        fontSize: 24))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                                viewModel.results[index]["bio"],
                                                style: TextStyle(
                                                    color:
                                                        Styles.primaryFontColor,
                                                    fontSize: 20)),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Text(
                              "No results found!",
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 20),
                            ))
                      : Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
