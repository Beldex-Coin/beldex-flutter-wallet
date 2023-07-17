import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/domain/common/language.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/seed_language/widgets/seed_language_picker.dart';
import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/stores/seed_language/seed_language_store.dart';

class SeedLanguage extends BasePage {
  @override
  String get title => S.current.select_language;

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
Widget trailing(BuildContext context){
  return Container();
}

  @override
  Widget body(BuildContext context) => SeedLanguageRoute();
}

class SeedLanguageRoute extends StatefulWidget {
  @override
  _SeedLanguageState createState() => _SeedLanguageState();
}

class _SeedLanguageState extends State<SeedLanguageRoute> {
  //final imageSeed = Image.asset('assets/images/seedIco.png');
 // var scrollController = ScrollController(keepScrollOffset: true);

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
  int _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    final seedLanguageStore = Provider.of<SeedLanguageStore>(context);
 final settingsStore = Provider.of<SettingsStore>(context);
 final _controller = ScrollController(keepScrollOffset: true);
 // final _scrollController = ScrollController(keepScrollOffset: true);
    return 
    ScrollableWithBottomSection(
      content: Column(
        children: <Widget>[
          Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: settingsStore.isDarkTheme ?  Color(0xff272733) : Color(0xffEDEDED) ,
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15)
              ),
          margin:
              EdgeInsets.only(left: 10.0, right: 10.0, top: 20, bottom: 20.0),
          padding: EdgeInsets.only(top:18),
          child: Column(
            children: [
              Text(
                S.of(context).choose_seed_lang,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
              ),
              SizedBox(
          height: 15,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*1.3/3,  //200,
          child: Container(
            margin: EdgeInsets.only(left: 20.0, right: 10.0),
            color: settingsStore.isDarkTheme ? Color(0xff181820) : Color(0xffD4D4D4),
            child:RawScrollbar(
              controller: _controller,
              thickness: 8,
              thumbColor: settingsStore.isDarkTheme ? Color(0xff3A3A45) : Color(0xffC2C2C2),
              radius: Radius.circular(10.0),
              isAlwaysShown: true,
              child:Container(
                margin: EdgeInsets.only(right:8),
               color:  settingsStore.isDarkTheme ?  Color(0xff272733) : Color(0xffEDEDED) ,
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
                        child: _selectedIndex != null && _selectedIndex == index
                            ? Card(
                                color:Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                                elevation:0, //3,
                                shape: RoundedRectangleBorder(
                                
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        // left: 10.0,
                                        // right: 10.0,
                                        top: 10.0,
                                        bottom: 10.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xff0BA70F)),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                    child: Center(
                                      child: Text(
                                        seedLocales[index],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
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
        
          //
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //       border: Border.all(color: Colors.grey),
          //       borderRadius: BorderRadius.circular(10)),
          //   margin:
          //   EdgeInsets.only(left: 40.0, right: 40.0, top: 60, bottom: 60.0),
          //   padding: EdgeInsets.all(13),
          //   child: Text(
          //     S.of(context).seed_language_choose,
          //     textAlign: TextAlign.center,
          //     style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
          //   ),
          // ),
          // SizedBox(
          //   height: 200,
          //   child: Container(
          //     margin: EdgeInsets.only(left: 20.0, right: 20.0),
          //     child: DraggableScrollbar.rrect(
          //       padding: EdgeInsets.only(left: 5),
          //       controller: scrollController,
          //       heightScrollThumb: 35,
          //       alwaysVisibleScrollThumb: true,
          //       backgroundColor:
          //       Theme.of(context).primaryTextTheme.button.backgroundColor,
          //       child: ListView.builder(
          //           controller: scrollController,
          //           scrollDirection: Axis.vertical,
          //           itemCount: seedLanguages.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             return InkWell(
          //               splashColor: Colors.transparent,
          //               onTap: () {
          //                 _onSelected(index);
          //               },
          //               child: _selectedIndex != null && _selectedIndex == index
          //                   ? Card(
          //                 color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
          //                 elevation: 3,
          //                 shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(12)),
          //                 child: Container(
          //                     padding: const EdgeInsets.only(
          //                         left: 10.0,
          //                         right: 10.0,
          //                         top: 18.0,
          //                         bottom: 18.0),
          //                     child: Center(
          //                       child: Text(
          //                         seedLocales[index],
          //                         style: TextStyle(
          //                             fontSize: 20,
          //                             fontWeight: FontWeight.bold),
          //                       ),
          //                     )),
          //               )
          //                   : Padding(
          //                 padding: const EdgeInsets.only(
          //                     left: 10.0,
          //                     right: 10.0,
          //                     top: 18.0,
          //                     bottom: 18.0),
          //                 child: Center(
          //                   child: Text(
          //                     seedLocales[index],
          //                     style: TextStyle(
          //                         fontSize: 20,
          //                         color: Colors.grey[800],
          //                         fontWeight: FontWeight.bold),
          //                   ),
          //                 ),
          //               ),
          //             );
          //           }),
          //     ),
          //   ),
          // ),
         /* Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  imageSeed,
                  Text(
                    S.of(context).seed_language_choose,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SeedLanguagePicker(),
                ],
              ),
            ),
          ),*/
        ],
      ),
      bottomSection: SizedBox(
      width: 250,
      child: PrimaryButton(
          onPressed: () =>
              Navigator.of(context).popAndPushNamed(seedLanguageStore.currentRoute),
          text: S.of(context).seed_language_next,
          color:
          Theme.of(context).primaryTextTheme.button.backgroundColor,
          borderColor:
          Theme.of(context).primaryTextTheme.button.backgroundColor),
    ),
    );
  }
}
