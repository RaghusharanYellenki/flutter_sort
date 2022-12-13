import 'dart:convert';
import 'package:flutter_task_finn/model/userlist_model.dart';
import 'package:http/http.dart' as http;

class GetDataService {
  Future<List<UserListModel>> getUserList() async {

    var response = await http.get(Uri.parse("https://fluttertaskfinn-default-rtdb.firebaseio.com/data.json"));
    var userslist = jsonDecode(response.body);

    List<UserListModel> getApiList = userslist.map<UserListModel>((json) =>
        UserListModel.fromJson(json)).toList();

    return getApiList;
  }
}