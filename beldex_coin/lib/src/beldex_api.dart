import 'dart:ffi';
import 'dart:io';

final DynamicLibrary beldexApi = Platform.isAndroid
    ? DynamicLibrary.open('libbeldex_coin.so')
    : DynamicLibrary.process();
