import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:while_app/theme/pallete.dart';

class ReelsScreen extends ConsumerStatefulWidget {
  const ReelsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends ConsumerState<ReelsScreen> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Container(
        decoration: BoxDecoration(
            color: currentTheme.primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: const Center(child: Text("Reels Screen")),
      ),
    );
  }
}
