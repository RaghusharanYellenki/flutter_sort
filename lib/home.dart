import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_finn/screens/login.dart';
import 'package:flutter_task_finn/screens/register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  navigateToLogin() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  navigateToRegister() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  @override
  void initState() {
    // TODO: implement initState
    this.checkAuthentification();
  }

  checkAuthentification() async {
    _auth.authStateChanges().listen(
          (user) {
        if (user == null) {
          Navigator.of(context).pushReplacementNamed("Startpage");
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Home Screen'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){
            _auth.signOut();
          }, icon: Icon( Icons.logout))
        ],
      ),      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 100),
                    ElevatedButton(
                      child: Text(
                        "LOGIN".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF80E1D1)),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(color: Colors.white, width: 3)),
                        ),
                      ),
                      onPressed: navigateToLogin,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      child: Text(
                        "REGISTER".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF80E1D1)),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(color: Colors.white, width: 3)),
                        ),
                      ),
                      onPressed: navigateToRegister,
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
                padding: EdgeInsets.only(top: 80, left: 20, right: 20),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ),
    );
  }
}
