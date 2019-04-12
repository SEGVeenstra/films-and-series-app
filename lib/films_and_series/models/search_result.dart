class SearchResult {
  final int count;
  final List<Result> results;

  SearchResult(this.count,this.results);
}

class Result {
  final String id;
  final String title;
  final String year;
  final String type;
  final String poster;

  Result(this.id, this.title, this.year,this.type,this.poster);
}