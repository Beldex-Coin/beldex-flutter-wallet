import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/nodes/node_indicator.dart';
import 'package:beldex_wallet/src/stores/node_list/node_list_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/beldex_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/util/constants.dart' as constants;

class NodeListPage extends BasePage {
  NodeListPage();

  @override
  String get title => S.current.nodes;

  @override
  Widget leading(context) {
    final nodeList = Provider.of<NodeListStore>(context);
    final settings = Provider.of<SettingsStore>(context);

    return Padding(
      padding: const EdgeInsets.only(top:20.0,bottom: 5,left: 10),
      child: Container(
       margin: EdgeInsets.only(top: 7,bottom:7,),
       // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.shadowColor,//Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: ButtonTheme(
          minWidth: double.minPositive,
          child: FlatButton(
              onPressed: () async {
                await showConfirmBeldexDialog(
                    context,
                    S.of(context).node_reset_settings_title,
                    S.of(context).nodes_list_reset_to_default_message,
                    onFutureConfirm: (context) async {
                  Navigator.pop(context);
                  await nodeList.reset();
                  await settings.setCurrentNodeToDefault();
                  return true;
                });
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              padding: EdgeInsets.all(0),
              child: Text(
                S.of(context).reset,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Theme.of(context).accentTextTheme.caption.decorationColor),
              )),
        ),
      ),
    );
  }

 /* @override
  Widget leading(context) {
    final nodeList = Provider.of<NodeListStore>(context);
    final settings = Provider.of<SettingsStore>(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ButtonTheme(
          minWidth: double.minPositive,
          buttonColor: Colors.black,
          child: FlatButton(
              onPressed: () async {
                await showConfirmBeldexDialog(
                    context,
                    S.of(context).node_reset_settings_title,
                    S.of(context).nodes_list_reset_to_default_message,
                    onFutureConfirm: (context) async {
                      Navigator.pop(context);
                      await nodeList.reset();
                      await settings.setCurrentNodeToDefault();
                      return true;
                    });
              },
              child: Text(
                S.of(context).reset,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryTextTheme.subtitle2.color),
              )),
        ),
        *//*Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).selectedRowColor),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(Icons.add, color: BeldexPalette.teal, size: 22.0),
                ButtonTheme(
                  minWidth: 28.0,
                  height: 28.0,
                  child: FlatButton(
                      shape: CircleBorder(),
                      onPressed: () async =>
                          await Navigator.of(context).pushNamed(Routes.newNode),
                      child: Offstage()),
                )
              ],
            )),*//*
      ],
    );
  }*/

  @override
  Widget body(context) => NodeListPageBody();
}

class NodeListPageBody extends StatefulWidget {
  @override
  NodeListPageBodyState createState() => NodeListPageBodyState();
}

class NodeListPageBodyState extends State<NodeListPageBody> {
  @override
  Widget build(BuildContext context) {
    final nodeList = Provider.of<NodeListStore>(context);
    final settings = Provider.of<SettingsStore>(context);

    final currentColor = Theme.of(context).selectedRowColor;
    final notCurrentColor = Theme.of(context).backgroundColor;

    return Container(
      padding: EdgeInsets.only(top:10.0,bottom: 20.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                width: 28.0,
                height: 28.0,
                margin: EdgeInsets.only(right: 25),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SvgPicture.asset('assets/images/add.svg',color: Theme.of(context).accentTextTheme.caption.decorationColor,),
                    ButtonTheme(
                      minWidth: 28.0,
                      height: 28.0,
                      child: FlatButton(
                          color: Colors.transparent,
                          onPressed: () async =>
                          await Navigator.of(context).pushNamed(Routes.newNode),
                          child: Offstage()),
                    )
                  ],
                )),
          ),
          SizedBox(height: 10,),
          Expanded(child: Observer(builder: (context) {
            return ListView.builder(
                itemCount: nodeList.nodes.length,
                itemBuilder: (BuildContext context, int index) {
                  final node = nodeList.nodes[index];

                  return Observer(builder: (_) {
                    final isCurrent = settings.node == null
                        ? false
                        : node.key == settings.node.key;

                    final content = Card(
                        margin: EdgeInsets.only(left: constants.leftPx,right: constants.rightPx,top: 20),
                        elevation: 2,
                        color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:Container(
                       // color: isCurrent ? currentColor : notCurrentColor,
                        child: ListTile(
                          title: Text(
                            node.uri,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6
                                    .color),
                          ),
                          trailing: FutureBuilder(
                              future: nodeList.isNodeOnline(node),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.done:
                                    return NodeIndicator(
                                        active: snapshot.data as bool);
                                  default:
                                    return NodeIndicator();
                                }
                              }),
                          onTap: () async {
                            if (!isCurrent) {
                              await showSimpleBeldexDialog(context, '',
                                  S.of(context).change_current_node(node.uri),
                                  onPressed: (context) async {
                                Navigator.of(context).pop();
                                await settings.setCurrentNode(node: node);
                              });
                            }
                          },
                        )));

                    return isCurrent
                        ? content
                        : Dismissible(
                            key: Key('${node.key}'),
                            confirmDismiss: (direction) async {
                              var result = false;
                              await showConfirmBeldexDialog(
                                  context,
                                  S.of(context).remove_node,
                                  S.of(context).remove_node_message,
                                  onDismiss: (context) =>
                                      Navigator.pop(context, false),
                                  onConfirm: (context) {
                                    result = true;
                                    Navigator.pop(context, true);
                                    return true;
                                  });
                              return result;
                            },
                            onDismissed: (direction) async =>
                                await nodeList.remove(node: node),
                            direction: DismissDirection.endToStart,
                            background: Container(
                                padding: EdgeInsets.only(right: 10.0),
                                alignment: AlignmentDirectional.centerEnd,
                                color: BeldexPalette.red,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      S.of(context).delete,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                )),
                            child: content);
                  });
                });
          }))
        ],
      ),
    );
  }
}
