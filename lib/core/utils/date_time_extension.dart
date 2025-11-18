import 'package:intl/intl.dart';

extension DateParsing on String {
  String convertToFormattedDate({bool withYear = true}) {
    if (isEmpty) return '';

    try {
      final DateTime date = DateTime.parse(this);

      final String format = withYear ? 'd MMMM yyyy' : 'd MMMM';

      return DateFormat(format, 'ru').format(date);
    } catch (e) {
      return this;
    }
  }
}
