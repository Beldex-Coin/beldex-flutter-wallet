import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../stores/settings/settings_store.dart';

Widget noTransactionsYet(SettingsStore settingsStore, double _screenWidth) {
  return Card(
    margin: EdgeInsets.only(
        top: 15, left: 10, right: 10, bottom: 15),
    elevation: 0,
    color: settingsStore.isDarkTheme
        ? Color(0xff24242f)
        : Color(0xfff3f3f3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15, top: 15),
          child: Text(
            'Transactions',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff060606)),
          ),
        ),
        Container(
          width: _screenWidth,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/swap/no_transactions_yet.svg",
                colorFilter: ColorFilter.mode(settingsStore.isDarkTheme ? Color(0xff65656E) : Color(0xffDADADA), BlendMode.srcIn),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "No Transactions Yet!",
                  style: TextStyle(
                      backgroundColor: Colors.transparent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: settingsStore
                          .isDarkTheme
                          ? Color(0xffffffff)
                          : Color(0xff222222))),
              SizedBox(
                height: 10,
              ),
              Text(
                  "There are no Transactions or\nexchanges made to show..",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      backgroundColor: Colors.transparent,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: settingsStore
                          .isDarkTheme
                          ? Color(0xff82828D)
                          : Color(0xff626262))),
            ],
          ),
        ),
      ],
    ),
  );
}