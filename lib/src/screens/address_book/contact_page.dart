import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/src/domain/common/contact.dart';
import 'package:beldex_wallet/src/domain/common/crypto_currency.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/address_book/address_book_store.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:provider/provider.dart';

import '../../../palette.dart';
import '../../domain/common/qr_scanner.dart';

class ContactPage extends BasePage {
  ContactPage({required this.contact});

  final Contact contact;

  @override
  String getTitle(AppLocalizations t) => t.addAddress;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget? leading(BuildContext context) {
    return leadingIcon(context);
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
  List<String> addNameList = [];
  CryptoCurrency _selectedCrypto = CryptoCurrency.bdx;

  @override
  void initState() {
    super.initState();
    if (widget.contact.name.isEmpty && widget.contact.address.isEmpty) {
      _currencyTypeController.text = _selectedCrypto.toString();
    } else {
      //_selectedCrypto = widget.contact.type;
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
              Card(
                elevation:0,
                color: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:25.0),
                  child:TextFormField(
                    controller: _contactNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value == '') {
                        return tr(context).nameShouldNotBeEmpty;
                      } else if (!validateInput(value)) {
                        return tr(context).enterAValidName;
                      }
                      if (_checkName(value)) {
                        return tr(context).thisNameAlreadyExist;
                      }
                      addressBookStore.validateContactName(value,tr(context));
                      if(addressBookStore.errorMessage?.isNotEmpty ?? false) {
                        return addressBookStore.errorMessage;
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle:
                        TextStyle(backgroundColor:Colors.transparent,fontSize: 16.0, color: Colors.grey.withOpacity(0.6),fontWeight: FontWeight.bold),
                        hintText: tr(context).enterName,
                        errorStyle: TextStyle(backgroundColor:Colors.transparent,color: BeldexPalette.red)),
                  ),
                ),
              ),
              SizedBox(height: 14.0),
              Card(
                elevation:0,
                color: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:25.0),
                  child:TextFormField(
                    controller: _addressController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9.-]')),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(value?.isEmpty ?? false || value == ''){
                        return 'Address should not be empty';
                      }else
                      {
                        if(widget.contact.name.isEmpty && widget.contact.address.isEmpty){
                          for (var items in addressBookStore.contactList) {
                            if (items.address.contains(value!)) {
                              return tr(context).theAddressAlreadyExist;
                            }
                          }
                        }
                        addressBookStore.validateAddress(value!, cryptoCurrency: _selectedCrypto,t:tr(context));
                        if(addressBookStore.errorMessage?.isNotEmpty ?? false) {
                          return addressBookStore.errorMessage;
                        }else{
                          return null;
                        }
                      }
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Container(
                            width: 20.0,
                            height: 20.0,
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () async => _presentQRScanner(context,_addressController),
                              child: SvgPicture.asset(
                                'assets/images/qr_code_svg.svg',
                                width: 20,
                                height: 20,
                                color:
                                Theme.of(context).primaryTextTheme.bodySmall?.color,
                                placeholderBuilder: (context) {
                                  return Icon(Icons.image);
                                },
                              ),
                            )),
                        hintStyle:
                        TextStyle(backgroundColor:Colors.transparent,fontSize: 16.0, color: Colors.grey.withOpacity(0.6),fontWeight: FontWeight.bold),
                        hintText: tr(context).enterAddress,
                        errorStyle: TextStyle(backgroundColor:Colors.transparent,color: BeldexPalette.red)),
                  ),
                ),
              ),
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
                  onPressed: () {
                    setState(() {
                      _selectedCrypto = CryptoCurrency.xmr;
                      _contactNameController.text = '';
                      _currencyTypeController.text =
                          _selectedCrypto.toString();
                      _addressController.text = '';
                    });
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: settingsStore.isDarkTheme
                        ? Color(0xff383848)
                        : Color(0xffE8E8E8),
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    tr(context).reset,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        backgroundColor: Colors.transparent,
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
                  onPressed: () async {
                          if (!(_formKey.currentState?.validate() ?? false)) {
                            return;
                          }
                          try {
                            if (widget.contact.name.isEmpty && widget.contact.address.isEmpty) {
                              final newContact = Contact(
                                  name: _contactNameController.text,
                                  address: _addressController.text,
                                  //type: _selectedCrypto
                              );

                              await addressBookStore.add(contact: newContact);
                            } else {
                              widget.contact?.name = _contactNameController.text;
                              widget.contact?.address = _addressController.text;
                              /*widget.contact.updateCryptoCurrency(
                                  currency: _selectedCrypto);*/

                              await addressBookStore.update(
                                  contact: widget.contact!);
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
                                    surfaceTintColor: Colors.transparent,
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
                                              style: TextStyle(backgroundColor: Colors.transparent,fontSize: 15),
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
                                                        tr(context).ok,
                                                        style: TextStyle(
                                                          backgroundColor: Colors.transparent,
                                                          color: Theme.of(context).primaryTextTheme.bodySmall?.color,
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
                    backgroundColor: Color(0xff0BA70F),
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    tr(context).add,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        backgroundColor: Colors.transparent,
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

  Future<void> _presentQRScanner(BuildContext context, TextEditingController controller) async {
    try {
      final code = await presentQRScanner();
      final uri = Uri.parse(code!);
      var address = '';

      if (uri == null) {
        controller?.text = code;
        return;
      }

      address = uri.path;
      controller?.text = address;
    } catch (e) {
      print('Error $e');
    }
  }
}
