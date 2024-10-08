import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beldex_wallet/palette.dart';

class BeldexTextField extends StatelessWidget {
  BeldexTextField(
      {this.enabled = true,
      this.hintText,
      this.keyboardType,
      required this.controller,
      this.validator,
      this.inputFormatters,
      this.prefixIcon,
      this.suffixIcon,
      this.focusNode, this.color,this.onChanged,this.autoValidateMode, this.onTap});

  final bool enabled;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final Color? color;
  final ValueChanged<String>? onChanged;
  final AutovalidateMode? autoValidateMode;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:0,
      color: color ?? Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:25.0),
        child: TextFormField(
            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            enabled: enabled,
            controller: controller,
          focusNode: focusNode ?? FocusNode(),
            style: TextStyle(
              backgroundColor: Colors.transparent,
                fontSize: 16.0,
                ),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            autovalidateMode: autoValidateMode,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintStyle:
                    TextStyle(backgroundColor:Colors.transparent,fontSize: 16.0, color: Colors.grey.withOpacity(0.6),fontWeight: FontWeight.bold),
                hintText: hintText,
                errorStyle: TextStyle(backgroundColor:Colors.transparent,color: BeldexPalette.red)),
            validator: validator,
            onTap: onTap,
        ),
      ),
    );
  }
}
