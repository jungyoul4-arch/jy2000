import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/staff.dart';
import '../../repositories/staff_repository.dart';

class StaffFormDialog extends ConsumerStatefulWidget {
  final Staff? staff; // null이면 등록, 있으면 수정
  final VoidCallback? onSuccess;

  const StaffFormDialog({
    super.key,
    this.staff,
    this.onSuccess,
  });

  @override
  ConsumerState<StaffFormDialog> createState() => _StaffFormDialogState();
}

class _StaffFormDialogState extends ConsumerState<StaffFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  int _selectedKind = 7; // 기본값: 일반직원
  bool _isLoading = false;

  bool get isEditMode => widget.staff != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      _nameController.text = widget.staff!.name;
      _phoneController.text = widget.staff!.phone;
      _selectedKind = widget.staff!.kind;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final repository = StaffRepository();
      final staffData = StaffCreate(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        kind: _selectedKind,
      );

      if (isEditMode) {
        await repository.update(widget.staff!.userId, staffData);
      } else {
        await repository.create(staffData);
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditMode ? '직원 정보가 수정되었습니다.' : '직원이 등록되었습니다.'),
          ),
        );
        widget.onSuccess?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${isEditMode ? '수정' : '등록'} 실패: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditMode ? '직원 수정' : '직원 등록'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이름
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '이름 *',
                  hintText: '이름을 입력하세요',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '이름을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 전화번호
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: '전화번호 *',
                  hintText: '01012345678',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '전화번호를 입력해주세요';
                  }
                  // 숫자만 추출하여 길이 검증
                  final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
                  if (digits.length < 10 || digits.length > 11) {
                    return '올바른 전화번호를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 역할
              DropdownButtonFormField<int>(
                value: _selectedKind,
                decoration: const InputDecoration(
                  labelText: '역할 *',
                ),
                items: staffKindOptions.map((option) {
                  return DropdownMenuItem<int>(
                    value: option['kind'] as int,
                    child: Text(option['name'] as String),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedKind = value);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(isEditMode ? '수정' : '등록'),
        ),
      ],
    );
  }
}
