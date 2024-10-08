import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/account_list/account_list_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/account.dart';
import 'package:beldex_wallet/src/widgets/beldex_text_field.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/util/constants.dart' as constants;

class AccountPage extends BasePage {
  AccountPage({this.account});

  final Account? account;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  String getTitle(AppLocalizations t) => t.account;

  @override
  Widget body(BuildContext context) => AccountForm(account);
}

class AccountForm extends StatefulWidget {
  AccountForm(this.account);

  final Account? account;

  @override
  AccountFormState createState() => AccountFormState();
}

class AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void initState() {
    if (widget.account != null){
      _textController.text = widget.account?.label ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountListStore = Provider.of<AccountListStore>(context);

    return ScrollableWithBottomSection(
      contentPadding: EdgeInsets.only(
          top: 40,
          left: constants.leftPx,
          right: constants.rightPx,
          bottom: 20),
      content: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: BeldexTextField(
                    hintText: tr(context).account,
                    controller: _textController,
                    validator: (value) {
                      accountListStore.validateAccountName(value!);
                      if(accountListStore.errorMessage?.isNotEmpty ?? false) {
                        return accountListStore.errorMessage;
                      }else{
                        return null;
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
      bottomSection: Observer(
          builder: (_) => SizedBox(
                width: 250,
                child: LoadingPrimaryButton(
                  onPressed: () async {
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    }

                    if (widget.account != null) {
                      await accountListStore.renameAccount(
                          index: widget.account!.id,
                          label: _textController.text);
                    } else {
                      await accountListStore.addAccount(
                          label: _textController.text);
                    }
                    Navigator.of(context).pop(_textController.text);
                  },
                  text: widget.account != null
                      ? tr(context).rename
                      : tr(context).add,
                  color: Color.fromARGB(255,46, 160, 33),//Theme.of(context).primaryTextTheme.button?.backgroundColor!,
                  borderColor: Color.fromARGB(255,46, 160, 33),//Theme.of(context).primaryTextTheme.button!?.backgroundColor!,
                  isLoading: accountListStore.isAccountCreating,
                ),
              )),
    );
  }
}
