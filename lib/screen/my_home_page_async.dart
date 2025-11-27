import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:list_student_pplg/widget/container_custome.dart';
import 'package:http/http.dart' as http;

class MyHomePageAsync extends StatefulWidget {
  const MyHomePageAsync({super.key});

  @override
  State<MyHomePageAsync> createState() => _MyHomePageAsyncState();
}

class _MyHomePageAsyncState extends State<MyHomePageAsync> {
  List<dynamic> listStudent = [];
  String classSelected = 'X';
  String majorSelected = 'PPLG';
  String genderSelected = 'Male';
  TextEditingController fullName = TextEditingController();
  TextEditingController age = TextEditingController();
  final List<DropdownMenuEntry<String>> listClasses =
      <DropdownMenuEntry<String>>[
        const DropdownMenuEntry(value: "X", label: "X"),
        const DropdownMenuEntry(value: "XI", label: "XI"),
        const DropdownMenuEntry(value: "XII", label: "XII"),
      ];
  final List<DropdownMenuEntry<String>> listMajor = <DropdownMenuEntry<String>>[
    const DropdownMenuEntry(value: "PPLG", label: "PPLG"),
    const DropdownMenuEntry(value: "HR", label: "HR"),
    const DropdownMenuEntry(value: "MPLB", label: "MPLB"),
    const DropdownMenuEntry(value: "TM", label: "TM"),
    const DropdownMenuEntry(value: "TSM", label: "TSM"),
    const DropdownMenuEntry(value: "TKRO", label: "TKRO"),
    const DropdownMenuEntry(value: "DKV", label: "DKV"),
    const DropdownMenuEntry(value: "TJKT", label: "TJKT"),
  ];
  final List<DropdownMenuEntry<String>> genderList =
      <DropdownMenuEntry<String>>[
        const DropdownMenuEntry(value: "Male", label: "Male"),
        const DropdownMenuEntry(value: "Female", label: "Female"),
      ];

  String typeForm = "";

  void _showModalSheet() {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return SizedBox(
          width: double.infinity,
          height: 400.0,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  typeForm,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: fullName,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Full Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Age"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownMenu(
                  width: double.infinity,
                  dropdownMenuEntries: listClasses,
                  initialSelection: classSelected,
                  onSelected: (String? value) => setState(() {
                    classSelected = value as String;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownMenu(
                  initialSelection: majorSelected,
                  width: double.infinity,
                  dropdownMenuEntries: listMajor,
                  onSelected: (String? value) => setState(() {
                    classSelected = value as String;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownMenu(
                  width: double.infinity,
                  initialSelection: genderSelected,
                  dropdownMenuEntries: genderList,
                  onSelected: (String? value) => setState(() {
                    genderSelected = value as String;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (fullName.text == "" || age.text == "") {
                      Navigator.pop(context);
                      const snackdemo = SnackBar(
                        content: Text('Student name and age must be filled!'),
                        backgroundColor: Colors.red,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                      return;
                    }
                    setState(() {
                      listStudent.add({
                        "full_name": fullName.text,
                        "classes": classSelected,
                        "major": majorSelected,
                        "Age": age.text,
                        "gender": genderSelected,
                      });
                    });

                    fullName.clear();
                    age.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Add Student"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUpdateModalSheet(int index) {
    setState(() {
      typeForm = "Update Student";
      fullName.text = listStudent[index]['full_name'];
      age.text = listStudent[index]['Age'];
      classSelected = listStudent[index]['classes'];
      majorSelected = listStudent[index]['major'];
      genderSelected = listStudent[index]['gender'];
    });
    _showModalSheet();
  }

  @override
  void initState() {
    super.initState();
    getStudent();
  }

  Future<http.Response> getStudent() async {
    final response = await http.get(
      Uri.parse('https://entertain-learningapp.ngubartech.com/api/student'),
    );

    if (response.statusCode == 200) {
      Map responseData = jsonDecode(response.body);
      List listData = responseData['data'] as List;
      setState(() {
        listStudent = listData;
      });
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "List Siswa From BE",
          style: TextStyle(
            // color: Color(0XFFFFFFE4)
            color: Colors.red,
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        child: ListView(
          children: [
            if (listStudent.isEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.redAccent,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                    strokeWidth: 10,
                  ),
                ),
              ),
            ],

            for (int idx = 0; idx < listStudent.length; idx++)
              ContainerCustome(
                name: listStudent[idx]['fullName'] ?? '',
                classes: listStudent[idx]['classes'] ?? '',
                // age: listStudent[idx]['Age'] ?? '',
                major: listStudent[idx]['major'] ?? '',
                gender: listStudent[idx]['gender'] ?? '',
                onTap: () => _showUpdateModalSheet(idx),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            typeForm = "Add Student";
            fullName.text = "";
            age.text = "";
          });
          _showModalSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
