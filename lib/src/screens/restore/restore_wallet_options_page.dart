import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/src/stores/seed_language/seed_language_store.dart';
import 'package:provider/provider.dart';

class RestoreWalletOptionsPage extends BasePage {
  @override
  String getTitle(AppLocalizations t) => t.recoverySeedkey;

  @override
  Color get backgroundColor => Palette.creamyGrey;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget? leading(BuildContext context) {
    return leadingIcon(context);
  }

  @override
  Widget body(BuildContext context) {
    final seedLanguageStore = Provider.of<SeedLanguageStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 50),
          child: GestureDetector(
            onTap: () {
              seedLanguageStore.setCurrentRoute(Routes.restoreWalletFromSeed);
              Navigator.pushNamed(context, Routes.seedLanguage);
            },
            child: Card(
              elevation: 0,
              color: settingsStore.isDarkTheme
                  ? Color(0xff272733)
                  : Color(0xffEDEDED),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: SvgPicture.asset(
                                  'assets/images/new-images/restore_seed.svg',
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffAEAEAE)
                                      : Color(0xff16161D),
                                ),
                              ),
                              Text(
                                tr(context).restore_title_from_seed,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffF7F7F7)
                                        : Color(0xff16161D)),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            tr(context).restore_description_from_seed,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        seedLanguageStore
                            .setCurrentRoute(Routes.restoreWalletFromSeed);
                        Navigator.pushNamed(context, Routes.seedLanguage);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff1BB71E)),

                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xffffffff),
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: GestureDetector(
            onTap: () {
              seedLanguageStore.setCurrentRoute(Routes.restoreWalletFromKeys);
              Navigator.pushNamed(context, Routes.seedLanguage);
            },
            child: Card(
              elevation: 0,
              color: settingsStore.isDarkTheme
                  ? Color(0xff272733)
                  : Color(0xffEDEDED),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: SvgPicture.asset(
                                  'assets/images/new-images/restore_key.svg',
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffAEAEAE)
                                      : Color(0xff16161D),
                                ),
                              ),
                              Text(
                                tr(context).restore_title_from_keys,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffF7F7F7)
                                        : Color(0xff16161D)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            tr(context).restore_description_from_keys,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        seedLanguageStore
                            .setCurrentRoute(Routes.restoreWalletFromKeys);
                        Navigator.pushNamed(context, Routes.seedLanguage);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff2979FB)),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xffffffff),
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
