import 'package:flutter/material.dart';

class Product {
  final int? id;
  final String name;
  final String? description;
  final double price;
  final int? quantity;
  final bool? isDiscount;
  final double? disCountPrice;
  final List<String> images;
  final int? categoryId;
  final int listId;
  final int? userId;
  final List<String>? sizes;
  final Map<String,Color>? colors;
  Product({
    this.sizes,
    this.colors,
    this.userId,
    required this.listId,
    this.id,
    required this.name,
     this.description,
    required this.price,
     this.quantity,
    required this.images,
     this.categoryId,
     this.isDiscount,
     this.disCountPrice
  });

  // Convert a Product object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'sizes': sizes!.join(','),
      'colors': colors,
      'quantity': quantity,
      'images': images.join(','), // Convert the list to a string
      'categoryId': categoryId,
      'disCountPrice': disCountPrice,
      'isDisCount': isDiscount,
      'listId' : listId,
      'userId' : userId,
    };
  }

  // Convert a Map object into a Product object
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      listId: map['listId'],
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      sizes: (map['sizes']as String ).split(','),
      colors: map['colors'],
      quantity: map['quantity'],
      images: (map['images'] as String).split(','), // Convert the string to a list
      categoryId: map['categoryId'],
      disCountPrice: map['disCountPrice'],
      isDiscount: map['isDiscount'],
      userId: map['userId'],
    );
  }
}
