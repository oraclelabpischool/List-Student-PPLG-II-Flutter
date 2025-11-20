import 'package:flutter/material.dart';

@immutable
class ContainerCustome extends StatelessWidget {
  ContainerCustome({super.key, required this.title1, required this.title2});

  String title1;
  String title2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title1), Text(title2)],
          ),
        ),
      ),
    );
  }
}
