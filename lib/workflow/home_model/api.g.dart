// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      (json['articles'] as List<dynamic>)
          .map((e) => NewsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as String,
      json['totalResults'] as int,
    );

NewsData _$NewsDataFromJson(Map<String, dynamic> json) => NewsData(
      json['author'] as String?,
      json['content'] as String?,
      json['description'] as String?,
      json['publishedAt'] as String,
      json['title'] as String,
      json['url'] as String,
      json['urlToImage'] as String?,
    );

NewsServerError _$NewsServerErrorFromJson(Map<String, dynamic> json) =>
    NewsServerError(
      json['message'] as String,
    );
