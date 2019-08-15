import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
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
      body: _query.length > 2
          ? FutureBuilder<SearchResult>(
              future: _service.search(_query, 1),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else if (snapshot.data.response)
                  return ListView(
                    children:
                        List.generate(snapshot.data.results.length, (index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  snapshot.data.results[index], _service)));
                        },
                        title: Text(snapshot.data.results[index].title),
                        subtitle: Text(snapshot.data.results[index].year),
                        leading:
                            Image.network(snapshot.data.results[index].poster),
                      );
                    }),
                  );
                else
                  return Center(
                    child: Text(snapshot.data.error),
                  );
              },
            )
          : Center(
              child: Text('Type atleast 3 or more characters to search!'),
            ),
    );
  }
}
