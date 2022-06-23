class APIConfiguration {
  static const String REST_API_URI = "http://brightonvandenend.nl:7000/zolder";
  static const String user = "$REST_API_URI/user";
  static const String location = "$REST_API_URI/location";
  static const String auth = "$REST_API_URI/auth";
  static const String locationAuth = "$location/audit";

  static const String STOMP_SOCKET_URI = "ws://brightonvandenend.nl:7000/zolder/stomp";

  static Map<String, String> baseHeader = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Map<String, String> getHeadersWithToken(String token) {
    Map<String, String> headers = baseHeader;
    headers.putIfAbsent("authorization", () => token);
    return headers;
  }
}
