import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/crypto_currency.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/address_book/address_book_store.dart';
import 'package:beldex_wallet/src/widgets/beldex_dialog.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/util/constants.dart' as constants;

class AddressBookPage extends BasePage {
  AddressBookPage({this.isEditable = true});

  final bool isEditable;

  @override
  String get title => S.current.address_book;

  @override
  Widget trailing(BuildContext context) {
   // if (!isEditable) return null;

    final addressBookStore = Provider.of<AddressBookStore>(context);

    return InkWell(
      onTap: () async {
        await Navigator.of(context).pushNamed(Routes.addressBookAddContact);
        await addressBookStore.updateContactList();
      },
      child: Container(
       // width: 35,
       // height: 35,
        padding: EdgeInsets.only(right:10),
        child:Icon(Icons.add,color:Color(0xff0BA70F),size: 35,)
        // decoration: BoxDecoration(
        //     color:Colors.yellow, // Theme.of(context).cardTheme.shadowColor, //Colors.black,
        //     borderRadius: BorderRadius.all(Radius.circular(10))),
        // child: ButtonTheme(
        //   minWidth: double.minPositive,
        //   child: TextButton(
        //       style: ButtonStyle(
        //         //foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
        //         overlayColor: MaterialStateColor.resolveWith(
        //             (states) => Colors.transparent),
        //       ),
        //       onPressed: () async {
        //         await Navigator.of(context)
        //             .pushNamed(Routes.addressBookAddContact);
        //         await addressBookStore.updateContactList();
        //       },
        //       child: 
        //       SvgPicture.asset(
        //         'assets/images/add.svg',
        //         color:
        //             Theme.of(context).accentTextTheme.caption.decorationColor,
        //       )
        //       ),
        // ),
      ),
    );
    /*Container(
        width: 28.0,
        height: 28.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).selectedRowColor),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Icon(Icons.add, color: BeldexPalette.teal, size: 22.0),
            ButtonTheme(
              minWidth: 28.0,
              height: 28.0,
              child: FlatButton(
                  shape: CircleBorder(),
                  onPressed: () async {
                    await Navigator.of(context)
                        .pushNamed(Routes.addressBookAddContact);
                    await addressBookStore.updateContactList();
                  },
                  child: Offstage()),
            )
          ],
        ));*/
  }

  @override
  Widget body(BuildContext context) {
    final addressBookStore = Provider.of<AddressBookStore>(context);
   final settingsStore = Provider.of<SettingsStore>(context);
    return Stack(
      children: [
       // Text( addressBookStore.contactList.isEmpty ? 'empty' :'not empty'),
        addressBookStore.contactList.isEmpty ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin:EdgeInsets.only(left:MediaQuery.of(context).size.width*0.30/3),
              //color: Colors.yellow,
              height: MediaQuery.of(context).size.height*1/3,
              child: SvgPicture.asset(
                settingsStore.isDarkTheme ? 'assets/images/new-images/address_empty_darktheme.svg' 
                : 'assets/images/new-images/address_empty_whitetheme.svg'
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: Container(
                child:Text('No addresses in book',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color:settingsStore.isDarkTheme ? Color(0xff646474):Color(0xff82828D)),)
              ),
            )
          ],
        ):
        
        
        Container(
            margin: EdgeInsets.only(
                top: 40, left: constants.leftPx, right: constants.rightPx,),
            padding: EdgeInsets.only(bottom:isEditable
                ?55.0:0.0),
            child: Observer(
              builder: (_) => ListView.separated(
                  separatorBuilder: (_, __) => Divider(
                        color: Theme.of(context).dividerTheme.color,
                        height: 1.0,
                      ),
                  itemCount: addressBookStore.contactList == null
                      ? 0
                      : addressBookStore.contactList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final contact = addressBookStore.contactList[index];

                    final content = Card(
                        elevation: 5,
                        color: Theme.of(context).cardColor,
                        //Color.fromARGB(255, 40, 42, 51),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 0.0, top: 0.0, bottom: 8.0),
                          child: ListTile(
                            onTap: () async {
                              if (!isEditable) {
                                Navigator.of(context).pop(contact);
                                return;
                              }
                              await Clipboard.setData(
                                  ClipboardData(text: contact.address));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  content: Text(
                                    S.of(context).copied_to_clipboard,
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 46, 113, 43),
                                  duration: Duration(milliseconds: 1500),
                                ),
                              );
                              /* if (!isEditable) {
                        Navigator.of(context).pop(contact);
                        return;
                      }

                      final isCopied = await showNameAndAddressDialog(
                            context, contact.name, contact.address);

                      if (isCopied) {
                        await Clipboard.setData(
                              ClipboardData(text: contact.address));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                            ),
                            content: Text(S
                                .of(context)
                                .copied_to_clipboard,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                            backgroundColor: Color.fromARGB(255, 46, 113, 43),
                            duration: Duration(
                                milliseconds: 1500),
                        ),);
                        */ /*Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Copied to Clipboard'),
                              backgroundColor: Colors.green,
                              duration: Duration(milliseconds: 1500),
                            ),
                        );*/ /*
                      }*/
                            },
                            /*leading: Container(
                      height: 48.0,
                      width: 48.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _getCurrencyBackgroundColor(contact.type),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        contact.name.substring(0,2).toUpperCase(),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: _getCurrencyTextColor(contact.type),
                        ),
                      ),
                    ),*/
                            title: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 38.0),
                                child: Text(
                                  contact.address,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6
                                          .color),
                                ),
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(top: 38.0),
                              child: Icon(Icons.arrow_forward_ios_rounded,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6
                                      .color,
                                  size: 20),
                            ),
                          ),
                        ));

                    return !isEditable
                        ? Stack(
                            children: [
                              content,
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .button
                                          .backgroundColor,
                                      //Color.fromARGB(255, 40, 42, 51),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 8.0,
                                        top: 8.0,
                                        bottom: 8.0),
                                    child: Text(
                                      contact.name,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .caption
                                              .color),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Slidable(
                            key: Key('${contact.key}'),
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'Edit',
                                color: Colors.blue,
                                icon: Icons.edit,
                                onTap: () async {
                                  await Navigator.of(context).pushNamed(
                                      Routes.addressBookAddContact,
                                      arguments: contact);
                                  await addressBookStore.updateContactList();
                                },
                              ),
                              IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: CupertinoIcons.delete,
                                onTap: () async {
                                  await showAlertDialog(context)
                                      .then((isDelete) async {
                                    if (isDelete != null && isDelete) {
                                      await addressBookStore.delete(
                                          contact: contact);
                                      await addressBookStore
                                          .updateContactList();
                                    }
                                  });
                                },
                              ),
                            ],
                            dismissal: SlidableDismissal(
                              child: SlidableDrawerDismissal(),
                              onDismissed: (actionType) async {
                                await addressBookStore.delete(contact: contact);
                                await addressBookStore.updateContactList();
                              },
                              onWillDismiss: (actionType) async {
                                return await showAlertDialog(context);
                              },
                            ),
                            child: Stack(
                              children: [
                                content,
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .button
                                            .backgroundColor,
                                        //Color.fromARGB(255, 40, 42, 51),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 8.0,
                                          top: 8.0,
                                          bottom: 8.0),
                                      child: Text(
                                        contact.name,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .caption
                                                .color),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                  }),
            )),
        !isEditable
            ? Container()
            :Positioned(
                bottom: 0,
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,//Colors.black,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
                    ),
                  width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(bottom: 20,top: 20,),
                    child: Text(
                  'Swipe left for more options',
                  style: TextStyle(fontSize:15.0,fontWeight:FontWeight.bold,color: Theme.of(context).primaryTextTheme.caption.color),
                  textAlign: TextAlign.center,
                ))),
      ],
    );
  }

  Color _getCurrencyBackgroundColor(CryptoCurrency currency) {
    Color color;
    switch (currency) {
      case CryptoCurrency.bdx:
        color = BeldexPalette.tealWithOpacity;
        break;
      case CryptoCurrency.ada:
        color = Colors.blue[200];
        break;
      case CryptoCurrency.bch:
        color = Colors.orangeAccent;
        break;
      case CryptoCurrency.bnb:
        color = Colors.blue;
        break;
      case CryptoCurrency.btc:
        color = Colors.orange;
        break;
      case CryptoCurrency.dash:
        color = Colors.blue;
        break;
      case CryptoCurrency.eos:
        color = Colors.orangeAccent;
        break;
      case CryptoCurrency.eth:
        color = Colors.black;
        break;
      case CryptoCurrency.ltc:
        color = Colors.blue[200];
        break;
      case CryptoCurrency.nano:
        color = Colors.orange;
        break;
      case CryptoCurrency.trx:
        color = Colors.black;
        break;
      case CryptoCurrency.usdt:
        color = Colors.blue[200];
        break;
      case CryptoCurrency.xlm:
        color = color = Colors.blue;
        break;
      case CryptoCurrency.xrp:
        color = Colors.orangeAccent;
        break;
      default:
        color = Colors.white;
    }
    return color;
  }

  Color _getCurrencyTextColor(CryptoCurrency currency) {
    Color color;
    switch (currency) {
      case CryptoCurrency.xmr:
        color = BeldexPalette.teal;
        break;
      case CryptoCurrency.ltc:
      case CryptoCurrency.ada:
      case CryptoCurrency.usdt:
        color = Palette.lightBlue;
        break;
      default:
        color = Colors.white;
    }
    return color;
  }

  Future<bool> showAlertDialog(BuildContext context) async {
    var result = false;
    await showConfirmBeldexDialog(context, 'Remove contact',
        'Are you sure that you want to remove selected contact?',
        onDismiss: (context) => Navigator.pop(context, false),
        onConfirm: (context) {
          result = true;
          Navigator.pop(context, true);
          return true;
        });
    return result;
  }

  Future<bool> showNameAndAddressDialog(
      BuildContext context, String name, String address) async {
    var result = false;
    await showSimpleBeldexDialog(
      context,
      name,
      address,
      buttonText: 'Copy',
      onPressed: (context) {
        result = true;
        Navigator.of(context).pop(true);
      },
    );
    return result;
  }
}
