import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _service = OmdbService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
          body: FutureBuilder<SearchResult>(
        future: _service.search("Harry potter", 1),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (snapshot.data.response) {
            return ListView(
              children: List.generate(snapshot.data.results.length, (index) {
                return ListTile(
                  title: Text(snapshot.data.results[index].title),
                  leading: Image.network(snapshot.data.results[index].poster),
                  subtitle: Text(snapshot.data.results[index].year),
                );
              }),
            );
          } else {
            return Center(
              child: Text(snapshot.data.error),
            );
          }
        },
      )),
    );
  }
}
