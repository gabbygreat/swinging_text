extension CamelCaseExtension on String {
  String get toCamelCaseSpace {
    // Use a StringBuffer to efficiently build the new string
    final StringBuffer result = StringBuffer();

    for (int i = 0; i < length; i++) {
      final String char = this[i];
      if (char.toUpperCase() == char && i != 0) {
        // If the character is uppercase and it is not the first character,
        // add a space before it.
        result.write(' $char');
      } else {
        result.write(char);
      }
    }

    // Capitalize the first character of the result and return.
    if (result.isNotEmpty) {
      final String firstChar = result.toString().substring(0, 1).toUpperCase();
      final String remaining = result.toString().substring(1);
      return '$firstChar$remaining';
    }

    return this;
  }
}
