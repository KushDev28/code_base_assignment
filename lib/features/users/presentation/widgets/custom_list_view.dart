import 'package:flutter/material.dart';

///Custom List View
class CustomListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics? physics;

  const CustomListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.padding = const EdgeInsets.all(16),
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      physics: physics,
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index], index);
      },
    );
  }
}
