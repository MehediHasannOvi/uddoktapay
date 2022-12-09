import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    getpament();
    super.initState();
  }

  String host = "https://sandbox.uddoktapay.com/api/checkout";

  Future<void> getpament() async {
    final response = await http.post(
      Uri.parse(host),
      body: jsonEncode(
        {
          "full_name": "Mehedi Hasan Ovi",
          "email": "mehediovi05@gmail.com",
         "metadata" : {"order_id": "10",
          "product_id": "5",},
          "amount": "999",
          "redirect_url": "uddoktapay.com",
          "cancel_url": "uddoktapay.com",
          "webhook_url": "https://pay.ababildev.xyz/callback/dae6a931bcabb60a9636ea05ecbead557dbc80b0"
        },
      ),
      headers: {
        "RT-UDDOKTAPAY-API-KEY": "982d381360a69d419689740d9f2e26ce36fb7a50"
      },
    );
    final getlink = jsonDecode(response.body);
    print(getlink);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "UddoktaPay",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.network(
                        "https://www.apple.com/v/macbook-air/o/images/overview/hero_mba_m2__ejbs627dj7ee_large.jpg")),
                trailing: MaterialButton(
                    onPressed: () {},
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text("Buy")),
                title: Text("MacBook Air"),
                subtitle: Text(" \$ 999"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
