extension DateTimeToJson on DateTime {
  String toJson() {
    return toIso8601String();
  }

  DateTime fromJson(String date) {
    return DateTime.parse(date);
  }
}