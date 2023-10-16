import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/domain/common/contact.dart';
import 'package:beldex_wallet/src/domain/common/crypto_currency.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/address_book/address_book_store.dart';
import 'package:beldex_wallet/src/widgets/address_text_field.dart';
import 'package:beldex_wallet/src/widgets/beldex_text_field.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:provider/provider.dart';

class ContactPage extends BasePage {
  ContactPage({this.contact});

  final Contact contact;

  @override
  String get title => S.current.addAddress;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) => ContactForm(contact, context);
}

class ContactForm extends StatefulWidget {
  ContactForm(this.contact, this.contxt);

  final Contact contact;
  final BuildContext contxt;

  @override
  State<ContactForm> createState() => ContactFormState();
}

class ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _contactNameController = TextEditingController();
  final _currencyTypeController = TextEditingController();
  final _addressController = TextEditingController();
  bool coinVisibility = false;
  final ScrollController _scrollController = ScrollController();
  List<String> addNameList = [];
  CryptoCurrency _selectedCrypto = CryptoCurrency.bdx;

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      _currencyTypeController.text = _selectedCrypto.toString();
    } else {
      _selectedCrypto = widget.contact.type;
      _contactNameController.text = widget.contact.name;
      _currencyTypeController.text = _selectedCrypto.toString();
      _addressController.text = widget.contact.address;
    }
    getAllAddressNames(widget.contxt);
  }

  @override
  void dispose() {
    _contactNameController.dispose();
    _currencyTypeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _setCurrencyType(BuildContext context) async {
    if (coinVisibility == false) {
      setState(() {
        coinVisibility = true;
      });
    } else {
      setState(() {
        coinVisibility = false;
      });
    }
  }

  bool validateInput(String input) {
    if (input.trim().isEmpty || input.startsWith(' ')) {
      // Value consists only of spaces or contains a leading space
      return false;
    }
    // Other validation rules can be applied here
    return true;
  }

  void getAllAddressNames(BuildContext context1) {
    final addressBookStore = Provider.of<AddressBookStore>(context1);
    setState(() {
      for (var i = 0; i < addressBookStore.contactList.length; i++) {
        addNameList.add(addressBookStore.contactList[i].name);
      }
    });
  }

  bool _checkName(String enteredName) {
    return addNameList.contains(enteredName);
  }

  @override
  Widget build(BuildContext context) {
    final addressBookStore = Provider.of<AddressBookStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    return ScrollableWithBottomSection(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 14.0),
              BeldexTextField(
                enabled: !coinVisibility,
                hintText: S.of(context).enterName,
                controller: _contactNameController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value == '') {
                    return S.of(context).nameShouldNotBeEmpty;
                  } else if (!validateInput(value)) {
                    return S.of(context).enterAValidName;
                  }
                  if (_checkName(value) && widget.contact == null) {
                    return S.of(context).thisNameAlreadyExist;
                  }
                  addressBookStore.validateContactName(value);
                  return addressBookStore.errorMessage;
                },
              ),
              SizedBox(height: 14.0),
              Visibility(
                visible: false,
                child: Stack(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () => _setCurrencyType(context),
                        child: IgnorePointer(
                          child: BeldexTextField(
                            controller: _currencyTypeController,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: coinVisibility,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 175,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(0.0, 2.0))
                            ],
                            border: Border.all(color: Colors.white),
                            color: Color.fromARGB(255, 31, 32, 39),
                            borderRadius: BorderRadius.circular(10)),
                        child: DraggableScrollbar.rrect(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 10, bottom: 10),
                          controller: _scrollController,
                          heightScrollThumb: 25,
                          alwaysVisibleScrollThumb: true,
                          backgroundColor: Theme.of(context)
                              .primaryTextTheme
                              .button
                              .backgroundColor,
                          child: ListView.builder(
                              itemCount: CryptoCurrency.all.length,
                              shrinkWrap: true,
                              controller: _scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () async {
                                    var currencyType =
                                        CryptoCurrency.all[0].toString();
                                    var selectedCurrency =
                                        CryptoCurrency.all[0];
                                    selectedCurrency =
                                        CryptoCurrency.all[index];
                                    currencyType =
                                        CryptoCurrency.all[index].toString();
                                    if (coinVisibility == false) {
                                      setState(() {
                                        coinVisibility = true;
                                      });
                                    } else {
                                      setState(() {
                                        coinVisibility = false;
                                      });
                                    }
                                    _selectedCrypto = selectedCurrency;
                                    _currencyTypeController.text = currencyType;
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      elevation: _selectedCrypto ==
                                              CryptoCurrency.all[index]
                                          ? 2.0
                                          : 0.0,
                                      color: _selectedCrypto ==
                                              CryptoCurrency.all[index]
                                          ? Theme.of(context).backgroundColor
                                          : Color.fromARGB(255, 31, 32, 39),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        child: Text(
                                          CryptoCurrency.all[index].toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: _selectedCrypto !=
                                                      CryptoCurrency.all[index]
                                                  ? Colors.grey.withOpacity(0.6)
                                                  : Theme.of(context)
                                                      .primaryTextTheme
                                                      .headline6
                                                      .color,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.0),
              AddressTextField(
                isActive: !coinVisibility,
                controller: _addressController,
                options: [AddressTextFieldOption.qrCode],
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if(value.isEmpty || value == ''){
                    return 'Address should not be empty';
                  }else
                  {
                     if(widget.contact == null){
                  for (var items in addressBookStore.contactList) {
                    if (items.address.contains(value)) {
                      return S.of(context).theAddressAlreadyExist;
                    }
                  }
                  }
                  addressBookStore.validateAddress(value,
                      cryptoCurrency: _selectedCrypto);
                  return addressBookStore.errorMessage;
                  }
                 
                },
              )
            ],
          ),
        ),
        bottomSection: Container(
          height: MediaQuery.of(context).size.height * 0.35 / 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: coinVisibility
                      ? null
                      : () {
                          if (!coinVisibility) {
                            setState(() {
                              _selectedCrypto = CryptoCurrency.xmr;
                              _contactNameController.text = '';
                              _currencyTypeController.text =
                                  _selectedCrypto.toString();
                              _addressController.text = '';
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    primary: settingsStore.isDarkTheme
                        ? Color(0xff383848)
                        : Color(0xffE8E8E8),
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    S.of(context).reset,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: settingsStore.isDarkTheme
                            ? Color(0xff93939B)
                            : Color(0xff16161D)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: coinVisibility
                      ? null
                      : () async {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          try {
                            if (widget.contact == null) {
                              final newContact = Contact(
                                  name: _contactNameController.text,
                                  address: _addressController.text,
                                  type: _selectedCrypto);

                              await addressBookStore.add(contact: newContact);
                            } else {
                              widget.contact.name = _contactNameController.text;
                              widget.contact.address = _addressController.text;
                              widget.contact.updateCryptoCurrency(
                                  currency: _selectedCrypto);

                              await addressBookStore.update(
                                  contact: widget.contact);
                            }
                            Navigator.pop(context);
                          } catch (e) {
                            await showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    elevation: 0,
                                    backgroundColor:
                                        Theme.of(context).cardTheme.color,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Container(
                                      height: 170,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              e.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 45,
                                                  ),
                                                  SizedBox(
                                                    width: 45,
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .cardTheme
                                                                .shadowColor,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      },
                                                      child: Text(
                                                        S.of(context).ok,
                                                        style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .caption
                                                              .color,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff0BA70F),
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    S.of(context).add,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
