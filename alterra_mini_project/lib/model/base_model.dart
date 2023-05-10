import 'package:flutter/material.dart';
import 'dart:convert';

class BaseModel {
  final int id;
  final String imageUrl;
  final String name;
  final double price;
  final double review;
  final double star;
  int value;
  String size;
  String newSize;
  Color selectedColor;

  BaseModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.review,
    required this.star,
    required this.value,
    required this.size,
    required this.newSize,
    this.selectedColor = Colors.white,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      price: json['price'].toDouble(),
      review: json['review'].toDouble(),
      star: json['star'].toDouble(),
      value: json['value'],
      size: json['size'],
      newSize: json['newSize'],
      selectedColor: Color(json['selectedColor']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'review': review,
      'star': star,
      'value': value,
      'size': size,
      'newSize': newSize,
      'selectedColor': selectedColor,
    };
  }
}

List<BaseModel> parseBaseModelList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<BaseModel>((json) => BaseModel.fromJson(json)).toList();
}
