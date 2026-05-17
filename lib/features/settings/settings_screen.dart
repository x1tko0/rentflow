import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/biometric_service.dart';
import '../../generated/app_localizations.dart';
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
          ]),
          const SizedBox(height: 20),
          _ProSectionHeader(l10n.notificationsSection),
          _SettingsCard(children: [
            _ProLockedTile(
              label: l10n.enableNotifications,
              icon: Icons.notifications_outlined,
              l10n: l10n,
            ),
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
          const SizedBox(height: 20),
          _ProSectionHeader(l10n.dataSection),
          _SettingsCard(children: [
            _ProLockedTile(label: l10n.backupToGoogleDrive, icon: Icons.backup_outlined, l10n: l10n),
            _Divider(),
            _ProLockedTile(label: l10n.restoreFromBackup, icon: Icons.restore_outlined, l10n: l10n),
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

class _ProLockedTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final AppLocalizations l10n;
  const _ProLockedTile({required this.label, required this.icon, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.proFeatureMessage))),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.onSurfaceVariant, size: 22),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(color: const Color(0xFF4F6AF0).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock, size: 11, color: Color(0xFF4F6AF0)),
                  const SizedBox(width: 3),
                  const Text('PRO', style: TextStyle(color: Color(0xFF4F6AF0), fontSize: 10, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
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
