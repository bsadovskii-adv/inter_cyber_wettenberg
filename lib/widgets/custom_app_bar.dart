import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar customAppBar(BuildContext context, {required String title, VoidCallback? onBack}) {
  final topPadding = MediaQuery.of(context).padding.top;
  return AppBar(
    toolbarHeight: 112,
    backgroundColor: const Color(0xFFFFCC00),
    elevation: 4,
    shadowColor: Colors.black.withValues(alpha: 0.8),
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    title: const SizedBox.shrink(),
    flexibleSpace: Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 4),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
