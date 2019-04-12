import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:films_and_series/films_and_series/widgets/SearchResultTile.dart';
import 'package:flutter/material.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  String _query = "iron";
  var _service = OmdbService();
  final _searchTextController = TextEditingController();

  _search(String text) {
    setState(() {
      _query = text;
      _searchTextController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Films & Series'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showDialog(context: context, builder: (context) {
                return SimpleDialog(title: Text('Search:'), children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:24.0),
                    child: TextField(controller: _searchTextController,),
                  ),
                  SizedBox(height: 16.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: RaisedButton(child: Text('Search'),onPressed: (){
                      _search(_searchTextController.text);
                      Navigator.pop(context);
                    },),
                  ),
                ],);
              });
            },
          ),
        ],
      ),
      body: _getResult(),
    );
  }

  Widget _getResult() {
    return FutureBuilder<List<SearchResult>>(
      future: _service.search(_query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(itemBuilder: (context, index) {
            if (index < snapshot.data.length)
              return ResultTile(snapshot.data[index]);
          });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
