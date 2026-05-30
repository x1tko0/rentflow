import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../generated/app_localizations.dart';

void showProGateSheet(BuildContext context, {VoidCallback? onUnlocked, bool force = false}) {
  if (!force && AppConstants.kDebugProUnlocked) {
    onUnlocked?.call();
    return;
  }
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _ProGateSheet(),
  );
}

class _ProGateSheet extends StatelessWidget {
  const _ProGateSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final items = [
      (Icons.home_work_outlined, l10n.faqProProperties),
      (Icons.picture_as_pdf_outlined, l10n.exportPdf),
      (Icons.backup_outlined, l10n.backupToGoogleDrive),
      (Icons.alarm_outlined, l10n.faqProNotifications),
      (Icons.table_chart_outlined, l10n.exportCsv),
      (Icons.label_outline, l10n.customCategories),
      (Icons.repeat, l10n.faqProRecurring),
    ];

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Gradient banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4F6AF0), Color(0xFF7C3AED)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'PRO',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.proDescription,
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 12),
                      // CTA button
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              l10n.proCta,
                              style: const TextStyle(
                                color: Color(0xFF4F6AF0),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.proCtaYearly,
                              style: TextStyle(
                                color: const Color(0xFF4F6AF0).withValues(alpha: 0.6),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.workspace_premium, color: Colors.white, size: 48),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Feature checklist
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  if (i > 0) Divider(height: 1, indent: 16, color: theme.colorScheme.outlineVariant),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        Icon(items[i].$1, size: 18, color: const Color(0xFF4F6AF0)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(items[i].$2, style: theme.textTheme.bodyMedium),
                        ),
                        const Icon(Icons.check_circle, size: 16, color: Color(0xFF34C759)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Dismiss
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
