import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'inventory_edit_screen.dart';

// --- Data Models ---

class StockLocationInfo {
  final String name;
  final String quantity;

  const StockLocationInfo({required this.name, required this.quantity});
}

class StockHistoryInfo {
  final String title;
  final String time;
  final String change;
  final Color changeColor;
  final String stockResult;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const StockHistoryInfo({
    required this.title,
    required this.time,
    required this.change,
    required this.changeColor,
    required this.stockResult,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });
}

class ProductDetailData {
  final String title;
  final String subtitle;
  final String category;
  final String sku;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final Color statusBorderColor;
  final String quantity;
  final String imageUrl;
  final Color quantityColor;
  final List<StockLocationInfo> locations;
  final List<StockHistoryInfo> history;

  const ProductDetailData({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.sku,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
    required this.statusBorderColor,
    required this.quantity,
    required this.imageUrl,
    required this.quantityColor,
    required this.locations,
    required this.history,
  });
}

// --- Main Detail Screen ---

class InventoryDetailScreen extends StatefulWidget {
  final ProductDetailData product;

  const InventoryDetailScreen({super.key, required this.product});

  @override
  State<InventoryDetailScreen> createState() => _InventoryDetailScreenState();
}

class _InventoryDetailScreenState extends State<InventoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const _DetailAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 140.0, // 여유 있게 패딩 설정하여 플로팅 버튼 및 바텀바 공간 확보
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SearchBarArea(),
                const SizedBox(height: 24),
                _ProductBentoCard(product: widget.product),
                const SizedBox(height: 24),
                _StockHistorySection(historyList: widget.product.history),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: _BottomActionButtons(
              onEditPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InventoryEditScreen(product: widget.product),
                  ),
                );
              },
              onScanPressed: () => _showSnackbar('바코드 스캔 기능이 실행되었습니다.'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF3F3BBD),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// --- Sub Widgets (Each < 100 Lines) ---

class _DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _DetailAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.8),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF464554), size: 18),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFE2DFFF),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFC7C4D6)),
            ),
            child: ClipOval(
              child: Image.network(
                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&auto=format&fit=crop&q=60',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, color: Color(0xFF3F3BBD), size: 18),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Retail Ops',
            style: TextStyle(
              color: Color(0xFF4F46E5),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.45,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Color(0xFF464554)),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE5E5EA))),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchBarArea extends StatelessWidget {
  const _SearchBarArea();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7C4D6)),
      ),
      child: Row(
        children: const [
          SizedBox(width: 16),
          Icon(Icons.search, color: Color(0xFF777585), size: 18),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '상품명 또는 바코드를 입력하세요',
                hintStyle: TextStyle(
                  color: Color(0xB3777585),
                  fontSize: 16,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(
                color: Color(0xFF1A1B1F),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductBentoCard extends StatelessWidget {
  final ProductDetailData product;

  const _ProductBentoCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7C4D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(),
                const SizedBox(width: 16),
                Expanded(child: _buildProductDetails()),
              ],
            ),
          ),
          _StockBreakdown(locations: product.locations),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 96,
      height: 128,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEDF3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(Icons.image, color: Colors.grey, size: 36),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFE9E7ED),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            product.category,
            style: const TextStyle(
              color: Color(0xFF464554),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          product.title,
          style: const TextStyle(
            color: Color(0xFF1A1B1F),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          product.sku,
          style: const TextStyle(
            color: Color(0xFF777585),
            fontSize: 13,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: product.statusBgColor,
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: product.statusBorderColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_outline, color: product.statusColor, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    product.status,
                    style: TextStyle(
                      color: product.statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${product.quantity} ',
                    style: TextStyle(
                      color: product.quantityColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: '개',
                    style: TextStyle(
                      color: Color(0xFF464554),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StockBreakdown extends StatelessWidget {
  final List<StockLocationInfo> locations;

  const _StockBreakdown({required this.locations});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0x08F4F3F8),
        border: Border(
          top: BorderSide(color: Color(0xFFC7C4D6)),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.location_on_outlined, color: Color(0xFF777585), size: 16),
              SizedBox(width: 8),
              Text(
                '위치별 상세 재고',
                style: TextStyle(
                  color: Color(0xFF777585),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: locations.map((loc) {
              final isLast = locations.indexOf(loc) == locations.length - 1;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: isLast ? 0.0 : 12.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFC7C4D6)),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loc.name,
                          style: const TextStyle(
                            color: Color(0xFF464554),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          loc.quantity,
                          style: const TextStyle(
                            color: Color(0xFF1A1B1F),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _StockHistorySection extends StatelessWidget {
  final List<StockHistoryInfo> historyList;

  const _StockHistorySection({required this.historyList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '최근 재고 변동 내역',
              style: TextStyle(
                color: Color(0xFF1A1B1F),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                '전체보기',
                style: TextStyle(
                  color: Color(0xFF3F3BBD),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFC7C4D6)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: historyList.map((hist) {
              final isLast = historyList.indexOf(hist) == historyList.length - 1;
              return Container(
                decoration: BoxDecoration(
                  border: isLast
                      ? null
                      : const Border(
                          bottom: BorderSide(color: Color(0xFFC7C4D6)),
                        ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: hist.iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(hist.icon, color: hist.iconColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hist.title,
                            style: const TextStyle(
                              color: Color(0xFF1A1B1F),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            hist.time,
                            style: const TextStyle(
                              color: Color(0xFF777585),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          hist.change,
                          style: TextStyle(
                            color: hist.changeColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '재고: ${hist.stockResult}',
                          style: const TextStyle(
                            color: Color(0xFF777585),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _BottomActionButtons extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onScanPressed;

  const _BottomActionButtons({
    required this.onEditPressed,
    required this.onScanPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 56,
              child: OutlinedButton(
                onPressed: onEditPressed,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF3F3BBD), width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: Colors.white,
                  shadowColor: Colors.black.withOpacity(0.1),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.edit_outlined, color: Color(0xFF3F3BBD), size: 18),
                    SizedBox(width: 8),
                    Text(
                      '재고 수정',
                      style: TextStyle(
                        color: Color(0xFF3F3BBD),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: onScanPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F3BBD),
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadowColor: Colors.black.withOpacity(0.1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.qr_code_scanner, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      '바코드 스캔',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
