import 'package:flutter/material.dart';
import '../models/order_item_data.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/order_options_bottom_sheet.dart';
import 'order_detail_screen.dart';
import 'order_success_screen.dart';
import 'notification_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late List<OrderItemData> _orderItems;

  @override
  void initState() {
    super.initState();
    _orderItems = [
      OrderItemData(
        id: '1',
        brand: 'LUMINA-X1',
        name: '프리미엄 크로노 워치',
        options: '사이즈: 42mm / 색상: 스페이스 그레이',
        quantity: 1,
        status: '스캔 대기',
        statusMessage: '스캔 대기',
        statusColor: const Color(0xFF3F3BBD),
        statusIcon: Icons.qr_code_scanner,
        isScanned: false,
        imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&auto=format&fit=crop&q=60',
        imagePlaceholderIcon: Icons.watch,
        subtitle: '남성용 럭셔리 컬렉션 - 실버 & 블랙',
        sku: 'WCH-2024-001',
        color: '스페이스 그레이',
        size: '42mm',
        locationZone: 'A-04',
        locationShelf: '12',
        availableStock: 24,
        pickingCaution: '고가의 귀중품입니다. 피킹 시 반드시 전용 보관함을 사용하고, 스크래치 방지를 위해 장갑을 착용하십시오.',
      ),
      OrderItemData(
        id: '2',
        brand: 'VELOCITY-PRO',
        name: '에어로니트 트레이닝 스니커즈',
        options: '사이즈: 270 / 색상: 크림슨 레드',
        quantity: 1,
        status: '스캔 대기',
        statusMessage: '스캔 대기',
        statusColor: const Color(0xFF3F3BBD),
        statusIcon: Icons.qr_code_scanner,
        isScanned: false,
        imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&auto=format&fit=crop&q=60',
        imagePlaceholderIcon: Icons.directions_run,
        subtitle: '초경량 러닝 컬렉션 - 크림슨 레드',
        sku: 'SNK-2024-912',
        color: '크림슨 레드',
        size: '270mm',
        locationZone: 'C-11',
        locationShelf: '03',
        availableStock: 8,
        pickingCaution: '박스 파손 주의. 좌우 신발 사이즈(270)가 동일한지 최종 스캔 전 확인하십시오.',
      ),
      OrderItemData(
        id: '3',
        brand: 'SONIC-H2',
        name: '노이즈 캔슬링 헤드셋',
        options: '사이즈: 프리 / 색상: 팬텀 블랙',
        quantity: 1,
        status: '스캔 대기',
        statusMessage: '스캔 대기',
        statusColor: const Color(0xFF3F3BBD),
        statusIcon: Icons.qr_code_scanner,
        isScanned: false,
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&auto=format&fit=crop&q=60',
        imagePlaceholderIcon: Icons.headphones,
        subtitle: '하이레스 무선 오디오 - 팬텀 블랙',
        sku: 'HDS-2024-441',
        color: '팬텀 블랙',
        size: '프리 사이즈',
        locationZone: 'D-05',
        locationShelf: '09',
        availableStock: 3,
        pickingCaution: '배터리가 포함된 정밀 전자기기입니다. 충격에 극히 취약하므로 에어캡 완충재로 이중 포장하십시오.',
      ),
    ];
  }

  void _resetAllScans() {
    setState(() {
      for (var item in _orderItems) {
        item.isScanned = false;
        item.status = '스캔 대기';
        item.statusMessage = '스캔 대기';
        item.statusColor = const Color(0xFF3F3BBD);
        item.statusIcon = Icons.qr_code_scanner;
      }
    });
  }

  void _navigateToSuccessScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSuccessScreen(
          scannedItems: _orderItems,
          onResetScan: _resetAllScans,
        ),
      ),
    );
  }

  void _markAllAsScanned() {
    setState(() {
      for (var item in _orderItems) {
        item.isScanned = true;
        item.status = '스캔완료';
        item.statusMessage = '1/1 완료';
        item.statusColor = const Color(0xFF16A34A);
        item.statusIcon = Icons.check_circle;
      }
    });
    _navigateToSuccessScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FE),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE5E5EA))),
          ),
        ),
        leadingWidth: 48,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Center(
            child: Icon(Icons.storefront_outlined, color: AppColors.primary, size: 24),
          ),
        ),
        title: const Text(
          '매장 운영',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0, bottom: 180.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '주문 상세 (피킹)',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5856D6),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        '진행 중',
                        style: TextStyle(
                          color: Color(0xFFE7E4FF),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '#P-2024-1015',
                  style: TextStyle(
                    color: Color(0xFF464554),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 32),

                // Customer Info Bento
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0x4DC7C4D6)),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEEEDF3),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person_outline, color: Color(0xFF3F3BBD), size: 20),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      '고객명',
                                      style: TextStyle(
                                        color: Color(0xFF777585),
                                        fontSize: 11,
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '김민석',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          color: Color(0x4DC7C4D6),
                          thickness: 1,
                          width: 24,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEEEDF3),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.phone_outlined, color: Color(0xFF3F3BBD), size: 20),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      '연락처',
                                      style: TextStyle(
                                        color: Color(0xFF777585),
                                        fontSize: 11,
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '010-4829-1052',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Order Items Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '주문 상품 (3건)',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.1,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.filter_list, color: Color(0xFF3F3BBD), size: 16),
                        SizedBox(width: 4),
                        Text(
                          '정렬',
                          style: TextStyle(
                            color: Color(0xFF3F3BBD),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Order Items List
                Column(
                  children: _orderItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailScreen(
                                item: item,
                                allItems: _orderItems,
                                onRefresh: () => setState(() {}),
                              ),
                            ),
                          );
                          if (result == true) {
                            setState(() {
                              item.isScanned = true;
                              item.status = '스캔완료';
                              item.statusMessage = '1/1 완료';
                              item.statusColor = const Color(0xFF16A34A);
                              item.statusIcon = Icons.check_circle;
                            });
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: _buildOrderItemCard(
                          brand: item.brand,
                          name: item.name,
                          options: item.options,
                          quantity: item.quantity,
                          status: item.status,
                          statusMessage: item.statusMessage,
                          statusColor: item.statusColor,
                          statusIcon: item.statusIcon,
                          isScanned: item.isScanned,
                          imageUrl: item.imageUrl,
                          imagePlaceholderIcon: item.imagePlaceholderIcon,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          
          // Bottom Action Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                border: const Border(top: BorderSide(color: Color(0x80E2E8F0))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _orderItems.every((item) => item.isScanned)
                          ? _navigateToSuccessScreen
                          : _markAllAsScanned,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _orderItems.every((item) => item.isScanned)
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF3F3BBD),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _orderItems.every((item) => item.isScanned)
                                ? Icons.arrow_forward
                                : Icons.qr_code_scanner,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _orderItems.every((item) => item.isScanned)
                                ? '피킹 완료 페이지 이동'
                                : '전체 스캔 완료',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => OrderOptionsBottomSheet(
                          orderItems: _orderItems,
                          onRefresh: () => setState(() {}),
                          orderId: '#P-2024-1015',
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9E7ED),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.more_vert,
                        color: Color(0xFF464554),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildOrderItemCard({
    required String brand,
    required String name,
    required String options,
    required int quantity,
    required String status,
    required String statusMessage,
    required Color statusColor,
    required IconData statusIcon,
    required bool isScanned,
    required String imageUrl,
    required IconData imagePlaceholderIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x4DC7C4D6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Area
          Stack(
            children: [
              Container(
                width: 96,
                height: 128,
                decoration: const BoxDecoration(
                  color: Color(0xFFEEEDF3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(11),
                    bottomLeft: Radius.circular(11),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    bottomLeft: Radius.circular(11),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(imagePlaceholderIcon, color: const Color(0xFFC7C4D6), size: 40),
                    ),
                  ),
                ),
              ),
              if (isScanned)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '스캔완료',
                      style: TextStyle(
                        color: Color(0xFF3F3BBD),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          // Details Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand,
                    style: const TextStyle(
                      color: Color(0xFF777585),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    options,
                    style: const TextStyle(
                      color: Color(0xFF464554),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$quantity 개',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(statusIcon, color: statusColor, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            statusMessage,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

