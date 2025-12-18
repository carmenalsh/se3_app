import 'package:complaints_app/features/app_services/presentation/composite/service_node.dart';
import 'package:complaints_app/features/app_services/presentation/widget/services_types.dart';
import 'package:flutter/material.dart';

class ServiceLeaf implements ServiceNode {
  final String title;
  final String image;
  final Color titleColor;
  final VoidCallback onTap;

  ServiceLeaf({
    required this.title,
    required this.image,
    required this.titleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ComplaintInformationWidget(
        titleColor: titleColor,
        image: image,
        title: title,
      ),
    );
  }
}
