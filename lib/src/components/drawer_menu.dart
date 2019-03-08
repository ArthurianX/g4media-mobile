import 'package:flutter/material.dart';
import 'package:g4mediamobile/src/components/donate_widget.dart';
import 'package:g4mediamobile/src/screens/about.dart';
import 'package:g4mediamobile/src/screens/home.dart';
import 'package:g4mediamobile/src/screens/settings.dart';
import 'package:g4mediamobile/src/services/utils.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        child: new Container(
          color: const Color(0xFF15202A),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              AppBar(
                leading: IconButton(
                  icon: Icon(Icons.close),
                  tooltip: 'Close Drawer',
                  color: const Color(0xFFFFFFFF),
                  onPressed: () {
                    G4Utils.changeStatusBarLight(false);
                    Navigator.pop(context);
                    },
                ),
                elevation: 0,
                centerTitle: true,
                titleSpacing: 0.0,
                backgroundColor: const Color(0xFF15202A),
                title: new Image.asset('images/logo_white.png', height: 32/*fit: BoxFit.cover*/ ),
              ),
              ListTile(
                title: Text('ACASA', style: _menuStyle()),
                onTap: () {
                  G4Utils.changeStatusBarLight(false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('DESPRE NOI', style: _menuStyle()),
                onTap: () {
                  G4Utils.changeStatusBarLight(false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutScreen()),
                  );
                },
              ),
//              ListTile(
//                title: Text('SETARI', style: _menuStyle()),
//                onTap: () {
//                  G4Utils.changeStatusBarLight(false);
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => SettingsScreen()),
//                  );
//                },
//              ),
              ListTile(
                title: Text('CONTACT', style: _menuStyle()),
                onTap: () {
                  G4Utils.changeStatusBarLight(false);
                  G4Utils.launchBrowserURL('https://www.g4media.ro/contact');
                },
              ),
              ListTile(title: Text('')),
//              ListTile(
//                title: Text('FEEDBACK', style: _menuStyle()),
//                onTap: () {
//                  G4Utils.changeStatusBarLight(false);
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => SettingsScreen()),
//                  );
//                },
//              ),
              ListTile(title: Text('')),
              ListTile(title: Text('')),
              new Container(
                  alignment: FractionalOffset.bottomCenter,

                  child: DonateWidget()
              ),
            ],
          )
        ),
    ),
  );
  }
}

_menuStyle() {
  return new TextStyle(
    color: const Color(0xFFFFFFFF),
    fontFamily: 'SourceSansPro',
    fontWeight: FontWeight.normal,
    fontSize: 18,
  );
}
