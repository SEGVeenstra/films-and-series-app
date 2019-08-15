import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:films_and_series/films_and_series/widgets/custom_error_widget.dart';
import 'package:films_and_series/films_and_series/widgets/result_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail_page.dart';

class SearchPage extends StatelessWidget {

  final _queryNotifier = ValueNotifier('');

  Function(Result) _navCallBack(BuildContext context) => (Result selectedResult) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetailPage(selectedResult)));
  };

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.search),
          title: TextField(
            onChanged: (newQuery) => _queryNotifier.value = newQuery,
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: _queryNotifier,
          builder: (context, query, child) => query.length > 2
              ? FutureBuilder<SearchResult>(
              future: Provider.of<OmdbService>(context).search(query, 1),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                else if (snapshot.data.response)
                  return ResultListWidget(snapshot.data.results, _navCallBack(context));
                else
                  return CustomErrorWidget(snapshot.data.error);
              })
              : CustomErrorWidget('Type atleast 3 or more characters to search!')
        )
      );
}




