import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

/// 다이얼로그 결과: 등록할 물품 입력값.
class ItemRegisterInput {
  final String name;
  final int price;
  final String imageUrl;
  const ItemRegisterInput({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

/// 미등록 UID 감지시 물품 이름/가격/사진(URL) 입력 다이얼로그.
Future<ItemRegisterInput?> showItemRegisterDialog(
  BuildContext context, {
  required String uid,
}) {
  return showDialog<ItemRegisterInput>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _ItemRegisterDialog(uid: uid),
  );
}

class _ItemRegisterDialog extends StatefulWidget {
  final String uid;
  const _ItemRegisterDialog({required this.uid});

  @override
  State<_ItemRegisterDialog> createState() => _ItemRegisterDialogState();
}

class _ItemRegisterDialogState extends State<_ItemRegisterDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      ItemRegisterInput(
        name: _nameController.text.trim(),
        price: int.parse(_priceController.text.trim()),
        imageUrl: _imageController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '신규 물품 등록',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'UID: ${widget.uid}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _field(
                controller: _nameController,
                label: '물품 이름',
                hint: '예: 오버핏 블레이저',
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? '이름을 입력해주세요' : null,
              ),
              const SizedBox(height: 14),
              _field(
                controller: _priceController,
                label: '가격 (원)',
                hint: '예: 89000',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return '가격을 입력해주세요';
                  if (int.tryParse(v.trim()) == null) return '숫자만 입력 가능합니다';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              _field(
                controller: _imageController,
                label: '사진 URL',
                hint: 'https://...',
                keyboardType: TextInputType.url,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? '사진 URL을 입력해주세요' : null,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        foregroundColor: const Color(0xFF64748B),
                      ),
                      child: const Text('취소'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        '등록',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF464554),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
          style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14),
        ),
      ],
    );
  }
}
