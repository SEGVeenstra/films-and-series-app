class SearchResult {
  final int count;
  final List<Result> results;
  final bool response;
  final String error;

  SearchResult(this.count,this.results, this.response, this.error);
}

class Result {
  final String id;
  final String title;
  final String year;
  final String type;
  final String poster;

  Result(this.id, this.title, this.year,this.type,this.poster);
}