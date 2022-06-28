import 'package:flutter/material.dart';
import 'package:zolder_app/models/location.dart';

import '../models/book.dart';

class BookTable extends StatelessWidget {
  const BookTable({Key? key, required this.location}) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        location.books.toString(),
      ),
    );
  }
}
