import 'package:condition/condition.dart';
import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _query = '';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.search),
          title: TextField(
            onChanged: (q) => _onQueryChange(q),
          ),
        ),
        body: Conditioned.boolean(
          _query.length > 2,
          trueBuilder: () => FutureBuilder<SearchResult>(
            future: Provider.of<OmdbService>(context).search(_query, 1),
            builder: (context, snapshot) => Conditioned(
              cases: [
                Case(
                  !snapshot.hasData,
                  builder: () => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Case(snapshot.hasData && snapshot.data.response,
                    builder: () => _ResultListWidget(snapshot.data.results)),
              ],
              defaultBuilder: () => _ErrorWidget(snapshot.data.error),
            ),
          ),
          falseBuilder: () =>
              _ErrorWidget('Type atleast 3 or more characters to search!'),
        ),
      );

  _onQueryChange(String newQuery) {
    setState(() {
      _query = newQuery;
    });
  }
}

class _ResultListWidget extends StatelessWidget {
  final List<Result> _results;

  _ResultListWidget(this._results);

  @override
  Widget build(BuildContext context) => ListView(
        children: List.generate(
            _results.length,
            (i) => ListTile(
                  onTap: () => _navigateToDetailPage(context, _results[i]),
                  title: Text(_results[i].title),
                  subtitle: Text(_results[i].year),
                  leading: Image.network(_results[i].poster),
                )),
      );

  _navigateToDetailPage(BuildContext context, Result result) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetailPage(result)));
  }
}

class _ErrorWidget extends StatelessWidget {
  final String _error;

  _ErrorWidget(this._error);

  @override
  Widget build(BuildContext context) => Center(
        child: Text(_error),
      );
}
