import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  SeedWidget({required Key key, required this.onMnemonicChange, required this.onFinish, required this.seedLanguage})
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

  final Function(List<MnemoticItem>) onMnemonicChange;
  final Function() onFinish;
  final String seedLanguage;
  late final List<String> words;

  @override
  SeedWidgetState createState() => SeedWidgetState();
}

class SeedWidgetState extends State<SeedWidget> {

  List<MnemoticItem> items = <MnemoticItem>[];
  final _seedController = TextEditingController();
  final _seedTextFieldKey = GlobalKey();
  int maxWordCount = 25;
  int wordCount = 0;
  List<MnemoticItem> currentMnemonics = [];
  String? _errorMessage;
  String _errorMessage1 = '';

  @override
  void initState() {
    super.initState();
    _seedController
        .addListener(() => changeCurrentMnemonic(_seedController.text));
  }

  void addMnemonic(String text) {
    setState(
            () => items.add(MnemoticItem(text: text.trim(), dic: widget.words)));
    _seedController.text = '';

    if (widget.onMnemonicChange != null) {
      widget.onMnemonicChange(items);
    }
  }

  void mnemonicFromText(String text) {
    final splitted = text.split(' ');

    if (splitted.length >= 2) {
      for (final text in splitted) {
        if (text == ' ' || text.isEmpty) {
          continue;
        }
        addMnemonic(text);
      }
    }
  }

  void clear() {
    setState(() {
      items = [];
      _seedController.text = '';

      if (widget.onMnemonicChange != null) {
        widget.onMnemonicChange(items);
      }
    });
  }

  void replaceText(String text) {
    setState(() => items = []);
    mnemonicFromText(text);
    _seedController.text = text;
  }

  void changeCurrentMnemonic(String text) {
    setState(() {
      final trimmedText = text.trim();
      final splitted = trimmedText.split(' ');
      _errorMessage = null;

      if (text == null) {
        currentMnemonics = [];
        return;
      }

      currentMnemonics = splitted
          .map((text) => MnemoticItem(text: text, dic: widget.words))
          .toList();

      var isValid = true;

      for (final word in currentMnemonics) {
        isValid = word.isCorrect();

        if (!isValid) {
          break;
        }
      }
    });
  }

  bool isSeedValid() {
    //var isValid = false;

    for (final item in items) {
      //isValid = item.isCorrect();
     /* if (!isValid) {
        break;
      }*/
      if(!item.isCorrect()){
        return false;
      }
    }
    return true;
  }

  late final List<String> words;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Card(
                  elevation: 0,
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1 / 3,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          key: _seedTextFieldKey,
                          maxLines: 5,
                          style: TextStyle(backgroundColor: Colors.transparent,fontSize: 16.0),
                          controller: _seedController,
                          inputFormatters: [WordLimitInputFormatter(25)],
                          textInputAction: TextInputAction.done,
                          onChanged: (text) {
                            if (text.isNotEmpty) {
                              words = text
                                  .split(' ')
                                  .where((word) => word.isNotEmpty)
                                  .toList();
                              if (words.length > maxWordCount) {
                                // Remove additional words
                                _seedController.text =
                                    words.sublist(0, maxWordCount).join(' ');
                                _seedController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(
                                      offset: _seedController.text.length),
                                );
                              }
                              setState(() {
                                _errorMessage1 = '';
                                wordCount = words.length;
                              });
                            } else {
                              _seedController.clear();
                              setState(() {
                                wordCount = 0;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.6)),
                            hintText:
                                tr(context).restore_from_seed_placeholder,
                            errorText: _errorMessage,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Text('$wordCount/25')],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _seedController.clear();
                                setState(() {
                                  wordCount = 0;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: settingsStore.isDarkTheme
                                    ? Color(0xff333343)
                                    : Color(0xffDADADA),
                                padding: EdgeInsets.only(
                                    top: 11, bottom: 11, left: 25, right: 25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(tr(context).clear,
                                  style: TextStyle(
                                      backgroundColor: Colors.transparent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: settingsStore.isDarkTheme
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton.icon(
                              icon: Icon(
                                Icons.paste,
                                size: 14,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                await Clipboard.getData('text/plain').then(
                                        (clipboard) => replaceText(clipboard?.text ?? ""));
                                setState(() {
                                  wordCount = _seedController.text
                                      .split(' ')
                                      .where((word) => word.isNotEmpty)
                                      .toList()
                                      .length;
                                });
                              },
                              label: Text(tr(context).paste,
                                  style: TextStyle(
                                      backgroundColor: Colors.transparent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Color(0xff2979FB),
                                padding: EdgeInsets.only(
                                    top: 11, bottom: 11, left: 25, right: 25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                _errorMessage1 == null || _errorMessage1 == ''
                    ? Container()
                    : Text(
                  '$_errorMessage1',
                  style: TextStyle(backgroundColor: Colors.transparent,color: Colors.red),
                ),
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.70 / 3),
                    PrimaryButton(
                        onPressed: () {
                          print('inside the function---> $_seedController');
                          if (wordCount == maxWordCount) {
                            replaceText(_seedController.text);
                            if(isSeedValid()) {
                              print('inside first if--->');
                              setState(() {
                                _errorMessage1 = '';
                              });
                              if (widget.onFinish != null) {
                                print('inside second if--->');
                                return widget.onFinish();
                              } else {
                                print('inside first else--->');
                                return null;
                              }
                            }else {
                              print('inside second else --->');
                              setState(() {
                                _errorMessage1 =
                                    tr(context).pleaseEnterAValidSeed;
                              });
                              return null;
                            }
                          } else {
                            print('inside second else --->');
                            setState(() {
                              _errorMessage1 =
                                  tr(context).pleaseEnterAValidSeed;
                            });
                            return null;
                          }
                        },
                        text: tr(context).seed_language_next,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .button!
                            .backgroundColor!,
                        borderColor: Theme.of(context)
                            .primaryTextTheme
                            .button!
                            .backgroundColor!)
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
  WordLimitInputFormatter(this.maxWords);

  final int maxWords;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
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
