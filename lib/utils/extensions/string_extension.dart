extension StringCheck on String? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}
