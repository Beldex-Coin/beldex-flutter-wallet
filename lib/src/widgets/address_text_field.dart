import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/contact.dart';
import 'package:beldex_wallet/src/domain/common/qr_scanner.dart';
import 'package:beldex_wallet/src/wallet/beldex/subAddress.dart';
import 'package:beldex_wallet/src/widgets/beldex_text_field.dart';

enum AddressTextFieldOption { qrCode, addressBook, subAddressList, saveAddress }

class AddressTextField extends StatelessWidget {
  AddressTextField(
      {@required this.controller,
      this.isActive = true,
      this.placeholder,
      this.options = const [
        AddressTextFieldOption.qrCode,
        AddressTextFieldOption.addressBook,
        AddressTextFieldOption.saveAddress
      ],
      this.onURIScanned,
      this.focusNode,
      this.validator,
      this.onChanged,
      this.autoValidateMode, this.onTap});

  static const prefixIconWidth = 20.0;
  static const prefixIconHeight = 20.0;
  static const spaceBetweenPrefixIcons = 15.0;

  final TextEditingController controller;
  final bool isActive;
  final String placeholder;
  final Function(Uri) onURIScanned;
  final List<AddressTextFieldOption> options;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final AutovalidateMode autoValidateMode;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return BeldexTextField(
      enabled: isActive,
      controller: controller,
      focusNode: focusNode,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
      ],
      suffixIcon: Padding(
          padding: EdgeInsets.only(right: 5),
          child: SizedBox(
            width: prefixIconWidth * options.length +
                (spaceBetweenPrefixIcons * options.length),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              SizedBox(width: 5),
                if (options.contains(AddressTextFieldOption.saveAddress)) ...[
                  Container(
                    width: prefixIconWidth,
                    height: prefixIconHeight,
                    padding: EdgeInsets.only(right: 8),
                    child: InkWell(
                        onTap: () async => _saveAddress(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Palette.wildDarkBlueWithOpacity,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Icon(Icons.paste,
                              size: 20,
                              color: Color(0xff0BA70F)
                              // Theme.of(context)
                              //     .primaryTextTheme
                              //     .caption
                              //     .color
                                  ),
                        )),
                  )
                ],
                SizedBox(width:5),
                if (options.contains(AddressTextFieldOption.qrCode)) ...[
                  Container(
                      width: prefixIconWidth,
                      height: prefixIconHeight,
                      child: InkWell(
                        onTap: () async => _presentQRScanner(context),
                        child: SvgPicture.asset(
                          'assets/images/qr_code_svg.svg',
                          width: 20,
                          height: 20,
                          color:
                              Theme.of(context).primaryTextTheme.caption.color,
                          placeholderBuilder: (context) {
                            return Icon(Icons.image);
                          },
                        ),
                      ))
                ],
                SizedBox(width: 10),
                if (options.contains(AddressTextFieldOption.addressBook)) ...[
                  Container(
                      width: prefixIconWidth,
                      height: prefixIconHeight,
                      child: InkWell(
                        onTap: () async => presetAddressBookPicker(context),
                        child: SvgPicture.asset(
                          'assets/images/contact_book_svg.svg',
                          width: 25,
                          height: 25,
                          color:
                              Theme.of(context).primaryTextTheme.caption.color,
                          placeholderBuilder: (context) {
                            return Icon(Icons.image);
                          },
                        ),
                      ))
                ],
                if (options
                    .contains(AddressTextFieldOption.subAddressList)) ...[
                  Container(
                      width: prefixIconWidth,
                      height: prefixIconHeight,
                      child: InkWell(
                        onTap: () async => _presetSubAddressListPicker(context),
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
      hintText: placeholder ?? S.of(context).enterAddress,
      validator: validator,
      onChanged: onChanged,
      autoValidateMode: autoValidateMode,
      onTap: onTap,
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
      print('Error $e');
    }
  }

  Future<void> presetAddressBookPicker(BuildContext context) async {
    final contact = await Navigator.of(context, rootNavigator: true)
        .pushNamed(Routes.pickerAddressBook);

    if (contact is Contact && contact.address != null) {
      controller.text = contact.address;
    }
  }

  Future<void> _presetSubAddressListPicker(BuildContext context) async {
    final subAddress = await Navigator.of(context, rootNavigator: true)
        .pushNamed(Routes.subaddressList);

    if (subAddress is Subaddress && subAddress.address != null) {
      controller.text = subAddress.address;
    }
  }

  Future<void> _saveAddress(BuildContext context) async {
    try {
      final data = await Clipboard.getData('text/plain');
      controller.text = data.text.toString();
    } catch (e) {
      print(e);
    }
  }
}
