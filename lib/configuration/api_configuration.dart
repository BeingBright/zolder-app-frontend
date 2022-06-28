class APIConfiguration {
  // static const String restApiUrl = "http://brightonvandenend.nl:8050/zolder";
  static const String restApiUrl = "http://localhost:7000/zolder";
  static const String user = "$restApiUrl/user";
  static const String location = "$restApiUrl/location";
  static const String auth = "$restApiUrl/auth";
  static const String locationAuth = "$location/audit";

  // static const String stompSocketUrl = "ws://brightonvandenend.nl:8050/zolder/stomp";
  static const String stompSocketUrl = "ws://localhost:7000/zolder/stomp";

  static Map<String, String> baseHeader = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Map<String, String> getHeadersWithToken(String token) {
    Map<String, String> headers = baseHeader;
    headers.putIfAbsent("authorization", () => token);
    return headers;
  }
}
