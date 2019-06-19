import 'package:films_and_series/films_and_series/models/detail_result.dart';
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(snapshot.data.results[index], _service)));
                      },
                      title: Text(snapshot.data.results[index].title),
                      leading:
                          Hero(tag: snapshot.data.results[index].id , child: Image.network(snapshot.data.results[index].poster)),
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

  final Result _searchResult;
  final OmdbService _service;

  DetailPage(this._searchResult, this._service);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_searchResult.title),),
      body: Column(
        children: <Widget>[
          Hero(tag: _searchResult.id, child: Image.network(_searchResult.poster, height: 300.0, width: double.maxFinite, alignment: Alignment.center,)),
          FutureBuilder<DetailResult>(
            future: _service.byId(_searchResult.id),
            builder: (context, snapshot){
              if(!snapshot.hasData)
                return Expanded(child: Center(child: CircularProgressIndicator(),));
              else
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(snapshot.data.plot),
                );
            },
          )
        ],
      ),
    );
  }
}

