import 'package:intl/intl.dart';

String dateTimeToDate(DateTime dt) {
  final localDt = dt.toLocal();

  return DateFormat('yyyy-MM-dd').format(localDt);
}

String dateTimeToTime(DateTime dt) {
  final localDt = dt.toLocal();

  return DateFormat('h:mm a').format(localDt);
}