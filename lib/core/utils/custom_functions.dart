import 'package:intl/intl.dart';

class CustomFunctions {
  String formatNoDecimal(double number) {
    final formatter = NumberFormat("#");
    String formattedNumber = formatter.format(number);
    return formattedNumber;
  }

  String formatOneDecimal(double number) {
    final formatter = NumberFormat("#.#");
    String formattedNumber = formatter.format(number);
    return formattedNumber;
  }
}
