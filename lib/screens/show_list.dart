import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/show_list/show_list_bloc.dart';
import '../bloc/theme/theme_cubit.dart';
import '../model/user.dart';
import '../services/backend_service.dart';
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
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            titleTextStyle: TVSTextStyle.appBarTitleTextStyle(
              Theme.of(context).brightness,
            ),
            titleSpacing: 20,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text("Shows"),
            pinned: true,
            actions: [
              IconButton(
                splashRadius: 25,
                icon: user.imageUrl == null
                    ? Image.asset(TVSImages.imgPlaceholderSmall)
                    : Image.network(
                        user.imageUrl!,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          TVSImages.imgPlaceholderSmall,
                        ),
                      ),
                onPressed: () {
                  showModalBottomSheet<void>(
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
              // display error
              if (state.failure != null) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.error_rounded,
                          size: 50,
                          color: Colors.red,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Failed to fetch shows.\nPlease check your internet connection.",
                          textAlign: TextAlign.center,
                          style: TVSTextStyle.errorTextStyle,
                        ),
                      ],
                    ),
                  ),
                );
              }
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: height * 0.12),
                const Spacer(),
                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () =>
                          BlocProvider.of<ThemeCubit>(context).switchTheme(),
                      icon: state == ThemeMode.dark
                          ? const Icon(
                              Icons.wb_sunny,
                              color: Colors.yellow,
                            )
                          : const Icon(
                              Icons.mode_night_rounded,
                              color: Colors.black,
                            ),
                    );
                  },
                )
              ],
            ),
            ClipOval(
              child: Container(
                color: Theme.of(context).primaryColor,
                height: height * 0.25,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipOval(
                    child: user.imageUrl == null
                        ? Image.asset(TVSImages.imgPlaceholderSmall)
                        : Image.network(
                            user.imageUrl!,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              TVSImages.imgPlaceholderBig,
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.07),
            TVSTextField(
              labelText: "Email",
              labelColor: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ),
            SizedBox(
              height: paddingBottom + (Platform.isAndroid ? 20 : 0),
            ),
          ],
        ),
      ),
    );
  }
}
