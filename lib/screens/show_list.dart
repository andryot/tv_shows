import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/show_list/show_list_bloc.dart';
import '../style/text_style.dart';

class ShowListScreen extends StatelessWidget {
  const ShowListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowListBloc(),
      child: const _ShowListScreen(),
    );
  }
}

class _ShowListScreen extends StatelessWidget {
  const _ShowListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        edgeOffset: 100,
        onRefresh: () async {},
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              titleTextStyle: TVSTextStyle.appBarTitleTextStyle,
              titleSpacing: 20,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: const Text("Shows"),
              pinned: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.all(15),
                    child: Container(
                      color: Colors.blue[100 * (index % 9 + 1)],
                      height: 80,
                      alignment: Alignment.center,
                      child: Text(
                        "Item $index",
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  );
                },
                childCount: 1000, // 1000 list items
              ),
            ),
          ],
        ),
      ),
    );
  }
}
