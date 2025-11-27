import 'package:flutter/material.dart';

@immutable
class ContainerCustome extends StatelessWidget {
  ContainerCustome({
    super.key,
    required this.name,
    required this.classes,
    required this.major,
    required this.gender,
    // required this.age,
    required this.onTap,
  });

  String name;
  String classes;
  String major;
  String gender;
  // String age;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: $name"),
                  Text("Class: $classes"),
                  Text("Gender: $gender"),
                  Text("Major: $major"),
                  // Text("Age: $age"),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () => onTap(),
                    icon: Icon(
                      Icons.edit,
                      color: const Color.fromARGB(255, 244, 147, 2),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: const Color.fromARGB(255, 255, 0, 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
