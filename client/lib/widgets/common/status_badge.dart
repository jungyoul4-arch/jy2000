import 'package:flutter/material.dart';

import '../../config/theme.dart';

class StatusBadge extends StatelessWidget {
  final String statusCode;
  final String statusName;
  final bool small;

  const StatusBadge({
    super.key,
    required this.statusCode,
    required this.statusName,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.getStatusColor(statusCode);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 6 : 10,
        vertical: small ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        statusName,
        style: TextStyle(
          color: color,
          fontSize: small ? 11 : 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
