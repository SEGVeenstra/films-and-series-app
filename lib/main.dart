import 'package:films_and_series/films_and_series/pages/search_page.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<OmdbService>(
      builder: (context) => OmdbService(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: SearchPage(),
      ),
    );
  }
}


