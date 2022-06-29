import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zolder_app/models/book.dart';

class BookUpdateModal extends StatelessWidget {
  BookUpdateModal({Key? key, required this.book}) : super(key: key);

  final Book book;
  final TextEditingController _bookIdController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  void _onUpdate(BuildContext context) {
    if (formkey.currentState!.validate()) {
      book.bookId = _bookIdController.text;
      Navigator.of(context).pop(book);
    }
  }

  void _onClear(BuildContext context) {
    book.bookId = "";
    Navigator.of(context).pop(book);
  }

  @override
  Widget build(BuildContext context) {
    _bookIdController.text = book.bookId;

    return AlertDialog(
      title: const Text("Update Book Location"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            _onClear(context);
          },
          child: const Text("Clear"),
        ),
        TextButton(
          onPressed: () {
            _onUpdate(context);
          },
          child: const Text("Update"),
        ),
      ],
      content: Form(
        key: formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.done,
            controller: _bookIdController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Inventory Name",
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
            ],
            onEditingComplete: () {
              _onUpdate(context);
            },
            validator: (value) {
              RegExp bookIDRegexp = RegExp("([0-9]{2}.[0-9]{2}.[0-9]{2})");
              if (value != null &&
                  (value.isEmpty || bookIDRegexp.hasMatch(value))) {
                return null;
              }
              return 'invalid Book Number';
            }),
      ),
    );
  }
}
