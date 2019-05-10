import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:flutter/material.dart';

class DetailPage  extends StatelessWidget {

  final Result _searchResult;

  DetailPage(this._searchResult);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_searchResult.title),
      ),
    );

  }
}
