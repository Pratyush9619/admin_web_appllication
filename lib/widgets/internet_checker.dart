import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

Future<void> check_intereConnection() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  print(connectivityResult);
  if (connectivityResult == ConnectivityResult.mobile) {
    print('Noo internet connection');
    // I am connected to a mobile network.
  } else if (connectivityResult == ConnectivityResult.wifi) {
    print('Connected to wifi network');
    // I am connected to a wifi network.
  } else if (connectivityResult == ConnectivityResult.ethernet) {
    // I am connected to a ethernet network.
  } else if (connectivityResult == ConnectivityResult.vpn) {
    // I am connected to a vpn network.
    // Note for iOS and macOS:
    // There is no separate network interface type for [vpn].
    // It returns [other] on any device (also simulator)
  } else if (connectivityResult == ConnectivityResult.bluetooth) {
    // I am connected to a bluetooth.
  } else if (connectivityResult == ConnectivityResult.other) {
    // I am connected to a network which is not in the above mentioned networks.
  } else if (connectivityResult == ConnectivityResult.none) {
    // I am not connected to any network.
    
  }
}
