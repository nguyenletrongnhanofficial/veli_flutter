
import 'dart:convert';
import 'dart:io';

import 'package:veli_flutter/models/user_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static final HttpService _instance = HttpService._internal();
  late http.Client _client;

  bool _isInitialized = false;

  factory HttpService() {
    return _instance;
  }
  
  HttpService._internal() {
    init();
  }

  Future<void> init() async {
    if (!_isInitialized) {
      _client = http.Client();
      _isInitialized = true;
    }
  }



}
