import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/global_variable.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout(
      {super.key, required this.mobileLayout, required this.webLayout});
  final Widget mobileLayout;
  final Widget webLayout;
  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return widget.webLayout;
        }
        return widget.mobileLayout;
      },
    );
  }
}
