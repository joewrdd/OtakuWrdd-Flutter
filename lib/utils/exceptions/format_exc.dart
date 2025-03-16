class TFormatException implements Exception {
  final String message;

  const TFormatException([
    this.message =
        'An Unexpected Format Error Occurred. Please Check Your Input.',
  ]);

  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  String get formattedMessage => message;

  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const TFormatException(
          'The Email Address Format Is Invalid. Please Enter A Valid Email.',
        );
      case 'invalid-phone-number-format':
        return const TFormatException(
          'The Provided Phone Number Format Is Invalid. Please Enter A Valid Number.',
        );
      case 'invalid-date-format':
        return const TFormatException(
          'The Date Format Is Invalid. Please Enter A Valid Date.',
        );
      case 'invalid-url-format':
        return const TFormatException(
          'The URL Format Is Invalid. Please Enter A Valid URL.',
        );
      case 'invalid-credit-card-format':
        return const TFormatException(
          'The Credit Card Format Is Invalid. Please Enter A Valid Credit Card Number.',
        );
      case 'invalid-numeric-format':
        return const TFormatException(
          'The Input Should Be A Valid Numeric Format.',
        );
      default:
        return const TFormatException();
    }
  }
}
