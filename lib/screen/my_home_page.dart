import 'package:flutter/material.dart';
import 'package:list_student_pplg/widget/container_custome.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showModalSheet() {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          width: double.infinity,
          height: 400.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Add Student",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "List Siswa",
          style: TextStyle(
            // color: Color(0XFFFFFFE4)
            color: Colors.red,
            fontSize: 40,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Column(
          children: [
            ContainerCustome(title1: "CONTENT 1", title2: "CONTENT 2"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showModalSheet,
        child: Text("+"),
      ),
    );
  }
}
