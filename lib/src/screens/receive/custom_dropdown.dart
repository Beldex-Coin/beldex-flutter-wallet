import 'package:flutter/material.dart';

class ExpandedSection extends StatefulWidget {
  final Widget? child;
  final int? height;
  final bool expand;

  ExpandedSection({this.expand = false, this.child, this.height});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  AnimationController? expandController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController!,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController?.forward();
    } else {
      expandController?.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: animation!,
        child: Container(
        
          padding: EdgeInsets.only(bottom: 5),
          constraints: BoxConstraints(
              //minHeight: 100,
              minWidth: double.infinity,
              maxHeight: widget.height! > 5 ? 195 : widget.height == 1?55:widget.height! * 50.0),
          child: Padding(padding: const EdgeInsets.only(bottom: 5), child: widget.child),
        ));
  }
}

// import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
// import 'package:beldex_wallet/src/stores/subaddress_list/subaddress_list_store.dart';
// import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:provider/provider.dart';

// class CustDropDown<T> extends StatefulWidget {
//   final List<CustDropdownMenuItem> items;
//   final Function onChanged;
//   final String hintText;
//   final double borderRadius;
//   final double maxListHeight;
//   final double borderWidth;
//   final int defaultSelectedIndex;
//   final bool enabled;
//   // final AppModel appModel;

//   const CustDropDown(
//       {@required this.items,
//       @required this.onChanged,
//       this.hintText = "",
//       this.borderRadius = 0,
//       this.borderWidth = 1,
//       this.maxListHeight = 100,
//       this.defaultSelectedIndex = -1,
//       Key key,
//       this.enabled = true,
//       //required this.appModel
//       })
//       : super(key: key);

//   @override
//   _CustDropDownState createState() => _CustDropDownState();
// }

// class _CustDropDownState extends State<CustDropDown>
//     with WidgetsBindingObserver {
//   bool _isOpen = false, _isAnyItemSelected = false, _isReverse = false;
//    OverlayEntry _overlayEntry;
//    RenderBox _renderBox;
//   Widget _itemSelected;
//    Offset dropDownOffset;
//   final LayerLink _layerLink = LayerLink();
//   final _scrollController = ScrollController(initialScrollOffset: 0.0);
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         setState(() {
//           dropDownOffset = getOffset();
//         });
//       }
//       if (widget.defaultSelectedIndex > -1) {
//         if (widget.defaultSelectedIndex < widget.items.length) {
//           if (mounted) {
//             setState(() {
//               _isAnyItemSelected = true;
//               _itemSelected = widget.items[widget.defaultSelectedIndex];
//               widget.onChanged(widget.items[widget.defaultSelectedIndex].value);
//             });
//           }
//         }
//       }
//     });
//     WidgetsBinding.instance.addObserver(this);
//     super.initState();
//   }

//   void _addOverlay() {
//     if (mounted) {
//       setState(() {
//         _isOpen = true;
//       });
//     }

//     _overlayEntry = _createOverlayEntry();
//     Overlay.of(context).insert(_overlayEntry);
//   }

//   void _removeOverlay() {
//     if (mounted) {
//       setState(() {
//         _isOpen = false;
//       });
//       _overlayEntry.remove();
//     }
//   }

//   @override
//   dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   OverlayEntry _createOverlayEntry() {
//     _renderBox = context.findRenderObject() as RenderBox;

//     var size = _renderBox.size;

//     dropDownOffset = getOffset();
//     final settingsStore = Provider.of<SettingsStore>(context,listen: false);
//     return OverlayEntry(
//         maintainState: false,
//         builder: (context) => Align(
//               alignment: Alignment.center,
//               child: CompositedTransformFollower(
//                 link: _layerLink,
//                 showWhenUnlinked: false,
//                 offset: dropDownOffset,
//                 child: SizedBox(
//                   height: widget.maxListHeight,
//                   width: size.width,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: _isReverse
//                         ? MainAxisAlignment.end
//                         : MainAxisAlignment.start,
//                     children: <Widget>[
//                       // Padding(
//                       //   padding: const EdgeInsets.only(top: 10,),
//                       //   child:
//                       Container(
//                         padding: EdgeInsets.only(
//                             top: MediaQuery.of(context).size.height * 0.06 / 3),
//                         constraints: BoxConstraints(
//                             maxHeight: widget.maxListHeight,
//                             maxWidth: size.width),
//                         decoration: BoxDecoration(
//                             //color: Colors.white,
//                             borderRadius: BorderRadius.circular(12)),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(widget.borderRadius),
//                           ),
//                           child: Material(
//                             color: settingsStore.isDarkTheme
//                                 ? 
//                                 Color(0xFF242430)
//                                 : Color(0xFFF9F9F9),
//                             elevation: 0,
//                             shadowColor: Colors.grey,
//                             child: RawScrollbar(
//                               thumbColor: settingsStore.isDarkTheme
//                                   ? Color(0xff4D4D64)
//                                   : Color(0xffC7C7C7),
                              
//                               controller: _scrollController,
//                               thickness: 3.6,
//                               child: ListView(
//                                 padding: EdgeInsets.zero,
//                                 controller: _scrollController,
//                                 shrinkWrap: true,
//                                 children: widget.items
//                                     .map((item) => GestureDetector(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: item.child,
//                                           ),
//                                           onTap: () {
//                                             if (mounted) {
//                                               setState(() {
//                                                 _isAnyItemSelected = true;
//                                                 _itemSelected = item.child;
//                                                 _removeOverlay();
//                                                 if (widget.onChanged != null)
//                                                   widget.onChanged(item.value);
//                                               });
//                                             }
//                                           },
//                                         ))
//                                     .toList(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//             ));
//   }

//   Offset getOffset() {
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     double y = renderBox.localToGlobal(Offset.zero).dy;
//     double spaceAvailable = _getAvailableSpace(y + renderBox.size.height);
//     if (spaceAvailable > widget.maxListHeight) {
//       _isReverse = false;
//       return Offset(0, renderBox.size.height);
//     } else {
//       _isReverse = true;
//       return Offset(
//           0,
//           renderBox.size.height -
//               (widget.maxListHeight + renderBox.size.height));
//     }
//   }

//   double _getAvailableSpace(double offsetY) {
//     double safePaddingTop = MediaQuery.of(context).padding.top;
//     double safePaddingBottom = MediaQuery.of(context).padding.bottom;

//     double screenHeight =
//         MediaQuery.of(context).size.height - safePaddingBottom - safePaddingTop;

//     return screenHeight - offsetY;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final settingsStore = Provider.of<SettingsStore>(context,listen: false);
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: GestureDetector(
//         onTap: widget.enabled
//             ? () {
//                 _isOpen ? _removeOverlay() : _addOverlay();
//               }
//             : null,
//         child: Container(
//           decoration: _getDecoration(),
//           child: Row(
//             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Expanded(
//                 child: Container(
//                   // flex: 3,
//                   child: _isAnyItemSelected
//                       ? Padding(
//                           padding: const EdgeInsets.only(left: 4.0),
//                           child: _itemSelected,
//                         )
//                       : Padding(
//                           padding: const EdgeInsets.only(
//                               left: 4.0), // change it here
//                           child: Center(
//                             child: Text(
//                               widget.hintText,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(color: Color(0xff00DC00)),
//                             ),
//                           ),
//                         ),
//                 ),
//               ),
//               Container(
//                 //flex: 1,
//                 child: Icon(
//                   Icons.arrow_drop_down,
//                   color:
//                       settingsStore.isDarkTheme ? Colors.white : Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Decoration _getDecoration() {
//     if (_isOpen && !_isReverse) {
//       return BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(widget.borderRadius),
//               topRight: Radius.circular(
//                 widget.borderRadius,
//               )));
//     } else if (_isOpen && _isReverse) {
//       return BoxDecoration(
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(widget.borderRadius),
//               bottomRight: Radius.circular(
//                 widget.borderRadius,
//               )));
//     } else if (!_isOpen) {
//       return BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)));
//     }
//   }
// }

// class CustDropdownMenuItem<T> extends StatelessWidget {
 

// CustDropdownMenuItem({@required this.value,@required this.child});
//  final String value;
//   final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     return child;
//   }
// }


