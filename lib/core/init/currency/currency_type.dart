enum CurrencyType { dollar, euro, ruble, manat }

extension CurrencyTypeExtension on CurrencyType {
  String get rawValue {
    switch (this) {
      case CurrencyType.euro: return 'euro';
      case CurrencyType.ruble: return 'ruble';
      case CurrencyType.manat: return 'manat';
      default: return 'dollar';
    }
  }
}
