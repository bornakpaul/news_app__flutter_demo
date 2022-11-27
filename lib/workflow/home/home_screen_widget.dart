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

  @override
  void initState() {
    _viewModel.getData();
    super.initState();
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
              itemCount: data.countries.length,
              itemBuilder: (context, index) {
                return Text(
                  "${data.countries[index].countryName} (${data.countries[index].abbreviation})",
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
