import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpDataApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: "网络数据异步获取",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HttpDataPage(),
      );
  }

}

class HttpDataPage extends StatefulWidget{
  HttpDataPage({Key? key}):super(key: key);
  @override
  State<StatefulWidget> createState() => _HttpDataPageState();

}

class _HttpDataPageState extends State<HttpDataPage>{
  List widgets = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网络数据异步获取'),
      ),
      body: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      }),
    );
  }

    Widget getRow(int i){
      return Padding(padding: EdgeInsets.all(10.0),
      child: Text("Row ${widgets[i]["title"]}"),
      );
    }

    Future<void> loadData() async {
      var dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      http.Response response = await http.get(dataURL);

      // print("sdd>>>>>>>>>>>>>>>>>"+response.body.toString());
      setState(() {
        widgets = jsonDecode(response.body);

      });
    }
  }

