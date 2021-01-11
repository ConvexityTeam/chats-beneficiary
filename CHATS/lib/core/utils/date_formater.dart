import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class Format {
  static final currencyFormat = new NumberFormat("#,##0.00", "en_us");
  //todo return date from String to string obj
  static String convertDateFromString(String date,
          [List<String> format = const [dd, '-', mm, '-', yyyy]]) =>
      formatDate(DateTime.parse(date), format);

  static String convertDateTimeFromString(String date) => formatDate(
      DateTime.parse(date), [yyyy, '-', mm, '-', dd, '', hh, '', nn, am]);

  static String formatNumber(number) => currencyFormat.format(number);
}
