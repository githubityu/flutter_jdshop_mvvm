import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  int _count = 0;
  int _count1 = 100;

  int get value => _count;

  int get value1 => _count1;

  void increment() {
    _count++;
    notifyListeners();
  }

  void increment1() {
    _count1++;
    notifyListeners();
  }
}