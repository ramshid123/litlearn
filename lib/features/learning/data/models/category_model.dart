import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litlearn/core/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel(
      {required super.text, required super.icon, required super.value});

  factory CategoryModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return CategoryModel(
      text: json.data()['text'],
      value: json.data()['value'],
      icon: json.data()['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'value': value,
      'icon': icon,
    };
  }

  factory CategoryModel.fromEntity(CategoryEntity courseEntity) {
    return CategoryModel(
      text: courseEntity.text,
      value: courseEntity.value,
      icon: courseEntity.icon,
    );
  }
}
