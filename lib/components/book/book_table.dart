import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:zolder_app/components/book/book_item.dart';
import 'package:zolder_app/models/book.dart';
import 'package:zolder_app/models/location.dart';

class BookTable extends StatefulWidget {
  BookTable({Key? key, required this.location}) : super(key: key) {
    books2d = generateList(location);
  }

  final Location location;

  late final List<List<Book?>> books2d;

  static List<List<Book?>> generateList(Location loc) {
    List<List<Book?>> bookList = List.generate(loc.rowCount ?? 0,
        (i) => List.generate(loc.columnCount ?? 0, (j) => null));
    for (var b in loc.books) {
      bookList[b.row!][b.column!] = b;
    }
    return bookList;
  }

  @override
  State<BookTable> createState() => _BookTableState();
}

class _BookTableState extends State<BookTable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StickyHeadersTable(
        rowsLength: widget.location.columnCount!,
        columnsLength: widget.location.rowCount!,
        legendCell: Text(widget.location.inventoryLocation!),
        columnsTitleBuilder: (int columnIndex) => Text("Rij $columnIndex"),
        rowsTitleBuilder: (int rowIndex) => Text("$rowIndex"),
        cellDimensions: const CellDimensions.fixed(
            contentCellWidth: 92.5,
            contentCellHeight: 38,
            stickyLegendWidth: 25,
            stickyLegendHeight: 20),
        cellAlignments: const CellAlignments.fixed(
            contentCellAlignment: Alignment.center,
            stickyColumnAlignment: Alignment.center,
            stickyRowAlignment: Alignment.center,
            stickyLegendAlignment: Alignment.center),
        contentCellBuilder: (i, j) =>
            BookItem(book: widget.books2d[i][j]!, context: context),
      ),
    );
  }
}

/*

import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:zolder_app/models/book.dart';
import 'package:zolder_app/models/location.dart';

import 'book_item.dart';

class BookTable extends StatelessWidget {
  BookTable({Key? key, required this.location}) : super(key: key) {
    books2d = generateList(location);
  }

  final Location location;

  late final List<List<Book?>> books2d;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StickyHeadersTable(
        rowsLength: location.columnCount!,
        columnsLength: location.rowCount!,
        legendCell: Text(location.inventoryLocation!),
        columnsTitleBuilder: (int columnIndex) => Text("Rij $columnIndex"),
        rowsTitleBuilder: (int rowIndex) => Text("Pallet $rowIndex"),
        cellAlignments: CellAlignments.fixed(
            contentCellAlignment: Alignment.center,
            stickyColumnAlignment: Alignment.center,
            stickyRowAlignment: Alignment.center,
            stickyLegendAlignment: Alignment.center),
        contentCellBuilder: (i, j) =>
            BookItem(book: books2d[i][j]!, context: context),
      ),
    );
  }

  static List<List<Book?>> generateList(Location loc) {
    List<List<Book?>> bookList = List.generate(loc.rowCount ?? 0,
        (i) => List.generate(loc.columnCount ?? 0, (j) => null));
    for (var b in loc.books) {
      bookList[b.row!][b.column!] = b;
    }
    print(bookList);
    return bookList;
  }
}

 */
