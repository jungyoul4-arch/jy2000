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
  final _idController = TextEditingController();
  final _pwController = TextEditingController();
  final _idFocusNode = FocusNode();
  final _pwFocusNode = FocusNode();
  bool _autoLogin = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    _idFocusNode.dispose();
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

  Future<void> _login() async {
    final id = _idController.text.trim();
    final pw = _pwController.text;

    if (id.isEmpty) {
      _showError('아이디를 입력해주세요.');
      return;
    }
    if (pw.isEmpty) {
      _showError('비밀번호를 입력해주세요.');
      return;
    }

    final success = await ref.read(authProvider.notifier).login(id, pw, _autoLogin);
    if (!success && mounted) {
      // 에러는 listener에서 처리
    }
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
                      '학원 관리',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 32),

                    // 아이디 입력
                    TextField(
                      controller: _idController,
                      focusNode: _idFocusNode,
                      decoration: const InputDecoration(
                        labelText: '아이디',
                        hintText: '아이디 입력',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        _pwFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 16),

                    // 비밀번호 입력
                    TextField(
                      controller: _pwController,
                      focusNode: _pwFocusNode,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        hintText: '비밀번호 입력',
                        prefixIcon: const Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _login(),
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
                            : _login,
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
