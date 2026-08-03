import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // 로그인 화면 색상 (라이트 테마)
  static const Color _pageColor = Colors.white;
  static const Color _cardColor = Colors.white;
  static const Color _fieldColor = Color(0xFFF5F7FA);
  static const Color _borderColor = Color(0xFFD7DDE7);
  static const Color _accentColor = Color(0xFF5B8DEF);
  static const Color _titleColor = Color(0xFF1B2130);
  static const Color _labelColor = Color(0xFF2B3445);
  static const Color _hintColor = Color(0xFF95A0B0);
  // 안내 문구용 (흰 배경 대비 확보)
  static const Color _guideColor = Color(0xFF6B7684);

  final _phoneController = TextEditingController();
  final _pwController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _pwFocusNode = FocusNode();
  bool _autoLogin = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _pwController.dispose();
    _phoneFocusNode.dispose();
    _pwFocusNode.dispose();
    super.dispose();
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
            const Text('로그인 실패'),
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

  Future<void> _login() async {
    // 하이픈 등을 제거하고 숫자만 전송
    final phone = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final pw = _pwController.text;

    if (phone.isEmpty) {
      _showError('전화번호를 입력해주세요.');
      return;
    }
    if (pw.isEmpty) {
      _showError('패스워드를 입력해주세요.');
      return;
    }

    await ref.read(authProvider.notifier).talkLogin(phone, pw, _autoLogin);
    // 성공 시 이동 / 실패 시 에러 표시는 build의 listener에서 처리
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStatus.loading;

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
      backgroundColor: _pageColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 타이틀
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: _accentColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '학원 관리',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _titleColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      '정율톡 계정으로 로그인하세요',
                      style: TextStyle(fontSize: 14, color: _guideColor),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 전화번호
                  _buildLabel('전화번호'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _phoneController,
                    focusNode: _phoneFocusNode,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                      LengthLimitingTextInputFormatter(13),
                    ],
                    style: const TextStyle(color: _titleColor),
                    decoration: _fieldDecoration('01012345678'),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => _pwFocusNode.requestFocus(),
                  ),
                  const SizedBox(height: 18),

                  // 패스워드
                  _buildLabel('패스워드'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _pwController,
                    focusNode: _pwFocusNode,
                    obscureText: _obscurePassword,
                    style: const TextStyle(color: _titleColor),
                    decoration: _fieldDecoration('패스워드').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: _hintColor,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _login(),
                  ),
                  const SizedBox(height: 12),

                  // 자동 로그인
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _autoLogin,
                          onChanged: (value) {
                            setState(() => _autoLogin = value ?? false);
                          },
                          side: const BorderSide(color: _borderColor),
                          activeColor: _accentColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '자동 로그인',
                        style: TextStyle(fontSize: 13, color: _labelColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 로그인 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: FilledButton(
                      onPressed: isLoading ? null : _login,
                      style: FilledButton.styleFrom(
                        backgroundColor: _accentColor,
                        disabledBackgroundColor: _accentColor.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              '로그인',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 패스워드 설정 안내
                  const Text(
                    "※ 패스워드 설정 방법 : 정율톡 설정의 '웹/태블릿 로그인 패스워드 설정'에서 하면 됩니다.",
                    style: TextStyle(
                      fontSize: 12,
                      color: _guideColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: _labelColor,
      ),
    );
  }

  InputDecoration _fieldDecoration(String hintText) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: _borderColor),
    );

    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: _hintColor),
      filled: true,
      fillColor: _fieldColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: border,
      enabledBorder: border,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: _accentColor, width: 1.5),
      ),
    );
  }
}
