extension StringToDateTimeExtension on String {
  DateTime toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
