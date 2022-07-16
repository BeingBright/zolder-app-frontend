import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class BookItem extends StatelessWidget {
  BookItem({Key? key, required this.bookId}) : super(key: key);

  final GetIt getIt = GetIt.instance;

  final String bookId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (bookId.isEmpty) ? Colors.black.withOpacity(0.25) : Colors.green,
      child: SizedBox(
        height: 34,
        width: 88.5,
        child: Center(child: Text(bookId)),
      ),
    );
  }
}
