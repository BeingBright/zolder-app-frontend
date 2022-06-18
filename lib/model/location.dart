class Location {
  String id;
  int row;
  int column;
  String location;
  String inventoryLocation;
  int bookNumber;

  Location(this.id, this.row, this.column, this.location,
      this.inventoryLocation, this.bookNumber);

  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        row = json['row'],
        column = json['column'],
        location = json['location'],
        inventoryLocation = json['inventoryLocation'],
        bookNumber = json['bookNumber'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'row': row,
        'column': column,
        'location': location,
        'inventoryLocation': inventoryLocation,
        'bookNumber': bookNumber,
      };

  @override
  String toString() {
    return 'Location{id: $id, row: $row, column: $column, location: $location, inventoryLocation: $inventoryLocation, bookNumber: $bookNumber}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          row == other.row &&
          column == other.column &&
          location == other.location &&
          inventoryLocation == other.inventoryLocation &&
          bookNumber == other.bookNumber;

  @override
  int get hashCode =>
      id.hashCode ^
      row.hashCode ^
      column.hashCode ^
      location.hashCode ^
      inventoryLocation.hashCode ^
      bookNumber.hashCode;
}