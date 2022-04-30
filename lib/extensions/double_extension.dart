
extension DoubleExtension on double? {

  bool isNotNullNotEmptyAndNotNegative() {
    final value = this;
    if (value != null) {
      return value.toString().isNotEmpty && !value.isNegative;
    } else {
      return false;
    }
  }

  bool isNotNullEmptyOrZero() {
    final value = this;
    if (value != null) {
      return value.toString().isNotEmpty && value.toString() != '0.0';
    } else {
      return false;
    }
  }

}
