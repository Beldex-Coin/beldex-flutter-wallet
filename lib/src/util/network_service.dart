import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus {online,offline}

class NetworkService{
  StreamController<NetworkStatus> controller = StreamController();

  NetworkService(){
    Connectivity().onConnectivityChanged.listen((event) { 
      controller.add(_networkStatus(event));
    });
  }

  NetworkStatus _networkStatus(List<ConnectivityResult> connectivityResult){
    return connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi) ? NetworkStatus.online: NetworkStatus.offline;
  }



}