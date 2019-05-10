import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/widgets/result_tile.dart';
import 'dart:async';
import 'package:flutter/material.dart';


class InfiniteListView extends StatelessWidget {

  var pageSize = 10;

  String _query = "love";
  int pageNumber = 0;

  var _service = OmdbService();

  var completers = new List<Completer<Result>>();

  Widget _loadItem(int itemIndex) {

    if (itemIndex >= completers.length) {
      pageNumber = ((itemIndex + 1) / pageSize).ceil();


      completers.addAll(List.generate(pageSize, (index) {
        return new Completer();
      }));

      _service.search(_query, pageNumber).then((items) {
        items.results.asMap().forEach((index, item) {
          completers[itemIndex + index].complete(item);
        });
      }).catchError((error) {
        completers.sublist(itemIndex, itemIndex + pageNumber).forEach((completer) {
          completer.completeError(error);
        });
      });
    }

    var future = completers[itemIndex].future;

    return new FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Container(
                padding: const EdgeInsets.all(8.0),
                child: new Placeholder(fallbackHeight: 100.0),
              );
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ResultTile(snapshot.data);
              } else if (snapshot.hasError) {
                return new Text(
                  '${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                );
              }
              return new Text('');
            default:
              return new Text('');
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) => _loadItem(index));
  }

}