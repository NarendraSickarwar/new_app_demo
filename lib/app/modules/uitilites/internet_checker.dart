import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';



///CCHECK INTERNET CONNECTION
Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network, make sure there is actually a net connection.
    var bool = await checkInternet();
    return bool ?? false;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a WIFI network, make sure there is actually a net connection.
    var bool = await checkInternet();
    return bool ?? false;
  } else {
    // Neither mobile data or WIFI detected, not internet connection found.
    return false;
  }
}

Future<bool?> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return Future.value(true);
    }
  } on SocketException catch (_) {
    return Future.value(false);
  }
  return null;
}
