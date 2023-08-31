import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/domain/common/language.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/custom_scrollbar.dart';
import 'package:beldex_wallet/src/widgets/beldex_dialog.dart';
import 'package:provider/provider.dart';

class ChangeLanguage extends BasePage {
  @override
  String get title => S.current.settings_change_language;



  @override
  Widget trailing(BuildContext context){
    return Container();
  }

  @override
  Widget body(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final currentLanguage = Provider.of<Language>(context);

    final currentColor = Theme.of(context).selectedRowColor;
    final notCurrentColor =
        Theme.of(context).accentTextTheme.subtitle1.backgroundColor;
    //var scrollController = ScrollController(keepScrollOffset: true);

 final _controller = ScrollController(keepScrollOffset: true);
 final _scrollController = ScrollController(keepScrollOffset: true);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

       Center(
         child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: settingsStore.isDarkTheme ?  Color(0xff272733) : Color(0xffEDEDED) ,
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)
                ),
            margin:
                EdgeInsets.only(left: 20.0, right: 20.0, top: 20, bottom: 20.0),
            padding: EdgeInsets.only(top:18),
            child: Column(
              children: [
                Text(
                  S.of(context).chooseLanguage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),
                ),
                SizedBox(
            height: 15,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*1/3,  //200,
            child: Container(
              margin: EdgeInsets.only(left: 20.0, right: 10.0),
              //color: Color(0xff181820),
              child:RawScrollbar(
                controller: _controller,
                thickness: 8,
                thumbColor: settingsStore.isDarkTheme ? Color(0xff3A3A45) : Color(0xff494955),
                radius: Radius.circular(10.0),
                isAlwaysShown: false,
                child:Container(
                  margin: EdgeInsets.only(right:8),
                 color:  settingsStore.isDarkTheme ?  Color(0xff272733) : Color(0xffEDEDED) ,
                  child:Container(
                padding: EdgeInsets.only(right: 6),
                child: ListView.builder(
                  controller: _controller,
                  itemCount: languages.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    final isCurrent = settingsStore.languageCode == null
                        ? false
                        : languages.keys.elementAt(index) ==
                            settingsStore.languageCode;

                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () async {
                        if (!isCurrent) {
                          await settingsStore.saveLanguageCode(
                              languageCode: languages.keys.elementAt(index));
                          currentLanguage.setCurrentLanguage(
                              languages.keys.elementAt(index));
                          Navigator.of(context).pop();
                        }
                      },
                      child: isCurrent
                          ? Card(
                              color: Colors.transparent, //Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                   border: Border.all(color:Color(0xff0BA70F))),
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      languages.values.elementAt(index),
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
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
                                  languages.values.elementAt(index),
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                    );
                    /*Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      color: isCurrent ? currentColor : notCurrentColor,
                      child: ListTile(
                        title: Text(
                          languages.values.elementAt(index),
                          style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  Theme.of(context).primaryTextTheme.headline6.color),
                        ),
                        onTap: () async {
                          if (!isCurrent) {
                            await showSimpleBeldexDialog(
                              context,
                              S.of(context).change_language,
                              S.of(context).change_language_to(
                                  languages.values.elementAt(index)),
                              onPressed: (context) {
                                settingsStore.saveLanguageCode(
                                    languageCode: languages.keys.elementAt(index));
                                currentLanguage.setCurrentLanguage(
                                    languages.keys.elementAt(index));
                                Navigator.of(context).pop();
                              },
                            );
                          }
                        },
                      ),
                    );*/
                  },
                ),
              ),
                  //  ListView.builder(
                  //     controller: _scrollController,
                  //     scrollDirection: Axis.vertical,
                  //     itemCount: seedLanguages.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return InkWell(
                  //         splashColor: Colors.transparent,
                  //         onTap: () {
                  //           _onSelected(index);
                  //         },
                  //         child: _selectedIndex != null && _selectedIndex == index
                  //             ? Card(
                  //                 color:Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                  //                 elevation:0, //3,
                  //                 shape: RoundedRectangleBorder(
                                  
                  //                     borderRadius: BorderRadius.circular(12)),
                  //                 child: Container(
                  //                     padding: const EdgeInsets.only(
                  //                         // left: 10.0,
                  //                         // right: 10.0,
                  //                         top: 10.0,
                  //                         bottom: 10.0),
                  //                         decoration: BoxDecoration(
                  //                           border: Border.all(color: Color(0xff0BA70F)),
                  //                           borderRadius: BorderRadius.circular(10)
                  //                         ),
                  //                     child: Center(
                  //                       child: Text(
                  //                         seedLocales[index],
                  //                         style: TextStyle(
                  //                             fontSize: 18,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     )),
                  //               )
                  //             : Padding(
                  //                 padding: const EdgeInsets.only(
                  //                     // left: 10.0,
                  //                     // right: 10.0,
                  //                     top: 18.0,
                  //                     bottom: 18.0),
                  //                 child: Center(
                  //                   child: Text(
                  //                     seedLocales[index],
                  //                     style: TextStyle(
                  //                         fontSize: 18,
                  //                         color: Colors.grey[800],
                  //                        // fontWeight: FontWeight.bold
                  //                         ),
                  //                   ),
                  //                 ),
                  //               ),
                  //       );
                  //     }),
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
       ),










      //   Container(
      //     width: MediaQuery.of(context).size.width,
      //     decoration: BoxDecoration(
      //         border: Border.all(color: Colors.grey),
      //         borderRadius: BorderRadius.circular(10)),
      //     margin:
      //         EdgeInsets.only(left: 40.0, right: 40.0, top: 60, bottom: 60.0),
      //     padding: EdgeInsets.all(13),
      //     child: Text(
      //       S.of(context).seed_language_choose,
      //       textAlign: TextAlign.center,
      //       style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
      //     ),
      //   ),
      //  /* Center(
      //     child: Container(
      //       //margin: EdgeInsets.only(left: 40.0, right: 40.0),
      //       height: 180,
      //       child: CustomScrollbar(
      //         strokeWidth: 8,
      //         trackColor: Color.fromARGB(255, 109,109,109),
      //         thumbColor: Color.fromARGB(255, 124,234,131),
      //         controller: scrollController,
      //         child: ListView.builder(
      //           physics: ScrollPhysics(),
      //           shrinkWrap: true,
      //           controller: scrollController,
      //           itemCount: languages.values.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             final isCurrent = settingsStore.languageCode == null
      //                 ? false
      //                 : languages.keys.elementAt(index) ==
      //                 settingsStore.languageCode;

      //             return InkWell(
      //               splashColor: Colors.transparent,
      //               onTap: () async {
      //                 if (!isCurrent) {
      //                   await settingsStore.saveLanguageCode(
      //                       languageCode: languages.keys.elementAt(index));
      //                   currentLanguage.setCurrentLanguage(
      //                       languages.keys.elementAt(index));
      //                 }
      //               },
      //               child: isCurrent
      //                   ? Card(
      //                 color: Color.fromARGB(255, 40, 42, 51),
      //                 elevation: 3,
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(12)),
      //                 child: Container(
      //                     padding: const EdgeInsets.all(10.0),
      //                     child: Center(
      //                       child: Text(
      //                         languages.values.elementAt(index),
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
      //                     top: 25.0,
      //                     bottom: 25.0),
      //                 child: Center(
      //                   child: Text(
      //                     languages.values.elementAt(index),
      //                     style: TextStyle(
      //                         fontSize: 20,
      //                         color: Colors.grey[800],
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                 ),
      //               ),
      //             );
      //             *//*Container(
      //               margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      //               color: isCurrent ? currentColor : notCurrentColor,
      //               child: ListTile(
      //                 title: Text(
      //                   languages.values.elementAt(index),
      //                   style: TextStyle(
      //                       fontSize: 16.0,
      //                       color:
      //                           Theme.of(context).primaryTextTheme.headline6.color),
      //                 ),
      //                 onTap: () async {
      //                   if (!isCurrent) {
      //                     await showSimpleBeldexDialog(
      //                       context,
      //                       S.of(context).change_language,
      //                       S.of(context).change_language_to(
      //                           languages.values.elementAt(index)),
      //                       onPressed: (context) {
      //                         settingsStore.saveLanguageCode(
      //                             languageCode: languages.keys.elementAt(index));
      //                         currentLanguage.setCurrentLanguage(
      //                             languages.keys.elementAt(index));
      //                         Navigator.of(context).pop();
      //                       },
      //                     );
      //                   }
      //                 },
      //               ),
      //             );*//*
      //           },
      //         ),
      //       ),
      //     ),
      //   ),*/
      //   Container(
      //     margin: EdgeInsets.only(left: 40.0, right: 40.0),
      //     height: 180,
      //     child: RawScrollbar(
      //       thumbColor: Color(0xff2ea021),
      //       isAlwaysShown: true,
      //       controller: scrollController,
      //       thickness: 10.0,
      //       radius: Radius.circular(10),
      //       child: Container(
      //         padding: EdgeInsets.only(right: 6),
      //         child: ListView.builder(
      //           itemCount: languages.values.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             final isCurrent = settingsStore.languageCode == null
      //                 ? false
      //                 : languages.keys.elementAt(index) ==
      //                     settingsStore.languageCode;

      //             return InkWell(
      //               splashColor: Colors.transparent,
      //               onTap: () async {
      //                 if (!isCurrent) {
      //                   await settingsStore.saveLanguageCode(
      //                       languageCode: languages.keys.elementAt(index));
      //                   currentLanguage.setCurrentLanguage(
      //                       languages.keys.elementAt(index));
      //                   Navigator.of(context).pop();
      //                 }
      //               },
      //               child: isCurrent
      //                   ? Card(
      //                       color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
      //                       elevation: 3,
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(12)),
      //                       child: Container(
      //                           padding: const EdgeInsets.all(10.0),
      //                           child: Center(
      //                             child: Text(
      //                               languages.values.elementAt(index),
      //                               style: TextStyle(
      //                                   fontSize: 20,
      //                                   fontWeight: FontWeight.bold),
      //                             ),
      //                           )),
      //                     )
      //                   : Padding(
      //                       padding: const EdgeInsets.only(
      //                           left: 10.0,
      //                           right: 10.0,
      //                           top: 25.0,
      //                           bottom: 25.0),
      //                       child: Center(
      //                         child: Text(
      //                           languages.values.elementAt(index),
      //                           style: TextStyle(
      //                               fontSize: 20,
      //                               color: Colors.grey[800],
      //                               fontWeight: FontWeight.bold),
      //                         ),
      //                       ),
      //                     ),
      //             );
      //             /*Container(
      //               margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      //               color: isCurrent ? currentColor : notCurrentColor,
      //               child: ListTile(
      //                 title: Text(
      //                   languages.values.elementAt(index),
      //                   style: TextStyle(
      //                       fontSize: 16.0,
      //                       color:
      //                           Theme.of(context).primaryTextTheme.headline6.color),
      //                 ),
      //                 onTap: () async {
      //                   if (!isCurrent) {
      //                     await showSimpleBeldexDialog(
      //                       context,
      //                       S.of(context).change_language,
      //                       S.of(context).change_language_to(
      //                           languages.values.elementAt(index)),
      //                       onPressed: (context) {
      //                         settingsStore.saveLanguageCode(
      //                             languageCode: languages.keys.elementAt(index));
      //                         currentLanguage.setCurrentLanguage(
      //                             languages.keys.elementAt(index));
      //                         Navigator.of(context).pop();
      //                       },
      //                     );
      //                   }
      //                 },
      //               ),
      //             );*/
      //           },
      //         ),
      //       ),
      //     ),
      //   ),
      ],
    );
  }
}
