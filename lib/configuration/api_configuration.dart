class APIConfiguration {
  static const String baseURI = "http://localhost:7000/zolder";
  static const String user = "$baseURI/user";
  static const String location = "$baseURI/location";
  static const String auth = "$baseURI/auth";
  static const String locationAuth = "$location/audit";

  static Map<String, String> baseHeader = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Map<String, String> getHeadersWithToken(String token) {
    Map<String, String> headers = baseHeader;
    headers.putIfAbsent("authorization", () => token);
    return headers;
  }
}
