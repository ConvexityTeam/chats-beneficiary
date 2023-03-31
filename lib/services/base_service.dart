class BaseService {
  // static String rootApi = "https://chats-backend.herokuapp.com/api/v1";
  static const String rootApi = String.fromEnvironment('BUILD_ENV') != "production"
      ? "https://staging-api.chats.cash/v1"
      : "https://api.chats.cash/v1";
  static String __rootApi = "https://staging-api.chats.cash/v1";
  static String GOOGLE_GEOCODER = "AIzaSyDgIDdU1WUh6_qQywGAGnT4CG6R4_zmux0";

  Map<String, String> header = {"Content-Type": "application/json"};
}
