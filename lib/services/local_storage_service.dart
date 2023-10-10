import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:veli_flutter/models/user_model.dart';

class LocalStorageService {
  //singleton
  static final LocalStorageService _instance = LocalStorageService._internal();
  late SharedPreferences _pref;
  bool _isInitialized = false;

  final String jwt = 'JWT';
  final String userInfo = 'UserInfo';
  final String roomId = 'RoomId';

  bool get isInitialized => _isInitialized;

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal() {
    init();
  }

  Future<void> init() async {
    if (!_isInitialized) {
      _pref = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  Future<String> getJwt() async {
    return _pref.getString(jwt) ?? '';
  }

  Future<bool> setJwt(String value) async {
    return _pref.setString(jwt, value);
  }

  Future<String> getRoomId() async {
    return _pref.getString(roomId) ?? '';
  }

  Future<bool> setRoomId(String value) async {
    return _pref.setString(roomId, value);
  }

  Future<bool> removeJwt() async {
    await _pref.remove(jwt);
    return _pref.remove(userInfo);
  }

  Future<bool> setUserInfo(UserModel user) async {
    return _pref.setString(userInfo, jsonEncode(user));
  }

  Future<UserModel?> getUserInfo() async {
    var data = _pref.getString(userInfo);

    if (data != null && data != '') {
      var userJson = jsonDecode(data);
      return UserModel.fromJson(userJson);
    }
    return null;
  }
}
