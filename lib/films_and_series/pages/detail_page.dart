import 'package:films_and_series/films_and_series/models/detail_result.dart';
import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final Result _searchResult;

  DetailPage(this._searchResult);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_searchResult.title),
        ),
        body: Column(
          children: <Widget>[
            Image.network(
              _searchResult.poster,
              height: 300,
              width: double.maxFinite,
              alignment: Alignment.center,
            ),
            FutureBuilder<DetailResult>(
                future:
                    Provider.of<OmdbService>(context).byId(_searchResult.id),
                builder: (context, snapshot) => !snapshot.hasData
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(snapshot.data.plot),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ],
        ),
      );
}
