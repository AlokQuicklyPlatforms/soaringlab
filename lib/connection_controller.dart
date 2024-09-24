import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectionController extends ChangeNotifier {
  Map _source = {ConnectivityResult.none: false};

  String? connectiontype;
  void setconnection(dynamic source) {
    log("Set conn called");
    _source = source;
    log("ths is source" + _source.keys.toList()[0].toString());

    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        print("this is current status " + _source.keys.toList()[0].toString());
        connectiontype = 'Mobile: Online';
        break;
      case ConnectivityResult.wifi:
        connectiontype = 'WiFi: Online';
        break;
      case ConnectivityResult.none:
        connectiontype = 'Not Connected';

      default:
        connectiontype = 'Offline';
    }
    notifyListeners();
  }
}
