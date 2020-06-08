import 'dart:math';

import 'package:flutter/material.dart';

const bool inProduction = const bool.fromEnvironment('dart.vm.product');

const topic = "topic";
const cateGory = "cateGory";
const IMAGE_JPG = "jpg";
const IMAGE_PNG = "png";
const PI = pi;
const DEGREE = 180.0;

int orderIndex = 0;
const limitSize = 20;


/// debug开关，上线需要关闭
/// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false

 bool isDriverTest  = false;
 bool isUnitTest  = false;

 const String data = 'data';
 const String message = 'message';
 const String code = 'code';

 const String keyGuide = 'keyGuide';
 const String phone = 'phone';
 const String accessToken = 'accessToken';
 const String refreshToken = 'refreshToken';

 const String theme = 'AppTheme';