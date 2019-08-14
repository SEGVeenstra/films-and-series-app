import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String _error;

  CustomErrorWidget(this._error);

  @override
  Widget build(BuildContext context) => Center(
    child: Text(_error),
  );
}