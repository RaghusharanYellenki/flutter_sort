import 'package:flutter/material.dart';
import 'package:flutter_task_finn/service/get_data.dart';
import 'package:flutter_task_finn/widgets/bottomsheetwidget.dart';
import 'package:flutter_task_finn/screens/list_widget.dart';
import 'package:flutter_task_finn/model/userlist_model.dart';


class ListHomeScreen extends StatefulWidget {
  const ListHomeScreen({Key? key}) : super(key: key);

  @override
  State<ListHomeScreen> createState() => _ListHomeScreenState();
}

class _ListHomeScreenState extends State<ListHomeScreen> {

  List sortList = ["Name", "Age", "City"];
  String selectedSort = "";
  List<UserListModel> dataList = [];
  List<UserListModel> userList = [];

  getDataList() async {
    dataList = await GetDataService().getUserList();
    setState(() {

    });
    userList = dataList;
    sortData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedSort = "Name";
    getDataList();
  }

  sortData(){
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

  updatelist(list , string){
    return ListWidget(
      items: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('UserList screen'),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.blueGrey,
        body: userList.isEmpty ? const Center(
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
                sortData();
              });
            },
          ),
        ],
      ),
    );
  }
}
