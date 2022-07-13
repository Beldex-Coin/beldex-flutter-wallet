import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_coin/beldex_coin_structs.dart';
import 'package:beldex_coin/stake.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/wallet/crypto_amount_format.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_amount_format.dart';
import 'package:beldex_wallet/src/widgets/nav/nav_list_header.dart';
import 'package:beldex_wallet/src/widgets/nav/nav_list_trailing.dart';
import 'package:beldex_wallet/src/widgets/beldex_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

extension StakeParsing on StakeRow {
  double get ownedPercentage {
    final percentage = belDexAmountToDouble(amount) / 10000;
    if (percentage > 1) return 1;
    return percentage;
  }
}

class StakePage extends BasePage {
  final _bodyKey = GlobalKey();

  @override
  Widget leading(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 12.0, left: 10),
        decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(10),
            //color: Colors.black,
            ),
        child: SvgPicture.asset('assets/images/beldex_logo_foreground1.svg'));
  }

  @override
  Widget body(BuildContext context) => StakePageBody(key: _bodyKey);
}

class StakePageBody extends StatefulWidget {
  StakePageBody({Key key}) : super(key: key);

  @override
  StakePageBodyState createState() => StakePageBodyState();
}

class StakePageBodyState extends State<StakePageBody> {
  void _launchUrl(String url) async {
    print('call _launchURL');
    if (await canLaunch(url)) await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder<List<StakeRow>>(
      future: getAllStakes(),
      builder: (BuildContext context, AsyncSnapshot<List<StakeRow>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Container(
                  width: 200,
                  height: 400,
                  child: Center(
                    child: Text(snapshot.error.toString()),
                  )),
            );
          }
          final allStakes = snapshot.data;
          final stakeColor = allStakes.isEmpty
              ? Theme.of(context).primaryTextTheme.button.backgroundColor
              : Theme.of(context).accentTextTheme.caption.decorationColor;
          var totalAmountStaked = 0;
          for (final stake in allStakes) {
            totalAmountStaked += stake.amount;
          }
          final stakePercentage = allStakes.isEmpty
              ? 1.0
              : min(belDexAmountToDouble(totalAmountStaked) / 10000, 1.0);
          return ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 220.0,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          strokeWidth: 15,
                          value: stakePercentage,
                          valueColor: AlwaysStoppedAnimation<Color>(stakeColor),
                        ),
                      ),
                    ),
                    Center(
                        child: Text(allStakes.isNotEmpty
                            ? belDexAmountToString(totalAmountStaked,
                                detail: AmountDetail.none)
                            : S.current.nothing_staked)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_circle_up_outlined,
                        size: 40,
                      ),
                      //Icon(Icons.arrow_upward_rounded,size: 40,),
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(Routes.newStake),
                    ),
                    Text(allStakes.isEmpty
                        ? S.current.start_staking
                        : S.current.stake_more)
                  ],
                ),
              ),
              if (allStakes.isNotEmpty)
                NavListHeader(title: S.current.your_contributions),
              if (allStakes.isNotEmpty)
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: allStakes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final stake = allStakes[index];
                      print('Contributors $index --> ');
                      final masterNodeKey = stake.masterNodeKey;
                      final nodeName =
                          '${masterNodeKey.substring(0, 12)}...${masterNodeKey.substring(masterNodeKey.length - 4)}';

                      return Dismissible(
                          key: Key(stake.masterNodeKey),
                          confirmDismiss: (direction) async {
                            if (!canRequestUnstake(stake.masterNodeKey)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text(S.of(context).unable_unlock_stake),
                                backgroundColor: Colors.red,
                              ));
                              /*Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(S.of(context).unable_unlock_stake),
                                  backgroundColor: Colors.red,
                                ));*/
                              return false;
                            }
                            var isSuccessful = false;
                            var isAuthenticated = false;

                            await Navigator.of(context).pushNamed(Routes.auth,
                                arguments: (bool isAuthenticatedSuccessfully,
                                    AuthPageState auth) async {
                              if (isAuthenticatedSuccessfully) {
                                isAuthenticated = true;
                                Navigator.of(auth.context).pop();
                              }
                            });

                            if (isAuthenticated) {
                              await showConfirmBeldexDialog(
                                  context,
                                  S.of(context).title_confirm_unlock_stake,
                                  S.of(context).body_confirm_unlock_stake(
                                      stake.masterNodeKey),
                                  onDismiss: (buildContext) {
                                isSuccessful = false;
                                Navigator.of(buildContext).pop();
                              }, onConfirm: (buildContext) {
                                isSuccessful = true;
                                Navigator.of(buildContext).pop();
                              });
                            }

                            return isSuccessful;
                          },
                          onDismissed: (direction) async {
                            await submitStakeUnlock(stake.masterNodeKey);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(S.of(context).unlock_stake_requested),
                              backgroundColor: Colors.green,
                            ));
                            /*Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(S.of(context).unlock_stake_requested),
                                backgroundColor: Colors.green,
                              ));*/
                          },
                          direction: DismissDirection.endToStart,
                          background: Container(
                              color: BeldexPalette.red,
                              padding: EdgeInsets.only(right: 10.0),
                              alignment: AlignmentDirectional.centerEnd,
                              //color: BeldexPalette.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.arrow_downward_sharp,
                                    color: Colors.white,
                                  )
                                ],
                              )),
                          child: InkWell(
                            onTap: () {
                              final url =
                                  'https://explorer.beldex.io/mn/$masterNodeKey';
                              _launchUrl(url);
                            },
                            child: NavListTrailing(
                              leading: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          stakeColor),
                                      value: stake.ownedPercentage),
                                  Text('${index + 1}'),
                                ],
                              ),
                              text: nodeName,
                            ),
                          ));
                    }),
            ],
          );
        } else {
          return Center(
            child: Container(
                width: 200,
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context)
                        .primaryTextTheme
                        .button
                        .backgroundColor),
                    backgroundColor: Theme.of(context)
                        .accentTextTheme
                        .caption
                        .decorationColor,
                  ),
                )),
          );
        }
      },
    ));
  }
}
