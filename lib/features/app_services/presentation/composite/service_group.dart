import 'package:flutter/material.dart';
import '../widget/divider_widget.dart'; 
import 'service_node.dart';

class ServiceGroup implements ServiceNode {
  final List<ServiceNode> children;
  final Axis scrollDirection;
  final EdgeInsets padding;
  final double space;
  final bool withDividers;
  final bool addLeadingSpace;

  ServiceGroup({
    required this.children,
    this.scrollDirection = Axis.horizontal,
    this.padding = const EdgeInsets.symmetric(vertical: 18),
    this.space = 25,
    this.withDividers = true,
    this.addLeadingSpace = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SingleChildScrollView(
        scrollDirection: scrollDirection,
        child: Row(
          children: [
            if (addLeadingSpace) const SizedBox(width: 30),
            for (int i = 0; i < children.length; i++) ...[
              children[i].build(context),
              if (i != children.length - 1) ...[
                SizedBox(width: space),
                if (withDividers) const DividerWidget(),
                SizedBox(width: space),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
