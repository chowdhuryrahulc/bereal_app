import 'dart:io';

import 'package:bereal_app/core/providers/scroll_behavior.dart';
import 'package:bereal_app/core/ui/user_appbar_widget.dart';
import 'package:bereal_app/home/real_social_widget.dart';
import 'package:bereal_app/home/small_real_widget.dart';
import 'package:bereal_app/real_camera/real_camera_controller.dart';
import 'package:bereal_app/styles/theme_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final PageController _controller;
  late final ScrollController _scrollController;
  bool menuVisibility = true;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        setState(() {
          menuVisibility = false;
        });
      } else {
        setState(() {
          menuVisibility = true;
        });
      }
    });
  }

  Widget empty() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your friends haven’t posted their BeReal yet, be the first one.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => context.push('/camera'),
                style: ref.watch(stylesProvider).button.primary,
                child: const Text("Take your BeReal"))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final scrollEnabled = ref.watch(scrollBehaviorProvider);

    return Scaffold(
        body: Stack(
      alignment: Alignment.topCenter,
      children: [
        PageView(
          controller: _controller,
          physics: scrollEnabled ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            HapticFeedback.lightImpact();
          },
          children: [
            ref.watch(realCameraControllerProvider).maybeWhen(
                  orElse: () => empty(),
                  finalized: (selfie, photo) => posted(photo, selfie),
                ),
            feed(),
          ],
        ),
        UserAppBar(
          controller: _controller,
          isVisible: menuVisibility,
        )
      ],
    ));
  }
}
