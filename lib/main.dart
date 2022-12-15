import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:uddoktapay/getpage.dart';
import 'package:uddoktapay/webview.dart';

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

  final String redirectUrl = "https://ababildev.xyz/";
  final String cancelUrl = "https://ababildev.xyz/login";

  //Your User Panel Host Url 
  String host = "***Enter Host Url ****";

  Future<String?> getpament() async {
    final response = await http.post(
      Uri.parse(host),
      body: jsonEncode(
        {
          "full_name": "Mehedi Hasan Ovi",
          "email": "mehediovi05@gmail.com",
          "metadata": {
            "order_id": "10",
            "product_id": "5",
          },
          "amount": "999",
          "redirect_url": redirectUrl,
          "cancel_url": cancelUrl,
          "webhook_url":
              "http://tv.ababildev.xyz/"
        },
      ),
  // Your Api key 
      headers: {
        "RT-UDDOKTAPAY-API-KEY": "*****Enter Api key*****"
      },
    );
    final getlink = jsonDecode(response.body)['payment_url'];

    setState(() {
      finalurl = getlink;
    });
    // return finalurl;
    print(finalurl);
  }

  String? finalurl;

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
                    onPressed: () {
                      getpament().then((value) {
                        // if (value == null) {
                        //   print("value is null ");
                        // } else {
                          Route route = MaterialPageRoute(
                              builder: (context) => AAWebView(
                                    url: finalurl!,
                                    cancel: cancelUrl,
                                    redirect: redirectUrl,
                                  ));
                          Navigator.push(context, route).then((value) {
                            print("this is ta value  print ${value}");
                            if (value == redirectUrl) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GetScreen()),
                              ).then((value) => Fluttertoast.showToast(
                                  msg: "your payment is received ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0));
                            } else if (value == cancelUrl) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                              // Fluttertoast.showToast(
                              //     msg: "Sorry Your Payment cancel Try Agen ",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 1,
                              //     backgroundColor: Colors.red,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0);
                            }
                          });
                        // } // 
                      });

                      print("Button Are Press ${finalurl}");
                    },
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
