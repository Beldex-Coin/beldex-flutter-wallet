import 'dart:ui';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:provider/provider.dart';

Future showBeldexDialog(BuildContext context, Widget child,
    {required void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => BeldexDialog(body: child, onDismiss: onDismiss),
      context: context);
}

Future showSimpleBeldexDialog(BuildContext context, String title, String body,
    {bool status = false,
    String? buttonText,
    required void Function(BuildContext context) onPressed,
    void Function(BuildContext context)? onDismiss}) {
  return showDialog<void>(
      builder: (_) => SimpleBeldexDialog(
            title,
            body,
            buttonText: buttonText!,
            onDismiss: onDismiss!,
            onPressed: onPressed,
            status: status,
          ),
      context: context);
}

Future showDialogForResetNode(
    BuildContext context, String title, String body, String fee, String address,
    {String? buttonText,
    required void Function(BuildContext context) onPressed,
    void Function(BuildContext context)? onDismiss}) {
  return showDialog<void>(
      builder: (_) => ShowResetNodeDialog(title, body, fee, address,
          buttonText: buttonText!, onDismiss: onDismiss!, onPressed: onPressed),
      context: context);
}

class ShowResetNodeDialog extends StatefulWidget {
  const ShowResetNodeDialog(
    this.title,
    this.body,
    this.fee,
    this.address, {
    this.buttonText,
    this.onPressed,
    this.onDismiss,
  }); // : super(key: key);

  final String title;
  final String body;
  final String fee;
  final String address;
  final String? buttonText;
  final void Function(BuildContext context)? onPressed;
  final void Function(BuildContext context)? onDismiss;

  @override
  _ShowResetNodeDialogState createState() => _ShowResetNodeDialogState();
}

class _ShowResetNodeDialogState extends State<ShowResetNodeDialog> {
  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text('${widget.title}',
              style: TextStyle(backgroundColor: Colors.transparent,fontWeight: FontWeight.w800))),
      backgroundColor:
          settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.body,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () => widget.onDismiss!(context),
                  style: ElevatedButton.styleFrom(
                    primary: settingsStore.isDarkTheme
                        ? Color(0xff383848)
                        : Color(0xffE8E8E8),
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(tr(context).cancel,
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
                          color: settingsStore.isDarkTheme
                              ? Color(0xff93939B)
                              : Color(0xff16161D),
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () => widget.onPressed!(context),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff0BA70F),
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    tr(context).ok,
                    style: TextStyle(
                        backgroundColor: Colors.transparent,
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future showConfirmBeldexDialog(BuildContext context, String title, String body,
    {void Function(BuildContext context)? onConfirm,
    Future Function(BuildContext context)? onFutureConfirm,
    void Function(BuildContext context)? onDismiss}) {
  return showDialog<void>(
      builder: (_) => ConfirmBeldexDialog(title, body,
          onDismiss: onDismiss!,
          onConfirm: onConfirm!,
          onFutureConfirm: onFutureConfirm!),
      context: context);
}

class BeldexDialog extends StatelessWidget {
  BeldexDialog({
    this.body,
    this.onDismiss,
  });

  final void Function(BuildContext context)? onDismiss;
  final Widget? body;

  void _onDismiss(BuildContext context) {
    if (onDismiss == null) {
      Navigator.of(context).pop();
    } else {
      onDismiss!(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onDismiss(context),
      child: Container(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            padding: EdgeInsets.all(15),
            decoration:
                BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SimpleBeldexDialog extends StatelessWidget {
  SimpleBeldexDialog(this.title, this.body,
      {this.buttonText, this.onPressed, this.onDismiss, required this.status});

  final String title;
  final String body;
  final String? buttonText;
  final bool status;
  final void Function(BuildContext context)? onPressed;
  final void Function(BuildContext context)? onDismiss;

  @override
  Widget build(BuildContext context) {
    return BeldexDialog(
        onDismiss: onDismiss,
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              status
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.none,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .caption!
                                  .color))),
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(body,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: 15,
                          decoration: TextDecoration.none,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .caption!
                              .color))),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: PrimaryButton(
                    text: buttonText ?? tr(context).ok,
                    color: Theme.of(context).primaryTextTheme.button?.backgroundColor,
                    borderColor: Theme.of(context).primaryTextTheme.button?.backgroundColor,
                    onPressed: () {
                      if (onPressed != null) onPressed!(context);
                    }),
              )
            ],
          ),
        ));
  }
}

class ConfirmBeldexDialog extends StatelessWidget {
  ConfirmBeldexDialog(this.title, this.body,
      {this.onFutureConfirm, this.onConfirm, this.onDismiss});

  final String title;
  final String body;
  final Future Function(BuildContext context)? onFutureConfirm;
  final void Function(BuildContext context)? onConfirm;
  final void Function(BuildContext context)? onDismiss;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return BeldexDialog(
        onDismiss: onDismiss,
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.none,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .caption!
                              .color))),
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(body,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: 15,
                          decoration: TextDecoration.none,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .caption!
                              .color))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () =>
                          onDismiss != null ? onDismiss!(context) : null,
                      style: ElevatedButton.styleFrom(
                        primary: settingsStore.isDarkTheme
                            ? Color(0xff383848)
                            : Color(0xffE8E8E8),
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        tr(context).cancel,
                        style: TextStyle(
                            backgroundColor: Colors.transparent,
                            decoration: TextDecoration.none,
                            color: settingsStore.isDarkTheme
                                ? Color(0xff93939B)
                                : Color(0xff222222),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () =>
                          onConfirm != null ? onConfirm!(context) : null,
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff0BA70F),
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        tr(context).ok,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
