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

  var _query = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: TextField(
              onChanged: (text){
                setState(() {
                  _query = text;
                });
              },
            ),
            leading: Icon(Icons.search),
          ),
          body: _query.length > 2 ? FutureBuilder<SearchResult>(
            future: _service.search(_query, 1),
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
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage()));
                      },
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
          ): Center(child: Text("Type at least 3 or more characters"),)),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

