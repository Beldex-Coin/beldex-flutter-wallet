import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/util/screen_sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/address_book/address_book_store.dart';
import 'package:beldex_wallet/src/widgets/beldex_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddressBookPage extends BasePage {
  AddressBookPage({this.isEditable = true});

  final bool isEditable;

  @override
  String getTitle(AppLocalizations t) => t.address_book;

  @override
  Widget? trailing(BuildContext context) {
    if (isEditable) return null;
    final addressBookStore = Provider.of<AddressBookStore>(context);
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: IconButton(
        icon: SvgPicture.asset('assets/images/new-images/menu_add_address.svg'),
        onPressed: () async {
          await Navigator.of(context).pushNamed(Routes.addressBookAddContact);
          await addressBookStore.updateContactList();
        },
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    final addressBookStore = Provider.of<AddressBookStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    ScreenSize.init(context);
    return Observer(builder: (_) {
      var addressBook = addressBookStore.contactList;
      return addressBook.isEmpty
          ? Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: ScreenSize
                          .screenHeight1, //MediaQuery.of(context).size.height * 1 / 3,
                      child: SvgPicture.asset(settingsStore.isDarkTheme
                          ? 'assets/images/new-images/address_empty_dark_theme.svg'
                          : 'assets/images/new-images/address_empty_white_theme.svg'),
                    ),
                    Container(
                        child: Text(
                      tr(context).noAddressesInBook,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: settingsStore.isDarkTheme
                              ? Color(0xff646474)
                              : Color(0xff82828D)),
                    ))
                  ],
                ),
              ),
            )
          : Container(
              child: ListView.builder(
                  itemCount: addressBook == null ? 0 : addressBook.length,
                  itemBuilder: (BuildContext context, int index) {
                    final contact = addressBook[index];

                    return !isEditable
                        ? Container(
                            height:
                                MediaQuery.of(context).size.height * 0.55 / 3,
                            width: double.infinity,
                            margin:
                                EdgeInsets.only(left: 15, right: 15, top: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffDADADA),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xff272733)
                                          : Color(0xffEDEDED)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                        ),
                                        child: Text(
                                          contact.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16),
                                        ),
                                      ),
                                      IconButton(
                                        icon: SvgPicture.asset(
                                            'assets/images/new-images/send.svg',
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffffffff)
                                                : Color(0xff16161D)),
                                        onPressed: () {
                                          Navigator.of(context).pop(contact);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(contact.address,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05 /
                                              3,
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xffFFFFFF)
                                              : Color(0xff626262))),
                                )
                              ],
                            ))
                        : Slidable(
                            key: Key('${contact.key}'),
                            endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                            SlidableAction(
                               label: tr(context).edit,
                               backgroundColor: Colors.blue,
                               foregroundColor: settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
                                icon: Icons.edit,
                                  onPressed: (context) async {
                                  await Navigator.of(context).pushNamed(
                                      Routes.addressBookAddContact,
                                      arguments: contact);
                                  await addressBookStore.updateContactList();
                                },
                              ),
                              SlidableAction(
                                label: tr(context).delete,
                                backgroundColor: Colors.red,
                                icon: CupertinoIcons.delete,
                                foregroundColor:
                                settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
                                onPressed: (context) async {
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
                            ]),
                      startActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          dismissible: DismissiblePane(
                            onDismissed: () async {
                              await addressBookStore.delete(
                                  contact: contact);
                              await addressBookStore
                                  .updateContactList();
                            },
                            confirmDismiss: () async {
                              return await showAlertDialog(
                                  context);
                            },
                          ),
                          children: []),
                            child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.55 /
                                    3,
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 15.0, right: 15, top: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffDADADA),
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xff272733)
                                              : Color(0xffEDEDED)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Text(
                                                contact.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: SvgPicture.asset(
                                                'assets/images/new-images/copy.svg',
                                                color: settingsStore.isDarkTheme
                                                    ? Color(0xffffffff)
                                                    : Color(0xff16161D)),
                                            onPressed: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: contact.address));
                                              Toast.show(
                                                'Address ${tr(context).copied}',
                                                duration: Toast.lengthShort,
                                                gravity: Toast.bottom,
                                                webTexColor: settingsStore
                                                        .isDarkTheme
                                                    ? Colors.black
                                                    : Colors
                                                        .white,
                                                backgroundColor:
                                                    settingsStore.isDarkTheme
                                                        ? Colors.grey.shade50
                                                        : Colors.grey.shade900,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(contact.address,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05 /
                                                  3,
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffFFFFFF)
                                                  : Color(0xff626262))),
                                    )
                                  ],
                                )),
                          );
                  }),
            );
    });
  }

  Future<bool> showAlertDialog(BuildContext context) async {
    var result = false;
    await showConfirmBeldexDialog(context, tr(context).removeContact,
        tr(context).areYouSureYouWantToRemoveSelectedContact,
        onDismiss: (context) => Navigator.pop(context, false),
        onConfirm: (context) {
          result = true;
          Navigator.pop(context, true);
          //return result;
        });
    return result;
  }
}
