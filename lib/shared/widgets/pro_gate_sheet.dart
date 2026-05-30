import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../core/services/billing_service.dart';
import '../../generated/app_localizations.dart';
import '../providers/pro_status_provider.dart';

void showProGateSheet(BuildContext context, {VoidCallback? onUnlocked, bool force = false}) {
  final isPro = ProviderScope.containerOf(context, listen: false).read(proStatusProvider).valueOrNull ?? false;
  if (!force && isPro) {
    onUnlocked?.call();
    return;
  }
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _ProGateSheet(onUnlocked: onUnlocked),
  );
}

class _ProGateSheet extends ConsumerStatefulWidget {
  final VoidCallback? onUnlocked;
  const _ProGateSheet({this.onUnlocked});

  @override
  ConsumerState<_ProGateSheet> createState() => _ProGateSheetState();
}

class _ProGateSheetState extends ConsumerState<_ProGateSheet> {
  bool _loading = false;

  Future<void> _purchase(BuildContext context, Package package) async {
    if (_loading) return;
    setState(() => _loading = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final unlocked = await BillingService.purchase(package);
      ref.invalidate(proStatusProvider);
      if (!mounted) return;
      if (unlocked) {
        if (!context.mounted) return;
        Navigator.pop(context);
        widget.onUnlocked?.call();
      }
    } on PlatformException catch (e) {
      final code = PurchasesErrorHelper.getErrorCode(e);
      if (code != PurchasesErrorCode.purchaseCancelledError && mounted) {
        messenger.showSnackBar(SnackBar(content: Text(e.message ?? e.toString())));
      }
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final packages = ref.watch(_proPackagesProvider);

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
                      packages.when(
                        data: (items) => _PurchaseButtons(
                          packages: items,
                          loading: _loading,
                          onPurchase: (package) => _purchase(context, package),
                        ),
                        loading: () => const _ProLoadingButton(),
                        error: (e, _) => _FallbackCta(l10n: l10n),
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

final _proPackagesProvider = FutureProvider.autoDispose<List<Package>>((ref) {
  return BillingService.getPackages();
});

class _PurchaseButtons extends StatelessWidget {
  final List<Package> packages;
  final bool loading;
  final ValueChanged<Package> onPurchase;
  const _PurchaseButtons({
    required this.packages,
    required this.loading,
    required this.onPurchase,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (packages.isEmpty) return _FallbackCta(l10n: l10n);

    return Column(
      children: [
        for (final package in packages.take(2)) ...[
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: loading ? null : () => onPurchase(package),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF4F6AF0),
              ),
              child: loading
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(_packageLabel(package)),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }

  String _packageLabel(Package package) {
    final price = package.storeProduct.priceString;
    return switch (package.packageType) {
      PackageType.annual => '$price / year',
      PackageType.monthly => '$price / month',
      _ => price,
    };
  }
}

class _ProLoadingButton extends StatelessWidget {
  const _ProLoadingButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _FallbackCta extends StatelessWidget {
  final AppLocalizations l10n;
  const _FallbackCta({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
