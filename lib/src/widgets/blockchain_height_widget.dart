import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/wallet/beldex/get_height_by_date.dart';
import 'package:provider/provider.dart';
import 'nospaceformatter.dart';

class BlockchainHeightWidget extends StatefulWidget {
  BlockchainHeightWidget({GlobalKey? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BlockchainHeightState();
}

class BlockchainHeightState extends State<BlockchainHeightWidget> {
  final dateController = TextEditingController();
  final restoreHeightController = TextEditingController();
  int get height => _height;
  int _height = 0;
  bool isRestoreByHeight = true;
  @override
  void initState() {
    restoreHeightController.addListener(() => _height =
    restoreHeightController.text.isNotEmpty
            ? int.parse(restoreHeightController.text)
            : 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      
      isRestoreByHeight ?  Row(
          children: <Widget>[
            Flexible(
                child: Card(
                  elevation:0,
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  margin: EdgeInsets.only(top: 20.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 30,top:5,bottom: 5),
              child: TextFormField(
                style: TextStyle(backgroundColor: Colors.transparent,fontSize: 14.0),
                  controller: restoreHeightController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly,NoSpaceFormatter(),FilteringTextInputFormatter.deny(RegExp('[-,. ]'))],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                      hintStyle: TextStyle(color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)),
                      hintText: tr(context).widgets_restore_from_blockheight,),
                              validator: (value){
                                 final pattern = RegExp(r'^(?!.*\s)\d+$');
                                 if(!pattern.hasMatch(value!)){
                                   return tr(context).enterValidHeightWithoutSpace;
                                 }else{
                                  return null;
                                 }
                              },
              ),
            ),
                ))
          ],
        ):
        Row(
          children: <Widget>[
            Flexible(
                child: Card(
                  elevation:0,
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  margin: EdgeInsets.only(top: 20.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 30,top:5,bottom:5,right:10),
              child: InkWell(
                  onTap: () => selectDate(context,settingsStore),
                  child: IgnorePointer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 130,
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: TextStyle(backgroundColor: Colors.transparent,fontSize: 14.0),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                                hintStyle:
                                    TextStyle(color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)),
                                hintText: tr(context).widgets_restore_from_date,),
                            controller: dateController,
                            validator: (value) {
                              if(value?.isEmpty ?? false){
                                return tr(context).dateShouldNotBeEmpty;
                              }else{
                               return null;
                              }
                            },
                          ),
                        ),
                        Icon(Icons.calendar_today,color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xffB5B5C1))
                      ],
                    ),
                  ),
              ),
            ),
                ))
          ],
        ),
      SizedBox(height: 20,),
      Center(
        child: InkWell(
          onTap: (){
            setState(() {
                    isRestoreByHeight = isRestoreByHeight ? false:true;
                        });
          },
          child: Container(
            height:50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:Color(0xff2979FB),
              borderRadius: BorderRadius.circular(10)
            ),
            child:Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(isRestoreByHeight ? tr(context).widgets_restore_from_date : tr(context).widgets_restore_from_blockheight,style:TextStyle( color:Color(0xffffffff),fontSize:14,fontWeight:FontWeight.bold)),
                Icon(Icons.arrow_right_alt_rounded,color: Color(0xffffffff),)
              ],
            )
          ),
        ),
      )
      ],
    );
  }

  Future selectDate(BuildContext context, SettingsStore settingsStore) async {
    final now = DateTime.now();
    final date = await showDatePicker(
        builder: (context, child){
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Color(0xff0BA70F),
                  onPrimary: Colors.white, // titles and
                  onSurface: settingsStore.isDarkTheme ? Colors.white : Colors.black, // Month days , years
                ),
                datePickerTheme: DatePickerThemeData(
                    backgroundColor: Theme.of(context).dialogBackgroundColor,
                    cancelButtonStyle: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Color(0xff0BA70F)),
                    ),
                    confirmButtonStyle: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(Color(0xff0BA70F))
                    ),
                    todayForegroundColor: WidgetStateProperty.all(settingsStore.isDarkTheme ? Colors.white : Colors.black),
                    todayBorder: BorderSide(
                      color: Color(0xff0BA70F),
                    )
                )
            ),
            child: child ?? SizedBox(),
          );
        },
        initialEntryMode:DatePickerEntryMode.calendarOnly,
        context: context,
        initialDate: now.subtract(Duration(days: 1)),
        firstDate: DateTime(2014, DateTime.april),
        lastDate: now);

    if (date != null) {
      setState(() {
              
            });
      final height = getHeightByDate(date: date);

      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(date);
        restoreHeightController.text = '$height';
        _height = height;
      });
    }
  }
}
