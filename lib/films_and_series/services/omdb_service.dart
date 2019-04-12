import 'dart:convert';

import 'package:films_and_series/config.dart';
import 'package:films_and_series/films_and_series/models/detail_result.dart';
import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:http/http.dart' as http;

class OmdbService {
  static const _baseUrl = 'http://www.omdbapi.com/';

  Future<SearchResult> search(String text, int page) async {
    var url = "$_baseUrl?apikey=$key&s=$text&page=$page";
    var result = await http.get(url);

    if(result.statusCode == 200) {
      var data = json.decode(result.body);
      var searchResults = data['Search'] as List;
      var count = int.parse(data['totalResults']);
      var response = data['Response'] == "True";
      var error = data['Error'];

      var results = searchResults.map((r) =>
            Result(r['imdbID'], r['Title'], r['Year'], r['Type'], r['Poster'])).toList();

      return SearchResult(count, results, response, error);
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