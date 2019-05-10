import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

class ResultTile extends StatelessWidget {

  final Result _result;

  ResultTile(this._result);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_result.title),
      subtitle: Text(_result.year),
      leading:Image(image:NetworkImageWithRetry(_result.poster), height: 60,),
      trailing: _result.type == 'movie' ? Icon(Icons.movie) : Icon(Icons.tv),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(_result)));
      },
    );
  }
}
