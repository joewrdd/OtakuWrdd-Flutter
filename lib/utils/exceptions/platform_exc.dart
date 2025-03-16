class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid Login Credentials. Please Double-Check Your Information.';
      case 'too-many-requests':
        return 'Too Many Requests. Please Try Again Later.';
      case 'invalid-argument':
        return 'Invalid Argument Provided To The Authentication Method.';
      case 'invalid-password':
        return 'Incorrect Password. Please Try Again.';
      case 'invalid-phone-number':
        return 'The Provided Phone Number Is Invalid.';
      case 'operation-not-allowed':
        return 'The Sign-In Provider Is Disabled For Your Firebase Project.';
      case 'session-cookie-expired':
        return 'The Firebase Session Cookie Has Expired. Please Sign In Again.';
      case 'uid-already-exists':
        return 'The Provided User ID Is Already In Use By Another User.';
      case 'sign_in_failed':
        return 'Sign-In Failed. Please Try Again.';
      case 'network-request-failed':
        return 'Network Request Failed. Please Check Your Internet Connection.';
      case 'internal-error':
        return 'Internal Error. Please Try Again Later.';
      case 'invalid-verification-code':
        return 'Invalid Verification Code. Please Enter A Valid Code.';
      case 'invalid-verification-id':
        return 'Invalid Verification ID. Please Request A New Verification Code.';
      case 'quota-exceeded':
        return 'Quota Exceeded. Please Try Again Later.';
      default:
        return 'An Unexpected Platform Error Occurred. Please Try Again.';
    }
  }
}
