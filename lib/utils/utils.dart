import 'package:intl/intl.dart';

class Utils {
  static formatMoney(int number) {
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', name: '₫', decimalDigits: 0);
    return formatCurrency.format(number);
  }
}
