import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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
  String _sadadResponse = 'did not start yet';
  final _sadadFlutterSdkPlugin = SadadFlutterSdk();

  @override
  void initState() {
    super.initState();
    startSadadTransaction();
  }

  Future<void> startSadadTransaction() async {
    String result;

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
      result = 'Failed to start sadad transaction';
    }

    if (!mounted) return;

    setState(() {
      _sadadResponse = result;
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
          child: Text('Running on: $_sadadResponse\n'),
        ),
      ),
    );
  }
}
