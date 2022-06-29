import 'package:flutter/material.dart';
import 'package:zolder_app/models/location.dart';

import 'book_item.dart';

class BookTable extends StatelessWidget {
  const BookTable({Key? key, required this.location}) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: location.books.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: location.columnCount ?? 1,
          mainAxisExtent: 75,
          childAspectRatio: 6,
        ),
        itemBuilder: (ctx, index) {
          return BookItem(context: ctx, book: location.books[index]);
        },
      ),
    );
  }
}
