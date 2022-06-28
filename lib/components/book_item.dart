import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolder_app/models/user_token_model.dart';

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
        if (Provider.of<UserTokenModel>(context,listen: false).userToken.role == "ADMIN") {
          print("$book LONG BOI PRESS");
        }
      },
      child: Text(
        book.bookId,
      ),
    );
  }
}
