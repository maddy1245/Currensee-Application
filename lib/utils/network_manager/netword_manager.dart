import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eproject_currensee/utils/popups/loaders.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

@override
void onInit() {
  super.onInit();

  // Pehle connection status check karna
  _connectivity.checkConnectivity().then((List<ConnectivityResult> result) {
    _updateConnectionStatus(result);
  });

  // Subscribe to connectivity changes (Updated for version 6.1.3)
  _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
    _updateConnectionStatus(result);
  });
}

Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
  _connectionStatus.value = results.isNotEmpty ? results.first : ConnectivityResult.none;

  if (_connectionStatus.value == ConnectivityResult.none) {
    Tloaders.warningSnackBar(title: 'No Internet Connection');
  }
}
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}

