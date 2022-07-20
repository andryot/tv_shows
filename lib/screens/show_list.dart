import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/show_list/show_list_bloc.dart';
import '../model/user.dart';
import '../services/backend_service.dart';
import '../style/colors.dart';
import '../style/images.dart';
import '../style/text_style.dart';
import '../widgets/tvs_elevated_button.dart';
import '../widgets/tvs_loading_indicator.dart';
import '../widgets/tvs_show_tile.dart';
import '../widgets/tvs_text_field.dart';

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
    final User user = BlocProvider.of<GlobalBloc>(context).state.user!;
    final ShowListBloc bloc = BlocProvider.of<ShowListBloc>(context);

    return Scaffold(
      body: CustomScrollView(
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
                splashRadius: 25,
                icon: user.imageUrl == null
                    ? Image.asset(TVSImages.imgPlaceholderSmall)
                    : Image.network(user.imageUrl!),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => _slidingUpPanel(context, user),
                  );
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
          // I used the cupertino version because it has builder method
          // for custom indicators
          CupertinoSliverRefreshControl(
            onRefresh: () async => bloc.refresh(),
            builder: (BuildContext context, RefreshIndicatorMode mode, double x,
                double y, double z) {
              return const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: TVSLoadingIndicator(radius: 8, dotRadius: 3.41),
              );
            },
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
    );
  }

  Widget _slidingUpPanel(BuildContext context, User user) {
    final double height = MediaQuery.of(context).size.height * 0.5;
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
    final GlobalBloc globalBloc = BlocProvider.of<GlobalBloc>(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            SizedBox(height: height * 0.12),
            ClipOval(
              child: Container(
                color: TVSColors.primaryColor,
                height: height * 0.25,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipOval(
                    child: user.imageUrl == null
                        ? Image.asset(TVSImages.imgPlaceholderSmall)
                        : Image.network(user.imageUrl!),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.07),
            TVSTextField(
              labelText: "Email",
              color: Colors.black,
              labelColor: TVSColors.primaryColor,
              controller: TextEditingController(text: user.email),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: TVSElevatedButton(
                text: "Logout",
                onPressed: () {
                  Navigator.pop(context);
                  globalBloc.logout(context);
                },
                color: TVSColors.primaryColor,
                textColor: Colors.white,
              ),
            ),
            SizedBox(
              height: paddingBottom + (Platform.isAndroid ? 20 : 0),
            )
          ],
        ),
      ),
    );
  }
}
