/* 
  For useful debugging the [Logger was invented]
  

  @author -> Amgad Fahd 

*/

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

import '../configs/config.dart';
// import 'package:logger/logger.dart';



/// default Logger callback
void appLogWriterCallback(String value, {bool isError = false}) {
  if (isError || Get.isLogEnable) dev.log(value, name: appName);


}

class Logger {
  static LogMode _logMode = LogMode.debug;


  static void init(LogMode mode) {
    Logger._logMode = mode;
  }

  static void log(dynamic data, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.debug) {
      debugPrintError("Error: $data$stackTrace");
    } else {
      debugPrint("$data");
    }
  }

  static void debugPrint(Object message, [bool isWarning = false]) {
    //
    if (kDebugMode) {

      dev.log(
        message.toString(),
        name: appName,
        time: DateTime.now(),
      );
    }
  }

  static void debugPrintError(Object message) {
    if (kDebugMode) {
      dev.log(
        message.toString(),
        name: appName,
        time: DateTime.now(),
        error: true,
      );
  
    }
  }
}

enum LogMode { debug, live }
