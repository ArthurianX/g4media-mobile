import 'package:flutter/material.dart';
import 'package:g4mediamobile/src/services/utils.dart';

class DonateWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new AnimatedOpacity(
        duration: new Duration(milliseconds: 300),
        opacity: 1.0,
        child: new InkWell(
          onTap: () => G4Utils.launchBrowserURL('https://www.g4media.ro/doneaza'),
          child: new Container(
            alignment: FractionalOffset.center,
            margin: new EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
            padding: new EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 16.0),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: const Color(0xFFFFC43A),
            ),
            child: new Column(
              children: <Widget>[
                new Text(
                  'Doneaza pentru presa pe care o sustii',
                  style: new TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF15202A),
                  ),
                ),
                new Text(
                  'G4Media este un non-profit si depinde de tine.',
                  style: new TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 16,
                    color: const Color(0xFF15202A),
                  ),
                ),
              ],
            )
          ),
        ),
    );
  }
}
