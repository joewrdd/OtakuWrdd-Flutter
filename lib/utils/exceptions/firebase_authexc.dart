class TFirebaseAuthException implements Exception {
  final String code;

  TFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The Email Address Is Already Registered. Please Use A Different Email.';
      case 'invalid-email':
        return 'The Email Address Provided Is Invalid. Please Enter A Valid Email.';
      case 'weak-password':
        return 'The Password Is Too Weak. Please Choose A Stronger Password.';
      case 'user-disabled':
        return 'This User Account Has Been Disabled. Please Contact Support For Assistance.';
      case 'user-not-found':
        return 'Invalid Login Details. User Not Found.';
      case 'wrong-password':
        return 'Incorrect Password. Please Check Your Password And Try Again.';
      case 'invalid-verification-code':
        return 'Invalid Verification Code. Please Enter A Valid Code.';
      case 'invalid-verification-id':
        return 'Invalid Verification ID. Please Request A New Verification Code.';
      case 'quota-exceeded':
        return 'Quota Exceeded. Please Try Again Later.';
      case 'email-already-exists':
        return 'The Email Address Already Exists. Please Use A Different Email.';
      case 'provider-already-linked':
        return 'The Account Is Already Linked With Another Provider.';
      case 'requires-recent-login':
        return 'This Operation Is Sensitive And Requires Recent Authentication. Please Log In Again.';
      case 'credential-already-in-use':
        return 'This Credential Is Already Associated With A Different User Account.';
      case 'user-mismatch':
        return 'The Supplied Credentials Do Not Correspond To The Previously Signed In User.';
      case 'account-exists-with-different-credential':
        return 'An Account Already Exists With The Same Email But Different Sign-In Credentials.';
      case 'operation-not-allowed':
        return 'This Operation Is Not Allowed. Contact Support For Assistance.';
      case 'expired-action-code':
        return 'The Action Code Has Expired. Please Request A New Action Code.';
      case 'invalid-action-code':
        return 'The Action Code Is Invalid. Please Check The Code And Try Again.';
      case 'missing-action-code':
        return 'The Action Code Is Missing. Please Provide A Valid Action Code.';
      case 'user-token-expired':
        return 'The User\'s Token Has Expired, And Authentication Is Required. Please Sign In Again.';
      case 'user-not-found':
        return 'No User Found For The Given Email Or UID.';
      case 'invalid-credential':
        return 'The Supplied Credential Is Malformed Or Has Expired.';
      case 'wrong-password':
        return 'The Password Is Invalid. Please Check Your Password And Try Again.';
      case 'user-token-revoked':
        return 'The User\'s Token Has Been Revoked. Please Sign In Again.';
      case 'invalid-message-payload':
        return 'The Email Template Verification Message Payload Is Invalid.';
      case 'invalid-sender':
        return 'The Email Template Sender Is Invalid. Please Verify The Sender\'s Email.';
      case 'invalid-recipient-email':
        return 'The Recipient Email Address Is Invalid. Please Provide A Valid Recipient Email.';
      case 'missing-iframe-start':
        return 'The Email Template Is Missing The Iframe Start Tag.';
      case 'missing-iframe-end':
        return 'The Email Template Is Missing The Iframe End Tag.';
      case 'missing-iframe-src':
        return 'The Email Template Is Missing The Iframe Src Attribute.';
      case 'auth-domain-config-required':
        return 'The AuthDomain Configuration Is Required For The Action Code Verification Link.';
      case 'missing-app-credential':
        return 'The App Credential Is Missing. Please Provide Valid App Credentials.';
      case 'invalid-app-credential':
        return 'The App Credential Is Invalid. Please Provide A Valid App Credential.';
      case 'session-cookie-expired':
        return 'The Firebase Session Cookie Has Expired. Please Sign In Again.';
      case 'uid-already-exists':
        return 'The Provided User ID Is Already In Use By Another User.';
      case 'invalid-cordova-configuration':
        return 'The Provided Cordova Configuration Is Invalid.';
      case 'app-deleted':
        return 'This Instance Of FirebaseApp Has Been Deleted.';
      case 'user-disabled':
        return 'The User Account Has Been Disabled.';
      case 'user-token-mismatch':
        return 'The Provided User\'s Token Has A Mismatch With The Authenticated User\'s User ID.';
      case 'web-storage-unsupported':
        return 'Web Storage Is Not Supported Or Is Disabled.';
      case 'invalid-credential':
        return 'The Supplied Credential Is Invalid. Please Check The Credential And Try Again.';
      case 'app-not-authorized':
        return 'The App Is Not Authorized To Use Firebase Authentication With The Provided API Key.';
      case 'keychain-error':
        return 'A Keychain Error Occurred. Please Check The Keychain And Try Again.';
      case 'internal-error':
        return 'An Internal Authentication Error Occurred. Please Try Again Later.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid Login Credentials.';
      default:
        return 'An Unexpected Authentication Error Occurred. Please Try Again.';
    }
  }
}

// ignore_for_file: unreachable_switch_case
