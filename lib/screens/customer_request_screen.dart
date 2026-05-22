import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/order_card.dart';
import 'request_detail_screen.dart';

class CustomerRequestScreen extends StatefulWidget {
  const CustomerRequestScreen({super.key});

  @override
  State<CustomerRequestScreen> createState() => _CustomerRequestScreenState();
}

class _CustomerRequestScreenState extends State<CustomerRequestScreen> {
  int _selectedIndex = 0; // 0: 전체, 1: 신규, 2: 지연, 3: 완료
  late List<OrderData> _orders;

  @override
  void initState() {
    super.initState();
    _orders = [
      const OrderData(
        orderNumber: '#20240523-01',
        customerName: '김아름님',
        timeAgo: '3분 전',
        productName: '오버핏 블레이저',
        totalPrice: '189,000원',
        isUrgent: true,
        isNew: true,
        phoneNumber: '010-****-5678',
        location: 'A구역 아우터 매대',
        message: 'M 사이즈가 있을까요?',
        messageTime: '오후 2:45',
        adminMemo: '재고 조회 결과 M 사이즈 2점 창고 보유 중 (확인 완료)',
        imageUrl:
            'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=500&auto=format&fit=crop&q=60',
        color: '블랙',
        category: 'Outerwear',
        availableSizes: ['S', 'M', 'L'],
        isCompleted: false,
      ),
      const OrderData(
        orderNumber: '#20240523-02',
        customerName: '이민호님',
        timeAgo: '8분 전',
        productName: '오가닉 코튼 티셔츠',
        totalPrice: '29,000원',
        isUrgent: false,
        isNew: true,
        phoneNumber: '010-****-1234',
        location: 'B구역 이너웨어 매대',
        message: 'L 사이즈 피팅룸에 가져다 주실 수 있나요?',
        messageTime: '오후 2:38',
        adminMemo: '티셔츠 화이트 L 사이즈 피팅룸 3번 전달 대기 중',
        imageUrl:
            'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=500&auto=format&fit=crop&q=60',
        color: '화이트',
        category: 'Top',
        availableSizes: ['M', 'L', 'XL'],
        isCompleted: false,
      ),
      const OrderData(
        orderNumber: '#20240523-03',
        customerName: '최수연님',
        timeAgo: '12분 전',
        productName: '프리미엄 텀블러',
        totalPrice: '34,500원',
        isUrgent: false,
        isNew: false,
        phoneNumber: '010-****-9876',
        location: 'C구역 잡화 코너',
        message: '텀블러 실버 색상도 매장에 진열되어 있나요?',
        messageTime: '오후 1:15',
        adminMemo: '실버 색상 완판, 블랙/화이트만 보유 중이라고 고객 안내 완료',
        imageUrl:
            'https://images.unsplash.com/photo-1577937927133-66ef06acdf18?w=500&auto=format&fit=crop&q=60',
        color: '실버',
        category: 'Accessories',
        availableSizes: ['One Size'],
        isCompleted: false,
      ),
      const OrderData(
        orderNumber: '#20240523-04',
        customerName: '정우성님',
        timeAgo: '15분 전',
        productName: '가죽 미니백',
        totalPrice: '89,000원',
        isUrgent: false,
        isNew: true,
        phoneNumber: '010-****-4321',
        location: 'D구역 가죽 잡화대',
        message: '가방 스크래치 없는 새 상품으로 매장에 꺼내주세요.',
        messageTime: '오후 2:20',
        adminMemo: '밀봉 보관 중인 새 상품 1점 카운터 뒤 보관 중',
        imageUrl:
            'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=500&auto=format&fit=crop&q=60',
        color: '블랙',
        category: 'Bag',
        availableSizes: ['One Size'],
        isCompleted: false,
      ),
      const OrderData(
        orderNumber: '#20240523-05',
        customerName: '한소희님',
        timeAgo: '22분 전',
        productName: '오버사이즈 린넨 셔츠',
        totalPrice: '39,000원',
        isUrgent: true,
        isNew: true,
        phoneNumber: '010-****-2468',
        location: 'A구역 셔츠 매대',
        message: '베이지 색상 S 사이즈 현재 매장에 남아있나요?',
        messageTime: '오후 2:10',
        adminMemo: '베이지 S 사이즈 마네킹 착용 1점 및 창고에 1점 남음',
        imageUrl:
            'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=500&auto=format&fit=crop&q=60',
        color: '베이지',
        category: 'Top',
        availableSizes: ['S', 'M'],
        isCompleted: false,
      ),
      const OrderData(
        orderNumber: '#20240523-06',
        customerName: '강동원님',
        timeAgo: '45분 전',
        productName: '데님 팬츠',
        totalPrice: '59,000원',
        isUrgent: false,
        isNew: false,
        phoneNumber: '010-****-1357',
        location: 'E구역 데님 존',
        message: '허리 30 사이즈 피팅하고 싶은데 안내 부탁드려요.',
        messageTime: '오후 1:40',
        adminMemo: '30사이즈 매장 재고 없음. 32사이즈로 피팅 권유 안내 예정',
        imageUrl:
            'https://images.unsplash.com/photo-1542272604-787c3835535d?w=500&auto=format&fit=crop&q=60',
        color: '딥블루',
        category: 'Bottom',
        availableSizes: ['28', '32', '34'],
        isCompleted: false,
      ),
      const OrderData(
        orderNumber: '#20240523-07',
        customerName: '송혜교님',
        timeAgo: '1시간 전',
        productName: '플로럴 원피스',
        totalPrice: '129,000원',
        isUrgent: true,
        isNew: false,
        phoneNumber: '010-****-8642',
        location: 'F구역 원피스 섹션',
        message: '원피스 기장 수선 서비스 당일 가능한가요?',
        messageTime: '오후 1:00',
        adminMemo: '매장 내 간이 수선실에서 당일 기장 수선 가능함 안내',
        imageUrl:
            'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=500&auto=format&fit=crop&q=60',
        color: '플로럴',
        category: 'Dress',
        availableSizes: ['S', 'M', 'L'],
        isCompleted: true, // 데모용으로 송혜교님 주문은 기본적으로 완료 상태로 설정
      ),
    ];
  }

  void _handleSegmentTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleCompleteOrder(String orderNumber) {
    setState(() {
      final index = _orders.indexWhere((o) => o.orderNumber == orderNumber);
      if (index != -1) {
        _orders[index] = _orders[index].copyWith(isCompleted: true);
      }
      _selectedIndex = 3; // 완료 탭으로 이동
    });
  }

  void _showActionSnackBar(
    BuildContext context,
    String action,
    String orderNumber,
  ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('주문 $orderNumber을 $action했습니다.'),
        backgroundColor: action == '수락'
            ? const Color(0xFF4441CC)
            : Colors.redAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: _CustomAppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ScreenHeader(totalCount: 7),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: _SegmentControl(
                  selectedIndex: _selectedIndex,
                  onTap: _handleSegmentTap,
                ),
              ),
              _OrderListView(
                selectedIndex: _selectedIndex,
                orders: _orders,
                onComplete: _handleCompleteOrder,
                onAction: (action, orderNum) =>
                    _showActionSnackBar(context, action, orderNum),
              ),
              const SizedBox(height: 96), // 하단 바텀바와 겹치지 않게 충분한 마진 제공
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.8),
      elevation: 0,
      scrolledUnderElevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
          ),
        ),
      ),
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFFE2DFFF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.person_outline,
                  color: Color(0xFF5E5CE6),
                  size: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              '주문 요청',
              style: TextStyle(
                color: Color(0xFF4F46E5),
                fontSize: 18,
                fontWeight: FontWeight.normal,
                letterSpacing: -0.45,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Color(0xFF464554)),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class _ScreenHeader extends StatelessWidget {
  final int totalCount;

  const _ScreenHeader({required this.totalCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '실시간 현황',
                style: TextStyle(
                  color: Color(0xFF464554),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '픽업 대기 주문',
                style: TextStyle(
                  color: Color(0xFF1A1B1F),
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.85,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF5E5CE6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: Color(0xFFF4F1FF),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  '$totalCount건',
                  style: const TextStyle(
                    color: Color(0xFFF4F1FF),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentControl extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _SegmentControl({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEDF3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildSegmentButton(0, '전체'),
          _buildSegmentButton(1, '신규'),
          _buildSegmentButton(2, '지연'),
          _buildSegmentButton(3, '완료'),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(int index, String text) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF4441CC)
                  : const Color(0xFF464554),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderListView extends StatelessWidget {
  final int selectedIndex;
  final List<OrderData> orders;
  final void Function(String orderNum) onComplete;
  final void Function(String action, String orderNum) onAction;

  const _OrderListView({
    required this.selectedIndex,
    required this.orders,
    required this.onComplete,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    // 필터링 처리 (0: 전체, 1: 신규, 2: 지연, 3: 완료)
    final filteredOrders = orders.where((order) {
      if (selectedIndex == 0) return true; // 전체
      if (selectedIndex == 1)
        return order.isNew && !order.isCompleted; // 신규 & 미완료
      if (selectedIndex == 2)
        return !order.isNew && !order.isCompleted; // 지연 & 미완료
      if (selectedIndex == 3) return order.isCompleted; // 완료건만
      return true;
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: filteredOrders.map((order) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: OrderCard(
              orderNumber: order.orderNumber,
              customerName: order.customerName,
              timeAgo: order.timeAgo,
              productName: order.productName,
              totalPrice: order.totalPrice,
              imageUrl: order.imageUrl,
              isUrgent: order.isUrgent,
              isNew: order.isNew,
              isCompleted: order.isCompleted,
              onReject: () => onAction('거절', order.orderNumber),
              onAccept: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RequestDetailScreen(
                      order: order,
                      onComplete: () => onComplete(order.orderNumber),
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class OrderData {
  final String orderNumber;
  final String customerName;
  final String timeAgo;
  final String productName;
  final String totalPrice;
  final bool isUrgent;
  final bool isNew;
  final bool isCompleted;

  // 상세 화면 연동용 추가 필드들
  final String phoneNumber;
  final String location;
  final String message;
  final String messageTime;
  final String adminMemo;
  final String imageUrl;
  final String color;
  final String category;
  final List<String> availableSizes;

  const OrderData({
    required this.orderNumber,
    required this.customerName,
    required this.timeAgo,
    required this.productName,
    required this.totalPrice,
    required this.isUrgent,
    required this.isNew,
    required this.phoneNumber,
    required this.location,
    required this.message,
    required this.messageTime,
    required this.adminMemo,
    required this.imageUrl,
    required this.color,
    required this.category,
    required this.availableSizes,
    this.isCompleted = false,
  });

  OrderData copyWith({
    String? orderNumber,
    String? customerName,
    String? timeAgo,
    String? productName,
    String? totalPrice,
    bool? isUrgent,
    bool? isNew,
    bool? isCompleted,
    String? phoneNumber,
    String? location,
    String? message,
    String? messageTime,
    String? adminMemo,
    String? imageUrl,
    String? color,
    String? category,
    List<String>? availableSizes,
  }) {
    return OrderData(
      orderNumber: orderNumber ?? this.orderNumber,
      customerName: customerName ?? this.customerName,
      timeAgo: timeAgo ?? this.timeAgo,
      productName: productName ?? this.productName,
      totalPrice: totalPrice ?? this.totalPrice,
      isUrgent: isUrgent ?? this.isUrgent,
      isNew: isNew ?? this.isNew,
      isCompleted: isCompleted ?? this.isCompleted,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      message: message ?? this.message,
      messageTime: messageTime ?? this.messageTime,
      adminMemo: adminMemo ?? this.adminMemo,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
      category: category ?? this.category,
      availableSizes: availableSizes ?? this.availableSizes,
    );
  }
}
