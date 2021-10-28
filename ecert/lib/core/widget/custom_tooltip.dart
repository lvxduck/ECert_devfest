import 'package:flutter/material.dart';

class TooltipTap extends StatefulWidget {
  const TooltipTap({
    Key? key,
    required this.child,
    required this.hoveMessage,
    required this.clickMessage,
    required this.onTap,
  }) : super(key: key);
  final Widget child;
  final String hoveMessage;
  final String clickMessage;
  final VoidCallback onTap;

  @override
  _TooltipTapState createState() => _TooltipTapState();
}

class _TooltipTapState extends State<TooltipTap> {
  late String message;

  @override
  void initState() {
    message = widget.hoveMessage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      key: key,
      message: message,
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          setState(() {
            message = widget.clickMessage;
          });
        },
        child: widget.child,
      ),
    );
  }
}
