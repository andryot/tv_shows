import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/show_list/show_list_bloc.dart';
import '../model/user.dart';
import '../services/backend_service.dart';
import '../style/text_style.dart';
import '../widgets/tvs_show_tile.dart';

class ShowListScreen extends StatelessWidget {
  const ShowListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = BlocProvider.of<GlobalBloc>(context).state.user!;
    return BlocProvider(
      create: (context) => ShowListBloc(
        backendService: BackendService.instance,
        user: user,
      ),
      child: const _ShowListScreen(),
    );
  }
}

class _ShowListScreen extends StatelessWidget {
  const _ShowListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShowListBloc bloc = BlocProvider.of<ShowListBloc>(context);
    return Scaffold(
      body: RefreshIndicator(
        displacement: 60,
        edgeOffset: 100,
        onRefresh: () async {
          bloc.refresh();
        },
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
            BlocBuilder<ShowListBloc, ShowListState>(
              builder: (context, state) {
                if (state.shows == null) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return TVSShowTile(
                        show: state.shows![index],
                      );
                    },
                    childCount: state.shows!.length, // 1000 list items
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
