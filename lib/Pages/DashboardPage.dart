
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/CustomWidgetStyles/CustomStyles.dart';
import 'package:untitled/Models/Classes.dart';
import 'package:untitled/Pages/AccountPage.dart';
import 'package:untitled/Pages/ClassPage.dart';
import 'package:untitled/Pages/ClassesEnrollnCreatePage.dart';
import '../Models/User.dart';
import '../firebase/FireBase_Crud_Classes_Operations.dart';
import '../firebase/Firebase_Crud_user_Operations.dart';
import 'SigningPage.dart';

class DashboardPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>DashboardPageState();

}

class DashboardPageState extends State<DashboardPage> {
    user? u =null;
    Widget? floatingWidget = null;

@override
void initState(){
    super.initState();
    var currentUser = FirebaseAuth.instance.currentUser;
    print("User after sign out: $currentUser");
  floatingWidget = EnrollCreateClass();

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('My Classes', style: HeadlinetextStyle(),),

        ),

      drawer: Drawer(

        child: u==null?Container():Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(u!.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              accountEmail: Text(u!.email, style: TextStyle(fontSize: 16)),

            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text("View Profile"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage(role: u!.role)));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout"),
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),

        onDrawerChanged: (isOpen){
          setState(() {});
        },

        body: FutureBuilder(
          future: getClasses(),
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.hasError) {
              print('this is the Clasees : ${snapshot.data?.docs}');
              var classList = snapshot.data?.docs;

              return Container(
                width: double.infinity,
                height: double.infinity,

                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(itemBuilder: (context, index) {
                    return Card(
                        elevation: 3,

                        margin: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          onTap:() {
                            var Class = classList?[index].data()!=null ?classes.fromMap(classList![index].data()):null;
                            ( u==null || Class==null)?Fluttertoast.showToast(msg: 'Something went wrong'):
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ClassPage(u!,Class.id,Class.name)));
                          } ,

                          title: Text('${classList?[index]['name']}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("ID: ${classList?[index]['id']}"),
                          trailing: Text(
                            "Members: ${classList?[index]['students'].length}",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      );
                  }, itemCount: classList?.length,
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }
            else {
              Fluttertoast.showToast(msg: 'Something went wrong');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text('let get Start', style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                      ),

                    ]

                ),
              );
            }
          },

        ),
        floatingActionButton: floatingWidget
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              FirebaseAuth.instance.authStateChanges().listen((User? user) {
                if (user == null) {
                  print("User is signed out.");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SigningPage()),
                        (route) => false,  // Removes all previous routes
                  );
                }
              });
            }
            ,
            child: Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void ScreenNavigation(String role ) async{
   await Navigator.push(context, MaterialPageRoute(
        builder: (context) => classEnrollnCreatePage(u!)));

    setState(() {
    });
  }


  Widget EnrollCreateClass() {
    return FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        if ((snapshot.hasError || snapshot.data == null) &&
            snapshot.connectionState != ConnectionState.waiting) {
          Fluttertoast.showToast(msg: 'Unable to get User info');
          return Container();
        }

        else {
            u = snapshot.data;
          print('here is Id : ${snapshot.data?.toString()}');

            return FloatingActionButton(onPressed: () {
              ScreenNavigation(u!.role);
              print('the role is :${u?.role}');
            }, child: Icon(Icons.add),);


        }
      },
    );
  }
}
