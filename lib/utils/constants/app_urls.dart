class AppUrls {
  static const String BASE_URL =
      "https://lionfish-app-zzj66.ondigitalocean.app/";

  static const Auth auth = Auth();
}

class Auth {
  const Auth();
  final String login = "search/login";
  final String register = "search/register";
  final String verifyOtp = "search/verify-otp";
}
