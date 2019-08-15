import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:films_and_series/films_and_series/widgets/result_list.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final OmdbService _service = OmdbService();
  var _query = "";

  _setQuery(String query) {
    setState(() {
      _query = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: TextField(
          onChanged: (text) => _setQuery(text),
        ),
      ),
      body: _query.length < 3
          ? Center(
              child: Text('Type atleast 3 or more characters to search!'),
            )
          : FutureBuilder<SearchResult>(
              future: _service.search(_query, 1),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else if (snapshot.data.response)
                  return ResultList(snapshot.data.results, _service);
                else
                  return Center(
                    child: Text(snapshot.data.error),
                  );
              },
            ),
    );
  }
}
