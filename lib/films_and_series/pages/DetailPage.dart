import 'package:films_and_series/films_and_series/models/detail_result.dart';
import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  final SearchResult _searchResult;

  DetailPage(this._searchResult);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(backgroundColor: Colors.transparent, expandedHeight: 300.0, flexibleSpace: FlexibleSpaceBar(
            title: Text(_searchResult.title, overflow: TextOverflow.ellipsis),
            background: Hero(tag: _searchResult.id, child: Image.network(_searchResult.poster, fit: BoxFit.cover,)),
          ),),
          SliverFillRemaining(
            child: FutureBuilder<DetailResult>(
              future: OmdbService().byId(_searchResult.id),
              builder: (context, snapshot){
                if(snapshot.hasData) {
                  return Container(padding: EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Genre', style: Theme.of(context).textTheme.headline,),
                          Text(snapshot.data.genre),
                          SizedBox(height: 16.0,),
                          Text('Plot', style: Theme.of(context).textTheme.headline,),
                          Text(snapshot.data.plot),
                          SizedBox(height: 16.0,),
                          Text('Actors', style: Theme.of(context).textTheme.headline,),
                          Text(snapshot.data.actors)
                        ]
                    ),);
                }
                else {
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          ), 
        ],
      ),
    );
  }
}
