import 'package:better_player/better_player.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:learn/image_loader.dart';
import 'package:learn/model.dart';

class BetterFeedVideo extends StatefulWidget {
  final Media feeds;
  final double width;
  final double height;
  const BetterFeedVideo({
    super.key,
    required this.feeds,
    required this.height,
    required this.width,
  });

  @override
  State<BetterFeedVideo> createState() => _BetterFeedVideoState();
}

class _BetterFeedVideoState extends State<BetterFeedVideo> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        aspectRatio: widget.width / widget.height,
        looping: true,
        allowedScreenSleep: false,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          enableFullscreen: false,
          enableSkips: false,
          enableOverflowMenu: false,
        ),
        fit: BoxFit.contain,
        playerVisibilityChangedBehavior: (visibilityFraction) {
          var visibility = visibilityFraction * 100;
          handlingVisibility(visibility: visibility);
        },
      ),
      betterPlayerDataSource: BetterPlayerDataSource.network(
        widget.feeds.url,
        videoFormat: BetterPlayerVideoFormat.hls,
        cacheConfiguration: BetterPlayerCacheConfiguration(
          useCache: true,
          key: widget.feeds.url,
        ),
        placeholder: Stack(
          children: [
            ImageLoader(
              image: widget.feeds.thumbnail!,
              height: widget.height,
              width: widget.width,
              boxFit: BoxFit.cover,
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ],
        ),
      ),
    );
    _betterPlayerController.setVolume(1);
  }

  void handlingVisibility({required double visibility}) {
    if (visibility < 80) {
      if (_betterPlayerController.isVideoInitialized() == true) {
        _betterPlayerController.pause();
      }
    } else {
      _betterPlayerController.play();
    }
  }

  @override
  void dispose() {
    _betterPlayerController.dispose(forceDispose: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: _betterPlayerController,
    );
  }
}
