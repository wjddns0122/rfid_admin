import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'inventory_detail_screen.dart';
import 'inventory_register_screen.dart';
import 'inventory_inbound_screen.dart';
import 'inventory_request_screen.dart';
import 'notification_screen.dart';

final List<ProductDetailData> _mockProducts = [
  ProductDetailData(
    title: '린넨 블렌드 블레이저',
    subtitle: '샌드스톤 • 사이즈 48',
    category: 'TOP / JACKET',
    sku: 'SKU: LN-2023-SD-048',
    status: '정상 재고',
    statusColor: const Color(0xFF059669),
    statusBgColor: const Color(0xFFECFDF5),
    statusBorderColor: const Color(0xFFD1FAE5),
    quantity: '14',
    imageUrl:
        'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=500&auto=format&fit=crop&q=60',
    quantityColor: const Color(0xFF3F3BBD),
    locations: const [
      StockLocationInfo(name: '창고 A', quantity: '10개'),
      StockLocationInfo(name: '매장 진열', quantity: '4개'),
    ],
    history: const [
      StockHistoryInfo(
        title: '입고 처리 (본사)',
        time: '2023.10.24 14:30 · 담당자 김철수',
        change: '+5',
        changeColor: Color(0xFF059669),
        stockResult: '14',
        icon: Icons.shopping_cart_outlined,
        iconBgColor: Color(0xFFEEF2FF),
        iconColor: Color(0xFF3F3BBD),
      ),
      StockHistoryInfo(
        title: '판매 처리',
        time: '2023.10.24 11:20 · POS 01',
        change: '-1',
        changeColor: Color(0xFFE11D48),
        stockResult: '9',
        icon: Icons.local_offer_outlined,
        iconBgColor: Color(0xFFFFF1F2),
        iconColor: Color(0xFFE11D48),
      ),
    ],
  ),
  ProductDetailData(
    title: '헤리티지 스니커즈',
    subtitle: '화이트 • 사이즈 42',
    category: 'SHOES / SNEAKERS',
    sku: 'SKU: SH-2023-WT-042',
    status: '품절 임박',
    statusColor: const Color(0xFFBA1A1A),
    statusBgColor: const Color(0xFFFFDAD6),
    statusBorderColor: const Color(0xFFFFB4AB),
    quantity: '2',
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&auto=format&fit=crop&q=60',
    quantityColor: const Color(0xFFBA1A1A),
    locations: const [
      StockLocationInfo(name: '창고 B', quantity: '1개'),
      StockLocationInfo(name: '매장 진열', quantity: '1개'),
    ],
    history: const [
      StockHistoryInfo(
        title: '판매 처리',
        time: '2026.05.22 10:15 · POS 02',
        change: '-1',
        changeColor: Color(0xFFE11D48),
        stockResult: '2',
        icon: Icons.local_offer_outlined,
        iconBgColor: Color(0xFFFFF1F2),
        iconColor: Color(0xFFE11D48),
      ),
      StockHistoryInfo(
        title: '입고 처리 (본사)',
        time: '2026.05.20 09:30 · 담당자 이영희',
        change: '+10',
        changeColor: Color(0xFF059669),
        stockResult: '3',
        icon: Icons.shopping_cart_outlined,
        iconBgColor: Color(0xFFEEF2FF),
        iconColor: Color(0xFF3F3BBD),
      ),
    ],
  ),
  ProductDetailData(
    title: '메리노 울 폴로',
    subtitle: '네이비 • 사이즈 L',
    category: 'TOP / KNIT',
    sku: 'SKU: PL-2023-NV-003',
    status: '정상 재고',
    statusColor: const Color(0xFF059669),
    statusBgColor: const Color(0xFFECFDF5),
    statusBorderColor: const Color(0xFFD1FAE5),
    quantity: '28',
    imageUrl:
        'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=500&auto=format&fit=crop&q=60',
    quantityColor: const Color(0xFF3F3BBD),
    locations: const [
      StockLocationInfo(name: '창고 A', quantity: '20개'),
      StockLocationInfo(name: '매장 진열', quantity: '8개'),
    ],
    history: const [
      StockHistoryInfo(
        title: '입고 처리 (본사)',
        time: '2026.05.21 16:40 · 담당자 박민수',
        change: '+15',
        changeColor: Color(0xFF059669),
        stockResult: '28',
        icon: Icons.shopping_cart_outlined,
        iconBgColor: Color(0xFFEEF2FF),
        iconColor: Color(0xFF3F3BBD),
      ),
      StockHistoryInfo(
        title: '판매 처리',
        time: '2026.05.21 11:10 · POS 01',
        change: '-2',
        changeColor: Color(0xFFE11D48),
        stockResult: '13',
        icon: Icons.local_offer_outlined,
        iconBgColor: Color(0xFFFFF1F2),
        iconColor: Color(0xFFE11D48),
      ),
    ],
  ),
];

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Icon(
              Icons.storefront_outlined,
              color: AppColors.primary,
              size: 24,
            ),
          ),
        ),
        title: const Text(
          '재고 관리',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.primary,
            ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 24.0,
          bottom: 96.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E5EA)),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 12),
                  Icon(Icons.search, color: Color(0xFF6B7280), size: 20),
                  SizedBox(width: 8),
                  Text(
                    '제품명, ID 또는 바코드 검색',
                    style: TextStyle(color: Color(0xFF6B7280), fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Inventory Stats Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E5EA)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '오늘의 활동',
                        style: TextStyle(
                          color: Color(0xFF464554),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '42개 품목 업데이트됨',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildStatIndicator(
                            const Color(0xFF5E5CE6),
                            '12개 재주문',
                          ),
                          const SizedBox(width: 16),
                          _buildStatIndicator(
                            const Color(0xFFBA1A1A),
                            '3개 품절 임박',
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.bar_chart,
                        color: Color(0xFFCBD5E1),
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Recently Viewed Items Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '최근 조회 품목',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '5분 전 업데이트',
                      style: TextStyle(color: Color(0xFF464554), fontSize: 11),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    '모두 보기',
                    style: TextStyle(
                      color: Color(0xFF5E5CE6),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Product List
            _buildProductCard(context, _mockProducts[0]),
            const SizedBox(height: 12),
            _buildProductCard(context, _mockProducts[1]),
            const SizedBox(height: 12),
            _buildProductCard(context, _mockProducts[2]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showQuickActionsBottomSheet(context),
        backgroundColor: const Color(0xFF5E5CE6),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildStatIndicator(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, ProductDetailData product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InventoryDetailScreen(product: product),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E5EA)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E5EA)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.image, color: Colors.grey, size: 32),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product.subtitle,
                        style: const TextStyle(
                          color: Color(0xFF464554),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: product.statusBgColor,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          product.status,
                          style: TextStyle(
                            color: product.statusColor,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Text(
                        product.quantity,
                        style: TextStyle(
                          color: product.quantityColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickActionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _QuickActionsSheet(),
    );
  }
}

// --- Quick Actions Bottom Sheet Components (< 100 lines each) ---

class _QuickActionsSheet extends StatelessWidget {
  const _QuickActionsSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Color(0x25000000),
            blurRadius: 50,
            offset: Offset(0, -12),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _BottomSheetHandle(),
            const _BottomSheetHeader(),
            const Divider(color: Color(0xFFE2E8F0), height: 1),
            const SizedBox(height: 8),
            _buildActionItem(
              context: context,
              title: '신규 품목 등록',
              subtitle: '새로운 상품 정보를 시스템에 추가합니다',
              icon: Icons.add_to_photos_outlined,
              iconBgColor: const Color(0xFFE2DFFF),
              iconColor: const Color(0xFF5E5CE6),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InventoryRegisterScreen(),
                  ),
                );
              },
            ),
            _buildActionItem(
              context: context,
              title: '재고 입고',
              subtitle: '입고된 물량을 확인하고 수량을 업데이트합니다',
              icon: Icons.move_to_inbox_outlined,
              iconBgColor: const Color(0xFFD8E2FF),
              iconColor: const Color(0xFF3F3BBD),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InventoryInboundScreen(),
                  ),
                );
              },
            ),
            _buildActionItem(
              context: context,
              title: '새 요청 작성',
              subtitle: '매장 간 이동이나 본사 발주를 요청합니다',
              icon: Icons.assignment_outlined,
              iconBgColor: const Color(0xFFFFDCBF),
              iconColor: const Color(0xFFD97706),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InventoryRequestScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            const _BottomSheetFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF1A1B1F),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF464554),
                      fontSize: 11,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFC7C4D6),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomSheetHandle extends StatelessWidget {
  const _BottomSheetHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      alignment: Alignment.center,
      child: Container(
        width: 40,
        height: 6,
        decoration: BoxDecoration(
          color: const Color(0xFFC7C4D6),
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
    );
  }
}

class _BottomSheetHeader extends StatelessWidget {
  const _BottomSheetHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '빠른 작업',
            style: TextStyle(
              color: Color(0xFF1A1B1F),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '인벤토리 관리를 위한 작업을 선택하세요.',
            style: TextStyle(
              color: Color(0xFF464554),
              fontSize: 11,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheetFooter extends StatelessWidget {
  const _BottomSheetFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F3F8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE3E2E7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              '닫기',
              style: TextStyle(
                color: Color(0xFF464554),
                fontSize: 17,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
