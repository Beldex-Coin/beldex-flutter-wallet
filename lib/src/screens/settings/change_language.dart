import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/src/domain/common/language.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:provider/provider.dart';

class ChangeLanguage extends BasePage {
  @override
  String getTitle(AppLocalizations t) => t.settings_change_language;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final languages = <LanguageName>[
      LanguageName('', 'System default'),
      ...languageNames];
    final langNotifier = Provider.of<LanguageNotifier>(context);
    final _controller = ScrollController(keepScrollOffset: true);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: settingsStore.isDarkTheme
                    ? Color(0xff272733)
                    : Color(0xffEDEDED),
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            margin:
                EdgeInsets.only(left: 20.0, right: 20.0, top: 20, bottom: 20.0),
            padding: EdgeInsets.only(top: 18),
            child: Column(
              children: [
                Text(
                  tr(context).chooseLanguage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 3, //200,
                  child: Container(
                      margin: EdgeInsets.only(left: 20.0, right: 10.0),
                      //color: Color(0xff181820),
                      child: RawScrollbar(
                        controller: _controller,
                        thickness: 8,
                        thumbColor: settingsStore.isDarkTheme
                            ? Color(0xff3A3A45)
                            : Color(0xff494955),
                        radius: Radius.circular(10.0),
                        thumbVisibility: false,
                        child: Container(
                          margin: EdgeInsets.only(right: 8),
                          color: settingsStore.isDarkTheme
                              ? Color(0xff272733)
                              : Color(0xffEDEDED),
                          child: Container(
                            padding: EdgeInsets.only(right: 6),
                            child: ListView.builder(
                              controller: _controller,
                              itemCount: languages.length,
                              itemBuilder: (BuildContext context, int index) {
                                final lang = languages[index];
                                final isCurrent = lang.code == (settingsStore.languageOverride ?? '');

                                return InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () async {
                                    if (!isCurrent) {
                                      settingsStore.saveLanguageOverride(lang.code == '' ? null : lang.code);
                                      langNotifier.trigger();
                                      Navigator.of(context).pop();
                                      /*await settingsStore.saveLanguageCode(
                                          languageCode:
                                              languages.keys.elementAt(index));
                                      currentLanguage.setCurrentLanguage(
                                          languages.keys.elementAt(index));
                                      Navigator.of(context).pop();*/
                                    }
                                  },
                                  child: isCurrent
                                      ? Card(
                                          color: Colors.transparent,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color:
                                                          Color(0xff0BA70F))),
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Center(
                                                child: Text(
                                                  lang.name,
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                              lang.name,
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
