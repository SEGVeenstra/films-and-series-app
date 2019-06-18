import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _service = OmdbService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: TextField(),
            leading: Icon(Icons.search),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
              )
            ],
          ),
          body: FutureBuilder<SearchResult>(
            future: _service.search("Harry potter", 1),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (snapshot.data.response) {
                return ListView(
                  children:
                      List.generate(snapshot.data.results.length, (index) {
                    return ListTile(
                      title: Text(snapshot.data.results[index].title),
                      leading:
                          Image.network(snapshot.data.results[index].poster),
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
