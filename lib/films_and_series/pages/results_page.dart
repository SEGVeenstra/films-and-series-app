import 'package:films_and_series/films_and_series/widgets/infinite_listview.dart';
import 'package:flutter/material.dart';


class ResultsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return
        Scaffold(
          appBar: AppBar(
            title: Text('Film app'),
          ),
          body: InfiniteListView(),
        );
  }
}