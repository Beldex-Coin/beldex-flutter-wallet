import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/contact.dart';
import 'package:beldex_wallet/src/domain/common/qr_scanner.dart';
import 'package:beldex_wallet/src/wallet/beldex/subaddress.dart';
import 'package:beldex_wallet/src/widgets/beldex_text_field.dart';

enum AddressTextFieldOption { qrCode, addressBook, subaddressList }

class AddressTextField extends StatelessWidget {
  AddressTextField(
      {@required this.controller,
      this.isActive = true,
      this.placeholder,
      this.options = const [
        AddressTextFieldOption.qrCode,
        AddressTextFieldOption.addressBook
      ],
      this.onURIScanned,
      this.focusNode,
      this.validator});

  static const prefixIconWidth = 20.0;
  static const prefixIconHeight = 20.0;
  static const spaceBetweenPrefixIcons = 10.0;

  final TextEditingController controller;
  final bool isActive;
  final String placeholder;
  final Function(Uri) onURIScanned;
  final List<AddressTextFieldOption> options;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BeldexTextField(
      enabled: isActive,
      controller: controller,
      focusNode: focusNode,
      suffixIcon: Padding(
          padding: EdgeInsets.only(right: 5),
          child: SizedBox(
            width: prefixIconWidth * options.length +
                (spaceBetweenPrefixIcons * options.length),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 5),
                if (options.contains(AddressTextFieldOption.qrCode)) ...[
                  Container(
                      width: prefixIconWidth,
                      height: prefixIconHeight,
                      child: InkWell(
                        onTap: () async => _presentQRScanner(context),
                        child: SvgPicture.asset('assets/images/qr_code_svg.svg',width: 25,height: 25,color: Theme.of(context).primaryTextTheme.caption.color,),//Icon(Icons.qr_code_outlined),
                      ))
                ],
                if (options.contains(AddressTextFieldOption.addressBook)) ...[
                  Container(
                      width: prefixIconWidth,
                      height: prefixIconHeight,
                      child: InkWell(
                        onTap: () async => _presetAddressBookPicker(context),
                        child: SvgPicture.asset('assets/images/contact_book_svg.svg',width: 25,height: 25,color: Theme.of(context).primaryTextTheme.caption.color ,),//Icon(Icons.contacts_rounded),
                      ))
                ],
                if (options
                    .contains(AddressTextFieldOption.subaddressList)) ...[
                  Container(
                      width: prefixIconWidth,
                      height: prefixIconHeight,
                      child: InkWell(
                        onTap: () async => _presetSubaddressListPicker(context),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Palette.wildDarkBlueWithOpacity,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Icon(Icons.arrow_downward_rounded)),
                      ))
                ],
              ],
            ),
          )),
      hintText: placeholder ?? S.current.widgets_address,
      validator: validator,
    );
  }

  Future<void> _presentQRScanner(BuildContext context) async {
    try {
      final code = await presentQRScanner();
      final uri = Uri.parse(code);
      var address = '';

      if (uri == null) {
        controller.text = code;
        return;
      }

      address = uri.path;
      controller.text = address;

      if (onURIScanned != null) {
        onURIScanned(uri);
      }
    } catch (e) {
     /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid BDX address'),
      ));*/
      print('Error $e');
    }
  }

  Future<void> _presetAddressBookPicker(BuildContext context) async {
    final contact = await Navigator.of(context, rootNavigator: true)
        .pushNamed(Routes.pickerAddressBook);

    if (contact is Contact && contact.address != null) {
      controller.text = contact.address;
    }
  }

  Future<void> _presetSubaddressListPicker(BuildContext context) async {
    final subaddress = await Navigator.of(context, rootNavigator: true)
        .pushNamed(Routes.subaddressList);

    if (subaddress is Subaddress && subaddress.address != null) {
      controller.text = subaddress.address;
    }
  }
}
