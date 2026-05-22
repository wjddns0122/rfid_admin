import 'package:flutter/material.dart';
import '../models/order_item_data.dart';
import 'product_selection_item_card.dart';

class ProductStatusSelectionSheet extends StatefulWidget {
  final List<OrderItemData> orderItems;
  final VoidCallback onRefresh;
  final bool isDamageReport;

  const ProductStatusSelectionSheet({
    super.key,
    required this.orderItems,
    required this.onRefresh,
    required this.isDamageReport,
  });

  @override
  State<ProductStatusSelectionSheet> createState() => _ProductStatusSelectionSheetState();
}

class _ProductStatusSelectionSheetState extends State<ProductStatusSelectionSheet> {
  final Set<String> _selectedIds = {};

  void _applyStatusChange() {
    if (_selectedIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('상품을 최소 1개 이상 선택해주세요.')),
      );
      return;
    }

    for (var item in widget.orderItems) {
      if (_selectedIds.contains(item.id)) {
        item.isScanned = false; // Reset scan status if holding/damage is reported
        if (widget.isDamageReport) {
          item.status = '파손 접수';
          item.statusMessage = '파손 보고됨';
          item.statusColor = const Color(0xFFBA1A1A);
          item.statusIcon = Icons.report_problem;
        } else {
          item.status = '일시 중지';
          item.statusMessage = '보류 중';
          item.statusColor = const Color(0xFFF59E0B);
          item.statusIcon = Icons.pause_circle_filled;
        }
      }
    }

    widget.onRefresh();
    Navigator.pop(context);

    final actionLabel = widget.isDamageReport ? '파손 보고' : '일시 중지';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_selectedIds.length}건의 상품이 $actionLabel 처리되었습니다.'),
        backgroundColor: widget.isDamageReport ? const Color(0xFFBA1A1A) : const Color(0xFFF59E0B),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isDamageReport ? '파손 상품 보고' : '보류 상품 선택';
    final desc = widget.isDamageReport
        ? '파손 또는 불량으로 교체 및 재지시가 필요한 상품을 선택하세요.'
        : '피킹을 일시 중지(보류)할 상품을 선택하세요.';

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(width: 32, height: 4, decoration: BoxDecoration(color: const Color(0xFFC7C4D6), borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1B1F))),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(fontSize: 13, color: Color(0xFF464554))),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFC7C4D6)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: widget.orderItems.map((item) {
                return ProductSelectionItemCard(
                  item: item,
                  isSelected: _selectedIds.contains(item.id),
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        _selectedIds.add(item.id);
                      } else {
                        _selectedIds.remove(item.id);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(backgroundColor: const Color(0xFFE9E7ED), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: const Text('이전', style: TextStyle(color: Color(0xFF1A1B1F), fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyStatusChange,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3F3BBD), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                    child: const Text('적용하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
