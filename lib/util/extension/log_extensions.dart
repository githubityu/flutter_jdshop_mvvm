import 'package:flutter/foundation.dart';
import 'dart:developer' as dev show log;
import 'package:logger/logger.dart';
extension ObjectExt on Object?{
  void log([dynamic error, StackTrace? stackTrace]){
    if(kDebugMode){
      Logger().e(toString(),error,stackTrace);
    }
  }
  void devLog(){
     dev.log(toString());
  }
}