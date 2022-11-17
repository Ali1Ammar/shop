import 'package:json_annotation/json_annotation.dart';
import 'package:shop/src/model/category.dart';

part "product.g.dart";

@JsonSerializable()
class Product {
  final int id;
  final String title;
  final int price;
  final String description;
  final Category category;
  final List<String> images;
  Product(this.id, this.title, this.price, this.description, this.category,
      this.images);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
