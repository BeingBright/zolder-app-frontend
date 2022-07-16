import 'package:zolder_app/model/book.dart';
import 'package:zolder_app/model/location.dart';
import 'package:zolder_app/model/user/user.dart';

class LocationAudit {
  String id;
  Location location;
  Book bookInLocation;
  String bookId;
  User user;
  DateTime timestamp;

  LocationAudit(this.id, this.location, this.bookInLocation, this.bookId,
      this.user, this.timestamp);

  LocationAudit.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        location = Location.fromJson(json['location']),
        bookInLocation = Book.fromJson(json['bookInLocation']),
        bookId = json['bookId'],
        user = User.fromJson(json['user']),
        timestamp = DateTime.parse(json['timestamp']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'location': location.toJson(),
        'bookInLocation': bookInLocation.toJson(),
        'bookId': bookId,
        'user': user.toJson(),
        'timestamp': timestamp
      };

  @override
  String toString() {
    return 'LocationAudit{id: $id, location: $location, bookInLocation: $bookInLocation, bookId: $bookId, user: $user, timestamp: $timestamp}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAudit &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          location == other.location &&
          bookInLocation == other.bookInLocation &&
          bookId == other.bookId &&
          user == other.user &&
          timestamp == other.timestamp;

  @override
  int get hashCode =>
      id.hashCode ^
      location.hashCode ^
      bookInLocation.hashCode ^
      bookId.hashCode ^
      user.hashCode ^
      timestamp.hashCode;
}
