import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_music_player/Body.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return MaterialApp(
      home: Scaffold(
          backgroundColor: theme.primaryColor,
          drawer: buildDrawer(theme),
          appBar: AppBar(
            iconTheme: theme.primaryIconTheme,
            backgroundColor: theme.primaryColor,
            title: Text("Title"),
            actions: [
              IconButton(
                color: theme.accentColor,
                icon: Icon(
                  Icons.email,
                ),
                onPressed: () {
                  setState(() {});
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.account_box,
                ),
                color: theme.accentColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return MaterialApp();
                      },
                    ),
                  );
                },
              ),
            ],
            elevation: 0,
          ),
          body: Body(
            theme: theme,
          )),
    );
  }

  Drawer buildDrawer(ThemeData theme) {
    return Drawer(
      child: Container(
        color: theme.primaryColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Text(
                      'Drawer Header',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: theme.textTheme.headline2.fontSize,
                        fontWeight: theme.textTheme.headline2.fontWeight,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: theme.accentColor,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Item 1',
                      style: theme.textTheme.bodyText1,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(
                      'Item 2',
                      style: theme.textTheme.bodyText1,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: theme.accentColor,
                        ),
                        title: Text(
                          'Settings',
                          style: theme.textTheme.bodyText1,
                        )),
                    ListTile(
                      leading: Icon(
                        Icons.help,
                        color: theme.accentColor,
                      ),
                      title: Text(
                        'Help and Feedback',
                        style: theme.textTheme.bodyText1,
                      ),
                      onTap: () {
                        setState(() {});
                      },
                    )
                  ],
                )))
          ],
        ),
      ),
    );
  }
}
