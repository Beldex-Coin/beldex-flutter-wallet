import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/stores/seed_language/seed_language_store.dart';
import 'package:beldex_wallet/l10n.dart';

class SeedLanguage extends BasePage {
  @override
  String getTitle (AppLocalizations t)=> t.selectLanguage;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget? leading(BuildContext context) {
    return leadingIcon(context);
  }

  @override
  Widget body(BuildContext context) => SeedLanguageRoute();
}

class SeedLanguageRoute extends StatefulWidget {
  @override
  _SeedLanguageState createState() => _SeedLanguageState();
}

class _SeedLanguageState extends State<SeedLanguageRoute> {
  List<String> getSeedLocales(AppLocalizations t){
    return [
      t.seed_language_english,
      'Chinese (simplified)',
      t.seed_language_dutch,
      t.seed_language_german,
      t.seed_language_japanese,
      t.seed_language_portuguese,
      t.seed_language_russian,
      t.seed_language_spanish,
      t.seed_language_french,
      t.seed_language_italian
    ];
  }
  int _selectedIndex = 0;

  void _onSelected(int index) {
    final seedLocales = getSeedLocales(tr(context));
    final seedLanguageStore = context.read<SeedLanguageStore>();
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex != null) {
        seedLanguageStore.setSelectedSeedLanguage(seedLocales[_selectedIndex]);
        print('seed languages ${seedLocales[_selectedIndex]}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final seedLanguageStore = Provider.of<SeedLanguageStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final _controller = ScrollController(keepScrollOffset: true);
    return ScrollableWithBottomSection(
      content: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: settingsStore.isDarkTheme
                    ? Color(0xff272733)
                    : Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(15)),
            margin:
                EdgeInsets.only(left: 10.0, right: 10.0, top: 20, bottom: 20.0),
            padding: EdgeInsets.only(top: 18),
            child: Column(
              children: [
                Text(
                  tr(context).chooseSeedLanguage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1.3 / 3, //200,
                  child: Container(
                      margin: EdgeInsets.only(left: 20.0, right: 10.0),
                      color: settingsStore.isDarkTheme
                          ? Color(0xff181820)
                          : Color(0xffD4D4D4),
                      child: RawScrollbar(
                        controller: _controller,
                        thickness: 8,
                        thumbColor: settingsStore.isDarkTheme
                            ? Color(0xff3A3A45)
                            : Color(0xffC2C2C2),
                        radius: Radius.circular(10.0),
                        thumbVisibility: true,
                        child: Container(
                          margin: EdgeInsets.only(right: 8),
                          color: settingsStore.isDarkTheme
                              ? Color(0xff272733)
                              : Color(0xffEDEDED),
                          child: ListView.builder(
                              controller: _controller,
                              scrollDirection: Axis.vertical,
                              itemCount: seedLanguages.length,
                              itemBuilder: (BuildContext context, int index) {
                                final seedLocales = getSeedLocales(tr(context));
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    _onSelected(index);
                                  },
                                  child: _selectedIndex != null &&
                                          _selectedIndex == index
                                      ? Card(
                                          color: Theme.of(context).cardColor,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0, bottom: 10.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xff0BA70F)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  seedLocales[index],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              top: 18.0, bottom: 18.0),
                                          child: Center(
                                            child: Text(
                                              seedLocales[index],
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                          ),
                                        ),
                                );
                              }),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSection: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: PrimaryButton(
            onPressed: () {
              if (_selectedIndex == 0) {
                final seedLocales = getSeedLocales(tr(context));
                seedLanguageStore.setSelectedSeedLanguage(seedLocales[_selectedIndex]);
              }
              Navigator.of(context).popAndPushNamed(seedLanguageStore.currentRoute);
            },
            text: tr(context).seed_language_next,
            color: Theme.of(context).primaryTextTheme.labelLarge?.backgroundColor,
            borderColor: Theme.of(context).primaryTextTheme.labelLarge?.backgroundColor),
      ),
    );
  }
}
