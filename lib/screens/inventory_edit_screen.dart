import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'inventory_detail_screen.dart';

class InventoryEditScreen extends StatefulWidget {
  final ProductDetailData product;

  const InventoryEditScreen({super.key, required this.product});

  @override
  State<InventoryEditScreen> createState() => _InventoryEditScreenState();
}

class _InventoryEditScreenState extends State<InventoryEditScreen> {
  bool isAddMode = true;
  int selectedReasonIndex = 0;
  late TextEditingController quantityController;
  late TextEditingController memoController;

  final List<String> reasons = ['재고 실사', '파손/분실', '오입력 수정'];

  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController(text: '0');
    memoController = TextEditingController();
  }

  @override
  void dispose() {
    quantityController.dispose();
    memoController.dispose();
    super.dispose();
  }

  void _onSave() {
    final qty = int.tryParse(quantityController.text) ?? 0;
    final modeText = isAddMode ? '추가' : '차감';
    
    // 이전 화면으로 돌아가며 성공 피드백 전달
    Navigator.pop(context);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '재고가 수정되었습니다: ${widget.product.title} ($qty개 $modeText / 사유: ${reasons[selectedReasonIndex]})',
        ),
        backgroundColor: const Color(0xFF3F3BBD),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const _EditAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 120.0, // 하단 고정 버튼 여유 공간
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProductContextCard(product: widget.product),
                const SizedBox(height: 24),
                _ModeAndQuantityCard(
                  isAddMode: isAddMode,
                  quantityController: quantityController,
                  onModeChanged: (val) {
                    setState(() => isAddMode = val);
                  },
                ),
                const SizedBox(height: 24),
                _ReasonSelector(
                  selectedReasonIndex: selectedReasonIndex,
                  reasons: reasons,
                  onReasonSelected: (idx) {
                    setState(() => selectedReasonIndex = idx);
                  },
                ),
                const SizedBox(height: 24),
                _MemoTextarea(memoController: memoController),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: _FixedActionButtonFooter(onPressed: _onSave),
          ),
        ],
      ),
    );
  }
}

// --- Sub Widgets (Each < 100 Lines) ---

class _EditAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _EditAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.8),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF464554), size: 24),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: const Text(
        '재고 수정',
        style: TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.2,
        ),
      ),
      // 상단 우측 체크 아이콘 버튼을 완벽히 제거 (요청 반영)
      actions: const [
        SizedBox(width: 48), // 대칭적인 레이아웃 균형을 위해 빈 공간 제공
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ProductContextCard extends StatelessWidget {
  final ProductDetailData product;

  const _ProductContextCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7C4D6).withOpacity(0.3)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
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
                  child: Icon(Icons.image, color: Colors.grey, size: 28),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.sku,
                  style: const TextStyle(
                    color: Color(0xFF464554),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  product.title,
                  style: const TextStyle(
                    color: Color(0xFF1A1B1F),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.inventory_2_outlined, color: Color(0xFF3F3BBD), size: 14),
                    const SizedBox(width: 6),
                    Text(
                      '현재 재고: ${product.quantity}개',
                      style: const TextStyle(
                        color: Color(0xFF3F3BBD),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeAndQuantityCard extends StatelessWidget {
  final bool isAddMode;
  final TextEditingController quantityController;
  final ValueChanged<bool> onModeChanged;

  const _ModeAndQuantityCard({
    required this.isAddMode,
    required this.quantityController,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7C4D6).withOpacity(0.3)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '조정 유형',
            style: TextStyle(
              color: Color(0xFF464554),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          _buildSegmentControl(),
          const SizedBox(height: 20),
          const Text(
            '수정 수량',
            style: TextStyle(
              color: Color(0xFF464554),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          _buildQuantityInput(),
        ],
      ),
    );
  }

  Widget _buildSegmentControl() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildSegmentButton('수량 추가', isAddMode, () => onModeChanged(true)),
          ),
          Expanded(
            child: _buildSegmentButton('수량 차감', !isAddMode, () => onModeChanged(false)),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive ? const Color(0xFF3F3BBD) : const Color(0xFF464554),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityInput() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7C4D6).withOpacity(0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                color: Color(0xFF1A1B1F),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            '개',
            style: TextStyle(
              color: Color(0xFF464554),
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReasonSelector extends StatelessWidget {
  final int selectedReasonIndex;
  final List<String> reasons;
  final ValueChanged<int> onReasonSelected;

  const _ReasonSelector({
    required this.selectedReasonIndex,
    required this.reasons,
    required this.onReasonSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            '수정 사유',
            style: TextStyle(
              color: Color(0xFF464554),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: reasons.asMap().entries.map((entry) {
            final idx = entry.key;
            final reason = entry.value;
            final isSelected = selectedReasonIndex == idx;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GestureDetector(
                onTap: () => onReasonSelected(idx),
                child: Container(
                  height: 58,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0x0A3F3BBD) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF3F3BBD) : const Color(0xFFC7C4D6).withOpacity(0.5),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        reason,
                        style: const TextStyle(
                          color: Color(0xFF1A1B1F),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF3F3BBD),
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MemoTextarea extends StatelessWidget {
  final TextEditingController memoController;

  const _MemoTextarea({required this.memoController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            '상세 메모 (선택)',
            style: TextStyle(
              color: Color(0xFF464554),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFC7C4D6).withOpacity(0.5)),
          ),
          child: TextField(
            controller: memoController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: '수정 사항에 대한 자세한 내용을 입력하세요.',
              hintStyle: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 15,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(
              color: Color(0xFF1A1B1F),
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}

class _FixedActionButtonFooter extends StatelessWidget {
  final VoidCallback onPressed;

  const _FixedActionButtonFooter({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3F3BBD).withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5856D6),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Center(
            child: Text(
              '수정 완료',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
