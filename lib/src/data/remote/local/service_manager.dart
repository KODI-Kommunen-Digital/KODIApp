import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';

class ServiceManager {
  static Future<List<CitizenServiceModel>> initializeServices() async {
    String configPath = dotenv.env['SERVICES_CONFIG']!;
    String jsonData = await rootBundle.loadString(configPath);
    List<dynamic> data = jsonDecode(jsonData);

    return data.map((item) {
      return CitizenServiceModel(
        imageUrl: item['imageUrl'],
        imageLink: item['imageLink'],
        arguments: item['arguments'],
        categoryId: item['categoryId'],
        subCategoryId: item['subCategoryId'],
        subServices: item['subServices'] != null
            ? (item['subServices'] as List)
            .map((sub) => CitizenServiceModel(
          imageUrl: sub['imageUrl'],
          imageLink: sub['imageLink'],
          arguments: sub['arguments'],
          categoryId: sub['categoryId'],
          subCategoryId: sub['subCategoryId'],
        ))
            .toList()
            : null,
      );
    }).toList();
  }

  static Future<List<CitizenServiceModel>> initializeServices6() async {
    String configPath = dotenv.env['SERVICES_CONFIG_6']!;
    String jsonData = await rootBundle.loadString(configPath);
    List<dynamic> data = jsonDecode(jsonData);

    return data
        .map((item) => CitizenServiceModel(
              imageUrl: item['imageUrl'],
              imageLink: item['imageLink'],
              arguments: item['arguments'],
              categoryId: item['categoryId'],
            ))
        .toList();
  }

    static Future<List<CitizenServiceModel>> initializeServices16() async {
    String configPath = dotenv.env['SERVICES_CONFIG_16']!;
    String jsonData = await rootBundle.loadString(configPath);
    List<dynamic> data = jsonDecode(jsonData);

    return data
        .map((item) => CitizenServiceModel(
              imageUrl: item['imageUrl'],
              imageLink: item['imageLink'],
              arguments: item['arguments'],
              categoryId: item['categoryId'],
            ))
        .toList();
  }
}
