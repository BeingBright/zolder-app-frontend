class Book {
  String? id;
  int? row;
  int? column;
  String bookId = "";

  Book(this.id, this.row, this.column, this.bookId);

  bool isEmpty() {
    return bookId.isEmpty;
  }

  Book.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        row = json['row'],
        column = json['column'],
        bookId = json['bookId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'row': row,
        'column': column,
        'bookId': bookId,
      };

  static List<Book> generateList(List json) {
    return List<Book>.from(json.map((e) {
      return Book.fromJson(e);
    }));
  }

  @override
  String toString() {
    return 'Book{row: $row, column: $column, bookId: $bookId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          row == other.row &&
          column == other.column;

  @override
  int get hashCode => id.hashCode ^ row.hashCode ^ column.hashCode;
}
