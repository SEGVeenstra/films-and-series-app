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
          onChanged: _onQueryChange,
        ),
      ),
      body: _query.length > 2
          ? _SearchResultWidget(_query)
          : _ErrorWidget('Type atleast 3 or more characters to search!'),
    );

  _onQueryChange(String newQuery) => setState(() {
        _query = newQuery;
      });
}

class _SearchResultWidget extends StatelessWidget {
  final String _query;

  _SearchResultWidget(this._query);

  @override
  Widget build(BuildContext context) => FutureBuilder<SearchResult>(
        future: Provider.of<OmdbService>(context).search(_query, 1),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (snapshot.data.response)
            return _ResultListWidget(snapshot.data.results);
          else
            return _ErrorWidget(snapshot.data.error);
        },
      );
}

class _ResultListWidget extends StatelessWidget {
  final List<Result> _results;

  _ResultListWidget(this._results);

  @override
  Widget build(BuildContext context) => ListView(
        children: List.generate(_results.length, (index) {
          final result = _results[index];

          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DetailPage(result)));
            },
            title: Text(result.title),
            subtitle: Text(result.year),
            leading: Image.network(result.poster),
          );
        }),
      );
}

class _ErrorWidget extends StatelessWidget {
  final String _error;

  _ErrorWidget(this._error);

  @override
  Widget build(BuildContext context) => Center(
        child: Text(_error),
      );
}
