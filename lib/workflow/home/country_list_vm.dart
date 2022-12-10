import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_demo/view_model/view_state.dart';
import 'package:news_app_demo/workflow/home_model/api.dart';
import 'package:news_app_demo/workflow/home_model/country.dart';
import 'dart:developer' as developer;

class CountryNameVM extends ChangeNotifier {
  late ViewState<CountryData> mainViewState = ViewState.loading();
  final List<CountryDetails> _countries = [];
  final List<Country> _cacheCountry = [];
  final String noteHiveBox = 'country-box';

  Future<void> cacheCountry(CountryData data) async {
    Box<CountryData> box = await Hive.openBox<CountryData>(noteHiveBox);
    await box.add(data);
  }

  Future<void> getCacheCountry() async {
    Box<CountryData> box = await Hive.openBox<CountryData>(noteHiveBox);
    if (box.isNotEmpty) {
      _cacheCountry.addAll(box.values.first.data);
    }
  }

  void getData() async {
    if (mainViewState.status != Status.loading) {
      mainViewState = ViewState.loading();
      notifyListeners();
    }
    await getCacheCountry();
    if (_cacheCountry.isNotEmpty) {
      mainViewState = ViewState.success(CountryData(data: _cacheCountry));
      notifyListeners();
      developer.log("Cached country list used");
    } else {
      http
          .get(Uri.parse('https://api.first.org/data/v1/countries'))
          .then((value) {
        final response = CountryList.fromJson(jsonDecode(value.body));
        for (final res in response.data.entries) {
          _countries.add(
            CountryDetails(res.key, res.value.country),
          );
          _cacheCountry
              .add(Country(region: res.key, country: res.value.country));
        }
        cacheCountry(CountryData(data: _cacheCountry));
        mainViewState = ViewState.success(CountryData(data: _cacheCountry));
        notifyListeners();
        developer.log("Api called and country list have been cached");
      }).catchError((error, stackTrace) {
        mainViewState = ViewState.error(error, stackTrace);
        notifyListeners();
      });
    }
  }

  Future<void> searchForAppointment(String query) async {
    mainViewState =
        ViewState.success(CountryData(data: _queryDataResponse(query)));
    notifyListeners();
  }

  List<Country> _queryDataResponse(String query) {
    return _cacheCountry.where((element) {
      return element.country.toUpperCase().contains(query) ||
          element.region.toUpperCase().contains(query);
    }).toList();
  }
}

class Countries {
  final List<CountryDetails> countries;

  const Countries(
    this.countries,
  );
}

class CountryDetails {
  final String abbreviation;
  final String countryName;

  const CountryDetails(
    this.abbreviation,
    this.countryName,
  );
}
