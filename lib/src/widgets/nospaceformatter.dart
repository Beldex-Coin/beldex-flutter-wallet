import 'package:flutter/services.dart';

/// no space entering into textfield
/// 
/// 
/// 
class NoSpaceFormatter extends TextInputFormatter {
  static const _invalidCharacters = [' ', '.', ',', '-'];

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Check if the new value contains any invalid characters
    if (_containsInvalidCharacters(newValue.text)) {
      // Remove the invalid characters from the new value
      final newString = _removeInvalidCharacters(newValue.text);

      // Calculate the offset for the cursor to maintain its position
      final cursorOffset = newValue.selection.baseOffset -
          (newValue.text.length - newString.length);

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: cursorOffset.clamp(0, newString.length) as int,
        ),
      );
    }
    return newValue;
  }

  bool _containsInvalidCharacters(String value) {
    for (final invalidChar in _invalidCharacters) {
      if (value.contains(invalidChar)) {
        return true;
      }
    }
    return false;
  }

  String _removeInvalidCharacters(String value) {
    String newString = value;
    for (final invalidChar in _invalidCharacters) {
      newString = newString.replaceAll(invalidChar, '');
    }
    return newString;
  }
}



//  class NoSpaceFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     // Check if the new value contains any space characters
//     if (newValue.text.contains(' ')) {
//       // Replace any space characters with an empty string
//       final newString = newValue.text.replaceAll(' ', '');

//       // Calculate the offset for the cursor to maintain its position
//       final cursorOffset = newValue.selection.baseOffset -
//           (newValue.text.length - newString.length);

//       return TextEditingValue(
//         text: newString,
//         selection: TextSelection.collapsed(
//           offset: cursorOffset.clamp(0, newString.length) as int,
//         ),
//       );
//     }
//     return newValue;
//   }
// }