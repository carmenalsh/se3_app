import 'dart:async';
import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';

OverlayEntry? _currentTopSnackBar;

void showTopSnackBar(
  BuildContext context, {
  required String message,
  required bool isSuccess,
  bool acceptClick = false,
  VoidCallback? onTap,
  Duration displayDuration = const Duration(seconds: 3),
}) {
  _currentTopSnackBar?.remove();
  _currentTopSnackBar = null;

  final overlay = Overlay.of(context, rootOverlay: true);
  if (overlay == null) return;

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (ctx) => _TopSnackBarOverlay(
      message: message,
      isSuccess: isSuccess,
      acceptClick: acceptClick,
      onTap: onTap,
      displayDuration: displayDuration,
      onDismissed: () {
        entry.remove();
        if (_currentTopSnackBar == entry) _currentTopSnackBar = null;
      },
    ),
  );

  _currentTopSnackBar = entry;
  overlay.insert(entry);
}

class _TopSnackBarOverlay extends StatefulWidget {
  final String message;
  final bool isSuccess;
  final bool acceptClick;
  final VoidCallback? onTap;
  final Duration displayDuration;
  final VoidCallback onDismissed;

  const _TopSnackBarOverlay({
    required this.message,
    required this.isSuccess,
    required this.acceptClick,
    required this.onTap,
    required this.displayDuration,
    required this.onDismissed,
  });

  @override
  State<_TopSnackBarOverlay> createState() => _TopSnackBarOverlayState();
}

class _TopSnackBarOverlayState extends State<_TopSnackBarOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;

  Timer? _timer;
  bool _dismissedBySwipe = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
      reverseDuration: const Duration(milliseconds: 260),
    );

    _slide = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ),
        );

    _controller.forward();

    _timer = Timer(widget.displayDuration, () async {
      if (mounted && !_dismissedBySwipe) {
        await _controller.reverse();
        widget.onDismissed();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = widget.isSuccess ? Colors.green : Colors.red;
    final IconData icon = widget.isSuccess ? Icons.check_circle : Icons.error;

    Widget snackContent = Material(
      color: backgroundColor,
      elevation: 8,
      shadowColor: Colors.black54,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.diagonal * .025,
                      fontFamily: AppFonts.amiri,
                    ),
                  ),
                ),
                if (widget.acceptClick || widget.onTap != null)
                  TextButton(
                    onPressed: widget.onTap ?? () {},
                    child: const Text(
                      "حسناً",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: SlideTransition(
          position: _slide,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.up,
              onDismissed: (_) async {
                _dismissedBySwipe = true;
                _timer?.cancel();
                widget.onDismissed();
              },
              child: snackContent,
            ),
          ),
        ),
      ),
    );
  }
}
