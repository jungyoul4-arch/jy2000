import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool _autoLogin = false;
  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String _formatPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length <= 3) return digits;
    if (digits.length <= 7) {
      return '${digits.substring(0, 3)}-${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits.substring(7, digits.length > 11 ? 11 : digits.length)}';
  }

  void _startTimer() {
    _remainingSeconds = 180;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  String _formatTime(int seconds) {
    final min = seconds ~/ 60;
    final sec = seconds % 60;
    return '$min:${sec.toString().padLeft(2, '0')}';
  }

  Future<void> _requestCode() async {
    final phone = _phoneController.text.replaceAll('-', '');
    if (phone.length < 10) {
      _showError('전화번호를 정확히 입력해주세요.');
      return;
    }

    final success = await ref.read(authProvider.notifier).requestCode(phone);
    if (success) {
      _startTimer();
      _showCodeDialog();
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red[700]),
            const SizedBox(width: 8),
            const Text('오류'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              message,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: message));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('클립보드에 복사되었습니다'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(Icons.copy, size: 18),
            label: const Text('복사'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showCodeDialog() {
    _codeController.clear();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('인증 코드 입력'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '전송된 4자리 인증 코드를 입력하세요',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 8),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Text(
                      _remainingSeconds > 0
                          ? '남은 시간: ${_formatTime(_remainingSeconds)}'
                          : '시간이 만료되었습니다. 다시 요청해주세요.',
                      style: TextStyle(
                        color: _remainingSeconds > 30 ? Colors.grey[600] : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  ref.read(authProvider.notifier).resetCodeSent();
                },
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  await _requestCode();
                },
                child: const Text('재전송'),
              ),
              FilledButton(
                onPressed: () async {
                  if (_codeController.text.length != 4) {
                    _showError('4자리 인증 코드를 입력해주세요.');
                    return;
                  }
                  if (_remainingSeconds <= 0) {
                    _showError('인증 시간이 만료되었습니다. 다시 요청해주세요.');
                    return;
                  }
                  final phone = _phoneController.text.replaceAll('-', '');
                  final success = await ref
                      .read(authProvider.notifier)
                      .verifyCode(phone, _codeController.text, _autoLogin);
                  if (success && mounted) {
                    Navigator.pop(dialogContext);
                  }
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // 인증 완료시 홈으로 이동
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated) {
        context.go('/');
      }
      if (next.error != null && previous?.error != next.error) {
        _showError(next.error!);
        ref.read(authProvider.notifier).clearError();
      }
    });

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 로고
                    Icon(
                      Icons.school,
                      size: 64,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '학생 상담 관리',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 32),

                    // 전화번호 입력
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: '전화번호',
                        hintText: '010-0000-0000',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      onChanged: (value) {
                        final formatted = _formatPhone(value);
                        if (formatted != value) {
                          _phoneController.value = TextEditingValue(
                            text: formatted,
                            selection: TextSelection.collapsed(
                              offset: formatted.length,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // 자동 로그인 체크박스
                    Row(
                      children: [
                        Checkbox(
                          value: _autoLogin,
                          onChanged: (value) {
                            setState(() {
                              _autoLogin = value ?? false;
                            });
                          },
                        ),
                        const Text('자동 로그인'),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // 로그인 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: authState.status == AuthStatus.loading
                            ? null
                            : _requestCode,
                        child: authState.status == AuthStatus.loading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('로그인'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
