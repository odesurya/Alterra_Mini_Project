import 'package:flutter/material.dart';
import 'base_model.dart';

class CartProvider with ChangeNotifier {
  List<BaseModel> _itemsOnCart = [];
  List<BaseModel> get itemsOnCart => _itemsOnCart;
  int _selectedSizeIndex = 0;
  int _selectedColorIndex = 0;

  List<String> sizes = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

  List<Color> colors = [
    const Color(0xFFFFB0AA),
    const Color(0xFFBDE1FF),
    const Color(0xFFCFFFD1),
    const Color(0xFFF5C0FF),
    const Color(0xFFFFFFFF),
    const Color(0xFFFAB5CC),
    const Color(0xFFEEE8B1),
  ];

  int get selectedColorIndex => _selectedColorIndex;
  Color get selectedColor => colors[_selectedColorIndex];
  String _newColor = '';

  String get newColor => _newColor;
  void setSelectedColor(int index) {
    _selectedColorIndex = index;
    notifyListeners();
  }

  void setNewColor(String color) {
    _newColor = color;
    notifyListeners();
  }

  void addNewColor(String color) {
    colors.add(Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000));
    setSelectedColor(colors.length - 1);
    notifyListeners();
  }

  int get selectedSizeIndex => _selectedSizeIndex;
  String get selectedSize {
    if (_selectedSizeIndex >= 0 && _selectedSizeIndex < sizes.length) {
      return sizes[_selectedSizeIndex];
    } else {
      return '';
    }
  }

  String _newSize = '';
  String get newSize => _newSize;

  void setSelectedSize(int index) {
    _selectedSizeIndex = index;
    notifyListeners();
  }

  void changeItemSize(int index, String newSize) {
    if (index >= 0 && index < _itemsOnCart.length) {
      _itemsOnCart[index].size = newSize;
      notifyListeners();
    }
  }

  void setNewSize(String newSize) {
    _newSize = newSize;
    notifyListeners();
  }

  void addToCart(BaseModel data) {
    data.size = sizes[_selectedSizeIndex];
    data.selectedColor = colors[_selectedColorIndex];
    _itemsOnCart.add(data);
    notifyListeners();
  }

  void delete(BaseModel data) {
    if (itemsOnCart.length == 1) {
      itemsOnCart.clear();
    } else {
      itemsOnCart.removeWhere((element) => element.id == data.id);
    }
    notifyListeners();
  }

  double calculateTotalPrice() {
    double total = 0.0;
    if (itemsOnCart.isEmpty) {
      total = 0;
    } else {
      for (BaseModel data in itemsOnCart) {
        total = total + data.price * data.value;
      }
    }
    return total;
  }

  void decrementItem(BaseModel current) {
    if (current.value > 1) {
      current.value--;
    } else {
      delete(current);
      current.value = 1;
    }
    notifyListeners();
  }

  void incrementItem(BaseModel current) {
    if (current.value >= 0) {
      current.value++;
    }
    notifyListeners();
  }

  void clearCart() {
    _itemsOnCart.clear();
    notifyListeners();
  }
}
