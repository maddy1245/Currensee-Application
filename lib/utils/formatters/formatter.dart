import 'package:intl/intl.dart';

class Tformatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}  ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)}  ${phoneNumber.substring(7)}';
    }
    return phoneNumber;
  }

  static String internationalPhoneNumber(String phoneNumber) {
    var digitsonly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    String countryCode = '+${digitsonly.substring(0, 2)}';
    digitsonly = digitsonly.substring(0, 2);
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode)');
    int i = 0;
    while (i < digitsonly.length) {
      int grouplength = 2;
      if (i == 0 && countryCode == '+1') {
        grouplength = 3;
      }
      int end = i + grouplength;
      formattedNumber.write(digitsonly.substring(i, end));
      if (end < digitsonly.length) {
        formattedNumber.write('');
      }
      i = end;
    }
    return phoneNumber;
  }
}
