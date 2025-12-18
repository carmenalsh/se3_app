class EndPoints {
  /// عدّل الـ baseUrl حسب الـ API تبعك
  static const String baseUrl = 'http://192.168.155.187/api/v1/';
  static const String refreshToken = 'http://localhost/api/refresh';

  // authhhhhh
  static const String registerCitizen = 'citizen/register';
  static const String verifyRegisterCode = 'citizen/verifyAccount';
  static const String resendVerifyCode = 'citizen/resendOtp';
  static const String forgotPasswordEmail = 'citizen/forgotPassword';
  static const String verifyForgotPasswordEmail =
      'citizen/verifyForgotPasswordEmail';
  static const String resendPasswordResetOtp = 'citizen/resendPasswordResetOtp';
  static const String resetPassword = 'citizen/resetPassword';
  static const String loginCitizen = 'citizen/login';
  static const String logout = 'citizen/logout';

  // home
  static const String getTransactions = 'citizen/home/transactionHistory';

  // account manag
  static const String updateAccount = 'citizen/Account/update';
  // create account
  static const String createAccount = 'citizen/Account/create';
  // app services
  static const String accountsForSelect = 'citizen/Account/forSelect';
  static const String withdraw = 'citizen/services/withdraw';
  static const String deposit = 'citizen/services/deposit';
  static const String transfer = 'citizen/services/transfer';
  static const String downloadFile = 'citizen/services/download';
  static const String scheduled = 'citizen/services/scheduled';
  static const String getNotifications = '/citizen/notification';

  // get Accounts
  static const String getAccounts = 'citizen/Account/index';
}
