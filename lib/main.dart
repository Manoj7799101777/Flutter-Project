import 'dart:convert';
import 'SecondRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:read_json_file/ProductDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Users List"),
              centerTitle: true,
            ),
            body: MyHomePage()));
  }
}

String? label = "";
// String? c = "";

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: ReadJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          var users = data.data as List<ProductDataModel>;
          return ListView.builder(
              itemCount: users == null ? 0 : users.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: 50,
                        //   height: 50,
                        //   // child: Image(
                        //   //   image:
                        //   //       NetworkImage(items[index].imageURL.toString()),
                        //   //   fit: BoxFit.fill,
                        //   // ),
                        // ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    var resultLabel =
                                        await _showTextInputDialog(context);
                                    if (resultLabel != null) {
                                      setState(() {
                                        label = resultLabel;
                                      });
                                    }
                                  },
                                  child: Text(
                                    users[index].name.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 8, right: 8),
                              //   child: Text(
                              //     users[index].name.toString(),
                              //     style: TextStyle(
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.bold),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 8, right: 8),
                              //   child: Text(items[index].price.toString()),
                              // )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  final _textFieldController = TextEditingController();
  final _textEditController = TextEditingController();

  Future<List<ProductDataModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsonfile/productlist.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((users) => ProductDataModel.fromJson(users)).toList();
  }

  Future<String?> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter Details'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Enter Age"),
            ),

            // content: TextField(
            //   controller: _textEditController,
            //   decoration: const InputDecoration(hintText: "Enter Age"),
            // ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Sign-in"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondRoute()),
                  );
                },
              ),
              // ElevatedButton(
              //   child: const Text('OK'),
              //   onPressed: () =>
              //       Navigator.pop(context, _textFieldController.text),
              // ),
            ],
          );
        });
  }
}
