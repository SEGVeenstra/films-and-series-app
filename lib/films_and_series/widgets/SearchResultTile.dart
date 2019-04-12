import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/pages/DetailPage.dart';
import 'package:flutter/material.dart';

class ResultTile extends StatelessWidget {

  final Result _result;

  ResultTile(this._result);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_result.title),
      subtitle: Text(_result.year),
      leading: Hero(tag: _result.id, child: Image.network(_result.poster, height: 60.0,)),
      trailing: _result.type == 'movie' ? Icon(Icons.movie) : Icon(Icons.tv),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(_result)));
      },
    );
  }
}