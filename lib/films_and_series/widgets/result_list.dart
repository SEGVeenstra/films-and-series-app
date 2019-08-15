import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/pages/detail_page.dart';
import 'package:flutter/material.dart';

class ResultList extends StatelessWidget {

  final List<Result> _results;

  ResultList(this._results);

  @override
  Widget build(BuildContext context) => ListView(
      children:
      List.generate(_results.length, (index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailPage(
                    _results[index])));
          },
          title: Text(_results[index].title),
          subtitle: Text(_results[index].year),
          leading:
          Image.network(_results[index].poster),
        );
      }),
    );
}