import "dart:developer";

import "package:easy_localization/easy_localization.dart";

class DateTimeUtils {
  static const String ddMmYyyy = "dd/MM/yyyy";

  static String formatTimestampToDate({
    required int timestamp,
    required String format,
  }) {
    try {
      log("formatTimestampToDate timestamp: $timestamp");
      final DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      final DateFormat formatter = DateFormat(format);
      log("formatTimestampToDate return: ${formatter.format(dateTime)}");
      return formatter.format(dateTime);
    } on Error catch (e) {
      log("formatTimestampToDate error: $e");
      return "";
    }
  }

  static String formatStringToDate({
    required String dateString,
    required String format,
  }) {
    try {
      log("formatStringToDate dateString: $dateString");

      // Handle empty or null string
      if (dateString.isEmpty) {
        log("formatStringToDate: empty dateString");
        return "";
      }

      final DateTime dateTime = DateTime.parse(dateString);
      final DateFormat formatter = DateFormat(format);
      log("formatStringToDate return: ${formatter.format(dateTime)}");
      return formatter.format(dateTime);
    } on FormatException catch (e) {
      log("formatStringToDate FormatException: $e");
      return "";
    } on Error catch (e) {
      log("formatStringToDate error: $e");
      return "";
    }
  }
}
