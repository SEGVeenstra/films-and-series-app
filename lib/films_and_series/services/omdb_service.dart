import 'dart:convert';

import 'package:films_and_series/config.dart';
import 'package:films_and_series/films_and_series/models/detail_result.dart';
import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:http/http.dart' as http;

class OmdbService {
  static const _baseUrl = 'http://www.omdbapi.com/';

  Future<List<SearchResult>> search(String text) async {
    var url = "$_baseUrl?apikey=$key&s=$text";
    var result = await http.get(url);

    if(result.statusCode == 200) {
      var data = json.decode(result.body);
      var searchResults = data['Search'] as List;

      return searchResults.map((r) =>
            SearchResult(r['imdbID'], r['Title'], r['Year'], r['Type'], r['Poster'])).toList();

    }
    return null;
  }

  Future<DetailResult> byId(String id) async {
    var url = "$_baseUrl?apikey=$key&i=$id";
    var result = await http.get(url);

    if(result.statusCode == 200) {
      var data = json.decode(result.body);

      return DetailResult(data['Plot'], data['Actors'], data['Genre']);
    }
    return null;
  }
}