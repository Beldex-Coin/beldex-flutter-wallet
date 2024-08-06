import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/src/stores/wallet_creation/wallet_creation_store.dart';
import 'package:beldex_wallet/src/stores/wallet_creation/wallet_creation_state.dart';
import 'package:beldex_wallet/src/domain/services/wallet_list_service.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:beldex_wallet/src/stores/seed_language/seed_language_store.dart';
import 'package:beldex_wallet/src/util/generate_name.dart';

class NewWalletPage extends BasePage {
  NewWalletPage(
      {required this.walletsService,
      required this.walletService,
      required this.sharedPreferences});

  final WalletListService walletsService;
  final WalletService walletService;
  final SharedPreferences sharedPreferences;

  @override
  String getTitle(AppLocalizations t) => t.new_wallet;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) => WalletNameForm();
}

class WalletNameForm extends StatefulWidget {
  @override
  _WalletNameFormState createState() => _WalletNameFormState();
}

class _WalletNameFormState extends State<WalletNameForm> {
  _WalletNameFormState() {
    setName();
  }

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ValueNotifier<bool> _isTextFieldNotEmpty = ValueNotifier(false);

  Future setName() async {
    var flag = true;
    while (flag) {
      final name = await generateName();

      print(name);
      if (name.length <= 15) {
        nameController.text = name;
        flag = false;
        break;
      }
    }
  }

  @override
  void initState() {
    nameController.addListener(_onTextChanged);
    super.initState();
  }

  List<String> getSeedLocales(AppLocalizations l10n) {
    return [
      l10n.seed_language_english,
      'Chinese (simplified)',
      l10n.seed_language_dutch,
      l10n.seed_language_german,
      l10n.seed_language_japanese,
      l10n.seed_language_portuguese,
      l10n.seed_language_russian,
      l10n.seed_language_spanish,
      l10n.seed_language_french,
      l10n.seed_language_italian
    ];
  }

  final _scrollController = ScrollController(keepScrollOffset: true);
  int _selectedIndex = 0;
  bool isError = false;
  bool canremove = false;

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

  void _onTextChanged() {
    _isTextFieldNotEmpty.value = nameController.text.isNotEmpty;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletCreationStore = Provider.of<WalletCreationStore>(context);
    final seedLanguageStore = Provider.of<SeedLanguageStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final seedLocales = getSeedLocales(tr(context));
    reaction((_) => walletCreationStore.state, (WalletCreationState state) {
      if (state is WalletCreatedSuccessfully) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }

      if (state is WalletCreationFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  surfaceTintColor: Colors.transparent,
                  content: Text(state.error),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(tr(context).ok),
                    ),
                  ],
                );
              });
        });
      }
    });

    return ScrollableWithBottomSection(
      content: Column(children: [
        Padding(
          padding: EdgeInsets.only(left: 30, right: 20, top: 40),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                tr(context).wallet_name,
                style: TextStyle(backgroundColor: Colors.transparent,fontSize: 18, fontWeight: FontWeight.w700),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 10),
          child: Form(
              key: _formKey,
              child: Card(
                color: settingsStore.isDarkTheme
                    ? Color(0xff272733)
                    : Color(0xffEDEDED),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: 16.0,
                          color: settingsStore.isDarkTheme
                              ? Colors.white
                              : Colors
                                .black, //Theme.of(context).textTheme.subtitle2.color
                        ),
                        controller: nameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 16.0,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff747474)
                                  : Color(0xff6F6F6F)),
                          hintText: tr(context).enterWalletName_,
                          errorStyle: TextStyle(backgroundColor:Colors.transparent,color:Colors.red,height: 1),
                        ),
                        validator: (value) {
                          final pattern = RegExp(r'^(?=.{1,15}$)[a-zA-Z0-9]+$');
                          if (!pattern.hasMatch(value!)) {
                            return tr(context).enterValidNameUpto15Characters;
                          } else {
                            walletCreationStore.validateWalletName(value,tr(context));
                            return walletCreationStore.errorMessage;
                          }
                        },
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _isTextFieldNotEmpty,
                        builder: (context, isNotEmpty, child) {
                          return isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .caption!
                                        .color,
                                  ),
                                  onPressed: () {
                                    nameController.clear();
                                  },
                                )
                              : Container();
                        },
                      ),
                    ],
                  ),
                ),
              )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Color(0xff272733)
                  : Color(0xffEDEDED),
              borderRadius: BorderRadius.circular(10)),
          margin:
              EdgeInsets.only(left: 10.0, right: 10.0, top: 20, bottom: 20.0),
          padding: EdgeInsets.only(top: 18),
          child: Column(
            children: [
              Text(
                tr(context).chooseSeedLanguage,
                textAlign: TextAlign.center,
                style: TextStyle(backgroundColor: Colors.transparent,fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1.2 / 3, //200,
                child: Container(
                    margin: EdgeInsets.only(left: 20.0, right: 10.0),
                    color: settingsStore.isDarkTheme
                        ? Color(0xff181820)
                        : Color(0xffD4D4D4),
                    child: RawScrollbar(
                      controller: _scrollController,
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
                            controller: _scrollController,
                            scrollDirection: Axis.vertical,
                            itemCount: seedLanguages.length,
                            itemBuilder: (BuildContext context, int index) {
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
                                                // left: 10.0,
                                                // right: 10.0,
                                                top: 10.0,
                                                bottom: 10.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xff0BA70F)),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                seedLocales[index],
                                                style: TextStyle(
                                                    backgroundColor: Colors.transparent,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            // left: 10.0,
                                            // right: 10.0,
                                            top: 18.0,
                                            bottom: 18.0),
                                        child: Center(
                                          child: Text(
                                            seedLocales[index],
                                            style: TextStyle(
                                              backgroundColor: Colors.transparent,
                                              fontSize: 18,
                                              color: Colors.grey[800],
                                              // fontWeight: FontWeight.bold
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
        SizedBox(
          height: 10,
        ),
        Observer(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: SizedBox(
                width: double.infinity,
                child: LoadingPrimaryButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_selectedIndex == 0) {
                        seedLanguageStore.setSelectedSeedLanguage(
                            seedLocales[_selectedIndex]);
                      }
                      walletCreationStore.create(
                          name: nameController.text,
                          language: seedLanguageStore.selectedSeedLanguage);
                    }
                  },
                  text: tr(context).continue_text,
                  color: Color.fromARGB(255,46, 160, 33),
                  borderColor: Color.fromARGB(255,46, 160, 33),
                  isLoading: walletCreationStore.state is WalletIsCreating,
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
