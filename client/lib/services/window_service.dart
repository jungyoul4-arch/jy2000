import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

/// 윈도우 위치/크기 저장 및 복원 서비스
class WindowService with WindowListener {
  static const String _keyWindowX = 'window_x';
  static const String _keyWindowY = 'window_y';
  static const String _keyWindowWidth = 'window_width';
  static const String _keyWindowHeight = 'window_height';
  static const String _keyWindowMaximized = 'window_maximized';

  // 기본 창 크기
  static const double _defaultWidth = 1280;
  static const double _defaultHeight = 800;
  static const double _minWidth = 800;
  static const double _minHeight = 600;

  SharedPreferences? _prefs;

  /// 윈도우 매니저 초기화 및 저장된 위치/크기 복원
  Future<void> initialize() async {
    // 데스크톱 플랫폼에서만 동작
    if (!Platform.isWindows && !Platform.isMacOS && !Platform.isLinux) {
      return;
    }

    try {
      await windowManager.ensureInitialized();

      _prefs = await SharedPreferences.getInstance();

      // 저장된 윈도우 상태 불러오기
      final savedBounds = _getSavedBounds();
      final isMaximized = _prefs?.getBool(_keyWindowMaximized) ?? false;

      WindowOptions windowOptions = WindowOptions(
        size: Size(savedBounds.width, savedBounds.height),
        minimumSize: const Size(_minWidth, _minHeight),
        center: savedBounds.left == null,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.normal,
      );

      await windowManager.waitUntilReadyToShow(windowOptions, () async {
        // 저장된 위치가 있으면 해당 위치로 이동
        if (savedBounds.left != null && savedBounds.top != null) {
          await windowManager.setPosition(
            Offset(savedBounds.left!, savedBounds.top!),
          );
        }

        // 최대화 상태 복원
        if (isMaximized) {
          await windowManager.maximize();
        }

        await windowManager.show();
        await windowManager.focus();
      });

      // 윈도우 이벤트 리스너 등록
      windowManager.addListener(this);
    } catch (e) {
      // 윈도우 초기화 실패 시 기본 설정으로 표시
      try {
        await windowManager.show();
        await windowManager.focus();
      } catch (_) {}
    }
  }

  /// 저장된 창 위치/크기 가져오기
  _SavedBounds _getSavedBounds() {
    final double? x = _prefs?.getDouble(_keyWindowX);
    final double? y = _prefs?.getDouble(_keyWindowY);
    final double width =
        _prefs?.getDouble(_keyWindowWidth) ?? _defaultWidth;
    final double height =
        _prefs?.getDouble(_keyWindowHeight) ?? _defaultHeight;

    return _SavedBounds(
      left: x,
      top: y,
      width: width.clamp(_minWidth, 3840),
      height: height.clamp(_minHeight, 2160),
    );
  }

  /// 현재 창 상태 저장
  Future<void> _saveWindowState() async {
    if (_prefs == null) return;

    final isMaximized = await windowManager.isMaximized();
    await _prefs!.setBool(_keyWindowMaximized, isMaximized);

    // 최대화 상태가 아닐 때만 위치/크기 저장
    if (!isMaximized) {
      final position = await windowManager.getPosition();
      final size = await windowManager.getSize();

      await _prefs!.setDouble(_keyWindowX, position.dx);
      await _prefs!.setDouble(_keyWindowY, position.dy);
      await _prefs!.setDouble(_keyWindowWidth, size.width);
      await _prefs!.setDouble(_keyWindowHeight, size.height);
    }
  }

  // WindowListener 구현
  @override
  void onWindowResized() {
    _saveWindowState();
  }

  @override
  void onWindowMoved() {
    _saveWindowState();
  }

  @override
  void onWindowMaximize() {
    _saveWindowState();
  }

  @override
  void onWindowUnmaximize() {
    _saveWindowState();
  }

  @override
  void onWindowClose() {
    _saveWindowState();
    windowManager.removeListener(this);
  }

  /// 리소스 정리
  void dispose() {
    windowManager.removeListener(this);
  }
}

class _SavedBounds {
  final double? left;
  final double? top;
  final double width;
  final double height;

  _SavedBounds({
    this.left,
    this.top,
    required this.width,
    required this.height,
  });
}
