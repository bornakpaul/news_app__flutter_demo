import 'package:json_annotation/json_annotation.dart';

part 'api.g.dart';

@JsonSerializable(createToJson: false)
class News {
  final int totalResults;
  final String status;
  final List<NewsData> articles;

  News(this.articles, this.status, this.totalResults);
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
}

@JsonSerializable(createToJson: false)
class NewsData {
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  NewsData(
    this.author,
    this.content,
    this.description,
    this.publishedAt,
    this.title,
    this.url,
    this.urlToImage,
  );

  factory NewsData.fromJson(Map<String, dynamic> json) =>
      _$NewsDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class NewsServerError {
  final String message;

  NewsServerError(this.message);

  factory NewsServerError.fromJson(Map<String, dynamic> json) =>
      _$NewsServerErrorFromJson(json);
}

@JsonSerializable(createToJson: false)
class RegionDetails {
  final String country;
  final String region;

  RegionDetails(
    this.country,
    this.region,
  );

  factory RegionDetails.fromJson(Map<String, dynamic> json) =>
      _$RegionDetailsFromJson(json);
}

@JsonSerializable(createToJson: false)
class CountryList {
  final Map<String, RegionDetails> data;

  CountryList(
    this.data,
  );

  factory CountryList.fromJson(Map<String, dynamic> json) =>
      _$CountryListFromJson(json);
}
