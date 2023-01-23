import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/NearEvents/all_near_events.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:flutter_application_1/route/routing_page.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            accountName: Text("Lindel Yosh"),
            accountEmail: Text("lindel795@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/logo.png"),
            ),
          ),


          ListTile(
            leading: IconButton(
              onPressed: () {
                RoutingPage.goTonext(
                context: context,
                navigateTo: HomePage(),
              );
              },
              icon: Icon(
                Icons.home,
              ),
            ),
            title: Text("Home"),
          ),


          ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person,
              ),
            ),
            title: Text("Profile"),
          ),


          ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
              ),
            ),
            title: Text("Saved Event"),
          ),


          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                context: context,
                navigateTo: AllNearEvents(),
              );
            },
            leading: Icon(
              Icons.event_available_rounded,
            ),
            title: Text("Nearby Events"),
          ),


          ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.history,
              ),
            ),
            title: Text("My History"),
          ),

          
          ListTile(
            leading: IconButton(
              onPressed: (){
                FirebaseAuth.instance.signOut().then(
                  (value) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  ),
                );
              }, 
              icon: Icon(
                Icons.exit_to_app,
              ),
            ),
            title: Text("Log Out"),
          ),
        ],
      ),
    );
  }
}