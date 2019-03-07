import 'package:url_launcher/url_launcher.dart';

class G4Utils {
  static List<String> months = ['Ianuarie', 'Februarie', 'Martie', 'Aprilie', 'Mai',
    'Iunie', 'Iulie', 'August', 'Septembrie', 'Octombrie', 'Noiembrie', 'Decembrie'];


  static launchBrowserURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  static mergePosts() {

  }
}

