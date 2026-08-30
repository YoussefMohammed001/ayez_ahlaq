import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/barber_widgets.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  bool _copied = false;
  final _qrPattern = List.generate(81, (i) {
    final row = i ~/ 9;
    final col = i % 9;
    final isBorder = row == 0 || row == 8 || col == 0 || col == 8;
    return isBorder || Random(i).nextBool();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'شارك رابطك'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        children: [
          const Text(
            'أي عميل يفتح رابطك، هيتحط أوتوماتيك في المفضلة بتاعته وهيلاقيك أول ما يفتح التطبيق.',
            style: TextStyle(fontSize: 12.5, color: AppColors.ivory500, height: 1.8),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          Center(
            child: Container(
              width: 150,
              height: 150,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: GridView.count(
                crossAxisCount: 9,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                children: [for (final on in _qrPattern) Container(color: on ? AppColors.ink950 : Colors.transparent)],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: BoxDecoration(
              color: AppColors.ink800,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.brass600, style: BorderStyle.solid, width: 1.5),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text('ayez-ahlaq.app/m-said7', textDirection: TextDirection.ltr, textAlign: TextAlign.right, style: TextStyle(color: AppColors.brass300, fontSize: 12.5)),
                ),
                IconButton(
                  icon: Icon(_copied ? Icons.check : Icons.ios_share_rounded, size: 18, color: AppColors.ivory100),
                  onPressed: () => setState(() => _copied = true),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Expanded(child: StatTile(value: '14', label: 'عميل جالك من الرابط')),
              SizedBox(width: 10),
              Expanded(child: StatTile(value: '3', label: 'حجوزات الأسبوع ده')),
            ],
          ),
        ],
      ),
    );
  }
}
