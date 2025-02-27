extension DateTimeToJson on DateTime {
  int toJson() {
    return millisecond;
  }

  static fromJson(int date) {
    return DateTime.fromMillisecondsSinceEpoch(date);
  }
}
