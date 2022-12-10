import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app_demo/view_model/view_state.dart';
import 'package:provider/provider.dart';

import 'country_list_vm.dart';

class NewsScreenWidget extends StatelessWidget {
  const NewsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Countries",
          style: TextStyle(color: Colors.blueAccent),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: _BodyWidget(),
      ),
    );
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget();

  @override
  State<_BodyWidget> createState() => __BodyWidgetState();
}

class __BodyWidgetState extends State<_BodyWidget> {
  final _viewModel = CountryNameVM();
  final countryCode = "IN";
  final _searchInputController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    _viewModel.getData();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _debounce?.cancel();
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CountryNameVM>(
      create: (context) => _viewModel,
      child: Consumer<CountryNameVM>(builder: (context, viewModel, _) {
        final viewState = viewModel.mainViewState;
        switch (viewModel.mainViewState.status) {
          case Status.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case Status.error:
            return Center(
              child: Text(viewState.exception.toString()),
            );
          case Status.success:
            final data = viewState.data!;
            return ListView.separated(
              itemCount: data.data.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _searchInputController,
                        decoration: InputDecoration(
                          labelText: 'Search country',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onChanged: (value) {
                          if (_debounce?.isActive == true) {
                            _debounce?.cancel();
                          }
                          _debounce =
                              Timer(const Duration(milliseconds: 500), () {
                            _viewModel.searchForAppointment(
                              value.toUpperCase(),
                            );
                          });
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      if (data.data.isEmpty)
                        Text(
                          "No country found matching with ${_searchInputController.text}",
                        )
                    ],
                  );
                }
                return Text(
                  "${data.data[index - 1].country} (${data.data[index - 1].region})",
                  style: const TextStyle(fontSize: 18),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
            );
        }
      }),
    );
  }
}
