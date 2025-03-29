import 'package:flutter/material.dart';


class InheritedDirectory extends InheritedWidget {
  const InheritedDirectory({
    super.key,
    required this.chapterCount,
    required super.child
  });
  final int chapterCount;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWIdget) => true;
  static InheritedDirectory of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedDirectory>()!;
  }
}