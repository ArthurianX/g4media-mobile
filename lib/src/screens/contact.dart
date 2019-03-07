import 'package:flutter/material.dart';
import 'package:g4mediamobile/flutter_html_view/flutter_html_text.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:g4mediamobile/src/models/models.dart';
import 'package:g4mediamobile/src/state/g4_store.dart';
import 'package:g4mediamobile/src/state/actions.dart';

import 'package:g4mediamobile/src/components/drawer_menu.dart';
import 'package:g4mediamobile/src/screens/search_github.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({Key key}) : super(key: key);
  
  final _aboutText = "<h2 class=\"p1\">Cine suntem</h2>\n<p class=\"p1\">Asociatia Group4 Media Freedom &amp; Democracy este o organizatie non-profit cu sediul in Bucuresti. Scopul Asociatiei este imbunatatirea si modernizarea sistemului democratic in Romania. Codul de înregistrare fiscală (CIF) este: 38512687</p>\n<h2 class=\"p1\">Expertiza</h2>\n<p class=\"p1\">Asociatia este fondata de jurnalisti cu o experienta de peste 20 de ani in mass media, specializati in politica externa si interna, economie si justitie precum si in presa de investigatie. Asociatia este deschisa catre toti cei care rezoneaza cu obiectivele si valorile organizatiei.</p>\n<h2 class=\"p1\">Staff</h2>\n<ul>\n<li class=\"p1\">Cristian Pantazi &#8211; redactor sef</li>\n<li class=\"p1\">Dan Tapalaga &#8211; editor proiect</li>\n<li>Cristian Citre &#8211; editor</li>\n</ul>\n<h2 class=\"p1\">Obiective</h2>\n<ul class=\"ul1\">\n<li class=\"li1\">Apararea si consolidarea unei <b>prese independente</b>, <b>libere</b> si care respecta standardele profesionale</li>\n<li class=\"li1\">Afirmarea si apararea libertatii presei in fata oricaror forme de intimidare, cenzura si presiune</li>\n<li class=\"li1\">Intarirea aplicarii principiului suprematiei si <b>domniei legii</b></li>\n<li class=\"li1\">Sustinerea unui sistem de justitie independent si profesionist</li>\n<li class=\"li1\">Imbunatatirea sistemului electoral</li>\n<li class=\"li1\">Apararea si promovarea principiilor <b>bunei guvernari,</b> a transparentei institutionale si decizionale si a accesului la informatiile de interes public</li>\n</ul>\n<h2 class=\"p1\">Ce facem</h2>\n<ul class=\"ul1\">\n<li class=\"li1\">Elaboram si implementam proiecte si programe</li>\n<li class=\"li1\">Publicam studii, cercetari, analize, anchete jurnalistice, comentarii si evaluari</li>\n<li class=\"li1\">Sprijinim si asistam jurnalistii sau organismele mass media a caror libertate de exprimare se afla in pericol</li>\n<li class=\"li1\">Organizam evenimente publice</li>\n</ul>\n<h2>Contact</h2>\n<ul>\n<li class=\"p1\">mobil: 0751.033.201, 0741.059.309</li>\n<li class=\"p1\">email: g4media.ro@gmail.com</li>\n</ul>\n<!-- AddThis Advanced Settings generic via filter on the_content --><!-- AddThis Share Buttons generic via filter on the_content -->";

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<G4Store, GithubSearchScreenViewModel>(
      converter: (store) {
        return GithubSearchScreenViewModel(
          state: store.state,
          onTextChanged: (term) => store.dispatch(SearchAction(term)),
        );
      },
      builder: (BuildContext context, GithubSearchScreenViewModel vm) {
        return new Scaffold(
          appBar: AppBar(
            // Here we take the value from the ContactScreen object that was created by
            // the App.build method, and use it to set our appbar title.
            // title: Text(widget.title),
            elevation: 1,
            centerTitle: true,
            titleSpacing: 0.0,
            backgroundColor: Colors.white,
            title: new Image.asset('images/logo.png', height: 32/*fit: BoxFit.cover*/ ),
          ),
//          body: new Stack(
//            fit: StackFit.loose,
//            children: <Widget>[SearchGithubScreen(vm), MumuGithubScreen(vm)],
//          ),
          body: new Container(
            child: new HtmlText(data: _aboutText),
          ),
          drawer: MyDrawer()
        );
      },
    );
  }
}
