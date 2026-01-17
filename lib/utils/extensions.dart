extension StringExtension on String {
  String get preciseErrorMessage {
    final parts = split(':');
    if (parts.length > 1) {
      return parts.sublist(1).join(':').trim();
    }
    return this;
  }
}
