import 'package:flutter/material.dart';
import 'package:news_app_demo/dal/api_client.dart';
import 'package:news_app_demo/view_model/view_state.dart';
import 'package:news_app_demo/workflow/home_model/api.dart';

class HomeScreenVM extends ChangeNotifier {
  late ViewState<News> mainViewState = ViewState.loading();

  void getData(String countryCode) {
    if (mainViewState.status != Status.loading) {
      mainViewState = ViewState.loading();
      notifyListeners();
    }
    ApiClient.get('top-headlines?country=$countryCode').then((value) {
      print("value : ${value}");
      mainViewState = ViewState.success(News.fromJson(value));
      notifyListeners();
    }).catchError((error, stackTrace) {
      mainViewState = ViewState.error(error, stackTrace);
      notifyListeners();
    });
  }
}
