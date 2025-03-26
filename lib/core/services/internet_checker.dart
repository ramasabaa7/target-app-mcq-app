/* import 'dart:async';
import 'dart:io';

import 'package:dopamin/core/utils/functions.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;
  NetworkInfoImpl(this._internetConnectionChecker);
  @override
  // Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
  Future<bool> get isConnected async {
    if (await _internetConnectionChecker.hasConnection) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else {
      return false;
    }
  }
}
 */


import 'dart:async';
import 'dart:io';

import 'package:dopamin/core/utils/functions.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;
  NetworkInfoImpl(this._internetConnectionChecker);

  @override
  Future<bool> get isConnected async {
    if (await _internetConnectionChecker.hasConnection) {
      try {
        final response = await HttpClient().getUrl(Uri.parse('https://google.com'));
        final httpResponse = await response.close();
        return httpResponse.statusCode == HttpStatus.ok;
      } catch (_) {
        return false;
      }
    } else {
      return false;
    }
  }
}

class CheckInternet extends GetxController {
  var hasInternet = false;
  late StreamSubscription subscription;
  @override
  void onInit() {
    subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;

      this.hasInternet = hasInternet;
      if (!hasInternet) {
        Functions.showSnackbarFailed("No internet connection");
      }
      //  update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}
