import 'package:flutter/material.dart';
import 'package:zolder_app/components/book_item.dart';
import 'package:zolder_app/models/location.dart';

class BookTable extends StatelessWidget {
  const BookTable({Key? key, required this.location}) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: location.books.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: location.rowCount ?? 1,
        mainAxisExtent: 75,
        childAspectRatio: 6,
      ),
      itemBuilder: (ctx, index) {
        return BookItem(book: location.books[index]);
      },
    );
  }
}
