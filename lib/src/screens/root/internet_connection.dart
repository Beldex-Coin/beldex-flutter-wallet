
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InternetConnectivityChecker extends StatefulWidget {
  const InternetConnectivityChecker({ Key key }) : super(key: key);

  @override
  State<InternetConnectivityChecker> createState() => _InternetConnectivityCheckerState();
}

class _InternetConnectivityCheckerState extends State<InternetConnectivityChecker> {
ConnectivityResult _connectivityResult;
StreamSubscription<ConnectivityResult> _connectivitySubscription;

@override
  void initState() {
    _checkConnectivity();
     _connectivitySubscription = Connectivity().onConnectivityChanged.listen(_updateConnectivity);
    super.initState();
  }


Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = connectivityResult;
    });
  }



   void _updateConnectivity(ConnectivityResult connectivityResult) {
    setState(() {
      _connectivityResult = connectivityResult;
    });

    if (connectivityResult == ConnectivityResult.none) {
      // _showNetworkSnackbar(true);
      NetworkStatus().setNetworkStatus(true);
      _showNetworkSnackbar(true);

    } else {
      NetworkStatus().setNetworkStatus(false);
       _showNetworkSnackbar(false);
    }
  }


 void _showNetworkSnackbar(bool value)async{
    final prefs = await SharedPreferences.getInstance();
   // if(value){
      await prefs.setBool('networkStatus', value);
    // }else{
    //   await prefs.setBool('networkSnackbar', false);
    // }
   
 }




  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      final  networkStatus = NetworkStatus();
    return ValueListenableBuilder<bool>(
              valueListenable: networkStatus.isConnected,
              builder: (context, value, child) {
                return value ? Container(
    height:50,width: MediaQuery.of(context).size.width*2.5/3,
    decoration: BoxDecoration(color: Color(0xff333343),
    borderRadius: BorderRadius.circular(10)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Icon(Icons.wifi_off ,color: Color(0xffA0A0A0),),
        ),
        Text('You are currently offline',style: TextStyle(color: Color(0xffA0A0A0)),)
      ],
    ),
    ): Container();
                
                // Text(
                //   'Network Status: ${value ? 'Connected' : 'Disconnected'}',
                //   style: TextStyle(fontSize: 24.0),
                // );
              },
            );
  }
}





/////listen the value
///


class NetworkStatus {
  static final NetworkStatus _instance = NetworkStatus._internal();
  factory NetworkStatus() => _instance;

  NetworkStatus._internal();

  final ValueNotifier<bool> isConnected = ValueNotifier<bool>(false);

  void setNetworkStatus(bool status) {
    isConnected.value = status;
  }
}



















// // import 'dart:io';
// import 'dart:async';
// import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';


// class MyConnectivity {
//   MyConnectivity._internal();

//   static final MyConnectivity _instance = MyConnectivity._internal();

//   static MyConnectivity get instance => _instance;

//   Connectivity connectivity = Connectivity();

//   StreamController controller = StreamController<dynamic>.broadcast();

//   Stream get myStream => controller.stream;

//   void initialise() async {
//     ConnectivityResult result = await connectivity.checkConnectivity();
//     _checkStatus(result);
//     connectivity.onConnectivityChanged.listen((result) {
//       _checkStatus(result);
//     });
//   }

//   void _checkStatus(ConnectivityResult result) async {
//     bool isOnline = false;
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         isOnline = true;
//       } else {
//         isOnline = false;
//       }
//     } on SocketException catch (_) {
//       isOnline = false;
//     }
//     controller.sink.add({result: isOnline});
//   }

//   void disposeStream() => controller.close();
// }





// class InternetScreen extends StatefulWidget {
//   const InternetScreen({ Key key }) : super(key: key);

//   @override
//   State<InternetScreen> createState() => _InternetScreenState();
// }

// class _InternetScreenState extends State<InternetScreen> {

//     final _source = {ConnectivityResult.none : false};
//   MyConnectivity _connectivity = MyConnectivity.instance; 




//    @override
//   void dispose() {
//     _connectivity.disposeStream();
//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     String status = "Offline";
//     switch (_source.keys.toList()[0]) {
//       case ConnectivityResult.none:
//         status = "Offline";
//         break;
//       case ConnectivityResult.mobile:
//         status = "Mobile: Online";
//         break;
//       case ConnectivityResult.wifi:
//         status = "WiFi: Online";
//         break;
//     }
//     return Scaffold(
//       body: Container(
//           child: Center(child: Text(status)),
//       ),
//     );
//   }
// }