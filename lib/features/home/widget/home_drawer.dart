import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: Text(
              'MovieBox Menu',
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle profile navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.white),
            title: Text('Favorites', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle favorites navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark, color: Colors.white),
            title: Text('Watchlist', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle watchlist navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle settings navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.white),
            title: Text('About', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle about navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_sharp, color: Colors.white),
            title: Text('Exit', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle exit navigation
              Navigator.pop(context);
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
