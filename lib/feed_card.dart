import 'dart:math';
import 'dart:ui';

import 'package:expandable_text/expandable_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/better_video.dart';
import 'package:learn/image_loader.dart';
import 'package:learn/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'model.dart';
import 'extension.dart';

class FeedCard extends ConsumerStatefulWidget {
  final Feeds post;
  final double? padUp;
  final RefreshController refreshController;
  const FeedCard({
    super.key,
    required this.post,
    this.padUp,
    required this.refreshController,
  });

  @override
  ConsumerState<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends ConsumerState<FeedCard> {
  ValueNotifier<int> slidePosition = ValueNotifier(0);
  ValueNotifier<bool> showSlidePosition = ValueNotifier(true);
  ValueNotifier<int> shareCount = ValueNotifier(0);

  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 4)).whenComplete(
        () {
          if (mounted) showSlidePosition.value = false;
        },
      );
      for (var i in widget.post.media) {
        if (i.type == "image") {
          precacheImage(ExtendedNetworkImageProvider(i.url), context);
        } else {
          precacheImage(ExtendedNetworkImageProvider(i.thumbnail!), context);
        }
      }
    });
    if (Random().nextBool()) {
      objectbox.storePost(widget.post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    if (widget.post.displayPhoto == null)
                      const CircleAvatar(
                        radius: 60 / 2,
                      )
                    else
                      ImageLoader(
                        image: widget.post.displayPhoto!,
                        height: 60,
                        width: 60,
                        boxShape: BoxShape.circle,
                        boxFit: BoxFit.cover,
                      ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(builder: (context) {
                          final name = widget.post.displayName;
                          return Text(name);
                        }),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                ExpandableText(
                  widget.post.text,
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 3,
                  animationDuration: const Duration(milliseconds: 500),
                  animation: true,
                  linkColor: Colors.purple,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: widget.post.media.map((e) => e.height).toList().getMax / 2,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CarouselSlider.builder(
                    onSlideChanged: (value) {
                      showSlidePosition.value = true;
                      slidePosition.value = value;
                      Future.delayed(const Duration(seconds: 4)).then(
                        (value) => showSlidePosition.value = false,
                      );
                    },
                    slideBuilder: (index) {
                      return LayoutBuilder(
                        builder: (context, constraint) {
                          var image = widget.post.media[index].url;
                          return widget.post.media[index].type == "image"
                              ? Container(
                                  height: constraint.maxHeight,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: ExtendedNetworkImageProvider(
                                        image,
                                        cache: true,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 10,
                                        sigmaY: 10,
                                        tileMode: TileMode.mirror,
                                      ),
                                      child: ImageLoader(
                                        image: image,
                                        width: constraint.maxWidth,
                                        height: constraint.maxHeight,
                                      ),
                                    ),
                                  ),
                                )
                              : BetterFeedVideo(
                                  feeds: widget.post.media[index],
                                  width: constraint.maxWidth,
                                  height: constraint.maxHeight,
                                );
                        },
                      );
                    },
                    slideTransform: const BackgroundToForegroundTransform(),
                    itemCount: widget.post.media.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    slidePosition.dispose();
    showSlidePosition.dispose();
    super.dispose();
  }
}
