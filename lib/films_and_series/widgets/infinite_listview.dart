import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/widgets/result_tile.dart';
import 'dart:async';
import 'package:flutter/material.dart';


class InfiniteListView extends StatelessWidget {

  final pageSize = 10;
  final String _query = "the matrix";
  final _service = OmdbService();

  final cache = new List<Completer<Result>>();

  Widget _loadItem(int itemIndex) {

    if (itemIndex >= cache.length) {

      //calculate the current page number based on the current item index
      //and the amount of items in one page
      var pageNumber = ((itemIndex + 1) / pageSize).ceil();

      //add completer objects for the next page of items
      cache.addAll(List.generate(pageSize, (index) {
        return new Completer();
      }));

      //Retrieve items and set completer objects
      _service.search(_query, pageNumber).then((items)
      {
        if (items.results != null)
          {
            items.results.asMap().forEach((index, item)
            {
              cache[itemIndex + index].complete(item);
            });

          }
      }).catchError((error)
      {
        cache.sublist(itemIndex, itemIndex + pageSize).forEach((completer)
        {
          completer.completeError(error);
        });
      });
    }

    var future = cache[itemIndex].future;

    return FutureBuilder(future: future, builder: (context, snapshot)
        {

          switch (snapshot.connectionState)
          {
            case ConnectionState.waiting:

              return new Container(padding: const EdgeInsets.all(8.0), child: new Placeholder(fallbackHeight: 60.0));

            case ConnectionState.done:

              if (snapshot.hasData)
              {
                return ResultTile(snapshot.data);
              }
              else if (snapshot.hasError)
              {
                return new Text('${snapshot.error}', style: TextStyle(color: Colors.red));
              }

              continue defaultValue;

            defaultValue: default:
              return new Text('');
          }

        });
  }


  @override
  Widget build(BuildContext context)
  {
    return new ListView.builder(itemBuilder: (BuildContext context, int index) => _loadItem(index));
  }

}

class KeepAliveFutureBuilder extends StatefulWidget {

  final Future future;
  final AsyncWidgetBuilder builder;

  KeepAliveFutureBuilder({
    this.future,
    this.builder
  });

  @override
  _KeepAliveFutureBuilderState createState() => _KeepAliveFutureBuilderState();
}

class _KeepAliveFutureBuilderState extends State<KeepAliveFutureBuilder> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: widget.builder,
    );
  }

  @override
  bool get wantKeepAlive => true;
}