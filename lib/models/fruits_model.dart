// To parse this JSON data, do
//
//     final fruit = fruitFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Fruit fruitFromJson(String str) => Fruit.fromJson(json.decode(str));

String fruitToJson(Fruit data) => json.encode(data.toJson());

class Fruit {
  Fruit({
    required this.genus,
    required this.name,
    required this.id,
    required this.family,
    required this.order,
    required this.nutritions,
  });

  String genus;
  String name;
  int id;
  String family;
  String order;
  Nutritions? nutritions;

  factory Fruit.fromJson(Map<String, dynamic> json) => Fruit(
    genus: json["genus"] == null ? null : json["genus"],
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    family: json["family"] == null ? null : json["family"],
    order: json["order"] == null ? null : json["order"],
    nutritions: json["nutritions"] == null ? null : Nutritions.fromJson(json["nutritions"]),
  );

  Map<String, dynamic> toJson() => {
    "genus": genus == null ? null : genus,
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "family": family == null ? null : family,
    "order": order == null ? null : order,
    "nutritions": nutritions == null ? null : nutritions!.toJson(),
  };
}

class Nutritions {
  Nutritions({
    required this.carbohydrates,
    required this.protein,
    required this.fat,
    required this.calories,
    required this.sugar,
  });

  double carbohydrates;
  double protein;
  double fat;
  int calories;
  double sugar;

  factory Nutritions.fromJson(Map<String, dynamic> json) => Nutritions(
    carbohydrates: json["carbohydrates"] == null ? null : json["carbohydrates"].toDouble(),
    protein: json["protein"] == null ? null : json["protein"].toDouble(),
    fat: json["fat"] == null ? null : json["fat"].toDouble(),
    calories: json["calories"] == null ? null : json["calories"],
    sugar: json["sugar"] == null ? null : json["sugar"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "carbohydrates": carbohydrates == null ? null : carbohydrates,
    "protein": protein == null ? null : protein,
    "fat": fat == null ? null : fat,
    "calories": calories == null ? null : calories,
    "sugar": sugar == null ? null : sugar,
  };
}
