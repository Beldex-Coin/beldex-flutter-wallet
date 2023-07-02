// import 'dart:io';
import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';


class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController<dynamic>.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}





class InternetScreen extends StatefulWidget {
  const InternetScreen({ Key key }) : super(key: key);

  @override
  State<InternetScreen> createState() => _InternetScreenState();
}

class _InternetScreenState extends State<InternetScreen> {

    final _source = {ConnectivityResult.none : false};
  MyConnectivity _connectivity = MyConnectivity.instance; 




   @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    String status = "Offline";
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        status = "Offline";
        break;
      case ConnectivityResult.mobile:
        status = "Mobile: Online";
        break;
      case ConnectivityResult.wifi:
        status = "WiFi: Online";
        break;
    }
    return Scaffold(
      body: Container(
          child: Center(child: Text(status)),
      ),
    );
  }
}