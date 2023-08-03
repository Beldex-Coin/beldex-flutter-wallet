import 'package:beldex_wallet/src/screens/rescan/rescan_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/src/wallet/mnemotic_item.dart';
import 'package:beldex_wallet/src/wallet/beldex/mnemonics/chinese_simplified.dart';
import 'package:beldex_wallet/src/wallet/beldex/mnemonics/dutch.dart';
import 'package:beldex_wallet/src/wallet/beldex/mnemonics/english.dart';
import 'package:beldex_wallet/src/wallet/beldex/mnemonics/english_old.dart';
import 'package:beldex_wallet/src/wallet/beldex/mnemonics/french.dart';
import 'package:beldex_wallet/src/wallet/beldex/mnemonics/german.dart';
import 'package:beldex_wallet/src/wallet/beldex/mnemonics/italian.dart';
import 'package:beldex_wallet/src/wallet/beldex/mnemonics/japanese.dart';
import 'package:beldex_wallet/src/wallet/beldex/mnemonics/portuguese.dart';
import 'package:beldex_wallet/src/wallet/beldex/mnemonics/russian.dart';
import 'package:beldex_wallet/src/wallet/beldex/mnemonics/spanish.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:provider/provider.dart';

final List<String> _englishWords =
    EnglishMnemonics.words + EnglishOldMnemonics.words;

class SeedWidget extends StatefulWidget {
  SeedWidget({Key key, this.onMnemoticChange, this.onFinish, this.seedLanguage})
      : super(key: key) {
    switch (seedLanguage) {
      case 'English':
        words = _englishWords;
        break;
      case 'Chinese (simplified)':
        words = ChineseSimplifiedMnemonics.words;
        break;
      case 'Dutch':
        words = DutchMnemonics.words;
        break;
      case 'German':
        words = GermanMnemonics.words;
        break;
      case 'Japanese':
        words = JapaneseMnemonics.words;
        break;
      case 'Portuguese':
        words = PortugueseMnemonics.words;
        break;
      case 'Russian':
        words = RussianMnemonics.words;
        break;
      case 'Spanish':
        words = SpanishMnemonics.words;
        break;
      case 'French':
        words = FrenchMnemonics.words;
        break;
      case 'Italian':
        words = ItalianMnemonics.words;
        break;
      default:
        words = _englishWords;
    }
  }

  final Function(List<MnemoticItem>) onMnemoticChange;
  final Function() onFinish;
  final String seedLanguage;
  List<String> words;

  @override
  SeedWidgetState createState() => SeedWidgetState();
}

class SeedWidgetState extends State<SeedWidget> {
  static const maxLength = 25;

  List<MnemoticItem> items = <MnemoticItem>[];
  final _seedController = TextEditingController();
  final _seedTextFieldKey = GlobalKey();
  MnemoticItem selectedItem;
  bool isValid;
  String errorMessage;

  List<MnemoticItem> currentMnemotics;
  bool isCurrentMnemoticValid;
  String _errorMessage;

  @override
  void initState() {
    super.initState();
    isValid = false;
    isCurrentMnemoticValid = false;
    _seedController
        .addListener(() => changeCurrentMnemotic(_seedController.text));
  }

  void addMnemotic(String text) {
    setState(() => items
        .add(MnemoticItem(text: text.trim(), dic: widget.words)));
    _seedController.text = '';

    if (widget.onMnemoticChange != null) {
      widget.onMnemoticChange(items);
    }
  }

  void mnemoticFromText(String text) {
    final splitted = text.split(' ');

    if (splitted.length >= 2) {
      for (final text in splitted) {
        if (text == ' ' || text.isEmpty) {
          continue;
        }

        if (selectedItem != null) {
          editTextOfSelectedMnemotic(text);
        } else {
          addMnemotic(text);
        }
      }
    }
  }

  void selectMnemotic(MnemoticItem item) {
    setState(() {
      selectedItem = item;
      currentMnemotics = [item];

      _seedController
        ..text = item.text
        ..selection = TextSelection.collapsed(offset: item.text.length);
    });
  }

  void onMnemoticTap(MnemoticItem item) {
    if (selectedItem == item) {
      setState(() => selectedItem = null);
      _seedController.text = '';
      return;
    }

    selectMnemotic(item);
  }

  void editTextOfSelectedMnemotic(String text) {
    setState(() => selectedItem.changeText(text));
    selectedItem = null;
    _seedController.text = '';

    if (widget.onMnemoticChange != null) {
      widget.onMnemoticChange(items);
    }
  }

  void clear() {
    setState(() {
      items = [];
      selectedItem = null;
      _seedController.text = '';

      if (widget.onMnemoticChange != null) {
        widget.onMnemoticChange(items);
      }
    });
  }

  void invalidate() {
    setState(() => isValid = false);
  }

  void validated() {
    setState(() => isValid = true);
  }

  void setErrorMessage(String errorMessage) {
    setState(() => this.errorMessage = errorMessage);
  }

  void replaceText(String text) {
    setState(() => items = []);
    mnemoticFromText(text);
    _seedController.text = text;
  }

  void changeCurrentMnemotic(String text) {
    setState(() {
      final trimmedText = text.trim();
      final splitted = trimmedText.split(' ');
      _errorMessage = null;

      if (text == null) {
        currentMnemotics = [];
        isCurrentMnemoticValid = false;
        return;
      }

      currentMnemotics = splitted
          .map((text) => MnemoticItem(text: text, dic: widget.words))
          .toList();

      var isValid = true;

      for (final word in currentMnemotics) {
        isValid = word.isCorrect();

        if (!isValid) {
          break;
        }
      }

      isCurrentMnemoticValid = isValid;
    });
  }

  void saveCurrentMnemoticToItems() {
    setState(() {
      if (selectedItem != null) {
        selectedItem.changeText(currentMnemotics.first.text.trim());
        selectedItem = null;
      } else {
        items.addAll(currentMnemotics);
        //_seedController.text = items.join(', ');
      }

      currentMnemotics = [];
      _seedController.text = '';
    });
  }

  void showErrorIfExist() {
    setState(() => _errorMessage =
        !isCurrentMnemoticValid ? S.current.incorrect_seed : null);
  }

  bool isSeedValid() {
    bool isValid;

    for (final item in items) {
      isValid = item.isCorrect();

      if (!isValid) {
        break;
      }
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
      alignment: Alignment.center,
      child: Column( 
      //  mainAxisSize: MainAxisSize.max,
       mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Flexible(
        //     fit: FlexFit.tight,
        //     flex:6,
        //     child: SingleChildScrollView(
        //       child: Wrap(
        //           children: items.map((item) {
        //         final isValid = item.isCorrect();
        //         final isSelected = selectedItem == item;

        //         return InkWell(
        //           onTap: () => onMnemoticTap(item),
        //           child: Container(
        //             padding: EdgeInsets.all(5),
        //               decoration: BoxDecoration(
        //                   color:
        //                       isValid ? Colors.grey : BeldexPalette.red,
        //                       borderRadius: BorderRadius.circular(7)
        //                       ),
        //               margin: EdgeInsets.only(right: 7, bottom: 8),
        //               child: Text(
        //                 item.toString(),
        //                 style: TextStyle(
        //                     color:
        //                         isValid ? Palette.blueGrey : Palette.lightGrey,
        //                     fontSize: 15,
        //                     fontWeight:
        //                         isSelected ? FontWeight.w900 : FontWeight.w400,
        //                     decoration: isSelected
        //                         ? TextDecoration.underline
        //                         : TextDecoration.none),
        //               )),
        //         );
        //       }).toList()),
        //     )),









        // Flexible(
        //     fit: FlexFit.tight,
        //     flex: 12,
        //     child: 
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
            
              child: Column(children: <Widget>[
                Card(
                  elevation: 0,
                  color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                      height:MediaQuery.of(context).size.height*1/3,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween
                      ,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          key: _seedTextFieldKey,
                          maxLines: 5,
                          onFieldSubmitted: (text) => isCurrentMnemoticValid
                              ? saveCurrentMnemoticToItems()
                              : null,
                          style: TextStyle(fontSize: 16.0),
                          controller: _seedController,
                          inputFormatters: [WordLimitInputFormatter(25)],
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border:InputBorder.none,
                              /*suffixIcon: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 145),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                          '${items.length}/${SeedWidgetState.maxLength}',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12)),
                                      SizedBox(width: 10),

                                    ],
                                  ),
                                ),
                              ),*/
                              hintStyle:
                                  TextStyle(color: Colors.grey.withOpacity(0.6)),
                              hintText: S.of(context).restore_from_seed_placeholder,
                              errorText: _errorMessage,
                              /*focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: BeldexPalette.teal, width: 2.0)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).focusColor,
                                      width: 1.0))*/),
                          enableInteractiveSelection: false,
                        ),
                        SizedBox(
                          height: 10,
                        ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => _seedController.clear(),
                              child: Container(
                                height:43,
                                width:90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: settingsStore.isDarkTheme ? Color(0xff333343) : Color(0xffDADADA)
                                ),
                                child: Center(child: Text('Clear',textAlign:TextAlign.center ,style: TextStyle(fontSize:16,fontWeight:FontWeight.w700))),
                              ),
                            ),
                          ),
                           GestureDetector(
                            onTap:  () async =>
                          Clipboard.getData('text/plain').then(
                                  (clipboard) =>
                                  replaceText(clipboard.text)),
                             child: Container(
                              height:43,
                              width:MediaQuery.of(context).size.width*0.90/3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff2979FB)
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:[
                                     Icon(Icons.paste,size: 14,color: Colors.white,),
                                     Padding(
                                       padding: const EdgeInsets.only(left:5.0),
                                       child: Text('Paste',style: TextStyle(fontSize:16,fontWeight:FontWeight.w700,color: Colors.white)),
                                     )
                                  ]
                                 
                                ),
                              ),
                          ),
                           )
                        ],
                      )






                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Text(
                        //       '${items.length}/${SeedWidgetState.maxLength}',
                        //       style: TextStyle(
                        //           color: Colors.grey.withOpacity(0.6), fontSize: 14)),
                        // ),
                      ],
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     FlatButton(
                //         padding: EdgeInsets.all(0),
                //         onPressed: () => _seedController.clear(),
                //         child: Text(S.of(context).clear,style: TextStyle(color:Theme.of(context).accentTextTheme.caption.decorationColor),)),
                //     InkWell(
                //       onTap: () async =>
                //           Clipboard.getData('text/plain').then(
                //                   (clipboard) =>
                //                   replaceText(clipboard.text)),
                //       child: Container(
                //           height: 35,
                //           padding: EdgeInsets.all(7),
                //           child: Text(S.of(context).paste)),
                //     ),
                //     SizedBox(width: 10,)
                //   ],
                // ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height:150
                    ),
                    Padding(
                        padding: EdgeInsets.only(top:20,),
                        child: (selectedItem == null && items.length == maxLength) && (_seedController.text != null || _seedController.text !='')
                            ? PrimaryButton(
                            text: S.of(context).restore_next,
                            isDisabled: !isSeedValid(),
                            onPressed: () => widget.onFinish != null
                                ? widget.onFinish()
                                : null,
                            color: Theme.of(context).primaryTextTheme.button.backgroundColor,
                            borderColor: Theme.of(context).primaryTextTheme.button.backgroundColor)
                            : 
                            SizedBox(
                          width: 250,
                              child: Container()
                              // PrimaryButton(
                              // text: selectedItem != null
                              //     ? S.of(context).save
                              //     : S.of(context).add_new_word,
                              // onPressed: () => isCurrentMnemoticValid
                              //     ? saveCurrentMnemoticToItems()
                              //     : null,
                              // onDisabledPressed: () => showErrorIfExist(),
                              // isDisabled:true,  //!isCurrentMnemoticValid,
                              // color: Theme.of(context).primaryTextTheme.button.backgroundColor,
                              // borderColor:Theme.of(context).primaryTextTheme.button.backgroundColor
                              // ),
                            )),
                  ],
                )
              ]),
            )
            //)
      ]),
    );
  }
}


class WordLimitInputFormatter extends TextInputFormatter {
  final int maxWords;

  WordLimitInputFormatter(this.maxWords);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    final wordCount = newText.split(' ').length;

    if (wordCount <= maxWords) {
      return newValue; // Allow the input.
    } else {
      // Reject the input if the word limit is reached.
      return oldValue;
    }
  }
}


















// import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:beldex_wallet/generated/l10n.dart';
// import 'package:beldex_wallet/palette.dart';
// import 'package:beldex_wallet/src/wallet/mnemotic_item.dart';
// import 'package:beldex_wallet/src/wallet/beldex/mnemonics/chinese_simplified.dart';
// import 'package:beldex_wallet/src/wallet/beldex/mnemonics/dutch.dart';
// import 'package:beldex_wallet/src/wallet/beldex/mnemonics/english.dart';
// import 'package:beldex_wallet/src/wallet/beldex/mnemonics/english_old.dart';
// import 'package:beldex_wallet/src/wallet/beldex/mnemonics/french.dart';
// import 'package:beldex_wallet/src/wallet/beldex/mnemonics/german.dart';
// import 'package:beldex_wallet/src/wallet/beldex/mnemonics/italian.dart';
// import 'package:beldex_wallet/src/wallet/beldex/mnemonics/japanese.dart';
// import 'package:beldex_wallet/src/wallet/beldex/mnemonics/portuguese.dart';
// import 'package:beldex_wallet/src/wallet/beldex/mnemonics/russian.dart';
// import 'package:beldex_wallet/src/wallet/beldex/mnemonics/spanish.dart';
// import 'package:beldex_wallet/src/widgets/primary_button.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// final List<String> _englishWords =
//     EnglishMnemonics.words + EnglishOldMnemonics.words;

// class SeedWidget extends StatefulWidget {
//   SeedWidget({Key key, this.onMnemoticChange, this.onFinish, this.seedLanguage})
//       : super(key: key) {
//     switch (seedLanguage) {
//       case 'English':
//         words = _englishWords;
//         break;
//       case 'Chinese (simplified)':
//         words = ChineseSimplifiedMnemonics.words;
//         break;
//       case 'Dutch':
//         words = DutchMnemonics.words;
//         break;
//       case 'German':
//         words = GermanMnemonics.words;
//         break;
//       case 'Japanese':
//         words = JapaneseMnemonics.words;
//         break;
//       case 'Portuguese':
//         words = PortugueseMnemonics.words;
//         break;
//       case 'Russian':
//         words = RussianMnemonics.words;
//         break;
//       case 'Spanish':
//         words = SpanishMnemonics.words;
//         break;
//       case 'French':
//         words = FrenchMnemonics.words;
//         break;
//       case 'Italian':
//         words = ItalianMnemonics.words;
//         break;
//       default:
//         words = _englishWords;
//     }
//   }

//   final Function(List<MnemoticItem>) onMnemoticChange;
//   final Function() onFinish;
//   final String seedLanguage;
//   List<String> words;

//   @override
//   SeedWidgetState createState() => SeedWidgetState();
// }

// class SeedWidgetState extends State<SeedWidget> {
//   static const maxLength = 25;

//   List<MnemoticItem> items = <MnemoticItem>[];
//   final _seedController = TextEditingController();
//   final _seedTextFieldKey = GlobalKey();
//   MnemoticItem selectedItem;
//   bool isValid;
//   String errorMessage;

//   List<MnemoticItem> currentMnemotics;
//   bool isCurrentMnemoticValid;
//   String _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     isValid = false;
//     isCurrentMnemoticValid = false;
//     _seedController
//         .addListener(() => changeCurrentMnemotic(_seedController.text));
//   }

//   void addMnemotic(String text) {
//     setState(() => items
//         .add(MnemoticItem(text: text.trim(), dic: widget.words)));
//     _seedController.text = '';

//     if (widget.onMnemoticChange != null) {
//       widget.onMnemoticChange(items);
//     }
//   }

//   void mnemoticFromText(String text) {
//     final splitted = text.split(' ');

//     if (splitted.length >= 2) {
//       for (final text in splitted) {
//         if (text == ' ' || text.isEmpty) {
//           continue;
//         }

//         if (selectedItem != null) {
//           editTextOfSelectedMnemotic(text);
//         } else {
//           addMnemotic(text);
//         }
//       }
//     }
//   }

//   void selectMnemotic(MnemoticItem item) {
//     setState(() {
//       selectedItem = item;
//       currentMnemotics = [item];

//       _seedController
//         ..text = item.text
//         ..selection = TextSelection.collapsed(offset: item.text.length);
//     });
//   }

//   void onMnemoticTap(MnemoticItem item) {
//     if (selectedItem == item) {
//       setState(() => selectedItem = null);
//       _seedController.text = '';
//       return;
//     }

//     selectMnemotic(item);
//   }

//   void editTextOfSelectedMnemotic(String text) {
//     setState(() => selectedItem.changeText(text));
//     selectedItem = null;
//     _seedController.text = '';

//     if (widget.onMnemoticChange != null) {
//       widget.onMnemoticChange(items);
//     }
//   }

//   void clear() {
//     setState(() {
//       items = [];
//       selectedItem = null;
//       _seedController.text = '';

//       if (widget.onMnemoticChange != null) {
//         widget.onMnemoticChange(items);
//       }
//     });
//   }

//   void invalidate() {
//     setState(() => isValid = false);
//   }

//   void validated() {
//     setState(() => isValid = true);
//   }

//   void setErrorMessage(String errorMessage) {
//     setState(() => this.errorMessage = errorMessage);
//   }

//   void replaceText(String text) {
//     setState(() => items = []);
//     mnemoticFromText(text);
//   }

//   void changeCurrentMnemotic(String text) {
//     setState(() {
//       final trimmedText = text.trim();
//       final splitted = trimmedText.split(' ');
//       _errorMessage = null;

//       if (text == null) {
//         currentMnemotics = [];
//         isCurrentMnemoticValid = false;
//         return;
//       }

//       currentMnemotics = splitted
//           .map((text) => MnemoticItem(text: text, dic: widget.words))
//           .toList();

//       var isValid = true;

//       for (final word in currentMnemotics) {
//         isValid = word.isCorrect();

//         if (!isValid) {
//           break;
//         }
//       }

//       isCurrentMnemoticValid = isValid;
//     });
//   }

//   void saveCurrentMnemoticToItems() {
//     setState(() {
//       if (selectedItem != null) {
//         selectedItem.changeText(currentMnemotics.first.text.trim());
//         selectedItem = null;
//       } else {
//         items.addAll(currentMnemotics);
//       }

//       currentMnemotics = [];
//       _seedController.text = '';
//     });
//   }

//   void showErrorIfExist() {
//     setState(() => _errorMessage =
//         !isCurrentMnemoticValid ? S.current.incorrect_seed : null);
//   }

//   bool isSeedValid() {
//     bool isValid;

//     for (final item in items) {
//       isValid = item.isCorrect();

//       if (!isValid) {
//         break;
//       }
//     }

//     return isValid;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final settingsStore = Provider.of<SettingsStore>(context);
//     return Container(
//       child: Column( //mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Flexible(
//             fit: FlexFit.tight,
//             flex:6,
//             child: SingleChildScrollView(
//               child: Wrap(
//                   children: items.map((item) {
//                 final isValid = item.isCorrect();
//                 final isSelected = selectedItem == item;

//                 return InkWell(
//                   onTap: () => onMnemoticTap(item),
//                   child: Container(
//                       decoration: BoxDecoration(
//                           color:
//                               isValid ? Colors.transparent : BeldexPalette.red),
//                       margin: EdgeInsets.only(right: 7, bottom: 8),
//                       child: Text(
//                         item.toString(),
//                         style: TextStyle(
//                             color:
//                                 isValid ? Palette.blueGrey : Palette.lightGrey,
//                             fontSize: 18,
//                             fontWeight:
//                                 isSelected ? FontWeight.w900 : FontWeight.w400,
//                             decoration: isSelected
//                                 ? TextDecoration.underline
//                                 : TextDecoration.none),
//                       )),
//                 );
//               }).toList()),
//             )),
//         Flexible(
//             //fit: FlexFit.tight,
//             flex: 13,
//             child: SingleChildScrollView(
//               child: Container(
               
//                // margin: EdgeInsets.only(left: 10,right: 10),
//                 child: Column(children: <Widget>[
//                   Card(
//                     elevation:0, //5,
//                     color:settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED),//Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: Container(
//                        height:MediaQuery.of(context).size.height*0.80/3,
//                       padding: EdgeInsets.all(15),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           TextFormField(
//                             key: _seedTextFieldKey,
//                             onFieldSubmitted: (text) => isCurrentMnemoticValid
//                                 ? saveCurrentMnemoticToItems()
//                                 : null,
//                             style: TextStyle(fontSize: 16.0),
//                             controller: _seedController,
//                             textInputAction: TextInputAction.done,
//                             decoration: InputDecoration(
//                               border:InputBorder.none,
//                                 /*suffixIcon: GestureDetector(
//                                   behavior: HitTestBehavior.opaque,
//                                   child: ConstrainedBox(
//                                     constraints: BoxConstraints(maxWidth: 145),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: <Widget>[
//                                         Text(
//                                             '${items.length}/${SeedWidgetState.maxLength}',
//                                             style: TextStyle(
//                                                 color: Colors.grey, fontSize: 12)),
//                                         SizedBox(width: 10),

//                                       ],
//                                     ),
//                                   ),
//                                 ),*/
//                                 hintStyle:
//                                     TextStyle(color: Colors.grey.withOpacity(0.6)),
//                                 hintText: S.of(context).restore_from_seed_placeholder,
//                                 errorText: _errorMessage,
//                                 /*focusedBorder: UnderlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: BeldexPalette.teal, width: 2.0)),
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: Theme.of(context).focusColor,
//                                         width: 1.0))*/),
//                             enableInteractiveSelection: false,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               InkWell(
//                                 onTap:  () => _seedController.clear(),
//                                 child: Container(
//                                  // height:50,
//                                  padding: EdgeInsets.all(10),
//                                   width:110,
//                                   decoration: BoxDecoration(
//                                     color: settingsStore.isDarkTheme ? Color(0xff333343) : Color(0xffDADADA),
//                                     borderRadius: BorderRadius.circular(10)
//                                   ),
//                                   child: Center(child: Text('Clear',style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),),
//                                 ),
//                               ),
//                               SizedBox(width: 10,),
//                               InkWell(
//                                 onTap:()async =>
//                             Clipboard.getData('text/plain').then(
//                                     (clipboard) =>
//                                     replaceText(clipboard.text)),
//                                 child: Container(
//                                  // height:50,
//                                  padding: EdgeInsets.all(10),
//                                   width:110,
//                                   decoration: BoxDecoration(
//                                     color:Color(0xff2979FB),
//                                     borderRadius: BorderRadius.circular(10)
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(Icons.paste,color: Colors.white,size: 15,),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left:5.0),
//                                         child: Text('Paste',style:TextStyle(color:Colors.white,fontSize:15,fontWeight: FontWeight.bold)),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                           // Align(
//                           //   alignment: Alignment.centerRight,
//                           //   child: Text(
//                           //       '${items.length}/${SeedWidgetState.maxLength}',
//                           //       style: TextStyle(
//                           //           color: Colors.grey.withOpacity(0.6), fontSize: 14)),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.end,
//                   //   children: [
//                   //     FlatButton(
//                   //         padding: EdgeInsets.all(0),
//                   //         onPressed: () => _seedController.clear(),
//                   //         child: Text(S.of(context).clear,style: TextStyle(color:Theme.of(context).accentTextTheme.caption.decorationColor),)),
//                   //     InkWell(
//                   //       onTap: () async =>
//                   //           Clipboard.getData('text/plain').then(
//                   //                   (clipboard) =>
//                   //                   replaceText(clipboard.text)),
//                   //       child: Container(
//                   //           height: 35,
//                   //           padding: EdgeInsets.all(7),
//                   //           child: Text(S.of(context).paste)),
//                   //     ),
//                   //     SizedBox(width: 10,)
//                   //   ],
//                   // ),
//                 // SizedBox(height:20),
//                   Padding(
//                       padding: EdgeInsets.all(0,),
//                       child: (selectedItem == null && items.length == maxLength)
//                           ? PrimaryButton(
//                           text: S.of(context).restore_next,
//                           isDisabled: !isSeedValid(),
//                           onPressed: () => widget.onFinish != null
//                               ? widget.onFinish()
//                               : null,
//                           color: Theme.of(context).primaryTextTheme.button.backgroundColor,
//                           borderColor: Theme.of(context).primaryTextTheme.button.backgroundColor)
//                           : 
//                           SizedBox(
//                         width: 250,
//                             child: 
//                             // GestureDetector(
//                             //   onTap: (){
//                             //      isCurrentMnemoticValid
//                             //  ? saveCurrentMnemoticToItems()
//                             //   : null;
//                             //   showErrorIfExist();
//                             //   },
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment.center,
//                             //     children: [
//                             //       SvgPicture.asset('assets/images/new-images/plus_fill.svg',color:Color(0xff0BA70F)),
//                             //       Padding(
//                             //         padding: const EdgeInsets.only(left:8.0),
//                             //         child: Text(
//                             //           selectedItem != null
//                             //    ? S.of(context).save
//                             //    : S.of(context).add_new_word,
//                             //    style: TextStyle(
//                             //     color:Color(0xff0BA70F),
//                             //     fontSize:16
//                             //    ),
//                             //         ),
//                             //       )
//                             //     ],
//                             //   ),
//                             // )
//                             PrimaryButton(
//                             text: selectedItem != null
//                                 ? S.of(context).save
//                                 : S.of(context).add_new_word,
//                             onPressed:()
//                              => isCurrentMnemoticValid
//                                 ? saveCurrentMnemoticToItems()
//                                 : null,
//                             onDisabledPressed: () => showErrorIfExist(),
//                             isDisabled: !isCurrentMnemoticValid,
//                             color: Theme.of(context).primaryTextTheme.button.backgroundColor,
//                             borderColor: Theme.of(context).primaryTextTheme.button.backgroundColor),
//                           )),

               
                          
//                 ]),
//               ),
//             )),
//             // SizedBox(
//             //   height:30,
//             // ),
//              Container(
//                   width:MediaQuery.of(context).size.width*2.0/3,

//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color:Color(0xff0BA70F)
//                   ),
//                   child:Center(
//                     child:Text('Next')
//                   )
//                 )
//       ]),
//     );
//   }
// }
