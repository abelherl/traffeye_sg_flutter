import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';

class AppScrollView extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const AppScrollView({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollShadow(
      size: 20,
      color: Colors.black26,
      child: SingleChildScrollView(
        padding: padding,
        physics: const BouncingScrollPhysics(),
        child: child,
      ),
    );
  }
}
