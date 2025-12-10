class EndPoints {
  /// عدّل الـ baseUrl حسب الـ API تبعك
  static const String baseUrl = 'http://192.168.130.187/api/v1/';
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
    static const String showComplaints = 'citizen/home/showComplaints';
    static const String searchComplaint = 'citizen/home/searchComplaint';
    static const String getNotifications = '/citizen/notification';

  // submit a complaint
  static const String agency = 'citizen/home/agencyByName';
  static const String complaintType = 'citizen/home/ComplaintTypeByName';
  static const String createComplaint = 'citizen/home/createComplain';
  // complaint details
  static const String complaintDetails = "citizen/complaint/getDetails/"; 
  static const String deleteComplaint = 'citizen/complaint/delete/';
  static const String addComplaintDetails = 'citizen/complaint/addDetails/';

}
