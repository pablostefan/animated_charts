import 'package:animated_charts/i18n/translate.dart';

enum PriceChange { loss, gain }

enum TimeFrame { oneHour, oneDay, oneWeek, oneMonth, oneYear, all }

extension Metadata on TimeFrame {
  static TimeFrame fromId(String id) {
    if (id == TranslateHome.strings.oneHour) {
      return TimeFrame.oneHour;
    } else if (id == TranslateHome.strings.oneDay) {
      return TimeFrame.oneDay;
    } else if (id == TranslateHome.strings.oneWeek) {
      return TimeFrame.oneWeek;
    } else if (id == TranslateHome.strings.oneMonth) {
      return TimeFrame.oneMonth;
    } else if (id == TranslateHome.strings.oneYear) {
      return TimeFrame.oneYear;
    } else if (id == TranslateHome.strings.all) {
      return TimeFrame.all;
    } else {
      throw ArgumentError("$id is not valid");
    }
  }

  String get displayName {
    switch (this) {
      case TimeFrame.oneHour:
        return TranslateHome.strings.oneHour;

      case TimeFrame.oneDay:
        return TranslateHome.strings.oneDay;

      case TimeFrame.oneWeek:
        return TranslateHome.strings.oneWeek;

      case TimeFrame.oneMonth:
        return TranslateHome.strings.oneMonth;

      case TimeFrame.oneYear:
        return TranslateHome.strings.oneYear;

      case TimeFrame.all:
        return TranslateHome.strings.all;
    }
  }
}
