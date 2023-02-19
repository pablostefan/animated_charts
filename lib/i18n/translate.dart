import 'dart:io';

import 'package:animated_charts/helpers/constants.dart';
import 'package:animated_charts/i18n/strings/en_us.dart';
import 'package:animated_charts/i18n/strings/pt_br.dart';

abstract class TranslateHome {
  static HomeStrings strings = _getType();

  static T _getType<T extends HomeStrings>() {
    switch (Platform.localeName) {
      case Constants.ptBR:
        return HomePtBR() as T;
      default:
        return HomeEnUS() as T;
    }
  }
}

abstract class HomeStrings {
  String get welcomeBack;

  String get pay;

  String get charge;

  String get convert;

  String get transfer;

  String get search;

  String get marketValue;

  String get oneHour;

  String get oneDay;

  String get oneWeek;

  String get oneMonth;

  String get oneYear;

  String get all;

  String get yourBalance;

  String get transactionHistory;

  String get signOutAccount;

  String get transactionHistoryTitle;

  String get paymentSent;

  String get paymentReceived;

  String get transferPerformed;

  String get conversionPerformed;
}
