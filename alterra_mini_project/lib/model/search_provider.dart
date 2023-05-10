import 'package:alterra_mini_project/model/base_model.dart';
import 'package:flutter/material.dart';
import 'package:alterra_mini_project/data/app_data.dart';

class SearchProvider with ChangeNotifier {
  List<BaseModel> _itemsOnSearch = headerList;

  List<BaseModel> get itemsOnSearch => _itemsOnSearch;

  set itemsOnSearch(List<BaseModel> value) {
    _itemsOnSearch = value;
    notifyListeners();
  }

  void setMainList(List<BaseModel> mainList) {
    itemsOnSearch = mainList;
  }

  void onSearch(String search) {
    itemsOnSearch = headerList
        .where((element) => element.name.toLowerCase().contains(search))
        .toList();
  }
}
