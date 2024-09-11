/// Error message when a connection timesout.
const String connectionTimedOut =
    '''Oops! There was a connection timed out. Please ensure your internet connection is stable and try again.''';

/// Error message when there is a send time out.
const String sendTimeOut =
    '''Oops! There was something wrong with getting your request. Please try again''';

/// Error message when the service doesn't
/// send out data in the given time splice.
const String receiveTimeOut =
    '''Oops! There was something wrong with processing your request. Pls try again''';

/// Error message typically shown when there is a network
/// response carries error.
const String responseError =
    '''Oops! There was something wrong with processing your request.Pls ensure your internet connection is stable.''';

/// Error message typically shown when a network request is cancelled.
const String requestCancelled = 'Opps your was terminated. Please try again';

/// A generic error message when the cause of the error cannot be determined.
const String somethingWentWrong =
    'Oopss! something went wrong. Please try again';

/// Error message shown when there is no interet connection.
/// Example is SocketException.
const String noInternet =
    '''Your internet connection is not stable, Please check your internet connection and try again.''';

/// Error message shown when user location is not detected.
const String unknownLocationError =
    '''Unable to retrieve current location, ensure you have turned on your location''';

/// Error message shown when the users tries to sign up an
/// email that already exists.
const String accountAlreadyExists = 'Account already exists';

/// Errow message shown when trying trying to log in an unverified account.
const String accountNotVerified = 'Account is not verified';

/// Error message shown when trying to log in with an invalid email or password.
const String invalidEmailOrPassword = 'Invalid email or password';

/// Error message when trying to access platform services and the app isn't
/// permitted to use the platform services.
const String permissionNotGranted = 'Opps you didnt grant us permission';
