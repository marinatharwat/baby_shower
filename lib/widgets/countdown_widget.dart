import 'dart:async';
import 'package:flutter/material.dart';
import '../theme.dart';

class CountdownWidget extends StatefulWidget {
  final DateTime targetDate;
  final bool isAr;
  const CountdownWidget({super.key, required this.targetDate, required this.isAr});

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = widget.targetDate.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _remaining = widget.targetDate.difference(DateTime.now());
          if (_remaining.isNegative) _remaining = Duration.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = _remaining.inDays;
    final h = _remaining.inHours % 24;
    final m = _remaining.inMinutes % 60;
    final s = _remaining.inSeconds % 60;

    final labels = widget.isAr
        ? ['يوم', 'ساعة', 'دقيقة', 'ثانية']
        : ['Days', 'Hours', 'Min', 'Sec'];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        _chip(d, labels[0]),
        _chip(h, labels[1]),
        _chip(m, labels[2]),
        _chip(s, labels[3]),
      ],
    );
  }

  Widget _chip(int value, String label) {
    return Container(
      width: 72,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value.toString().padLeft(2, '0'),
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: widget.isAr ? 11 : 10,
              color: AppColors.sky,
              letterSpacing: widget.isAr ? 0 : 1,
            ),
          ),
        ],
      ),
    );
  }
}
