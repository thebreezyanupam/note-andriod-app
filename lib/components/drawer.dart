import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  //log out user


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerTheme: const DividerThemeData(color: Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Container(
                    width: 150,
                    child: const Icon(Icons.note, size: 50,),
                  ),
                ),

                const SizedBox(height: 20,),
                // Home
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: const Icon(Icons.notes_rounded),
                    title: Text('NOTE', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                    onTap: () {
                      // This is already the home screen so just pop the drawer
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 20,),

                // Profile
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('SETTINGS'),
                    onTap: () {
                      // This is already the home screen so just pop the drawer
                      Navigator.pop(context);

                      //navigate to profile page
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
