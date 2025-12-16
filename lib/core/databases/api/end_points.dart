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
    static const String showComplaints = 'citizen/home/showComplaints';
    static const String searchComplaint = 'citizen/home/searchComplaint';
    static const String getNotifications = '/citizen/notification';
// account manag
  static const String agency = 'citizen/home/agencyByName';
  static const String updateAccount = 'citizen/Account/update';
// create account
  static const String createAccount = 'citizen/Account/create';
  // app services
  static const String accountsForSelect = 'citizen/Account/forSelect';
  static const String withdraw  = 'citizen/services/withdraw';
  static const String deposit  = 'citizen/services/deposit';
  static const String transfer  = 'citizen/services/transfer';

  // submit a complaint
  static const String getAccounts = 'citizen/Account/index';
  static const String complaintType = 'citizen/home/ComplaintTypeByName';
  static const String createComplaint = 'citizen/home/createComplain';
  // complaint details
  static const String complaintDetails = "citizen/complaint/getDetails/"; 
  static const String deleteComplaint = 'citizen/complaint/delete/';
  static const String addComplaintDetails = 'citizen/complaint/addDetails/';

}
