import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollableWithBottomSection extends StatefulWidget {
  ScrollableWithBottomSection(
      {required this.content,
      this.bottomSection,
      this.contentPadding,
      this.bottomSectionPadding});

  final Widget content;
  final Widget? bottomSection;
  final EdgeInsets? contentPadding;
  final EdgeInsets? bottomSectionPadding;

  @override
  ScrollableWithBottomSectionState createState() =>
      ScrollableWithBottomSectionState();
}

class ScrollableWithBottomSectionState
    extends State<ScrollableWithBottomSection> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: constraints.heightConstraints().maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: widget.contentPadding ??
                    EdgeInsetsDirectional.only(start: 20, end: 20),
                child: widget.content,
              ),
              Padding(
                  padding: widget.bottomSectionPadding ??
                      EdgeInsetsDirectional.only(bottom: 20, end: 20, start: 20),
                  child: widget.bottomSection)
            ],
          ),
        ),
      );
    });
  }
}
