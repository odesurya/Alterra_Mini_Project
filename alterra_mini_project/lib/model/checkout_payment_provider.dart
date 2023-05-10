import 'package:flutter/material.dart';

class CheckoutPaymentProvider extends ChangeNotifier {
  String? _address;
  String? get address => _address;

  String? _selectedPaymentOption;
  String? get selectedPaymentOption => _selectedPaymentOption;

  void setAddress(String address) {
    _address = address;
    notifyListeners();
  }

  void setSelectedPaymentOption(String? paymentOption) {
    _selectedPaymentOption = paymentOption;
    notifyListeners();
  }

  void setSelectedPaymentOptionChecked(bool value) {
    if (value) {
      setSelectedPaymentOption('checked');
    } else {
      setSelectedPaymentOption(null);
    }
  }
}
