import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beldex_wallet/palette.dart';

class BeldexTextField extends StatelessWidget {
  BeldexTextField(
      {this.enabled = true,
      this.hintText,
      this.keyboardType,
      this.controller,
      this.validator,
      this.inputFormatters,
      this.prefixIcon,
      this.suffixIcon,
      this.focusNode});

  final bool enabled;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String Function(String) validator;
  final List<TextInputFormatter> inputFormatters;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Theme.of(context).cardColor,//Color.fromARGB(255, 40,42,51),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:25.0),
        child: TextFormField(
            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            enabled: enabled,
            controller: controller,
            focusNode: focusNode,
            style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).accentTextTheme.overline.color),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintStyle:
                    TextStyle(fontSize: 16.0, color: Colors.grey.withOpacity(0.6),fontWeight: FontWeight.bold),
                hintText: hintText,
                /*focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: BeldexPalette.teal, width: 2.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor, width: 1.0)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: BeldexPalette.red, width: 1.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: BeldexPalette.red, width: 1.0)),*/
                errorStyle: TextStyle(color: BeldexPalette.red)),
            validator: validator),
      ),
    );
  }
}
