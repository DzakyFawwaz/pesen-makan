import 'package:aplikasi_pemesanan_flutter/menu_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuItemProvider extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    if (_counter > 0) {
      _counter--;
      _setPrefItems();
      notifyListeners();
    }
  }

  void addTotalPrice(double price) {
    _totalPrice += price;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double price) {
    if (_totalPrice - price >= 0) {
      _totalPrice -= price;
      _setPrefItems();
      notifyListeners();
    }
  }

  void reset() {
    _counter = 0;
    _totalPrice = 0.0;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }
}
