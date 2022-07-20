import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/show.dart';
import '../style/text_style.dart';
import 'tvs_loading_indicator.dart';

class TVSShowTile extends StatelessWidget {
  final Show show;
  const TVSShowTile({
    Key? key,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 5,
        child: Stack(
          children: [
            CachedNetworkImage(
              // I had to do this because I constantly got
              // "Connection closed before full header was received"
              // exception
              imageUrl: show.imageUrl.replaceAll('https', 'http'),
              placeholder: (context, url) => const TVSLoadingIndicator(
                radius: 16,
                dotRadius: 6.82,
              ),
              height: 200,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 220),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              show.title,
                              style: TVSTextStyle.showTileTitleTextStyle,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              show.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
