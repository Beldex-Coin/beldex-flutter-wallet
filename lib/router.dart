import 'package:beldex_wallet/src/swap/model/create_transaction_model.dart';
import 'package:beldex_wallet/src/swap/provider/get_currencies_full_provider.dart';
import 'package:beldex_wallet/src/swap/provider/get_exchange_amount_provider.dart';
import 'package:beldex_wallet/src/swap/provider/get_pairs_params_provider.dart';
import 'package:beldex_wallet/src/swap/provider/get_transactions_provider.dart';
import 'package:beldex_wallet/src/swap/provider/validate_address_provider.dart';
import 'package:beldex_wallet/src/swap/screen/swap_exchange_page.dart';
import 'package:beldex_wallet/src/swap/screen/swap_exchanging_page.dart';
import 'package:beldex_wallet/src/swap/screen/swap_payment_details_page.dart';
import 'package:beldex_wallet/src/swap/screen/swap_payment_page.dart';
import 'package:beldex_wallet/src/swap/screen/swap_wallet_address_page.dart';
import 'package:beldex_wallet/src/swap/signature_page.dart';
import 'package:beldex_wallet/src/swap/util/swap_page_change_notifier.dart';
import 'package:beldex_wallet/src/bns/bns_page.dart';
import 'package:beldex_wallet/src/bns/bns_renewal.dart';
import 'package:beldex_wallet/src/bns/bns_renewal_change_notifier.dart';
import 'package:beldex_wallet/src/bns/bns_update.dart';
import 'package:beldex_wallet/src/bns/bns_update_change_notifier.dart';
import 'package:beldex_wallet/src/bns/buy_bns_change_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'l10n.dart';
import 'package:beldex_wallet/routes.dart';
// MARK: Import domains

import 'package:beldex_wallet/src/domain/common/contact.dart';
import 'package:beldex_wallet/src/domain/services/user_service.dart';
import 'package:beldex_wallet/src/domain/services/wallet_list_service.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/node/node.dart';

// MARK: Import screens
import 'package:beldex_wallet/src/screens/accounts/account_list_page.dart';
import 'package:beldex_wallet/src/screens/accounts/account_page.dart';
import 'package:beldex_wallet/src/screens/address_book/address_book_page.dart';
import 'package:beldex_wallet/src/screens/address_book/contact_page.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/screens/auth/create_login_page.dart';
import 'package:beldex_wallet/src/screens/auth/create_unlock_page.dart';
import 'package:beldex_wallet/src/screens/changelog/changelog_page.dart';
import 'package:beldex_wallet/src/screens/dangerzone/dangerzone_page.dart';
import 'package:beldex_wallet/src/screens/dashboard/create_dashboard_page.dart';
import 'package:beldex_wallet/src/screens/disclaimer/disclaimer_page.dart';
import 'package:beldex_wallet/src/screens/faq/faq_page.dart';
import 'package:beldex_wallet/src/screens/new_wallet/new_wallet_page.dart';
import 'package:beldex_wallet/src/screens/nodes/new_node_page.dart';
import 'package:beldex_wallet/src/screens/nodes/nodes_list_page.dart';
import 'package:beldex_wallet/src/screens/profile/profile_page.dart';
import 'package:beldex_wallet/src/screens/receive/receive_page.dart';
import 'package:beldex_wallet/src/screens/rescan/rescan_page.dart';
import 'package:beldex_wallet/src/screens/restore/restore_options_page.dart';
import 'package:beldex_wallet/src/screens/restore/restore_wallet_from_keys_page.dart';
import 'package:beldex_wallet/src/screens/restore/restore_wallet_from_seed_details.dart';
import 'package:beldex_wallet/src/screens/restore/restore_wallet_from_seed_page.dart';
import 'package:beldex_wallet/src/screens/restore/restore_wallet_options_page.dart';
import 'package:beldex_wallet/src/screens/seed/create_seed_page.dart';
import 'package:beldex_wallet/src/screens/seed_language/seed_language_page.dart';
import 'package:beldex_wallet/src/screens/send/send_page.dart';
import 'package:beldex_wallet/src/screens/settings/change_language.dart';
import 'package:beldex_wallet/src/screens/settings/settings.dart';
import 'package:beldex_wallet/src/screens/setup_pin_code/setup_pin_code.dart';
import 'package:beldex_wallet/src/screens/show_keys/show_keys_page.dart';
import 'package:beldex_wallet/src/screens/stake/new_stake_page.dart';
import 'package:beldex_wallet/src/screens/stake/stake_page.dart';
import 'package:beldex_wallet/src/screens/subaddress/subaddress_list_page.dart';
import 'package:beldex_wallet/src/screens/transaction_details/transaction_details_page.dart';
import 'package:beldex_wallet/src/screens/wallet_list/wallet_list_page.dart';
import 'package:beldex_wallet/src/screens/welcome/welcome_page.dart';
import 'package:beldex_wallet/src/stores/account_list/account_list_store.dart';
import 'package:beldex_wallet/src/stores/address_book/address_book_store.dart';
import 'package:beldex_wallet/src/stores/auth/auth_store.dart';
// MARK: Import stores

import 'package:beldex_wallet/src/stores/authentication/authentication_store.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/node_list/node_list_store.dart';
import 'package:beldex_wallet/src/stores/price/price_store.dart';
import 'package:beldex_wallet/src/stores/rescan/rescan_wallet_store.dart';
import 'package:beldex_wallet/src/stores/send/send_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/subaddress_list/subaddress_list_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/user/user_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_keys_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:beldex_wallet/src/stores/wallet_creation/wallet_creation_store.dart';
import 'package:beldex_wallet/src/stores/wallet_list/wallet_list_store.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_store.dart';
import 'package:beldex_wallet/src/wallet/mnemotic_item.dart';
import 'package:beldex_wallet/src/wallet/beldex/account.dart';
import 'package:beldex_wallet/src/wallet/beldex/subaddress.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_description.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Router {
  static Route<dynamic> generateRoute(
      {required SharedPreferences sharedPreferences,
      required WalletListService walletListService,
      required WalletService walletService,
      required UserService userService,
      required RouteSettings settings,
      required PriceStore priceStore,
      required WalletStore walletStore,
      required SyncStore syncStore,
      required BalanceStore balanceStore,
      required SettingsStore settingsStore,
      required Box<Contact> contacts,
      required Box<Node> nodes,
      required Box<TransactionDescription> transactionDescriptions}) {
    switch (settings.name) {
      case Routes.welcome:
        return MaterialPageRoute<void>(builder: (_) => WelcomePage());

      case Routes.newWalletFromWelcome:
        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              Provider(
              create: (_) => UserStore(
              accountService: UserService(
                  secureStorage: FlutterSecureStorage(),
                  sharedPreferences: sharedPreferences)),),
              Provider(
                create: (_) => AuthStore(
                    sharedPreferences: sharedPreferences,
                    userService: userService,
                    walletService: walletService),
              )
            ],
            child: SetupPinCodePage(
                onPinCodeSetup: (context, _) =>
                    Navigator.pushNamed(context, Routes.newWallet)),
          );
        });

      case Routes.newWallet:
        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              ProxyProvider<AuthenticationStore, WalletCreationStore>(
              update: (_, authStore, __) => WalletCreationStore(
              authStore: authStore,
              sharedPreferences: sharedPreferences,
              walletListService: walletListService),),
            ],
            child: NewWalletPage(
                walletsService: walletListService,
                walletService: walletService,
                sharedPreferences: sharedPreferences),
          );
        });

      case Routes.setupPin:
        Function(BuildContext, String)? callback;

        if (settings.arguments is Function(BuildContext, String)) {
          callback = settings.arguments as Function(BuildContext, String);
        }

        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              Provider(
                create: (_) => UserStore(
                    accountService: UserService(
                        secureStorage: FlutterSecureStorage(),
                        sharedPreferences: sharedPreferences)),
              ),
              Provider(
                create: (_) => AuthStore(
                    sharedPreferences: sharedPreferences,
                    userService: userService,
                    walletService: walletService),
              )
            ],
            child: SetupPinCodePage(
              onPinCodeSetup: (context, pin) =>
                  callback == null ? null : callback(context, pin)!,
            ),
          );
        });

      case Routes.restoreOptions:
        return MaterialPageRoute<void>(builder: (_) => RestoreOptionsPage());

      case Routes.restoreWalletOptions:
        return MaterialPageRoute<void>(
            builder: (_) => RestoreWalletOptionsPage());

      case Routes.restoreWalletOptionsFromWelcome:
        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              Provider(
              create: (_) => UserStore(
              accountService: UserService(
                  secureStorage: FlutterSecureStorage(),
                  sharedPreferences: sharedPreferences)),),
              Provider(
                create: (_) => AuthStore(
                    sharedPreferences: sharedPreferences,
                    userService: userService,
                    walletService: walletService),
              )
            ],
            child: SetupPinCodePage(
                onPinCodeSetup: (context, _) => Navigator.pushNamed(
                    context, Routes.restoreWalletOptions)),
          );
        });

      case Routes.seed:
        return MaterialPageRoute<void>(
            builder: (_) { return createSeedPage(
                settingsStore: settingsStore,
                walletService: walletService,
                callback: () { },
                showSeed: true);});

      case Routes.restoreWalletFromSeed:
        return MaterialPageRoute<void>(
            builder: (_) {
                return ProxyProvider<AuthenticationStore, WalletRestorationStore>(
                    update: (_, authStore, __) => WalletRestorationStore(
                        authStore: authStore,
                        sharedPreferences: sharedPreferences,
                        walletListService: walletListService),
                    child: RestoreWalletFromSeedPage(
                        walletsService: walletListService,
                        walletService: walletService,
                        sharedPreferences: sharedPreferences));});

      case Routes.restoreWalletFromKeys:
        return MaterialPageRoute<void>(
            builder: (_) {
                return ProxyProvider<AuthenticationStore, WalletRestorationStore>(
                    update: (_, authStore, __) => WalletRestorationStore(
                        authStore: authStore,
                        sharedPreferences: sharedPreferences,
                        walletListService: walletListService),
                    child: RestoreWalletFromKeysPage(
                        walletsService: walletListService,
                        walletService: walletService,
                        sharedPreferences: sharedPreferences));});

      case Routes.dashboard:
        return MaterialPageRoute<void>(
            builder: (_) { return createDashboardPage(
                walletService: walletService,
                priceStore: priceStore,
                settingsStore: settingsStore,
                transactionDescriptions: transactionDescriptions,
                walletStore: walletStore);});

      case Routes.send:
        return MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (_) {
              return MultiProvider(
                    providers: [
                      ProxyProvider<SettingsStore, BalanceStore>(
                        update: (_, settingsStore, __) => BalanceStore(
                            walletService: walletService,
                            settingsStore: settingsStore,
                            priceStore: priceStore),
                      ),
                      Provider(
                        create: (_) => SyncStore(walletService: walletService),
                      ),
                      Provider(
                          create: (_) => SendStore(
                              walletService: walletService,
                              priceStore: priceStore,
                              settingsStore: settingsStore,
                              transactionDescriptions:
                                  transactionDescriptions)),
                    ],
                    child: SendPage(
                        flashMap: settings.arguments as Map<String, dynamic>));});

      case Routes.receive:
        return MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (_) {
              return MultiProvider(providers: [
                  Provider(create: (_) => SubaddressListStore(walletService: walletService)),
                  ChangeNotifierProvider<ReceivePageChangeNotifier>(create: (_) => ReceivePageChangeNotifier())
                ], child: ReceivePage());});
      case Routes.transactionDetails:
        return MaterialPageRoute<void>(
            builder: (_) {
              return TransactionDetailsPage(
                transactionInfo: settings.arguments as TransactionInfo);});

      case Routes.transactionlist:
        return MaterialPageRoute<void>(
            builder: (_) {
              return createTransactionListPage(
                walletService: walletService,
                priceStore: priceStore,
                settingsStore: settingsStore,
                transactionDescriptions: transactionDescriptions,
                walletStore: walletStore);});

      case Routes.disclaimer:
        return MaterialPageRoute<void>(builder: (_) => DisclaimerPage());

      case Routes.seedLanguage:
        return MaterialPageRoute<void>(builder: (_) => SeedLanguage());

      case Routes.walletList:
        return MaterialPageRoute<void>(
            builder: (_) {
              return Provider(
                create: (_) => WalletListStore(
                    walletListService: walletListService,
                    walletService: walletService),
                child: WalletListPage());});

      case Routes.auth:
        return PageRouteBuilder<void>(
            fullscreenDialog: true,
            transitionDuration: Duration(milliseconds: 0),
            pageBuilder: (_, __, ___) {
              return Provider(
                  create: (_) => AuthStore(
                      sharedPreferences: sharedPreferences,
                      userService: userService,
                      walletService: walletService),
                  child: AuthPage(
                      onAuthenticationFinished:
                          settings.arguments as OnAuthenticationFinished),
                );});
      case Routes.auth1:
        return PageRouteBuilder<void>(
            fullscreenDialog: true,
            transitionDuration: Duration(milliseconds: 0),
            pageBuilder: (_, __, ___) {
              return Provider(
                  create: (_) => AuthStore(
                      sharedPreferences: sharedPreferences,
                      userService: userService,
                      walletService: walletService),
                  child: AuthPage(
                    onAuthenticationFinished:
                        settings.arguments as OnAuthenticationFinished,
                    closable: false,
                  ),
                );});

      case Routes.unlock:
        return PageRouteBuilder<void>(
            fullscreenDialog: true,
            transitionDuration: Duration(milliseconds: 0),
            pageBuilder: (_, __, ___) {
              return createUnlockPage(
                sharedPreferences: sharedPreferences,
                userService: userService,
                walletService: walletService,
                onAuthenticationFinished:
                    settings.arguments as OnAuthenticationFinished);});

      case Routes.nodeList:
        return MaterialPageRoute<void>(builder: (context) {
          return Provider(
              create: (_) => NodeListStore(nodesSource: nodes),
              child: NodeListPage());
        });

      case Routes.newNode:
        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              Provider(create: (_) =>NodeListStore(nodesSource: nodes)),
              ChangeNotifierProvider<NewNodePageChangeNotifier>(create: (_) => NewNodePageChangeNotifier())
            ],
            child: NewNodePage(),
          );
        });

      case Routes.login:
        return MaterialPageRoute<void>(builder: (context) {
          final authenticationStore = Provider.of<AuthenticationStore>(context);

          return createLoginPage(
              sharedPreferences: sharedPreferences,
              userService: userService,
              walletService: walletService,
              walletListService: walletListService,
              authenticationStore: authenticationStore);
        });

      case Routes.accountList:
        return MaterialPageRoute<void>(builder: (context) {
          return Provider(
                create: (_) => AccountListStore(walletService: walletService),
            child: AccountListPage(),);
        });

      case Routes.accountCreation:
        return MaterialPageRoute<String>(builder: (context) {
          return Provider(
              create: (_) => AccountListStore(walletService: walletService),
              child: AccountPage(account: settings.arguments as Account));
        });

      case Routes.addressBook:
        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              Provider(
                  create: (_) =>
                      AccountListStore(walletService: walletService)),
              Provider(create: (_) => AddressBookStore(contacts: contacts))
            ],
            child: AddressBookPage(isEditable: true),
          );
        });

      case Routes.pickerAddressBook:
        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              Provider(
                  create: (_) =>
                      AccountListStore(walletService: walletService)),
              Provider(create: (_) => AddressBookStore(contacts: contacts))
            ],
            child: AddressBookPage(isEditable: false),
          );
        });

      case Routes.addressBookAddContact:
        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              Provider(
                  create: (_) =>
                      AccountListStore(walletService: walletService)),
              Provider(create: (_) => AddressBookStore(contacts: contacts))
            ],
            child: ContactPage(contact: settings.arguments as Contact),
          );
        });

      case Routes.showKeys:
        return MaterialPageRoute<void>(
            builder: (context) {
              return Provider(
                create: (_) => WalletKeysStore(walletService: walletService),
                child: ShowKeysPage(),
              );
            },
            fullscreenDialog: true);

      case Routes.dangerzoneKeys:
        return MaterialPageRoute<void>(builder: (context) {
          return DangerZonePage(
            pageTitle: 'Show Keys',
            nextPage: Routes.showKeys,
          );
        });

      case Routes.dangerzoneSeed:
        return MaterialPageRoute<void>(builder: (context) {
          return DangerZonePage(
            pageTitle: 'Show Seed',
            nextPage: Routes.seed,
          );
        });

      case Routes.subaddressList:
        return MaterialPageRoute<Subaddress>(
            builder: (_) {
              return MultiProvider(providers: [
                  Provider(
                      create: (_) =>
                          SubaddressListStore(walletService: walletService))
                ], child: SubaddressListPage());});

      case Routes.restoreWalletFromSeedDetails:
        return MaterialPageRoute<void>(
            builder: (_) {
                return ProxyProvider<AuthenticationStore, WalletRestorationStore>(
                    update: (_, authStore, __) => WalletRestorationStore(
                        authStore: authStore,
                        sharedPreferences: sharedPreferences,
                        walletListService: walletListService,
                        seed: settings.arguments as List<MnemoticItem>),
                    child: RestoreWalletFromSeedDetailsPage());});

      case Routes.settings:
        return MaterialPageRoute<void>(
            builder: (_) {
              return Provider(
                create: (_) => NodeListStore(nodesSource: nodes),
                child: SettingsPage());});

      case Routes.rescan:
        return MaterialPageRoute<void>(
            builder: (_) {
              return Provider(
                create: (_) => RescanWalletStore(walletService: walletService),
                child: RescanPage());});

      case Routes.faq:
        return MaterialPageRoute<void>(builder: (_) => FaqPage());

      case Routes.changelog:
        return MaterialPageRoute<void>(builder: (_) => ChangelogPage());

      case Routes.changeLanguage:
        return MaterialPageRoute<void>(builder: (_) => ChangeLanguage());

      case Routes.profile:
        return MaterialPageRoute<void>(builder: (_) => ProfilePage());

      case Routes.stake:
        return MaterialPageRoute<void>(builder: (_) => StakePage());

      case Routes.newStake:
        return MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (_) {
              return MultiProvider(providers: [
                  ProxyProvider<SettingsStore, BalanceStore>(
                    update: (_, settingsStore, __) => BalanceStore(
                        walletService: walletService,
                        settingsStore: settingsStore,
                        priceStore: priceStore),
                  ),
                  Provider(
                    create: (_) => SyncStore(walletService: walletService),
                  ),
                  Provider(
                      create: (_) => SendStore(
                          walletService: walletService,
                          priceStore: priceStore,
                          settingsStore: settingsStore,
                          transactionDescriptions: transactionDescriptions)),
                ], child: NewStakePage());});

      case Routes.bns:
        return MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (_) {
              return MultiProvider(
                  providers: [
                    ProxyProvider<SettingsStore, BalanceStore>(
                      update: (_, settingsStore, __) => BalanceStore(
                          walletService: walletService,
                          settingsStore: settingsStore,
                          priceStore: priceStore),
                    ),
                    Provider(
                      create: (_) => SyncStore(walletService: walletService),
                    ),
                    Provider(
                        create: (_) => SendStore(
                            walletService: walletService,
                            priceStore: priceStore,
                            settingsStore: settingsStore,
                            transactionDescriptions:
                            transactionDescriptions)),
                    ChangeNotifierProvider<BuyBnsChangeNotifier>(create: (_) => BuyBnsChangeNotifier())
                  ],
                  child: BnsPage());
            });
      case Routes.bnsUpdate:
        return MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (_) {
              return MultiProvider(
                  providers: [
                    ProxyProvider<SettingsStore, BalanceStore>(
                      update: (_, settingsStore, __) => BalanceStore(
                          walletService: walletService,
                          settingsStore: settingsStore,
                          priceStore: priceStore),
                    ),
                    Provider(
                      create: (_) => SyncStore(walletService: walletService),
                    ),
                    Provider(
                        create: (_) => SendStore(
                            walletService: walletService,
                            priceStore: priceStore,
                            settingsStore: settingsStore,
                            transactionDescriptions:
                            transactionDescriptions)),
                    ChangeNotifierProvider<BnsUpdateChangeNotifier>(create: (_) => BnsUpdateChangeNotifier())
                  ],
                  child: BnsUpdatePage(bnsDetails: settings.arguments as Map<String, dynamic>));
            });
      case Routes.bnsRenewal:
        return MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (_) {
              return MultiProvider(
                  providers: [
                    ProxyProvider<SettingsStore, BalanceStore>(
                      update: (_, settingsStore, __) => BalanceStore(
                          walletService: walletService,
                          settingsStore: settingsStore,
                          priceStore: priceStore),
                    ),
                    Provider(
                      create: (_) => SyncStore(walletService: walletService),
                    ),
                    Provider(
                        create: (_) => SendStore(
                            walletService: walletService,
                            priceStore: priceStore,
                            settingsStore: settingsStore,
                            transactionDescriptions:
                            transactionDescriptions)),
                    ChangeNotifierProvider<BnsRenewalChangeNotifier>(create: (_) => BnsRenewalChangeNotifier())
                  ],
                  child: BnsRenewalPage(bnsName: settings.arguments as String));
            });
      case Routes.swapExchange:
        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<SwapExchangePageChangeNotifier>(create: (_) => SwapExchangePageChangeNotifier()),
              ChangeNotifierProvider<GetCurrenciesFullProvider>(create: (_) => GetCurrenciesFullProvider()),
              ChangeNotifierProvider<GetPairsParamsProvider>(create: (_) => GetPairsParamsProvider()),
              ChangeNotifierProvider<GetExchangeAmountProvider>(create: (_) => GetExchangeAmountProvider())
            ],
            child: SwapExchangePage(),
          );
        });
      case Routes.swapWalletAddress:
        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ValidateAddressProvider>(create: (_) => ValidateAddressProvider())
            ],
            child: SwapWalletAddressPage(exchangeData : settings.arguments as ExchangeData),
          );
        });
      case Routes.swapPayment:
        return MaterialPageRoute<void>(builder: (context) {
          return SwapPaymentPage();
        });
      case Routes.swapPaymentDetails:
        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<GetTransactionsProvider>(create: (_) => GetTransactionsProvider())
            ],
            child: SwapPaymentDetailsPage(transactionDetails : settings.arguments as CreateTransactionModel),
          );
        });
      case Routes.swapExchanging:
        return MaterialPageRoute<void>(builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<GetTransactionsProvider>(create: (_) => GetTransactionsProvider())
            ],
            child: SwapExchangingPage(transactionDetails : settings.arguments as CreateTransactionModel),
          );
        });
      case Routes.signature:
        return MaterialPageRoute<void>(builder: (context) {
          return SignaturePage();
        });

      default:
        return MaterialPageRoute<void>(
            builder: (context) {
              return Scaffold(
                  body: Center(
                      child: Text(tr(context).router_no_route(settings.name ?? 'null'))),
                );});
    }
  }
}
