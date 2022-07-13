import 'package:mobx/mobx.dart';
import 'package:flutter/foundation.dart';
import 'package:beldex_wallet/src/domain/services/user_service.dart';
import 'package:beldex_wallet/src/stores/user/user_store_state.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  UserStoreBase({@required this.accountService});

  UserService accountService;

  @observable
  UserStoreState state;

  @observable
  String errorMessage;

  @action
  Future set({String password}) async {
    state = UserStoreStateInitial();

    try {
      await accountService.setPassword(password);
      state = PinCodeSetSuccessfully();
    } catch (e) {
      state = PinCodeSetFailed(error: e.toString());
    }
  }
}
