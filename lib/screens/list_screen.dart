import 'package:flutter/material.dart';
import 'package:flutter_task_finn/bottomsheetwidget.dart';
import 'package:flutter_task_finn/screens/list_widget.dart';
import 'package:flutter_task_finn/userlist_model.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:convert';

class ListHomeScreen extends StatefulWidget {
  const ListHomeScreen({Key? key}) : super(key: key);

  @override
  State<ListHomeScreen> createState() => _ListHomeScreenState();
}

class _ListHomeScreenState extends State<ListHomeScreen> {

  List sortList = ["Name", "Age", "City"];
  String selectedSort = "Name";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text('UserList screen'),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.blueGrey,
        body: FutureBuilder(
      future: ReadJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {

          var namedList = data.data as List<UserListModel>;
          namedList.sort((x, y) => x.name!.compareTo(y.name!));

          var ageList = data.data as List<UserListModel>;
          ageList.sort((a, b) => a.age!.compareTo(b.age!));

          var cityList = data.data as List<UserListModel>;
          cityList.sort((c, d) => c.city!.compareTo(d.city!));

          return ListWidget(
            items: selectedSort == "Name" ? namedList : selectedSort == "Age" ? ageList : cityList ,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
      bottomNavigationBar: Row(
        children: [
          BottomSheetButtonWidget(
            selectedName: selectedSort,
            buttonText: "Sort By:",
            modelList: sortList,
            onSelectedText: (String updatedSort) {
              setState(() {
                selectedSort = updatedSort;
                print(selectedSort);
;              });
            },
          ),
        ],
      ),
    );
  }

  Future<List<UserListModel>> ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/userlist.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => UserListModel.fromJson(e)).toList();
  }
}
