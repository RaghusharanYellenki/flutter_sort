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
  List<UserListModel> userList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReadJsonData();
  }

  updatelist(list , string){
    return ListWidget(
      items: list,
    );
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
        body: userList.isEmpty ? Center(
          child: CircularProgressIndicator(),
        )
            : updatelist(userList , selectedSort),
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
                userList.clear();
                ReadJsonData();
;              });
            },
          ),
        ],
      ),
    );
  }

  ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/userlist.json');
    final list = json.decode(jsondata) as List<dynamic>;
    userList = list.map((e) => UserListModel.fromJson(e)).toList();
    setState(() {
      if(selectedSort == "Name"){
        userList.sort((a,b) => a.name!.compareTo(b.name!));
      }else if(selectedSort == "Age"){
        userList.sort((a,b) => a.age!.compareTo(b.age!));
      }else{
        userList.sort((a,b) => a.city!.compareTo(b.city!));
      }
    });
  }
}
