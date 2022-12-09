// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:minorproject/screens/about.dart';
// import 'package:minorproject/screens/account.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   Razorpay _razorpay;
//   bool suc = false;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User user;
//   bool isloggedin = false;
//
//   @required
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     this.checkAuthentification();
//     this.getUser();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse payS) {
//     Fluttertoast.showToast(
//         msg:
//         "Your payment has done successfully: " + payS.paymentId.toString());
//     suc = true;
//   }
//
//   void _handlePaymentError(PaymentFailureResponse res) {
//     Fluttertoast.showToast(
//         msg: "You payment has failed and the reason is : " +
//             res.code.toString() +
//             "-" +
//             res.message.toString());
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse resp) {
//     Fluttertoast.showToast(
//         msg: "redirecting to external wallet" + resp.walletName.toString());
//   }
//
//   checkAuthentification() async {
//     _auth.authStateChanges().listen(
//           (user) {
//         if (user == null) {
//           Navigator.of(context).pushReplacementNamed("Startpage");
//         }
//         return null;
//       },
//     );
//   }
//
//   getUser() async {
//     User firebaseUser = _auth.currentUser;
//     await firebaseUser?.reload();
//     firebaseUser = _auth.currentUser;
//
//     if (firebaseUser != null) {
//       setState(() {
//         this.user = firebaseUser;
//         this.isloggedin = true;
//       });
//     }
//     return null;
//   }
//
//   signOut() async {
//     _auth.signOut();
//
//     final googleSignIn = GoogleSignIn();
//     await googleSignIn.signOut();
//   }
//
//   callRazorpay() async {
//     var options = {
//       'key': 'rzp_test_3Z1jhQyaJKtqlW',
//       'amount': 18000,
//       'name': 'Raghusharan',
//       'description': ' for order Payment',
//       'prefill': {'contact': '6305438811', 'email': 'test@razorpay.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (msg) {
//       print(msg);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return !isloggedin
//         ? CircularProgressIndicator()
//         : Scaffold(
//       drawer: Drawer(
//         child: Column(
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(color: Colors.amber),
//               child: Stack(
//                 children: <Widget>[
//                   Positioned(
//                     right: 70,
//                     top: 20,
//                     child: Row(
//                       children: <Widget>[
//                         Icon(Icons.person, size: 50.0),
//                         Text(
//                           '${user.displayName}',
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             Icons.arrow_forward_ios,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             setState(
//                                   () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           Accountpage()),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.format_list_bulleted),
//               title: Text('Order History'),
//               onTap: () {
//                 print('Order History Page');
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.payment),
//               title: Text('Payment Gateway'),
//               onTap: () {
//                 callRazorpay();
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.developer_board),
//               title: Text('Developer'),
//               onTap: () {
//                 setState(
//                       () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => About()),
//                     );
//                   },
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.live_help_outlined),
//               title: Text('Help and Support'),
//               onTap: () {
//                 print('Help and Support');
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.system_update_alt_sharp),
//               title: Text('Updates'),
//               onTap: () => {
//                 print('Updates'),
//               },
//             ),
//             Divider(
//               height: 3,
//             ),
//             ListTile(
//               leading: Icon(Icons.exit_to_app),
//               title: Text('Logout'),
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       content: Text(
//                         'Are you sure you want to logout',
//                         textAlign: TextAlign.center,
//                       ),
//                       actions: <Widget>[
//                         ElevatedButton(
//                           onPressed: signOut,
//                           child: Text('yes'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text('Cancel'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       appBar: new AppBar(
//         title: Text('Home Screen'),
//         backgroundColor: Colors.blue,
//       ),
//       body: !isloggedin
//           ? CircularProgressIndicator()
//           : SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 100),
//               Center(
//                 child: Text(
//                   'Welcome ${user.displayName}\n your registered email is \n\n ${user.email}',
//                   style: TextStyle(
//                       fontWeight: FontWeight.normal, fontSize: 30),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     callRazorpay();
//                   },
//                   child: Text("Checkout to Razorpay")),
//               Text(suc ? "Payment is success" : "  "),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }