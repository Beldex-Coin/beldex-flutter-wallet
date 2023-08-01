import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/wallet_creation/wallet_creation_store.dart';
import 'package:beldex_wallet/src/stores/wallet_creation/wallet_creation_state.dart';
import 'package:beldex_wallet/src/domain/services/wallet_list_service.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/src/stores/seed_language/seed_language_store.dart';
import 'package:beldex_wallet/src/screens/seed_language/widgets/seed_language_picker.dart';
import 'package:beldex_wallet/src/util/generate_name.dart';
import 'dart:math' as math;

class NewWalletPage extends BasePage {
  NewWalletPage(
      {@required this.walletsService,
      @required this.walletService,
      @required this.sharedPreferences});

  final WalletListService walletsService;
  final WalletService walletService;
  final SharedPreferences sharedPreferences;

  @override
  String get title => S.current.new_wallet;

  // @override
  // Widget leading(BuildContext context) {
  //   return Container(
  //       padding: const EdgeInsets.only(top: 12.0, left: 10),
  //       decoration: BoxDecoration(
  //         //borderRadius: BorderRadius.circular(10),
  //         //color: Colors.black,
  //       ),
  //       child: SvgPicture.asset('assets/images/beldex_logo_foreground1.svg'));
  // }

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

  Future setName() async {
    while (true) {
      final name = await generateName();

      print(name);
      if (name.length <= 15) {
        nameController.text = name;
        break;
      }
    }
  }

  List<String> avatarList = [
    "assets/images/avatar1.png",
    "assets/images/avatar2.png",
    "assets/images/avatar3.png",
    "assets/images/avatar4.png",
    "assets/images/avatar5.png"
  ];
  final List<String> seedLocales = [
    S.current.seed_language_english,
    S.current.seed_language_chinese,
    S.current.seed_language_dutch,
    S.current.seed_language_german,
    S.current.seed_language_japanese,
    S.current.seed_language_portuguese,
    S.current.seed_language_russian,
    S.current.seed_language_spanish,
    S.current.seed_language_french,
    S.current.seed_language_italian
  ];
  final _scrollController = ScrollController(keepScrollOffset: true);
  final _controller = ScrollController(keepScrollOffset: true);
  int _selectedIndex = 0;
  bool isError = false;
  bool canremove = false;
  void _onSelected(int index) {
    final seedLanguageStore = context.read<SeedLanguageStore>();
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex != null) {
        //selectedSeedLanguage = seedLanguages[seedLocales.indexOf(selectedSeedLanguage)];
        seedLanguageStore.setSelectedSeedLanguage(seedLocales[_selectedIndex]);
        print('seed languages ${seedLocales[_selectedIndex]}');
      }
    });
  }



void _loading(bool _canLoad) {
    // setState(() {
    //   canLoad = true;
    // });

    // Simulate an asynchronous task, e.g., fetching data from an API
    // Future.delayed(Duration(seconds: 3), () {
    //   setState(() {
    //     canLoad = false;
    //   });

    //   // Close the HUD progress loader
    //   Navigator.pop(context);
    // });
   if(_canLoad){
    // Show the HUD progress loader
    showHUDLoader(context);
   }
  //  else{
  //    Navigator.pop(context);
  //  }
    
  }




void showHUDLoader(BuildContext context) {
  //final settingsStore = Provider.of<SettingsStore>(context,listen: false);
    showDialog<void>(
      context: context,
      //barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          // Prevent closing the dialog when the user presses the back button
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

            //backgroundColor: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
            content: 
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)),),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text('Creating new wallet...',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ),
        );
      },
    );
  }


















  @override
  Widget build(BuildContext context) {
    final walletCreationStore = Provider.of<WalletCreationStore>(context);
    final seedLanguageStore = Provider.of<SeedLanguageStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);

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
                  content: Text(state.error),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(S.of(context).ok),
                    ),
                  ],
                );
              });
        });
      }
    });

    return ScrollableWithBottomSection(
      content: Column(children: [
        /* Padding(
            padding: EdgeInsets.all(20),
            child: Image.asset('assets/images/beldex.png',
                height: 124, width: 400),
          ),*/
        Padding(
          padding: EdgeInsets.only(left: 30, right: 20, top: 40),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).wallet_name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 10),
          child: Container(
            height:isError ? 90 : 60,
            child: Form(
                key: _formKey,
                child: Card(
                  color: settingsStore.isDarkTheme
                      ? Color(0xff272733)
                      : Color(
                          0xffEDEDED), //Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                  elevation: 0, //3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    margin: EdgeInsets.only(left: 30),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 16.0,
                        color: settingsStore.isDarkTheme
                            ? Colors.white
                            : Colors
                                .black, //Theme.of(context).accentTextTheme.subtitle2.color
                      ),
                      controller: nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        suffixIcon:  Transform.rotate(
                          angle: 135 * math.pi / 180,
                          child: IconButton(
                            icon: Icon(
                              Icons.add_rounded,
                              color:canremove ? Colors.transparent :  Theme.of(context)
                                  .primaryTextTheme
                                  .caption
                                  .color,
                            ),
                            onPressed: () {
                              setState(() {
                                                              
                                                            });
                              canremove = true;
                              isError = true;
                              nameController.text = '';
                            },
                          ),
                        ),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 16.0, color: settingsStore.isDarkTheme ? Color(0xff747474) : Color(0xff6F6F6F)),
                        hintText: S.of(context).enter_wallet_name,
                      ),
                      validator: (value) {
                        final pattern = RegExp(r'^[a-zA-Z]{1,15}$');
                        if (!pattern.hasMatch(value)) {
                          return 'Enter valid name upto 15 characters';
                        } else {
                          walletCreationStore.validateWalletName(value);
                          // if(walletCreationStore.errorMessage == null)
                          // {
                          //     setState(() {
                          //               isError = false;
                          //          });
                          // }
                          return walletCreationStore.errorMessage;
                        }
                      
                      },
                      onChanged: (value){
                          setState(() {
                               isError = false;  
                            });
                            if(value.length > 15 || value.isEmpty){
                              isError = true;
                            }
                            if(value.isEmpty){
                              canremove = true;
                            }else{
                              canremove = false;
                            }
                      },
                    ),
                  ),
                )),
          ),
        ),
        /*Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select your avatar",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: avatarList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          avatarList[index],
                          width: 55,
                          height: 55,
                        ),
                      );
                    }),
              )
            ],
          ),
        ),*/
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Color(0xff272733)
                  : Color(0xffEDEDED),
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          margin:
              EdgeInsets.only(left: 10.0, right: 10.0, top: 20, bottom: 20.0),
          padding: EdgeInsets.only(top: 18),
          child: Column(
            children: [
              Text(
                S.of(context).choose_seed_lang,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
                      controller: _controller,
                      thickness: 8,
                      thumbColor: settingsStore.isDarkTheme
                          ? Color(0xff3A3A45)
                          : Color(0xffC2C2C2),
                      radius: Radius.circular(10.0),
                      isAlwaysShown: true,
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
                              return InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  _onSelected(index);
                                },
                                child: _selectedIndex != null &&
                                        _selectedIndex == index
                                    ? Card(
                                        color: Theme.of(context)
                                            .cardColor, //Color.fromARGB(255, 40, 42, 51),
                                        elevation: 0, //3,
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
                    )

                    //  DraggableScrollbar.rrect(
                    //   padding: EdgeInsets.only(left: 5),
                    //   controller: _scrollController,
                    //   heightScrollThumb: 80,
                    //   alwaysVisibleScrollThumb: true,
                    //   backgroundColor:
                    //       Theme.of(context).primaryTextTheme.button.backgroundColor,
                    //   /*hoverThickness:12.0,
                    //     showTrackOnHover: true,
                    //     radius: Radius.circular(10),
                    //     isAlwaysShown: true,
                    //     thickness: 8.0,
                    //     controller: _scrollController,
                    //     notificationPredicate: (ScrollNotification notification) {
                    //       return notification.depth == 0;
                    //     },*/
                    //   child: ListView.builder(
                    //       controller: _scrollController,
                    //       scrollDirection: Axis.vertical,
                    //       itemCount: seedLanguages.length,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return InkWell(
                    //           splashColor: Colors.transparent,
                    //           onTap: () {
                    //             _onSelected(index);
                    //           },
                    //           child: _selectedIndex != null && _selectedIndex == index
                    //               ? Card(
                    //                   color:Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                    //                   elevation:0, //3,
                    //                   shape: RoundedRectangleBorder(

                    //                       borderRadius: BorderRadius.circular(12)),
                    //                   child: Container(
                    //                       padding: const EdgeInsets.only(
                    //                           // left: 10.0,
                    //                           // right: 10.0,
                    //                           top: 10.0,
                    //                           bottom: 10.0),
                    //                           decoration: BoxDecoration(
                    //                             border: Border.all(color: Color(0xff0BA70F)),
                    //                             borderRadius: BorderRadius.circular(10)
                    //                           ),
                    //                       child: Center(
                    //                         child: Text(
                    //                           seedLocales[index],
                    //                           style: TextStyle(
                    //                               fontSize: 18,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                       )),
                    //                 )
                    //               : Padding(
                    //                   padding: const EdgeInsets.only(
                    //                       // left: 10.0,
                    //                       // right: 10.0,
                    //                       top: 18.0,
                    //                       bottom: 18.0),
                    //                   child: Center(
                    //                     child: Text(
                    //                       seedLocales[index],
                    //                       style: TextStyle(
                    //                           fontSize: 18,
                    //                           color: Colors.grey[800],
                    //                          // fontWeight: FontWeight.bold
                    //                           ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //         );
                    //       }),
                    // ),
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Observer(
          builder: (context) {
            return GestureDetector(
              onTap: ()async {
                if (_formKey.currentState.validate()) {
                  _loading(true);
                  isError = false; setState(() {
                                    });
                 await walletCreationStore.create(
                      name: nameController.text,
                      language: seedLanguageStore.selectedSeedLanguage);
                    _loading(false);
                }else{
                  setState(() {
                          isError = true;
                                    });
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 20, bottom: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff0BA70F)),
                  child: Center(
                    child: Text(S.of(context).continue_text,
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                  )
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   //250,
                  //   child: LoadingPrimaryButton(
                  //     onPressed: () {
                  //       if (_formKey.currentState.validate()) {
                  //         walletCreationStore.create(
                  //             name: nameController.text,
                  //             language: seedLanguageStore.selectedSeedLanguage);
                  //       }
                  //     },
                  //     text: S.of(context).continue_text,
                  //     color:
                  //         Theme.of(context).primaryTextTheme.button.backgroundColor,
                  //     borderColor:
                  //         Theme.of(context).primaryTextTheme.button.backgroundColor,
                  //     isLoading: walletCreationStore.state is WalletIsCreating,
                  //   ),
                  // ),
                  ),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        /* Padding(padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: SeedLanguagePicker(),
          )*/
      ]),
      /*bottomSection: Observer(
          builder: (context) {
            return SizedBox(
              width: 250,
              child: LoadingPrimaryButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    walletCreationStore.create(name: nameController.text,
                        language: seedLanguageStore.selectedSeedLanguage);
                  }
                },
                text: S.of(context).continue_text,
                color: Theme.of(context).primaryTextTheme.button.backgroundColor,
                borderColor:
                    Theme.of(context).primaryTextTheme.button.decorationColor,
                isLoading: walletCreationStore.state is WalletIsCreating,
              ),
            );
          },
        )*/
    );
  }

}
