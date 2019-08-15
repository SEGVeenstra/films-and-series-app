import 'package:films_and_series/films_and_series/models/detail_result.dart';
import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/pages/search_page.dart';
import 'package:films_and_series/films_and_series/services/omdb_service.dart';
import 'package:flutter/material.dart';

import 'films_and_series/pages/detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: SearchPage(),
    );
  }
}
