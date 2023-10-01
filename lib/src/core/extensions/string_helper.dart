const String thousandSeparator = ',';

extension StringHelper on String {
  String toCapitalised() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalised()).join(' ');

  String removeThousandSeparator() => replaceAll(thousandSeparator, '');
}

extension ThousandSeparator on int {
  String toThousands() {
    final numberString = toString();
    final numberDigits = List.from(numberString.split(''));
    int index = numberDigits.length - 3;
    while (index > 0) {
      numberDigits.insert(index, thousandSeparator);
      index -= 3;
    }
    return numberDigits.join();
  }
}

extension LocalizedNumerals on String {
  String toArabicNumerals() {
    const Map<String, String> numbers = {
      '0': '۰',
      '1': '۱',
      '2': '۲',
      '3': '۳',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '۷',
      '8': '۸',
      '9': '۹',
    };

    return replaceAllMapped(
      RegExp('[0-9]'),
      (match) => numbers[this[match.start]]!,
    );
  }
}

extension DebuggingInfo on Function {
  String getMethodName() => "Called method ==> ${toString().substring(toString().indexOf("'") + 1, toString().lastIndexOf("'"))}";
}
