import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/showSnackBar.dart';
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
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color:Color(0xff0BA70F),
          shape: BoxShape.circle,
        ),
        margin: EdgeInsets.only(right:10),
        child:Icon(Icons.add,color:Color(0xffffffff),size: 26,)
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
    return
     addressBookStore.contactList.isEmpty ?
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin:EdgeInsets.only(left:MediaQuery.of(context).size.width*0.36/3),
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
      Column(
        children: [
          Observer(
              builder: (_) =>Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: 
                    addressBookStore.contactList == null
                          ? 0
                          : addressBookStore.contactList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final contact = addressBookStore.contactList[index];

                      return Container(
            height: 150,
            width: double.infinity,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:Color(0xffDADADA),
                      
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:Column(children: [
                     Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:8.0,),
                            child: Text(contact.name,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
                          ),
                          InkWell(
                            onTap: (){
                                Clipboard.setData(ClipboardData(
                                                              text: contact.address));
                                                          displaySnackBar(context,S.of(context).copied);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: SvgPicture.asset('assets/images/new-images/copy.svg',color:settingsStore.isDarkTheme ? Color(0xffffffff): Color(0xff16161D)),
                            ),
                          )
                        ],
                      ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(contact.address,style:TextStyle(color:settingsStore.isDarkTheme ? Color(0xffFFFFFF) : Color(0xff626262))),
                     )
                  ],)
            );
                    } ),
                ),
              )),
          
        ],
       ) ;
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
