import 'package:flutter/material.dart';

import '../../models/book.dart';

class BookAuditModal extends StatelessWidget {
  const BookAuditModal({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Book Audit Log"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Close"),
        ),
      ],
    );
  }
}
