import 'package:flutter/material.dart';

class SubjectsScreen extends StatefulWidget {
  List<dynamic> subjects;

  SubjectsScreen(this.subjects);

  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  List<Subject> subjectsModel = [];
  List<Subject> selectedSubjectsModel = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < this.widget.subjects.length; i++) {
      subjectsModel.add(Subject(this.widget.subjects[i], false));
    }

    return Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text("Subjects"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: List.generate(this.subjectsModel.length, (index) {
                  return subjecttile(this.subjectsModel[index].name,
                      this.subjectsModel[index].isSelected, index);
                }),
              ),
            ),
            Container(
              height: 40,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pop(this.selectedSubjectsModel);
                  },
                  child: Text(
                    "Select ${this.selectedSubjectsModel.length} Subjects",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ));
  }

  Widget subjecttile(String name, bool isSelect, int index) {
    final slectedcolor = Theme.of(context).primaryColor;

    return ListTile(
      selected: isSelect,
      title: Text(
        name,
        style: isSelect
            ? TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: slectedcolor)
            : TextStyle(),
      ),
      onTap: () {
        setState(() {
          this.subjectsModel[index].isSelected =
              !this.subjectsModel[index].isSelected;
          if (this.subjectsModel[index].isSelected == true) {
            this.selectedSubjectsModel.add(Subject(name, true));
          } else if (this.subjectsModel[index].isSelected == false) {
            this.selectedSubjectsModel.removeWhere(
                (element) => element.name == this.subjectsModel[index].name);
          }
        });
      },
      trailing: isSelect
          ? Icon(
              Icons.check,
              color: slectedcolor,
              size: 26,
            )
          : null,
    );
  }
}

class Subject {
  String name;
  bool isSelected;

  Subject(this.name, this.isSelected);
}
