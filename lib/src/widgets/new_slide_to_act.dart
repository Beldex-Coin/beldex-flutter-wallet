import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

class NewSlideToAct extends StatefulWidget {
  const NewSlideToAct({
    Key? key,
    this.sliderButtonIconSize = 24,
    this.sliderButtonIconPadding = 16,
    this.sliderButtonYOffset = 0,
    this.height = 130,
    this.outerColor,
    this.borderRadius = 52,
    this.elevation = 6,
    this.animationDuration = const Duration(milliseconds: 300),
    this.reversed = false,
    this.alignment = Alignment.center,
    this.submittedIcon,
    this.onFutureSubmit,
    this.onSubmit,
    this.child,
    this.innerColor,
    this.text,
    this.sliderButtonIcon,
  }) : super(key: key);

  /// The size of the sliding icon
  final double sliderButtonIconSize;

  /// Tha padding of the sliding icon
  final double sliderButtonIconPadding;

  /// The offset on the y axis of the slider icon
  final double sliderButtonYOffset;

  /// The child that is rendered instead of the default Text widget
  final Widget? child;

  /// The height of the component
  final double height;

  /// The color of the inner circular button, of the tick icon of the text.
  /// If not set, this attribute defaults to primaryIconTheme.
  final Color? innerColor;

  /// The color of the external area and of the arrow icon.
  /// If not set, this attribute defaults to accentColor from your theme.
  final Color? outerColor;

  /// The text showed in the default Text widget
  final String? text;

  /// The borderRadius of the sliding icon and of the background
  final double borderRadius;

  /// Callback called on submit
  final Future Function()? onFutureSubmit;
  final VoidCallback? onSubmit;

  /// Elevation of the component
  final double? elevation;

  /// The widget to render instead of the default icon
  final Widget? sliderButtonIcon;

  /// The widget to render instead of the default submitted icon
  final Widget? submittedIcon;

  /// The duration of the animations
  final Duration animationDuration;

  /// If true the widget will be reversed
  final bool reversed;

  /// the alignment of the widget once it's submitted
  final Alignment alignment;

  @override
  SlideToActState createState() => SlideToActState();
}

/// Use a GlobalKey to access the state. This is the only way to call [SlideToActState.reset]
class SlideToActState extends State<NewSlideToAct> with TickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _sliderKey = GlobalKey();
  double _dx = 0;
  double _maxDx = 0;

  double get _progress => _dx == 0 ? 0 : _dx / _maxDx;
  double _endDx = 0;
  double _dz = 1;
  double? _initialContainerWidth, _containerWidth;
  double _checkAnimationDx = 0;
  bool submitted = false;
  AnimationController? _checkAnimationController,
      _shrinkAnimationController,
      _resizeAnimationController,
      _cancelAnimationController;
  AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    if (widget.onSubmit != null && widget.onFutureSubmit != null) {
      throw Exception('onSubmit and onFutureSubmit can\'t be used both');
    }

    return Align(
      alignment: widget.alignment,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(widget.reversed ? pi : 0),
        child: Container(
          key: _containerKey,
          height: widget.height,
          width: _containerWidth,
          constraints: _containerWidth != null
              ? null
              : BoxConstraints.expand(height: widget.height),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: submitted
                ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(widget.reversed ? pi : 0),
              child: Center(
                child: Stack(
                  clipBehavior: Clip.antiAlias,
                  children: <Widget>[
                    widget.submittedIcon ??
                        Icon(
                          Icons.done,
                          color: widget.innerColor ??
                              Theme.of(context).primaryIconTheme.color,
                        ),
                    Positioned.fill(
                      right: 0,
                      child: Transform(
                        transform: Matrix4.rotationY(
                            _checkAnimationDx * (pi / 2)),
                        alignment: Alignment.centerRight,
                        child: Container(
                          color: widget.outerColor ??
                              Theme.of(context).floatingActionButtonTheme.foregroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  bottom: 30.0,
                  child: AnimatedBuilder(
                      animation: animationController!,
                      builder: (context, child) {
                        return Container(
                          decoration: ShapeDecoration(
                            shape: CircleBorder(),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                8.0 * animationController!.value),
                            child: child,
                          ),
                        );},
                    child: Transform.scale(
                      scale: _dz,
                      origin: Offset(0,_dx),
                      child: Transform.translate(
                        offset: Offset( 0,-_dx),
                        child: Container(
                          key: _sliderKey,
                          child: GestureDetector(
                            onVerticalDragUpdate: onHorizontalDragUpdate,
                            onVerticalDragEnd: (details) async {
                              _endDx = _dx;
                              if (_progress <= 0.8) {
                                await _cancelAnimation();
                              } else {
                                if (widget.onFutureSubmit != null) {
                                  await widget.onFutureSubmit!();
                                } else if (widget.onSubmit != null) {
                                  widget.onSubmit!();
                                }
                                await _cancelAnimation();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 55.0),
                              child: ClipOval(
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.green.shade600,
                                          Colors.green,
                                          Colors.blue
                                        ],
                                        transform: GradientRotation(
                                            math.pi / 4)),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .backgroundColor, //kHintColor, so this should be changed?
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(100),
                                  ),
                                  child: ClipOval(
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      width: 75,
// this width forces the container to be a circle
                                      height: 75,
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .backgroundColor,
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .backgroundColor),
                                        borderRadius:
                                        BorderRadius.circular(
                                            100),
                                      ),
// this height forces the container to be a circle
                                      child: SvgPicture.asset(
                                        'assets/images/up_arrow_svg.svg',
                                        color: Theme.of(context).primaryTextTheme.caption!.color,
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Positioned(
                  bottom: 0,
                  child: Text(widget.text!,
                      style: TextStyle(
                        backgroundColor: Colors.transparent,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors
                            .grey, //Theme.of(context).textTheme.overline.backgroundColor,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dx = (_dx - details.delta.dy).clamp(0.0,_maxDx) as double;
    });
  }

  /// Call this method to revert the animations
  Future reset() async {
    await _checkAnimationController?.reverse().orCancel;

    submitted = false;

    await _shrinkAnimationController?.reverse().orCancel;

    await _resizeAnimationController?.reverse().orCancel;

    await _cancelAnimation();
  }

  Future _checkAnimation() async {
    _checkAnimationController?.reset();

    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _checkAnimationController!,
      curve: Curves.slowMiddle,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _checkAnimationDx = animation.value;
        });
      }
    });
    await _checkAnimationController?.forward().orCancel;
  }

  Future _shrinkAnimation() async {
    _shrinkAnimationController?.reset();

    final diff = _initialContainerWidth! - widget.height;
    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _shrinkAnimationController!,
      curve: Curves.easeOutCirc,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _containerWidth = _initialContainerWidth! - (diff * animation.value);
        });
      }
    });

    setState(() {
      submitted = true;
    });
    await _shrinkAnimationController?.forward().orCancel;
  }

  Future _resizeAnimation() async {
    _resizeAnimationController?.reset();

    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _resizeAnimationController!,
      curve: Curves.easeInBack,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _dz = 1 - animation.value;
        });
      }
    });
    await _resizeAnimationController?.forward().orCancel;
  }

  Future _cancelAnimation() async {
    _cancelAnimationController!.reset();
    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _cancelAnimationController!,
      curve: Curves.fastOutSlowIn,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _dx = (_endDx - (_endDx * animation.value));
        });
      }
    });
    await _cancelAnimationController?.forward().orCancel;
  }

  @override
  void initState() {
    super.initState();

    _cancelAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _checkAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _shrinkAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _resizeAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final containerBox =
      _containerKey.currentContext?.findRenderObject() as RenderBox;
      _containerWidth = containerBox.size.width;
      _initialContainerWidth = _containerWidth;

      final sliderBox =
      _sliderKey.currentContext?.findRenderObject() as RenderBox;
      final sliderWidth = sliderBox.size.width;

      _maxDx =
          _containerWidth! - (sliderWidth / 2) - 40 - widget.sliderButtonYOffset;
    });

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cancelAnimationController?.dispose();
    _checkAnimationController?.dispose();
    _shrinkAnimationController?.dispose();
    _resizeAnimationController?.dispose();
    animationController!.dispose();
    super.dispose();
  }
}
