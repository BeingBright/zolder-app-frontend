import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin provider {
  T getProvided<T>(BuildContext context) => context.read<T>();
}
