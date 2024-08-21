import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';


class FormatDate{
  String formatDate(String date,String format,String location){
    initializeDateFormatting(location);
    DateFormat dateFormat = DateFormat(format);
    DateTime toDate = DateTime.parse(date);
    String newDate = dateFormat.format(toDate);
    return newDate;
  }

  DateTime toDate(String date){
    DateTime toDate = DateTime.parse(date);
    return toDate;
  }
}