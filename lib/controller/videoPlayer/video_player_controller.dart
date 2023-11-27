import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayController with ChangeNotifier {
  late VideoPlayerController controller;
  late Duration totalDuration;
  late Duration currentPosition;
  bool isPlaying = false;
  bool isLoading = true;

  bool isPortrait = true;
  void toggleOrientation() {
    isPortrait = !isPortrait;
    if (isPortrait) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    notifyListeners();
  }

  void initializeVideo(String videoUrl) {
    isLoading = true;
    notifyListeners();
    controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        controller.play();

        isPlaying = true;
        notifyListeners();
        totalDuration = controller.value.duration;
      });
    notifyListeners();
    controller.addListener(() {
      currentPosition = controller.value.position;
      notifyListeners();
    });

    if (controller.value.position >= controller.value.duration) {
      // Video has finished playing
      controller.pause();
      isPlaying = false;
      notifyListeners();
      log('video finishedddddddddddddddddddddd');
    }
    controller.addListener(() {
      if (controller.value.position == controller.value.duration) {
        isPlaying = false;
        notifyListeners();
        // Video has finished playing, show the pause button
      }
    });

    isLoading = false;
    notifyListeners();
  }

  void videoPuseAndPlay() {
    if (controller.value.isPlaying) {
      controller.pause();
      isPlaying = false;
    } else {
      controller.play();
      isPlaying = true;
    }
    notifyListeners();
  }
}
