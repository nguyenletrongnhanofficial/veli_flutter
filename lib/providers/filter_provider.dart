import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  Map<String, dynamic> filter = {};
  String detailDocumentId = '';

  void setFilter(Map<String, dynamic> newFilter) {
    filter = newFilter;
    notifyListeners();
  }

}
