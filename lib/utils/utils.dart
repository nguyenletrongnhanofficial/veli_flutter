import 'package:intl/intl.dart';
import 'package:veli_flutter/constants/common.constanst.dart';

class Utils {
  static formatMoney(num number) {
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', name: '₫', decimalDigits: 0);
    return formatCurrency.format(number);
  }

  static String generateUrl(Map<String, dynamic> filter) {

  var url = '${apiHost}/api/document?';

  if (filter['schoolId'] != null) {
    url += 'school_id=${filter['schoolId']}&'; 
  }

  if (filter['subjectId'] != null) {
    url += 'subject_id=${filter['subjectId']}&';
  }

  if (filter['districtId'] != null) {
    url += 'district_id=${filter['districtId']}&';
  }

  if (filter['price_from'] != null) {
    url += 'price_from=${filter['price_from']}&'; 
  }

  if (filter['price_to'] != null) {
    url += 'price_to=${filter['price_to']}&';
  }

  if (filter['address'] != '') {
    url += 'address=${filter['address']}&';
  }

  // remove last &
  url = url.substring(0, url.length - 1);
  return url;

}
}
