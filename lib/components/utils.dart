import 'package:intl/intl.dart';

class Dates {
  String getDateTime() {
    final DateTime now = DateTime.now();
    // final timeFormattter = DateFormat.jm().add_jm(); // 00/00/0000 format
    final timeFormattter = DateFormat.yMMMd('en_US').add_jm();
    return timeFormattter.format(now);
  }

  String getDate() {
    // 00/00/0000 format
    final DateTime now = DateTime.now();
    final timeFormattter = DateFormat.yMMMMd('en_US');
    return timeFormattter.format(now);
  }
}


