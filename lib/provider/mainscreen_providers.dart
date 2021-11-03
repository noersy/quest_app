import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quest_app/config/api_paths.dart';
import 'package:quest_app/model/cards.dart';
import 'package:quest_app/model/formats.dart';
import 'package:quest_app/model/sets.dart';
import 'package:quest_app/model/types.dart';

class CardsSetsProviders extends ChangeNotifier {
  late Cards? cards;
  late Sets? sets;
  List<int> statusCode = [];

  Future<List<int>> getAllData() async {
    int data1 = await getCards();
    int data2 = await getSets();
    statusCode = [data1, data2];
    return [data1, data2];
  }

  Future<int> getCards() async {
    try {
      var response = await http.get(Uri.parse(ApiPaths.allCard()), headers: {});

      cards = allCardFromJson(response.body);

      return 200;
    } on TimeoutException catch (_) {
      return 501;
    } on SocketException catch (_) {
      return 501;
    }
  }

  Future<int> getSets() async {
    try {
      var response = await http.get(Uri.parse(ApiPaths.sets()), headers: {});

      sets = setsFromJson(response.body);

      return 200;
    } on TimeoutException catch (_) {
      return 501;
    } on SocketException catch (_) {
      return 501;
    }
  }
}

class TypesFormatsProviders extends ChangeNotifier {
  late Types? types;
  late Formats? formats;
  List<int> statusCode = [];

  Future<List<int>> getAllData() async {
    int data1 = await getTypes();
    int data2 = await getFormats();
    statusCode = [data1, data2];
    return [data1, data2];
  }

  Future<int> getTypes() async {
    try {
      var response = await http.get(Uri.parse(ApiPaths.types()), headers: {});

      types = typesFromJson(response.body);

      return 200;
    } on TimeoutException catch (_) {
      return 501;
    } on SocketException catch (_) {
      return 501;
    }
  }

  Future<int> getFormats() async {
    try {
      var response = await http.get(Uri.parse(ApiPaths.formats()), headers: {});

      formats = formatsFromJson(response.body);

      return 200;
    } on TimeoutException catch (_) {
      return 501;
    } on SocketException catch (_) {
      return 501;
    }
  }
}
