class ServerException {
  final String message;
  final String status;
  final int statusCode;

  ServerException(this.message, this.status, this.statusCode);

  ServerException.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        status = json['status'],
        statusCode = json['statusCode'];

  Map<String, dynamic> toJson() => {
        'message': message,
        'status': status,
        'statusCode': statusCode,
      };

  @override
  String toString() {
    return message;
  }
}
