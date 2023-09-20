enum Currency {
  USD,
  EUR,
  GBP,
  JPY,
  AUD,
  CAD,
  CHF,
  CNY,
  SEK,
  NZD,
}

extension CurrencyExtension on Currency {
  String get symbol {
    switch (this) {
      case Currency.USD:
        return '\$';
      case Currency.EUR:
        return '€';
      case Currency.GBP:
        return '£';
      case Currency.JPY:
        return '¥';
      case Currency.AUD:
        return 'A\$';
      case Currency.CAD:
        return 'C\$';
      case Currency.CHF:
        return 'CHF';
      case Currency.CNY:
        return '¥';
      case Currency.SEK:
        return 'kr';
      case Currency.NZD:
        return 'NZ\$';
      default:
        return '€';
    }
  }

  String get abbreviation {
    switch (this) {
      case Currency.USD:
        return 'USD';
      case Currency.EUR:
        return 'EUR';
      case Currency.GBP:
        return 'GBP';
      case Currency.JPY:
        return 'JPY';
      case Currency.AUD:
        return 'AUD';
      case Currency.CAD:
        return 'CAD';
      case Currency.CHF:
        return 'CHF';
      case Currency.CNY:
        return 'CNY';
      case Currency.SEK:
        return 'SEK';
      case Currency.NZD:
        return 'NZD';
      default:
        return 'EUR';
    }
  }
}
