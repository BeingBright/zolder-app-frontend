import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolder_app/components/book/book_audit_modal.dart';
import 'package:zolder_app/components/book/book_update_modal.dart';
import 'package:zolder_app/controller/location_command.dart';
import 'package:zolder_app/models/user_token_model.dart';
import '../../models/book.dart';

class BookItem extends StatefulWidget {
  const BookItem({Key? key, required this.book, required this.context})
      : super(key: key);

  final Book book;
  final BuildContext context;

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  void _onPress() {
    var dialog = showDialog(
      context: context,
      builder: (ctx) {
        return BookUpdateModal(
          book: widget.book,
        );
      },
    );
    dialog.then((books) {
      if (books == null) return;
      LocationCommand().updateBook(books);
      setState(() {
        widget.book.bookId = books.bookId;
      });
    });
  }

  void _onLongPress() {
    showDialog(
      context: context,
      builder: (ctx) {
        return BookAuditModal(
          book: widget.book,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: (widget.book.bookId.isEmpty)
          ? Colors.black.withOpacity(0.25)
          : Colors.green,
      onPressed: _onPress,
      onLongPress: () {
        if (Provider.of<UserTokenModel>(context, listen: false)
                .userToken
                .role ==
            "ADMIN") {
          _onLongPress();
        }
      },
      child: Text(
        widget.book.bookId,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
