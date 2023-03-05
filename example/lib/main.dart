import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sadad_flutter_sdk/entities/sadad_transaction.dart';
import 'package:sadad_flutter_sdk/sadad_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _sadadFlutterSdkPlugin = SadadFlutterSdk();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    var transaction = SadadTransaction(
      email: "a3bd2llah@gmail.com",
        mobileNumber: "97431487378",
        customerId: "123456789",
        clientToken: "",
        transactionAmount: "10000.0",
        orderItems: [const SadadOrderItem(name: "top up", quantity: 1, amount: 10000)],
        orderId: "123456789");
    try {
      result = await _sadadFlutterSdkPlugin.createTransaction(transaction) ?? 'Unknown platform version';
    } on PlatformException {
      result = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
