import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'circular_progress_bar.dart';

/// Loads an SVG coin icon and renders it. Many exchange assets shipped from
/// Adobe Illustrator carry `<style>` blocks with CSS classes (`.st0{fill:..}`
/// + `class="st0"`) which flutter_svg cannot evaluate, so the classes are
/// inlined into `fill`/`stroke` attributes before rendering.
class SwapCoinSvgImage extends StatefulWidget {
  const SwapCoinSvgImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.color,
  });

  final String url;
  final double? width;
  final double? height;
  final Color? color;

  @override
  State<SwapCoinSvgImage> createState() => _SwapCoinSvgImageState();
}

class _SwapCoinSvgImageState extends State<SwapCoinSvgImage> {
  String? _svgString;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(SwapCoinSvgImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _svgString = null;
      _error = null;
      _load();
    }
  }

  Future<void> _load() async {
    final cached = _svgCache[widget.url];
    if (cached != null) {
      if (mounted) setState(() => _svgString = cached);
      return;
    }
    try {
      final response = await http.get(Uri.parse(widget.url));
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }
      final inlined = _inlineSvgClassStyles(response.body);
      _svgCache[widget.url] = inlined;
      if (mounted) setState(() => _svgString = inlined);
    } catch (err) {
      if (mounted) setState(() => _error = err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = SizedBox(
      width: widget.width,
      height: widget.height,
      child: circularProgressBar(widget.color ?? Color(0xff737373), 1.0),
    );
    if (_error != null) {
      return Icon(Icons.error, size: widget.width ?? 15);
    }
    if (_svgString == null) return placeholder;
    return SvgPicture.string(
      _svgString!,
      width: widget.width,
      height: widget.height,
      placeholderBuilder: (_) => placeholder,
    );
  }
}

/// In-memory cache of inlined SVG strings keyed by URL.
final Map<String, String> _svgCache = {};

/// Rewrites `<style>... .st0{fill:#F4A427;} ...</style>` CSS class rules into
/// inline `fill=`/`stroke=` presentation attributes so flutter_svg can render
/// assets that rely on embedded CSS classes.
String _inlineSvgClassStyles(String svg) {
  final styleRegex = RegExp(r'<style[^>]*>(.*?)</style>', dotAll: true);
  final styleMatch = styleRegex.firstMatch(svg);
  if (styleMatch == null) return svg;

  final classToProps = <String, Map<String, String>>{};
  final ruleRegex = RegExp(r'\.([\w-]+)\s*\{([^}]*)\}');
  for (final m in ruleRegex.allMatches(styleMatch.group(1)!)) {
    final decls = <String, String>{};
    for (final d in m.group(2)!.split(';')) {
      final idx = d.indexOf(':');
      if (idx > 0) {
        final k = d.substring(0, idx).trim();
        final v = d.substring(idx + 1).trim();
        if (k.isNotEmpty && v.isNotEmpty) decls[k] = v;
      }
    }
    classToProps[m.group(1)!] = decls;
  }

  var out = svg.substring(0, styleMatch.start);
  final afterStyle = svg.substring(styleMatch.end);
  final classAttrRegex = RegExp(r'class\s*=\s*"([\w\s]+)"');
  out += afterStyle.replaceAllMapped(classAttrRegex, (m) {
    final classes = m.group(1)!.split(RegExp(r'\s+'));
    final props = <String, String>{};
    for (final c in classes) {
      final p = classToProps[c];
      if (p != null) props.addAll(p);
    }
    if (props.isEmpty) return m.group(0)!;
    return props.entries.map((e) => '${e.key}="${e.value}"').join(' ');
  });
  return out;
}