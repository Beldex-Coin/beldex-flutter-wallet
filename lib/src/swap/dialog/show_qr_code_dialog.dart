import 'package:flutter/material.dart';

import '../../../l10n.dart';
import '../../screens/receive/qr_image.dart';
import '../../stores/settings/settings_store.dart';

Future showQRCodeDialog(BuildContext context, SettingsStore settingsStore, String? payInAddress, {void Function(BuildContext context)? onDismiss}) {
  final AlertDialog alert = AlertDialog(
    backgroundColor: settingsStore.isDarkTheme
        ? Color(0xff272733)
        : Color(0xffffffff),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Recipient Address',
            style: TextStyle(
                color: settingsStore.isDarkTheme
                    ? Color(0xffffffff)
                    : Color(0xff222222),
                fontSize: 16,
                fontWeight: FontWeight.w800)),
        Container(
          height: MediaQuery.of(context).size.height * 0.60 / 2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: settingsStore.isDarkTheme
                ? Color(0xff1B1B23)
                : Color(0xfff3f3f3),
          ),
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(10),
            child: QrImage(
              data: payInAddress!,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if(onDismiss != null) {
              onDismiss(context);
            }
          },
          child: Container(
            height: 41,
            width: 121,
            decoration:
            BoxDecoration(
              borderRadius:
              BorderRadius
                  .circular(
                  10),
              color: Color(
                  0xff0BA70F),
            ),
            alignment:
            Alignment.center,
            child: Text(
              tr(context).ok,
              style: TextStyle(
                  backgroundColor: Colors.transparent,
                  color: Colors
                      .white,
                  fontWeight:
                  FontWeight
                      .w800,
                  fontSize: 15),
              textAlign: TextAlign
                  .center,
            ),
          ),
        )
      ],
    ),
  );
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return PopScope(
          canPop: false,
          child: alert
      );
    },
  );
}