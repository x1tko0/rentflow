import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../main.dart' show restartApp, skipBiometricOnce;
import '../../shared/widgets/pro_gate_sheet.dart';
import '../../core/services/backup_service.dart';
import '../../core/services/biometric_service.dart';
import '../../core/services/notification_service.dart';
import '../../core/utils/formatters.dart';
import '../../generated/app_localizations.dart';
import '../../shared/providers/repository_providers.dart';
import '../faq/presentation/faq_screen.dart';
import 'settings_provider.dart';

class _CurrencyOption {
  final String symbol;
  final String code;
  const _CurrencyOption(this.symbol, this.code);
  String get display => '$symbol $code';
}

const _currencies = [
  _CurrencyOption('\$', 'USD'),
  _CurrencyOption('₽', 'RUB'),
  _CurrencyOption('₴', 'UAH'),
  _CurrencyOption('€', 'EUR'),
  _CurrencyOption('£', 'GBP'),
  _CurrencyOption('zł', 'PLN'),
  _CurrencyOption('R\$', 'BRL'),
  _CurrencyOption('₺', 'TRY'),
  _CurrencyOption('﷼', 'SAR'),
  _CurrencyOption('¥', 'JPY'),
  _CurrencyOption('₹', 'INR'),
  _CurrencyOption('元', 'CNY'),
];

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ProBanner(l10n: l10n),
          const SizedBox(height: 24),
          _SectionHeader(l10n.appearance),
          _SettingsCard(children: [
            _ThemeTile(current: settings.themeMode, onChanged: notifier.setThemeMode, l10n: l10n),
            _Divider(),
            _CurrencyTile(current: settings.currency, onChanged: notifier.setCurrency, l10n: l10n),
          ]),
          const SizedBox(height: 20),
          _SectionHeader(l10n.aboutApp),
          _SettingsCard(children: [
            _InfoTile(label: l10n.versionLabel, value: '1.0.0'),
            _Divider(),
            _InfoTile(label: l10n.propertyLimit, value: l10n.propertyLimitValue(AppConstants.freePropertyLimit)),
            _Divider(),
            _LinkTile(
              label: l10n.contactDeveloper,
              icon: Icons.mail_outline,
              onTap: () => _contactDeveloper(context),
            ),
            _Divider(),
            _LinkTile(
              label: l10n.rateApp,
              icon: Icons.star_outline,
              onTap: () {},
            ),
            _Divider(),
            _LinkTile(
              label: l10n.privacyPolicy,
              icon: Icons.privacy_tip_outlined,
              onTap: () => _openPrivacyPolicy(context),
            ),
            _Divider(),
            _LinkTile(
              label: l10n.faqTitle,
              icon: Icons.help_outline,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const FaqScreen()),
              ),
            ),
          ]),
          const SizedBox(height: 20),
          _SectionHeader(l10n.notificationsSection),
          _SettingsCard(children: [
            _NotificationsToggleTile(
              enabled: settings.notificationsEnabled,
              onChanged: (v) => _toggleNotifications(context, ref, v, l10n, notifier),
              l10n: l10n,
            ),
          ]),
          const SizedBox(height: 20),
          _ProSectionHeader(l10n.proSection),
          _SettingsCard(children: [
            _NotifyDaysTile(
              days: settings.notificationDaysBefore,
              enabled: settings.notificationsEnabled,
              l10n: l10n,
              onTap: () {
                if (!AppConstants.kDebugProUnlocked) {
                  showProGateSheet(context);
                  return;
                }
                _showDaysPicker(context, ref, settings.notificationDaysBefore, l10n);
              },
            ),
            _Divider(),
            _BackupTile(l10n: l10n),
            _Divider(),
            _RestoreTile(l10n: l10n),
            _Divider(),
            _RestorePurchasesTile(l10n: l10n),
          ]),
          const SizedBox(height: 20),
          _SectionHeader(l10n.biometricSection),
          _SettingsCard(children: [
            _BiometricTile(
              enabled: settings.biometricEnabled,
              onChanged: (v) => _toggleBiometric(context, ref, v, l10n),
              l10n: l10n,
            ),
          ]),
        ],
      ),
    );
  }

  Future<void> _openPrivacyPolicy(BuildContext context) async {
    final uri = Uri.parse(AppConstants.privacyPolicyUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _contactDeveloper(BuildContext context) async {
    final uri = Uri(scheme: 'mailto', path: 'orbitraystudio@gmail.com', query: 'subject=RentFlow Feedback');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot open email app')),
      );
    }
  }

  Future<void> _toggleNotifications(BuildContext context, WidgetRef ref, bool enable, AppLocalizations l10n, SettingsNotifier notifier) async {
    await notifier.setNotificationsEnabled(enable);
    if (!enable) {
      await NotificationService.cancelAll();
      return;
    }
    await NotificationService.requestPermission();
    final days = ref.read(settingsProvider).notificationDaysBefore;
    final currency = ref.read(settingsProvider).currency;
    await _rescheduleAll(l10n, ref, days, currency);
  }

  static Future<void> _rescheduleAll(AppLocalizations l10n, WidgetRef ref, int days, String currency) async {
    final tenants = await ref.read(tenantRepositoryProvider).getAll();
    final now = DateTime.now();
    for (final t in tenants) {
      if (!t.isActive) continue;
      final notifId = t.id.hashCode.abs() % 100000;
      await NotificationService.cancel(notifId);
      final thisMonth = DateTime(now.year, now.month, t.paymentDay);
      final next = thisMonth.isAfter(now) ? thisMonth : DateTime(now.year, now.month + 1, t.paymentDay);
      await NotificationService.schedulePaymentReminder(
        id: notifId,
        title: l10n.notificationPaymentTitle,
        body: '${t.firstName} ${t.lastName} — ${formatMoney(t.rentAmount, currency: currency)}',
        paymentDate: next,
        daysBefore: days,
      );
    }
  }

  void _showDaysPicker(BuildContext context, WidgetRef ref, int current, AppLocalizations l10n) {
    const options = [1, 2, 3, 5, 7, 10, 14];
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Text(l10n.notifyDaysBefore, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            for (final d in options)
              ListTile(
                title: Text('$d'),
                trailing: current == d ? const Icon(Icons.check, color: Color(0xFF4F6AF0)) : null,
                onTap: () async {
                  Navigator.pop(context);
                  await ref.read(settingsProvider.notifier).setNotificationDaysBefore(d);
                  final s = ref.read(settingsProvider);
                  if (s.notificationsEnabled) {
                    await _rescheduleAll(l10n, ref, d, s.currency);
                  }
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleBiometric(BuildContext context, WidgetRef ref, bool enable, AppLocalizations l10n) async {
    if (enable) {
      final available = await BiometricService.isAvailable();
      if (!available) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Biometrics not available on this device')),
          );
        }
        return;
      }
      final ok = await BiometricService.authenticate(l10n.enableBiometric);
      if (!ok) return;
    }
    await ref.read(settingsProvider.notifier).setBiometric(enable);
  }
}

class _ProBanner extends StatelessWidget {
  final AppLocalizations l10n;
  const _ProBanner({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4F6AF0), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                  child: const Text('PRO', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                ),
                const SizedBox(height: 8),
                Text(l10n.proDescription, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          l10n.proCta,
                          style: const TextStyle(color: Color(0xFF4F6AF0), fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.proCtaYearly,
                          style: TextStyle(color: const Color(0xFF4F6AF0).withValues(alpha: 0.6), fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.workspace_premium, color: Colors.white, size: 48),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _ProSectionHeader extends StatelessWidget {
  final String title;
  const _ProSectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF4F6AF0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock, color: Colors.white, size: 9),
                const SizedBox(width: 2),
                const Text('PRO', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(children: children),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, indent: 16, endIndent: 0, color: Theme.of(context).colorScheme.outlineVariant);
  }
}

class _ThemeTile extends StatelessWidget {
  final ThemeMode current;
  final ValueChanged<ThemeMode> onChanged;
  final AppLocalizations l10n;
  const _ThemeTile({required this.current, required this.onChanged, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final options = {
      ThemeMode.system: l10n.themeSystem,
      ThemeMode.light: l10n.themeLight,
      ThemeMode.dark: l10n.themeDark,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.brightness_auto_outlined, color: theme.colorScheme.onSurfaceVariant, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text(l10n.theme, style: theme.textTheme.bodyMedium)),
          DropdownButton<ThemeMode>(
            value: current,
            underline: const SizedBox.shrink(),
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary),
            items: options.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
            onChanged: (v) => v != null ? onChanged(v) : null,
          ),
        ],
      ),
    );
  }
}

class _CurrencyTile extends StatelessWidget {
  final String current;
  final ValueChanged<String> onChanged;
  final AppLocalizations l10n;
  const _CurrencyTile({required this.current, required this.onChanged, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Find current option or fallback to USD
    final currentOption = _currencies.firstWhere(
      (c) => c.symbol == current,
      orElse: () => _currencies.first,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.currency_exchange, color: theme.colorScheme.onSurfaceVariant, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text(l10n.currency, style: theme.textTheme.bodyMedium)),
          DropdownButton<_CurrencyOption>(
            value: currentOption,
            underline: const SizedBox.shrink(),
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary),
            items: _currencies.map((c) => DropdownMenuItem(value: c, child: Text(c.display))).toList(),
            onChanged: (v) => v != null ? onChanged(v.symbol) : null,
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
          Text(value, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _LinkTile({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.onSurfaceVariant, size: 22),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
            Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant, size: 20),
          ],
        ),
      ),
    );
  }
}

class _NotificationsToggleTile extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final AppLocalizations l10n;
  const _NotificationsToggleTile({required this.enabled, required this.onChanged, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.notifications_outlined, color: theme.colorScheme.onSurfaceVariant, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text(l10n.enableNotifications, style: theme.textTheme.bodyMedium)),
          Switch(value: enabled, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _NotifyDaysTile extends StatelessWidget {
  final int days;
  final bool enabled;
  final AppLocalizations l10n;
  final VoidCallback onTap;
  const _NotifyDaysTile({required this.days, required this.enabled, required this.l10n, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLocked = !AppConstants.kDebugProUnlocked;
    final textColor = isLocked
        ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
        : theme.colorScheme.onSurface;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.alarm_outlined,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: isLocked ? 0.4 : 1.0), size: 22),
            const SizedBox(width: 12),
            Expanded(child: Text(l10n.notifyDaysBefore,
                style: theme.textTheme.bodyMedium?.copyWith(color: textColor))),
            if (isLocked)
              Icon(Icons.lock_outline, size: 16, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5))
            else ...[
              Text('$days', style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary, fontWeight: FontWeight.w600)),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}

class _BackupTile extends StatefulWidget {
  final AppLocalizations l10n;
  const _BackupTile({required this.l10n});

  @override
  State<_BackupTile> createState() => _BackupTileState();
}

class _BackupTileState extends State<_BackupTile> {
  bool _loading = false;

  Future<void> _backup() async {
    if (!AppConstants.kDebugProUnlocked) {
      showProGateSheet(context);
      return;
    }
    setState(() => _loading = true);
    try {
      await BackupService.uploadBackup();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(widget.l10n.backupSaved),
      ));
    } catch (e) {
      if (!mounted) return;
      final raw = e.toString();
      if (raw.contains('sign_in_cancelled')) return;
      final msg = raw.contains('db_file_not_found')
          ? 'DB file not found'
          : '${widget.l10n.backupFailed}: $raw';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), duration: const Duration(seconds: 6)));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLocked = !AppConstants.kDebugProUnlocked;
    final textColor = isLocked
        ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
        : theme.colorScheme.onSurface;
    return InkWell(
      onTap: _loading ? null : _backup,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.backup_outlined,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: isLocked ? 0.4 : 1.0), size: 22),
            const SizedBox(width: 12),
            Expanded(child: Text(widget.l10n.backupToGoogleDrive,
                style: theme.textTheme.bodyMedium?.copyWith(color: textColor))),
            if (_loading)
              const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
            else if (isLocked)
              Icon(Icons.lock_outline, size: 16, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5))
            else
              Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant, size: 20),
          ],
        ),
      ),
    );
  }
}

class _RestoreTile extends StatefulWidget {
  final AppLocalizations l10n;
  const _RestoreTile({required this.l10n});

  @override
  State<_RestoreTile> createState() => _RestoreTileState();
}

class _RestoreTileState extends State<_RestoreTile> {
  bool _loading = false;

  Future<void> _restore() async {
    if (!AppConstants.kDebugProUnlocked) {
      showProGateSheet(context);
      return;
    }
    setState(() => _loading = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await BackupService.downloadBackup();
      messenger.showSnackBar(SnackBar(
        content: Text(widget.l10n.dataRestored),
        duration: const Duration(seconds: 2),
      ));
      await Future.delayed(const Duration(milliseconds: 1500));
      skipBiometricOnce = true;
      restartApp();
    } catch (e) {
      if (!mounted) return;
      final raw = e.toString();
      final msg = raw.contains('backup_not_found')
          ? widget.l10n.backupNotFound
          : raw.contains('sign_in_cancelled')
              ? 'Sign in cancelled'
              : '${widget.l10n.backupFailed}: $raw';
      messenger.showSnackBar(SnackBar(content: Text(msg), duration: const Duration(seconds: 6)));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLocked = !AppConstants.kDebugProUnlocked;
    final textColor = isLocked
        ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
        : theme.colorScheme.onSurface;
    return InkWell(
      onTap: _loading ? null : _restore,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.restore_outlined,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: isLocked ? 0.4 : 1.0), size: 22),
            const SizedBox(width: 12),
            Expanded(child: Text(widget.l10n.restoreFromBackup,
                style: theme.textTheme.bodyMedium?.copyWith(color: textColor))),
            if (_loading)
              const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
            else if (isLocked)
              Icon(Icons.lock_outline, size: 16, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5))
            else
              Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant, size: 20),
          ],
        ),
      ),
    );
  }
}

class _RestorePurchasesTile extends StatefulWidget {
  final AppLocalizations l10n;
  const _RestorePurchasesTile({required this.l10n});

  @override
  State<_RestorePurchasesTile> createState() => _RestorePurchasesTileState();
}

class _RestorePurchasesTileState extends State<_RestorePurchasesTile> {
  bool _loading = false;

  Future<void> _restore() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(widget.l10n.restorePurchasesSuccess)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: _loading ? null : _restore,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.receipt_long_outlined, color: theme.colorScheme.onSurfaceVariant, size: 22),
            const SizedBox(width: 12),
            Expanded(child: Text(widget.l10n.restorePurchases, style: theme.textTheme.bodyMedium)),
            if (_loading)
              const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
            else
              Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant, size: 20),
          ],
        ),
      ),
    );
  }
}

class _BiometricTile extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final AppLocalizations l10n;
  const _BiometricTile({required this.enabled, required this.onChanged, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.fingerprint, color: theme.colorScheme.onSurfaceVariant, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text(l10n.enableBiometric, style: theme.textTheme.bodyMedium)),
          Switch(value: enabled, onChanged: onChanged),
        ],
      ),
    );
  }
}
