import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:flutter/material.dart';

class ResultListWidget extends StatelessWidget {
  final List<Result> _results;
  final Function(Result result) _detailTap;

  ResultListWidget(this._results, this._detailTap);

  @override
  Widget build(BuildContext context) => ListView(
    children: List.generate(
        _results.length,
            (i) => ListTile(
          onTap: () => _detailTap(_results[i]),
          title: Text(_results[i].title),
          subtitle: Text(_results[i].year),
          leading: Image.network(_results[i].poster),
        )),
  );
}