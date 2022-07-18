import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:zolder_app/component/book_item.dart';
import 'package:zolder_app/component/book_update_modal.dart';
import 'package:zolder_app/model/book.dart';
import 'package:zolder_app/model/location.dart';
import 'package:zolder_app/model/user/auth_token.dart';
import 'package:zolder_app/model/user/user.dart';
import 'package:zolder_app/services/book_service.dart';

class BookTable extends StatefulWidget {
  BookTable({Key? key, required this.location, this.searchTerm})
      : super(key: key) {
    books = generateList(location);
  }

  final GetIt getIt = GetIt.instance;

  final Location location;

  String? searchTerm = "";

  late final List<List<Book?>> books;

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
  void _onCellPressed(int i, int j) {
    if (widget.getIt<AuthTokenModel>().authToken.role == UserRole.office) {
      return;
    }
    var dialog = showDialog(
      context: context,
      builder: (ctx) {
        return BookUpdateModal(
          book: widget.books[i][j]!,
        );
      },
    );
    dialog.then((books) {
      if (books == null) return;
      widget.getIt<BookService>().updateBook(books);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StickyHeadersTable(
        key: UniqueKey(),
        columnsLength: widget.location.rowCount!,
        rowsLength: widget.location.columnCount!,
        columnsTitleBuilder: (i) => Text("Rij $i"),
        rowsTitleBuilder: (i) => Text("$i"),
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
        contentCellBuilder: (i, j) => BookItem(
            bookId: widget.books[i][j]!.bookId,
            highlight:
                widget.books[i][j]!.bookId.replaceAll(".", "").contains(widget.searchTerm ?? "") &&
                    (widget.searchTerm ?? "").isNotEmpty),
        onContentCellPressed: _onCellPressed,
        scrollPhysics: CustomScrollPhysics(
          contentHorizontal: const BouncingScrollPhysics(),
          contentVertical: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
