import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CustomScrollbar extends SingleChildRenderObjectWidget {
  final ScrollController controller;
  final Widget child;
  final double strokeWidth;
  final EdgeInsets padding;
  final Color trackColor;
  final Color thumbColor;

  const CustomScrollbar({
    Key key,
    this.controller,
    this.child,
    this.strokeWidth,
    this.padding,
    this.trackColor,
    this.thumbColor,
  }) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomScrollbar(
      controller: controller,
      strokeWidth: strokeWidth ?? 16,
      padding:
      padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      trackColor: trackColor ?? Colors.purpleAccent.withOpacity(0.3),
      thumbColor: thumbColor ?? Colors.purpleAccent,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCustomScrollbar renderObject) {
    if (strokeWidth != null) {
      renderObject.strokeWidth = strokeWidth;
    }
    if (padding != null) {
      renderObject.padding = padding;
    }
    if (trackColor != null) {
      renderObject.trackColor = trackColor;
    }
    if (thumbColor != null) {
      renderObject.thumbColor = thumbColor;
    }
  }
}

class RenderCustomScrollbar extends RenderShiftedBox {
  final ScrollController controller;
  Offset _thumbPoint = Offset(0, 0);
  EdgeInsets padding;
  double strokeWidth;
  Color trackColor;
  Color thumbColor;

  RenderCustomScrollbar({
    RenderBox child,
    this.padding,
    this.controller,
    this.strokeWidth,
    this.trackColor,
    this.thumbColor,
  }) : super(child) {
    controller.addListener(_updateThumbPoint);
  }

  void _updateThumbPoint() {
    _thumbPoint = Offset(_getHorizontalOffset(), _getThumbVerticalOffset());
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  double _getHorizontalOffset() {
    return size.width - padding.right - strokeWidth / 2;
  }

  double _getThumbVerticalOffset() {
    var scrollExtent = _getScrollExtent();
    var scrollPosition = controller.position;
    var scrollOffset =
    ((scrollPosition.pixels - scrollPosition.minScrollExtent) /
        scrollExtent)
        .clamp(0.0, 1.0);
    return (_getHeightWithPadding() - _getThumbHeight()) * scrollOffset;
  }

  double _getHeightWithPadding() {
    return size.height - padding.vertical;
  }

  double _getScrollExtent() {
    return controller.position.maxScrollExtent;
  }

  double _getThumbHeight() {
    var scrollExtent = _getScrollExtent();
    var height = _getHeightWithPadding();
    if (scrollExtent == 0) {
      return height;
    }
    return (height / (scrollExtent / height + 1));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    context.paintChild(child, offset);
    _resetThumbStartPointIfNeeded();
    _trackPaint(context, offset);
    _thumbPaint(context, offset);
    //_textPaint(context, offset);
  }

  void _resetThumbStartPointIfNeeded() {
    var scrollMaxExtent = _getScrollExtent();
    if (scrollMaxExtent == 0) {
      _thumbPoint = Offset(_getHorizontalOffset(), 0);
    }
  }

  void _trackPaint(PaintingContext context, Offset offset) {
    var width = _getHorizontalOffset();
    final trackPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = trackColor
      ..strokeWidth = strokeWidth;
    final startPoint = Offset(width, offset.dy + padding.top);
    final endPoint = Offset(width, startPoint.dy + _getHeightWithPadding());
    context.canvas.drawLine(startPoint, endPoint, trackPaint);
  }

  void _thumbPaint(PaintingContext context, Offset offset) {
    var width = _getHorizontalOffset();
    final paintThumb = Paint()
      ..strokeWidth = strokeWidth
      ..color = thumbColor
      ..strokeCap = StrokeCap.round;
    final startPoint =
    Offset(width, (_thumbPoint.dy + offset.dy + padding.top));
    final endPoint = Offset(width, startPoint.dy + _getThumbHeight());
    context.canvas.drawLine(startPoint, endPoint, paintThumb);
  }

  void _textPaint(PaintingContext context, Offset offset) {
    var canvas = context.canvas;
    canvas.save();
    canvas.translate(size.width - 6,
        (_thumbPoint.dy + _getThumbHeight() * 0.45 + offset.dy + padding.top));
    canvas.rotate(1.5708);
    TextSpan span = TextSpan(
        text: _getPercent(),
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold));
    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset.zero);
    canvas.restore();
  }

  String _getPercent() {
    if (_getScrollExtent() == 0) {
      return '100 %';
    }
    return (controller.position.pixels / _getScrollExtent() * 100)
        .toStringAsFixed(0) +
        ' %';
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    if (child == null) return;
    child.layout(constraints.copyWith(maxWidth: _getChildMaxWidth()),
        parentUsesSize: !constraints.isTight);
    final BoxParentData childParentData = child.parentData as BoxParentData;
    childParentData.offset = Offset.zero;
  }

  double _getChildMaxWidth() {
    return constraints.maxWidth - padding.horizontal - strokeWidth;
  }
}