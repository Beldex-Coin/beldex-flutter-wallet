import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:date_range_picker/date_range_picker.dart' as date_rage_picker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';

//import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/balance_display_mode.dart';

//import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/dashboard/date_section_row.dart';
import 'package:beldex_wallet/src/screens/dashboard/transaction_row.dart';
import 'package:beldex_wallet/src/screens/dashboard/wallet_menu.dart';
import 'package:beldex_wallet/src/stores/action_list/action_list_store.dart';
import 'package:beldex_wallet/src/stores/action_list/date_section_item.dart';
import 'package:beldex_wallet/src/stores/action_list/transaction_list_item.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:beldex_wallet/src/widgets/picker.dart';
import 'package:provider/provider.dart';

import '../../../palette.dart';

class TransactionDetailsList extends BasePage {
  final _bodyKey = GlobalKey();

  @override
  Widget leading(BuildContext context) {
    return InkWell(
      onTap:() {
        _presentWalletMenu(context);
      },
      child: Container(
        height: 20,
          padding: EdgeInsets.only(top: 12.0,bottom: 10),
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(10),
              //color: Colors.black,
              ),
          child: SvgPicture.asset('assets/images/new-images/refresh.svg',color: Theme.of(context).primaryTextTheme.caption.color,)
          // Icon(Icons.autorenew_outlined,color: Theme.of(context).primaryTextTheme.caption.color,
          // )
          ),
    );
  }
  @override
  Widget middle(BuildContext context) {
    //final walletStore = Provider.of<WalletStore>(context);
  final walletStore = Provider.of<WalletStore>(context);
    return Text(walletStore.name,style: TextStyle(fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryTextTheme
                                                      .headline6
                                                      .color ),); //Image.asset('assets/images/title_with_logo.png', height: 134, width: 160);
  }

  @override
  Widget trailing(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.centerLeft,
      // decoration: BoxDecoration(
      //   color: Theme.of(context).accentTextTheme.headline6.color,
      //   borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Theme.of(context).accentTextTheme.headline6.color,
      //       blurRadius: 2.0,
      //       spreadRadius: 1.0,
      //       offset: Offset(2.0, 2.0), // shadow direction: bottom right
      //     )
      //   ],
      // ),
      child: SizedBox(
        height: 55, //55
        width: 55, //37
        child: ButtonTheme(
          minWidth: double.minPositive,
          child: TextButton(
              /* highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              padding: EdgeInsets.all(0),*/
              style: ButtonStyle(
                overlayColor:
                    MaterialStateColor.resolveWith((states) => Colors.transparent),
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.profile),
              child:
               SvgPicture.asset(
                'assets/images/new-images/setting.svg',
                fit: BoxFit.cover,
                color: settingsStore.isDarkTheme ? Colors.white : Colors.black,
                width: 25,
                height: 25,
              ) /*Icon(Icons.account_circle_rounded,
                  color: Theme.of(context).primaryTextTheme.caption.color,
                  size: 30)*/
              ),
        ),
      ),
    );
  }

  /*@override
  Widget trailing(BuildContext context) {
    return SizedBox(
      width: 30,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () => Navigator.of(context).pushNamed(Routes.profile),
          child: Icon(Icons.account_circle_rounded,
              color: Theme.of(context).primaryTextTheme.caption.color,
              size: 30)),
    );
  }*/

  @override
  Widget body(BuildContext context) => TransactionDetailsListBody(key: _bodyKey);

  void _presentWalletMenu(BuildContext bodyContext) {
    final walletMenu = WalletMenu(bodyContext);

    showDialog<void>(
     // barrierColor: Color(0xff),
        builder: (_) => Picker(
            items: walletMenu.items,
            selectedAtIndex: -1,
            title: S.of(bodyContext).wallet_menu,
            pickerHeight: 250,
            onItemSelected: (String item) =>
                walletMenu.action(walletMenu.items.indexOf(item))),
        context: bodyContext);
  }
}

class TransactionDetailsListBody extends StatefulWidget {
 TransactionDetailsListBody({Key key}) : super(key: key);

  @override
  TransactionDetailsListBodyState createState() => TransactionDetailsListBodyState();
}

class TransactionDetailsListBodyState extends State<TransactionDetailsListBody> {
  final _connectionStatusObserverKey = GlobalKey();
  final _balanceObserverKey = GlobalKey();
  final _balanceTitleObserverKey = GlobalKey();
  final _syncingObserverKey = GlobalKey();
  final _listObserverKey = GlobalKey();
  final _listKey = GlobalKey();
  final _sendbuttonEnableKey = GlobalKey();
  String syncStatus;

  //
  // List<Item> transactions = [
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 99.00',
  //       color: Colors.red),
  //   Item(
  //       id: 'receive',
  //       icon: Icons.arrow_downward,
  //       text: '25.01.2021',
  //       amount: '+\$ 105.00',
  //       color: Colors.green),
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 105.00',
  //       color: Colors.red),
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 105.00',
  //       color: Colors.red),
  //   Item(
  //       id: 'receive',
  //       icon: Icons.arrow_downward,
  //       text: '20.01.2021',
  //       amount: '+\$ 60.00',
  //       color: Colors.green),
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 105.00',
  //       color: Colors.red),
  //   Item(
  //       id: 'receive',
  //       icon: Icons.arrow_downward,
  //       text: '20.01.2021',
  //       amount: '+\$ 60.00',
  //       color: Colors.green),
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 105.00',
  //       color: Colors.red),
  //   Item(
  //       id: 'receive',
  //       icon: Icons.arrow_downward,
  //       text: '20.01.2021',
  //       amount: '+\$ 60.00',
  //       color: Colors.green),
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 105.00',
  //       color: Colors.red)
  // ];

  IconData iconDataVal = Icons.arrow_upward_outlined;

  @override
  Widget build(BuildContext context) {
    //
    final walletStore = Provider.of<WalletStore>(context);

    final balanceStore = Provider.of<BalanceStore>(context);
    final actionListStore = Provider.of<ActionListStore>(context);
    final syncStore = Provider.of<SyncStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final transactionDateFormat = settingsStore.getCurrentDateFormat(
        formatUSA: 'MMMM d, yyyy, HH:mm', formatDefault: 'd MMMM yyyy, HH:mm');
    print('Called');
    return Observer(
        key: _listObserverKey,
        builder: (_) {
          final items = actionListStore.items ?? <String>[];
          final itemsCount = items.length + 2;
          return Scaffold(
            backgroundColor: settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
            appBar: AppBar( 
              elevation: 0, 
              backgroundColor: settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
              leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Icon(Icons.arrow_back,color: settingsStore.isDarkTheme ? Colors.white:Colors.black,)),
              centerTitle: true,
              title: Text(
                                    S.of(context).transactions_text,
                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
                                  ),
              actions: [
                Container(
                  
                  //margin: EdgeInsets.only(right:MediaQuery.of(context).size.height*0.09/3),
                  child: Container(
                      margin: EdgeInsets.only(left:15,right:0,bottom: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        //color: Colors.yellow,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // Divider(
                          //   height: 10,
                          // ),
                          Padding(
                            padding:
                                EdgeInsets.only(right: 20, top: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // Text(
                                  //   S.of(context).transactions_text,
                                  //   style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
                                  // ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                        accentColor: Colors.green,
                                        primaryColor: Colors.blue,
                                        
                                        backgroundColor: settingsStore.isDarkTheme ? Color(0xff292935):Color(0xffffffff)),
                                    child: Builder(
                                      builder: (context) => PopupMenuButton<int>(
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                              enabled: false,
                                              value: -1,
                                              child: Text('Filter by',// S.of(context).transactions,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryTextTheme
                                                          .caption
                                                          .color))),
                                          PopupMenuItem(
                                              value: 0,
                                              child: Observer(
                                                  builder: (_) => Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(S
                                                            .of(context)
                                                            .incoming),
                                                        Theme(
                                                          data: Theme.of(context).copyWith(accentColor: Colors.green,checkboxTheme: CheckboxThemeData(fillColor:MaterialStateProperty.all(Colors.green),checkColor: MaterialStateProperty.all(Colors.white),)),
                                                          child: Checkbox(
                                                            value: actionListStore
                                                                .transactionFilterStore
                                                                .displayIncoming,
                                                            onChanged: (value) =>
                                                                actionListStore
                                                                    .transactionFilterStore
                                                                    .toggleIncoming(),
                                                          ),
                                                        )
                                                      ]))),
                                          PopupMenuItem(
                                              value: 1,
                                              child: Observer(
                                                  builder: (_) => Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(S
                                                            .of(context)
                                                            .outgoing),
                                                        Theme(
                                                          data: Theme.of(context).copyWith(accentColor: Colors.green,checkboxTheme: CheckboxThemeData(fillColor:MaterialStateProperty.all(Colors.green),checkColor: MaterialStateProperty.all(Colors.white),)),
                                                          child: Checkbox(
                                                            value: actionListStore
                                                                .transactionFilterStore
                                                                .displayOutgoing,
                                                            onChanged: (value) =>
                                                                actionListStore
                                                                    .transactionFilterStore
                                                                    .toggleOutgoing(),
                                                          ),
                                                        )
                                                      ]))),
                                          PopupMenuItem(
                                              value: 2,
                                              child: Text(S
                                                  .of(context)
                                                  .transactions_by_date)),
                                        ],
                                        onSelected: (item) async {
                                          print('item length --> $item');
                                          if (item == 2) {
                                            final picked =
                                            await date_rage_picker.showDatePicker(
                                              context: context,
                                              initialFirstDate: DateTime.now()
                                                  .subtract(Duration(days: 1)),
                                              initialLastDate: (DateTime.now()),
                                              firstDate: DateTime(2015),
                                              lastDate: DateTime.now(),
                                                 // .add(Duration(days: 1)), // hide the date
                                                  );

                                            print('picked length --> ${picked.length}');

                                            if (picked != null &&
                                                picked.length == 2) {
                                              actionListStore.transactionFilterStore
                                                  .changeStartDate(picked.first);
                                              actionListStore.transactionFilterStore
                                                  .changeEndDate(picked.last);
                                            }
                                          }
                                        },
                                        child: SvgPicture.asset('assets/images/new-images/filter.svg',width:18,height:18,color: Theme.of(context).primaryTextTheme.caption.color,)/*Text(S.of(context).filters,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context)
                                                    .primaryTextTheme
                                                    .subtitle2
                                                    .color))*/,
                                      )
                                    ),
                                  )

                                ]),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            body: ListView.builder(
                key: _listKey,
                padding: EdgeInsets.only(bottom: 15),
                itemCount: itemsCount,
                itemBuilder: (context, index) {
                  
                if(index==0){
                  return Container();
                }








                  if (index == 1 && actionListStore.totalCount > 0) {
                    return Container();
                    // return Container(
                    //   margin: EdgeInsets.only(left:15,right:0,bottom: 15.0),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10.0),
                    //     //color: Colors.yellow,
                    //   ),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       // SizedBox(
                    //       //   height: 5,
                    //       // ),
                    //       // Divider(
                    //       //   height: 10,
                    //       // ),
                    //       Padding(
                    //         padding:
                    //             EdgeInsets.only(right: 20, top: 10),
                    //         child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: <Widget>[
                    //               Text(
                    //                 S.of(context).transactions_text,
                    //                 style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
                    //               ),
                    //               Theme(
                    //                 data: Theme.of(context).copyWith(
                    //                     accentColor: Colors.green,
                    //                     primaryColor: Colors.blue,
                                        
                    //                     backgroundColor: settingsStore.isDarkTheme ? Color(0xff292935):Color(0xffffffff)),
                    //                 child: Builder(
                    //                   builder: (context) => PopupMenuButton<int>(
                    //                     itemBuilder: (context) => [
                    //                       PopupMenuItem(
                    //                           enabled: false,
                    //                           value: -1,
                    //                           child: Text('Filter by',// S.of(context).transactions,
                    //                               style: TextStyle(
                    //                                   fontWeight: FontWeight.bold,
                    //                                   color: Theme.of(context)
                    //                                       .primaryTextTheme
                    //                                       .caption
                    //                                       .color))),
                    //                       PopupMenuItem(
                    //                           value: 0,
                    //                           child: Observer(
                    //                               builder: (_) => Row(
                    //                                   mainAxisAlignment:
                    //                                   MainAxisAlignment
                    //                                       .spaceBetween,
                    //                                   children: [
                    //                                     Text(S
                    //                                         .of(context)
                    //                                         .incoming),
                    //                                     Theme(
                    //                                       data: Theme.of(context).copyWith(accentColor: Colors.green,checkboxTheme: CheckboxThemeData(fillColor:MaterialStateProperty.all(Colors.green),checkColor: MaterialStateProperty.all(Colors.white),)),
                    //                                       child: Checkbox(
                    //                                         value: actionListStore
                    //                                             .transactionFilterStore
                    //                                             .displayIncoming,
                    //                                         onChanged: (value) =>
                    //                                             actionListStore
                    //                                                 .transactionFilterStore
                    //                                                 .toggleIncoming(),
                    //                                       ),
                    //                                     )
                    //                                   ]))),
                    //                       PopupMenuItem(
                    //                           value: 1,
                    //                           child: Observer(
                    //                               builder: (_) => Row(
                    //                                   mainAxisAlignment:
                    //                                   MainAxisAlignment
                    //                                       .spaceBetween,
                    //                                   children: [
                    //                                     Text(S
                    //                                         .of(context)
                    //                                         .outgoing),
                    //                                     Theme(
                    //                                       data: Theme.of(context).copyWith(accentColor: Colors.green,checkboxTheme: CheckboxThemeData(fillColor:MaterialStateProperty.all(Colors.green),checkColor: MaterialStateProperty.all(Colors.white),)),
                    //                                       child: Checkbox(
                    //                                         value: actionListStore
                    //                                             .transactionFilterStore
                    //                                             .displayOutgoing,
                    //                                         onChanged: (value) =>
                    //                                             actionListStore
                    //                                                 .transactionFilterStore
                    //                                                 .toggleOutgoing(),
                    //                                       ),
                    //                                     )
                    //                                   ]))),
                    //                       PopupMenuItem(
                    //                           value: 2,
                    //                           child: Text(S
                    //                               .of(context)
                    //                               .transactions_by_date)),
                    //                     ],
                    //                     onSelected: (item) async {
                    //                       print('item length --> $item');
                    //                       if (item == 2) {
                    //                         final picked =
                    //                         await date_rage_picker.showDatePicker(
                    //                           context: context,
                    //                           initialFirstDate: DateTime.now()
                    //                               .subtract(Duration(days: 1)),
                    //                           initialLastDate: (DateTime.now()),
                    //                           firstDate: DateTime(2015),
                    //                           lastDate: DateTime.now()
                    //                               .add(Duration(days: 1)),);

                    //                         print('picked length --> ${picked.length}');

                    //                         if (picked != null &&
                    //                             picked.length == 2) {
                    //                           actionListStore.transactionFilterStore
                    //                               .changeStartDate(picked.first);
                    //                           actionListStore.transactionFilterStore
                    //                               .changeEndDate(picked.last);
                    //                         }
                    //                       }
                    //                     },
                    //                     child: SvgPicture.asset('assets/images/new-images/filter.svg',width:18,height:18,color: Theme.of(context).primaryTextTheme.caption.color,)/*Text(S.of(context).filters,
                    //                         style: TextStyle(
                    //                             fontSize: 16.0,
                    //                             color: Theme.of(context)
                    //                                 .primaryTextTheme
                    //                                 .subtitle2
                    //                                 .color))*/,
                    //                   )
                    //                 ),
                    //               )

                    //             ]),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }

                  index -= 2;

                  if (index < 0 || index >= items.length) {
                     return  Container(
                height:MediaQuery.of(context).size.height*1.38/3,
                margin: EdgeInsets.only(top:8.0,bottom:10.0,right:15.0,left:15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                color: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED), //Color(0xff24242F),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    settingsStore.isDarkTheme ?
                    SvgPicture.asset('assets/images/new-images/notrans_black.svg'):
                    SvgPicture.asset('assets/images/new-images/notrans_white.svg'),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                      child: Text(S.of(context).no_trans_yet,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16.0),),
                    ),
                    Text('After your first transaction,\n you will be able to view it here.',textAlign: TextAlign.center,style: TextStyle(color:Color(0xff82828D)),),
                   ],
                  ),
              );
                   
                  }

                  final item = items[index];
                
             
              //   if(item is TransactionListItem){
              //      final transaction = item.transaction;
              //       final savedDisplayMode =
              //           settingsStore.balanceDisplayMode;
              //       final formattedAmount =
              //           savedDisplayMode == BalanceDisplayMode.hiddenBalance
              //               ? '---'
              //               : transaction.amountFormatted();
              //       final formattedFiatAmount =
              //           savedDisplayMode == BalanceDisplayMode.hiddenBalance
              //               ? '---'
              //               : transaction.fiatAmount();
                
                


              // return  Container(
              //        decoration: BoxDecoration(
              //       borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0,),topRight: Radius.circular(8.0,)),
              //       color: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED)
              //     ),
              //      child:Column(
              //       children: [
              //         //Text('sample'),
              //         if(item is DateSectionItem) DateSectionRow(date:item.date),
              //         if(item is TransactionListItem)
                         
              //            TransactionRow(
              //           onTap: () => Navigator.of(context).pushNamed(
              //               Routes.transactionDetails,
              //               arguments: transaction),
              //           direction: transaction.direction,
              //           formattedDate:
              //               transactionDateFormat.format(transaction.date),
              //           formattedAmount: formattedAmount,
              //           formattedFiatAmount: formattedFiatAmount,
              //           isPending: transaction.isPending,
              //           //isStake: transaction.isStake,
              //           )
                      
                      
              //       ],
              //      )
              //   );

              //   }



                  if (item is DateSectionItem) {
                    return DateSectionRow(date: item.date,index: index,);
                  }

                  if (item is TransactionListItem) {
                    final transaction = item.transaction;
                    final savedDisplayMode =
                        settingsStore.balanceDisplayMode;
                    final formattedAmount =
                        savedDisplayMode == BalanceDisplayMode.hiddenBalance
                            ? '---'
                            : transaction.amountFormatted();
                    final formattedFiatAmount =
                        savedDisplayMode == BalanceDisplayMode.hiddenBalance
                            ? '---'
                            : transaction.fiatAmount();

                    return TransactionRow(
                        onTap: () => Navigator.of(context).pushNamed(
                            Routes.transactionDetails,
                            arguments: transaction),
                        direction: transaction.direction,
                        formattedDate:
                            transactionDateFormat.format(transaction.date),
                        formattedAmount: formattedAmount,
                        formattedFiatAmount: formattedFiatAmount,
                        isPending: transaction.isPending,
                        transaction: transaction,
                        //isStake: transaction.isStake,
                        );
                  }

                  return Container();
                }),
          );
        });
  }

  Future<bool> onBackPressed() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final settingsStore = Provider.of<SettingsStore>(context);
          return Dialog(
            elevation: 0,
            backgroundColor:settingsStore.isDarkTheme ? Color(0xff272733):Color(0xffffffff), //Theme.of(context).cardTheme.color,//Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).are_you_sure,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      S.of(context).do_you_want_to_exit_an_app,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 55,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor:settingsStore.isDarkTheme ? Color(0xff333343) : Color(0xffDADADA) //Theme.of(context).cardTheme.shadowColor,
                                //Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                S.of(context).no,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).primaryTextTheme.caption.color,),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor:Color(0xff0BA70F),// Theme.of(context).cardTheme.shadowColor,//Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                S.of(context).yes,
                                style: TextStyle
                                (fontWeight: FontWeight.w800,
                                  color: Colors.white,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class Item {
  Item({this.id, this.icon, this.text, this.amount, this.color});

  String id;
  IconData icon;
  String text;
  String amount;
  Color color;
}
