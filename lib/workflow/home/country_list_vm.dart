import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_demo/view_model/view_state.dart';
import 'package:news_app_demo/workflow/home_model/api.dart';

class CountryNameVM extends ChangeNotifier {
  late ViewState<Countries> mainViewState = ViewState.loading();
  final List<CountryDetails> countries = [];

  void getData() async {
    if (mainViewState.status != Status.loading) {
      mainViewState = ViewState.loading();
      notifyListeners();
    }
    http
        .get(Uri.parse('https://api.first.org/data/v1/countries?limit=20'))
        .then((value) {
      final response = CountryList.fromJson(jsonDecode(value.body));
      for (final res in response.data.entries) {
        countries.add(
          CountryDetails(res.key, res.value.country),
        );
      }
      mainViewState = ViewState.success(Countries(countries));
      notifyListeners();
    }).catchError((error, stackTrace) {
      mainViewState = ViewState.error(error, stackTrace);
      notifyListeners();
    });
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
