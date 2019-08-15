import 'package:films_and_series/films_and_series/models/detail_result.dart';
import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  final OmdbService _service;
  final Result _searchResult;

  DetailPage(this._searchResult, this._service);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_searchResult.title),),
      body: Column(
        children: <Widget>[
          Image.network(_searchResult.poster, height: 300,width: double.maxFinite, alignment: Alignment.center,),
          FutureBuilder<DetailResult>(
            future: _service.byId(_searchResult.id),
            builder: (context, snapshot){
              if(!snapshot.hasData)
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              else
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(snapshot.data.plot),
                );
            },
          ),
        ],
      ),
    );
  }
}