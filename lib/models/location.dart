import 'book.dart';

class Location {
  String? id;
  int? rowCount;
  int? columnCount;
  String? buildingLocation;
  String? inventoryLocation;
  List<Book> books = [];

  Location(this.id, this.rowCount, this.columnCount, this.buildingLocation,
      this.inventoryLocation, this.books);

  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        rowCount = json['rowCount'],
        columnCount = json['columnCount'],
        buildingLocation = json['buildingLocation'],
        inventoryLocation = json['inventoryLocation'],
        books = booksFromJson(json['books']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'rowCount': rowCount,
        'columnCount': columnCount,
        'buildingLocation': buildingLocation,
        'inventoryLocation': inventoryLocation
      };

  static List<Book> booksFromJson(List json) {
    return List<Book>.from(json.map((e) {
      return Book.fromJson(e);
    }));
  }

  @override
  String toString() {
    return 'Location{id: $id, rowCount: $rowCount, columnCount: $columnCount, buildingLocation: $buildingLocation, inventoryLocation: $inventoryLocation, books: $books}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          buildingLocation == other.buildingLocation &&
          inventoryLocation == other.inventoryLocation;

  @override
  int get hashCode =>
      id.hashCode ^ buildingLocation.hashCode ^ inventoryLocation.hashCode;
}
