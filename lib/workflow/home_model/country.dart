import 'package:hive/hive.dart';

part 'country.g.dart';

@HiveType(typeId: 0)
class Country extends HiveObject {
  @HiveField(0)
  String country;
  @HiveField(1)
  String region;

  Country({
    required this.country,
    required this.region,
  });
}

@HiveType(typeId: 1)
class CountryData extends HiveObject {
  @HiveField(0)
  List<Country> data;

  CountryData({
    required this.data,
  });
}
