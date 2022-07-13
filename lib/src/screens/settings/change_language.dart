import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/domain/common/language.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/custom_scrollbar.dart';
import 'package:beldex_wallet/src/widgets/beldex_dialog.dart';
import 'package:provider/provider.dart';

class ChangeLanguage extends BasePage {
  @override
  String get title => S.current.settings_change_language;


  @override
  Widget body(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final currentLanguage = Provider.of<Language>(context);

    final currentColor = Theme.of(context).selectedRowColor;
    final notCurrentColor =
        Theme.of(context).accentTextTheme.subtitle1.backgroundColor;
    var scrollController = ScrollController(keepScrollOffset: true);


    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          margin:
              EdgeInsets.only(left: 40.0, right: 40.0, top: 60, bottom: 60.0),
          padding: EdgeInsets.all(13),
          child: Text(
            S.of(context).seed_language_choose,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
          ),
        ),
       /* Center(
          child: Container(
            //margin: EdgeInsets.only(left: 40.0, right: 40.0),
            height: 180,
            child: CustomScrollbar(
              strokeWidth: 8,
              trackColor: Color.fromARGB(255, 109,109,109),
              thumbColor: Color.fromARGB(255, 124,234,131),
              controller: scrollController,
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                controller: scrollController,
                itemCount: languages.values.length,
                itemBuilder: (BuildContext context, int index) {
                  final isCurrent = settingsStore.languageCode == null
                      ? false
                      : languages.keys.elementAt(index) ==
                      settingsStore.languageCode;

                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () async {
                      if (!isCurrent) {
                        await settingsStore.saveLanguageCode(
                            languageCode: languages.keys.elementAt(index));
                        currentLanguage.setCurrentLanguage(
                            languages.keys.elementAt(index));
                      }
                    },
                    child: isCurrent
                        ? Card(
                      color: Color.fromARGB(255, 40, 42, 51),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              languages.values.elementAt(index),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    )
                        : Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: 25.0,
                          bottom: 25.0),
                      child: Center(
                        child: Text(
                          languages.values.elementAt(index),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                  *//*Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    color: isCurrent ? currentColor : notCurrentColor,
                    child: ListTile(
                      title: Text(
                        languages.values.elementAt(index),
                        style: TextStyle(
                            fontSize: 16.0,
                            color:
                                Theme.of(context).primaryTextTheme.headline6.color),
                      ),
                      onTap: () async {
                        if (!isCurrent) {
                          await showSimpleBeldexDialog(
                            context,
                            S.of(context).change_language,
                            S.of(context).change_language_to(
                                languages.values.elementAt(index)),
                            onPressed: (context) {
                              settingsStore.saveLanguageCode(
                                  languageCode: languages.keys.elementAt(index));
                              currentLanguage.setCurrentLanguage(
                                  languages.keys.elementAt(index));
                              Navigator.of(context).pop();
                            },
                          );
                        }
                      },
                    ),
                  );*//*
                },
              ),
            ),
          ),
        ),*/
        Container(
          margin: EdgeInsets.only(left: 40.0, right: 40.0),
          height: 180,
          child: RawScrollbar(
            thumbColor: Color(0xff2ea021),
            isAlwaysShown: true,
            controller: scrollController,
            thickness: 10.0,
            radius: Radius.circular(10),
            child: Container(
              padding: EdgeInsets.only(right: 6),
              child: ListView.builder(
                itemCount: languages.values.length,
                itemBuilder: (BuildContext context, int index) {
                  final isCurrent = settingsStore.languageCode == null
                      ? false
                      : languages.keys.elementAt(index) ==
                          settingsStore.languageCode;

                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () async {
                      if (!isCurrent) {
                        await settingsStore.saveLanguageCode(
                            languageCode: languages.keys.elementAt(index));
                        currentLanguage.setCurrentLanguage(
                            languages.keys.elementAt(index));
                        Navigator.of(context).pop();
                      }
                    },
                    child: isCurrent
                        ? Card(
                            color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    languages.values.elementAt(index),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 25.0,
                                bottom: 25.0),
                            child: Center(
                              child: Text(
                                languages.values.elementAt(index),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                  );
                  /*Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    color: isCurrent ? currentColor : notCurrentColor,
                    child: ListTile(
                      title: Text(
                        languages.values.elementAt(index),
                        style: TextStyle(
                            fontSize: 16.0,
                            color:
                                Theme.of(context).primaryTextTheme.headline6.color),
                      ),
                      onTap: () async {
                        if (!isCurrent) {
                          await showSimpleBeldexDialog(
                            context,
                            S.of(context).change_language,
                            S.of(context).change_language_to(
                                languages.values.elementAt(index)),
                            onPressed: (context) {
                              settingsStore.saveLanguageCode(
                                  languageCode: languages.keys.elementAt(index));
                              currentLanguage.setCurrentLanguage(
                                  languages.keys.elementAt(index));
                              Navigator.of(context).pop();
                            },
                          );
                        }
                      },
                    ),
                  );*/
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
