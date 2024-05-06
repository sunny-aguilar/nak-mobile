import 'package:intl/intl.dart';

class Dates {

  String getDate() {
    getTime();
    return DateFormat.yMMMMd('en_US').format(DateTime.now());
  }

  String getTime() {
    final DateTime now = DateTime.now();
    final timeFormatter = DateFormat.jm();
    final formattedTime = timeFormatter.format(now);
    return formattedTime;
  }

  String getDateTime() {
    return '${getDate()} ${getTime()}';
  }
}


