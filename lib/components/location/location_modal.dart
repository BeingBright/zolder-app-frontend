import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zolder_app/models/location.dart';

class LocationModal extends StatelessWidget {
  LocationModal({Key? key}) : super(key: key);

  final TextEditingController _rowController = TextEditingController();
  final TextEditingController _columnController = TextEditingController();
  final TextEditingController _inventoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add location"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(Location(
                  null,
                  int.parse(_rowController.text),
                  int.parse(_columnController.text),
                  "Celc",
                  _inventoryController.text, []));
            },
            child: const Text("Add"))
      ],
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.next,
              controller: _inventoryController,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Inventory Name",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              controller: _rowController,
              autocorrect: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Number of rows",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
            TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              controller: _columnController,
              autocorrect: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Number of columns",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onEditingComplete: () {
                Navigator.of(context, rootNavigator: true).pop(
                  Location(
                    null,
                    int.parse(_rowController.text),
                    int.parse(_columnController.text),
                    "Celc",
                    _inventoryController.text,
                    [],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
