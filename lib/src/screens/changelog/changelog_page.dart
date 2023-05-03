import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:provider/provider.dart';
import 'package:yaml/yaml.dart';

class ChangelogPage extends BasePage {
  final String changelogPath = 'assets/changelog.yml';

  @override
  String get title => S.current.changelog;

@override
Widget trailing(BuildContext context){
  return Icon(Icons.settings,color:Colors.transparent);
}



  @override
  Widget body(BuildContext context) {
       final settingsStore = Provider.of<SettingsStore>(context);
    return FutureBuilder(
      builder: (context, snapshot) {
        final changelogs = loadYaml(snapshot.data.toString()) as YamlList;

        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final versionTitle = changelogs[index]['version'].toString();
            final versionChanges = changelogs[index]['changes'] as YamlList;
            final versionChangesText = versionChanges
                .map((dynamic element) => '- $element')
                .join('\n');

            return Theme(
             data: Theme.of(context).copyWith(accentColor:settingsStore.isDarkTheme ? Colors.white : Colors.black,
                  dividerColor: Colors.transparent,
                  textSelectionTheme: TextSelectionThemeData(
                    selectionColor: Colors.green
                  )),
              child: Container(
                    margin: EdgeInsets.only(left:15,right:15.0,bottom:8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: settingsStore.isDarkTheme ? Color(0xff434359) : Color(0xffDADADA)),
                      borderRadius: BorderRadius.circular(10)
                    ),
                child: ExpansionTile(
                  title: Text(versionTitle,style: TextStyle(fontFamily: 'Poppins',fontSize: 16,fontWeight: FontWeight.w800)),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Text('$versionChangesText\n')))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          //separatorBuilder: (_, __) =>
           //   Divider(color: Theme.of(context).dividerTheme.color, height: 1.0),
          itemCount: changelogs == null ? 0 : changelogs.length,
        );
      },
      future: rootBundle.loadString(changelogPath),
    );
  }
}
