// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

extension StringX on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp('[A-Za-z]');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidCountry {
    final nameRegExp = RegExp('[a-zA-Z]');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r'(^[+0]?[0-9]{10,14}$)');
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidNumber {
    final phoneRegExp = RegExp(r'^[0-9]+$');
    return phoneRegExp.hasMatch(this);
  }

  String toCapitalized() {
    return length > 0
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : '';
  }

  String toTitleCase() {
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.toCapitalized())
        .join(' ');
  }

  String toFormattedNumber() {
    final RegExp regExp = RegExp(r'^\d+(\.\d+)?$');

    if (regExp.hasMatch(this)) {
      final value = double.parse(this);
      final formatter = NumberFormat.currency(
        locale: "id",
        symbol: "",
        decimalDigits: 0,
      );
      return formatter.format(value);
    } else {
      return '-';
    }
  }

  // Reverse a string
  String get reversed => split('').reversed.join();
}

extension DoubleX on double {
  // Limit to 2 decimal places
  String get toTwoDecimal => toStringAsFixed(2);

  // Convert to percentage string
  String get toPercentage => '${(this * 100).toStringAsFixed(2)}%';
}

extension NumX on num {
  // Convert num to padding (EdgeInsets)
  EdgeInsets get ea => EdgeInsets.all(this.toDouble());
  EdgeInsets get eot => EdgeInsets.only(top: this.toDouble());
  EdgeInsets get eob => EdgeInsets.only(bottom: this.toDouble());
  EdgeInsets get eol => EdgeInsets.only(left: this.toDouble());
  EdgeInsets get eor => EdgeInsets.only(right: this.toDouble());

  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());

  // Convert num to BorderRadius.circular
  BorderRadius get brc => BorderRadius.circular(this.toDouble());
  Radius get rc => Radius.circular(this.toDouble());

  // Convert num to duration in milliseconds
  Duration get msec => Duration(milliseconds: this.toInt());
  Duration get sec => Duration(seconds: this.toInt());
  Duration get min => Duration(minutes: this.toInt());
  Duration get hr => Duration(hours: this.toInt());

  // Format num as currency with specific locale (e.g., US dollars)
  String toCurrency({String locale = 'en_US', String symbol = '\$'}) {
    return NumberFormat.currency(locale: locale, symbol: symbol).format(this);
  }

  // Limit num to specific decimal places
  String toFixed(int fractionDigits) => this.toStringAsFixed(fractionDigits);

  SizedBox get spacing => SizedBox(
        width: this is int && this > 0 ? toDouble() : null,
        height: this is int && this > 0 ? toDouble() : null,
      );
}

extension DurationX on Duration {
  // Make format HH:mm:ss
  String formatDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));

    return "${twoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

extension ListPaddingExtension on List<int> {
  EdgeInsets get es {
    if (this.length != 2) {
      throw Exception(
          "List must contain exactly 2 elements: [horizontal, vertical]");
    }
    return EdgeInsets.symmetric(
        vertical: this[0].toDouble(), horizontal: this[1].toDouble());
  }

  EdgeInsets get etrbl {
    if (this.length != 4) {
      throw Exception(
          "List must contain exactly 4 elements: [top, right, bottom, left]");
    }
    return EdgeInsets.only(
        top: this[0].toDouble(),
        right: this[1].toDouble(),
        bottom: this[2].toDouble(),
        left: this[3].toDouble());
  }
}

extension ContextX on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  Size get mSize => MediaQuery.of(this).size;
  NavigatorState get nav => Navigator.of(this);
}

extension WidgetX on Widget {
  Widget expand({int flex = 1}) => Expanded(
        flex: flex,
        child: this,
      );
  Widget visible(bool isVisible) => Visibility(
        visible: isVisible,
        child: this,
      );
  Widget shimmer({required bool isEnabled}) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: isEnabled,
        child: this,
      );

  /// Adds a tap gesture to the widget
  Widget onTap(void Function(BuildContext context)? onTap,
      {bool isDoubleTap = false}) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: isDoubleTap ? null : () => onTap?.call(context),
        onDoubleTap: isDoubleTap ? () => onTap?.call(context) : null,
        child: this,
      ),
    );
  }

  /// Adds a long press gesture to the widget
  Widget onLongPress(Function()? onLongPress) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: this,
    );
  }

  /// Adds custom gesture handling
  Widget withGestures({
    Function()? onTap,
    Function()? onDoubleTap,
    Function()? onLongPress,
    Function()? onPanUpdate,
    Function()? onPanEnd,
    Function()? onTapCancel,
  }) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onPanUpdate: onPanUpdate != null ? (details) => onPanUpdate() : null,
      onPanEnd: onPanEnd != null ? (details) => onPanEnd() : null,
      onTapCancel: onTapCancel,
      child: this,
    );
  }
}
