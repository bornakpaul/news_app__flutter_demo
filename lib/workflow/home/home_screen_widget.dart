import 'package:flutter/material.dart';
import 'package:news_app_demo/view_model/view_state.dart';
import 'package:news_app_demo/workflow/home/home_screen_vm.dart';
import 'package:provider/provider.dart';

class NewsScreenWidget extends StatelessWidget {
  const NewsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Demo News App")),
      body: const _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget();

  @override
  State<_BodyWidget> createState() => __BodyWidgetState();
}

class __BodyWidgetState extends State<_BodyWidget> {
  final _viewModel = HomeScreenVM();
  final countryCode = "in";

  @override
  void initState() {
    _viewModel.getData(countryCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenVM>(
      create: (context) => _viewModel,
      child: Consumer<HomeScreenVM>(builder: (context, viewModel, _) {
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
            return Center(child: Text(data.articles[0].title));
        }
      }),
    );
  }
}
