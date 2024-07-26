import 'dart:ui';
import 'package:flutter/material.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double _top1 = 100, _left1 = 100, _diameter1 = 45, _dx1 = 1, _dy1 = 1.1;
  double _top2 = 200, _left2 = 200, _diameter2 = 30, _dx2 = 0.2, _dy2 = -1;
  double _top3 = 300, _left3 = 300, _diameter3 = 40, _dx3 = -0.5, _dy3 = 0.9;
  double _top4 = 50, _left4 = 50, _diameter4 = 50, _dx4 = 0.7, _dy4 = -1.1;
  double _top5 = 150, _left5 = 150, _diameter5 = 43, _dx5 = -1.3, _dy5 = 0.8;
  double _top6 = 250, _left6 = 250, _diameter6 = 38, _dx6 = 0.2, _dy6 = -1.8;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          _updatePosition();
        });
      });
    _controller.repeat();
  }

  void _updatePosition() {
    _updateContainerPosition(
      context,
      _top1,
      _left1,
      _diameter1,
      _dx1,
      _dy1,
      (top, left, dx, dy) {
        _top1 = top;
        _left1 = left;
        _dx1 = dx;
        _dy1 = dy;
      },
    );

    _updateContainerPosition(
      context,
      _top2,
      _left2,
      _diameter2,
      _dx2,
      _dy2,
      (top, left, dx, dy) {
        _top2 = top;
        _left2 = left;
        _dx2 = dx;
        _dy2 = dy;
      },
    );

    _updateContainerPosition(
      context,
      _top3,
      _left3,
      _diameter3,
      _dx3,
      _dy3,
      (top, left, dx, dy) {
        _top3 = top;
        _left3 = left;
        _dx3 = dx;
        _dy3 = dy;
      },
    );

    _updateContainerPosition(
      context,
      _top4,
      _left4,
      _diameter4,
      _dx4,
      _dy4,
      (top, left, dx, dy) {
        _top4 = top;
        _left4 = left;
        _dx4 = dx;
        _dy4 = dy;
      },
    );

    _updateContainerPosition(
      context,
      _top5,
      _left5,
      _diameter5,
      _dx5,
      _dy5,
      (top, left, dx, dy) {
        _top5 = top;
        _left5 = left;
        _dx5 = dx;
        _dy5 = dy;
      },
    );

    _updateContainerPosition(
      context,
      _top6,
      _left6,
      _diameter6,
      _dx6,
      _dy6,
      (top, left, dx, dy) {
        _top6 = top;
        _left6 = left;
        _dx6 = dx;
        _dy6 = dy;
      },
    );
  }

  void _updateContainerPosition(
    BuildContext context,
    double top,
    double left,
    double diameter,
    double dx,
    double dy,
    Function(double, double, double, double) updatePosition,
  ) {
    top += dy * 2;
    left += dx * 2;

    if (top <= 0 || top + diameter >= MediaQuery.of(context).size.height) {
      dy = -dy;
    }
    if (left <= 0 || left + diameter >= MediaQuery.of(context).size.width) {
      dx = -dx;
    }

    updatePosition(top, left, dx, dy);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedContainer(
    double top,
    double left,
    double diameter,
    Color color,
  ) {
    return AnimatedPositioned(
      top: top,
      left: left,
      duration: const Duration(milliseconds: 20),
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.6),
          border: Border.all(color: color.withOpacity(0.5), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: color.withOpacity(0.1),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.05),
      body: Stack(children: [
        _buildAnimatedContainer(_top1, _left1, _diameter1, Colors.red),
        _buildAnimatedContainer(_top2, _left2, _diameter2, Colors.green),
        _buildAnimatedContainer(_top3, _left3, _diameter3, Colors.blue),
        _buildAnimatedContainer(_top3, _left4, _diameter4, Colors.pink),
        _buildAnimatedContainer(_top3, _left5, _diameter5, Colors.black),
        _buildAnimatedContainer(_top3, _left6, _diameter6, Colors.purple),
      ]),
    );
  }
}
