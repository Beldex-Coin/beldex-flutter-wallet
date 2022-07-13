import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beldex_wallet/src/domain/services/user_service.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/stores/auth/auth_store.dart';

Widget createUnlockPage(
          {@required SharedPreferences sharedPreferences,
          @required UserService userService,
          @required WalletService walletService,
          @required Function(bool, AuthPageState) onAuthenticationFinished}) =>
      WillPopScope(
          onWillPop: () async => false,
          child: Provider(
              create: (_) => AuthStore(
                  sharedPreferences: sharedPreferences,
                  userService: userService,
                  walletService: walletService),
              child: AuthPage(
                  onAuthenticationFinished: onAuthenticationFinished,
                  closable: false)));