import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/show.dart';
import '../style/text_style.dart';

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
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                // i had to do this because I constantly got
                // "Connection closed before full header was received"
                // exception
                imageUrl: show.imageUrl.replaceAll('https', 'http'),
                height: 200,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 20),
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
    );
  }
}
