// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_book_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddressBookStore on AddressBookStoreBase, Store {
  final _$contactListAtom = Atom(name: 'AddressBookStoreBase.contactList');

  @override
  List<Contact> get contactList {
    _$contactListAtom.reportRead();
    return super.contactList;
  }

  @override
  set contactList(List<Contact> value) {
    _$contactListAtom.reportWrite(value, super.contactList, () {
      super.contactList = value;
    });
  }

  final _$isValidAtom = Atom(name: 'AddressBookStoreBase.isValid');

  @override
  bool get isValid {
    _$isValidAtom.reportRead();
    return super.isValid;
  }

  @override
  set isValid(bool value) {
    _$isValidAtom.reportWrite(value, super.isValid, () {
      super.isValid = value;
    });
  }

  final _$errorMessageAtom = Atom(name: 'AddressBookStoreBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$addAsyncAction = AsyncAction('AddressBookStoreBase.add');

  @override
  Future<dynamic> add({Contact contact}) {
    return _$addAsyncAction.run(() => super.add(contact: contact));
  }

  final _$updateContactListAsyncAction =
      AsyncAction('AddressBookStoreBase.updateContactList');

  @override
  Future<dynamic> updateContactList() {
    return _$updateContactListAsyncAction.run(() => super.updateContactList());
  }

  final _$updateAsyncAction = AsyncAction('AddressBookStoreBase.update');

  @override
  Future<dynamic> update({Contact contact}) {
    return _$updateAsyncAction.run(() => super.update(contact: contact));
  }

  final _$deleteAsyncAction = AsyncAction('AddressBookStoreBase.delete');

  @override
  Future<dynamic> delete({Contact contact}) {
    return _$deleteAsyncAction.run(() => super.delete(contact: contact));
  }

  @override
  String toString() {
    return '''
contactList: ${contactList},
isValid: ${isValid},
errorMessage: ${errorMessage}
    ''';
  }
}
