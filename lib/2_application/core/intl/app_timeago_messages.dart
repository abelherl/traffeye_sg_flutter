import 'package:get/get.dart';
import 'package:timeago/timeago.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';

class AppTimeagoMessages implements LookupMessages {
  @override String prefixAgo() => IntlHelper.lastUpdated.tr;
  @override String prefixFromNow() => '';
  @override String suffixAgo() => '';
  @override String suffixFromNow() => '';
  @override String lessThanOneMinute(int seconds) => IntlHelper.justNow.tr;
  @override String aboutAMinute(int minutes) => '$minutes ${IntlHelper.minutesAgo.tr}';
  @override String minutes(int minutes) => '$minutes ${IntlHelper.minutesAgo.tr}';
  @override String aboutAnHour(int minutes) => '$minutes ${IntlHelper.minutesAgo.tr}';
  @override String hours(int hours) => '$hours ${IntlHelper.hoursAgo.tr}';
  @override String aDay(int hours) => '$hours ${IntlHelper.hoursAgo.tr}';
  @override String days(int days) => '$days ${IntlHelper.daysAgo.tr}';
  @override String aboutAMonth(int days) => '$days ${IntlHelper.daysAgo.tr}';
  @override String months(int months) => IntlHelper.aLongTimeAgo;
  @override String aboutAYear(int year) => IntlHelper.aLongTimeAgo;
  @override String years(int years) => IntlHelper.aLongTimeAgo;
  @override String wordSeparator() => ' ';
}
