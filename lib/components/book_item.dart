import 'package:flutter/material.dart';

import '../models/book.dart';

class BookItem extends StatelessWidget {
  const BookItem({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.red,
      onPressed: () {
        print(book);
      },
      onLongPress: () {
        print("$book LONG BOI PRESS");
      },
      child: Text(
        book.bookId,
      ),
    );
  }
}
