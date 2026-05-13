import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

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
            onPressed: () {},
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

                // Item 1
                _buildOrderItemCard(
                  brand: 'LUMINA-X1',
                  name: '프리미엄 가죽 시계 스트랩',
                  options: '사이즈: Large / 색상: 코냑',
                  quantity: 1,
                  status: '스캔완료',
                  statusMessage: '1/1 완료',
                  statusColor: const Color(0xFF16A34A),
                  statusIcon: Icons.check_circle,
                  isScanned: true,
                  imagePlaceholderIcon: Icons.watch,
                ),
                const SizedBox(height: 12),

                // Item 2
                _buildOrderItemCard(
                  brand: 'VELOCITY-PRO',
                  name: '에어로니트 트레이닝 스니커즈',
                  options: '사이즈: 270 / 색상: 크림슨 레드',
                  quantity: 1,
                  status: '스캔 대기',
                  statusMessage: '스캔 대기',
                  statusColor: const Color(0xFF3F3BBD),
                  statusIcon: Icons.qr_code_scanner,
                  isScanned: false,
                  imagePlaceholderIcon: Icons.directions_run,
                ),
                const SizedBox(height: 12),

                // Item 3
                _buildOrderItemCard(
                  brand: 'SONIC-H2',
                  name: '노이즈 캔슬링 헤드셋',
                  options: '사이즈: 프리 / 색상: 팬텀 블랙',
                  quantity: 1,
                  status: '스캔 대기',
                  statusMessage: '스캔 대기',
                  statusColor: const Color(0xFF3F3BBD),
                  statusIcon: Icons.qr_code_scanner,
                  isScanned: false,
                  imagePlaceholderIcon: Icons.headphones,
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F3BBD),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.qr_code_scanner, size: 20),
                          SizedBox(width: 8),
                          Text(
                            '전체 스캔 완료',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
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
                // TODO: Replace with actual image asset
                child: Icon(imagePlaceholderIcon, color: const Color(0xFFC7C4D6), size: 40),
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
