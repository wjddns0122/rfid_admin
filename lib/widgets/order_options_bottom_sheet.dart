import 'package:flutter/material.dart';
import '../models/order_item_data.dart';
import 'option_item_tile.dart';
import 'product_status_selection_sheet.dart';

class OrderOptionsBottomSheet extends StatelessWidget {
  final List<OrderItemData> orderItems;
  final VoidCallback onRefresh;
  final String orderId;

  const OrderOptionsBottomSheet({
    super.key,
    required this.orderItems,
    required this.onRefresh,
    this.orderId = '#P-2024-1015',
  });

  void _openSelectionSheet(BuildContext context, {required bool isDamageReport}) {
    Navigator.pop(context); // Close this sheet first
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductStatusSelectionSheet(
        orderItems: orderItems,
        onRefresh: onRefresh,
        isDamageReport: isDamageReport,
      ),
    );
  }

  void _changePicker(BuildContext context) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('담당 피커 변경', style: TextStyle(fontWeight: FontWeight.bold)),
        children: ['이지원 (피커 A)', '박민재 (피커 B)', '최수진 (피커 C)'].map((name) {
          return SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('담당 피커가 $name(으)로 변경되었습니다.'),
                  backgroundColor: const Color(0xFF3F3BBD),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(name, style: const TextStyle(fontSize: 16)),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _printPickingList(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('피킹 리스트가 프린터(Zone-A-PRT)로 전송되어 출력을 시작합니다.'),
        backgroundColor: Color(0xFF16A34A),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(28.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFC7C4D6),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '주문 관리 옵션',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1B1F),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$orderId 주문에 대한 추가 작업을 선택하세요.',
                  style: const TextStyle(fontSize: 13, color: Color(0xFF464554)),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFC7C4D6)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          OptionItemTile(
            onTap: () => _openSelectionSheet(context, isDamageReport: false),
            title: 'Hold Order',
            subtitle: '주문을 일시 중지 상태로 변경합니다.',
            circleColor: const Color(0xFFD8E2FF),
            titleColor: const Color(0xFF1A1B1F),
            icon: Icons.pause_circle_filled,
            iconColor: const Color(0xFF3F3BBD),
          ),
          OptionItemTile(
            onTap: () => _openSelectionSheet(context, isDamageReport: true),
            title: 'Report Damaged Item',
            subtitle: '파손된 상품을 보고하고 대체품을 요청합니다.',
            circleColor: const Color(0xFFFFDAD6),
            titleColor: const Color(0xFFBA1A1A),
            icon: Icons.report_problem,
            iconColor: const Color(0xFFBA1A1A),
          ),
          OptionItemTile(
            onTap: () => _changePicker(context),
            title: 'Change Picker',
            subtitle: '이 주문의 담당 피커를 다른 동료로 변경합니다.',
            circleColor: const Color(0xFFE3E2E7),
            titleColor: const Color(0xFF1A1B1F),
            icon: Icons.person_pin,
            iconColor: const Color(0xFF464554),
          ),
          OptionItemTile(
            onTap: () => _printPickingList(context),
            title: 'Print Picking List',
            subtitle: '현재 주문의 피킹 리스트를 종이로 출력합니다.',
            circleColor: const Color(0xFFE2DFFF),
            titleColor: const Color(0xFF1A1B1F),
            icon: Icons.print,
            iconColor: const Color(0xFF3F3BBD),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFE9E7ED),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  '취소',
                  style: TextStyle(
                    color: Color(0xFF1A1B1F),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
