import 'package:flutter/material.dart';
import '../../../generated/app_localizations.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.faqTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.faqHowToUseTab),
              Tab(text: l10n.faqProTab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _HowToUseTab(l10n: l10n),
            _ProTab(l10n: l10n),
          ],
        ),
      ),
    );
  }
}

// ── How to Use ───────────────────────────────────────────────────────────────

class _HowToUseTab extends StatelessWidget {
  final AppLocalizations l10n;
  const _HowToUseTab({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SectionLabel(l10n.faqGettingStarted),
        const SizedBox(height: 8),
        _StepCard(step: 1, title: l10n.faqStep1Title, body: l10n.faqStep1Body),
        _StepCard(step: 2, title: l10n.faqStep2Title, body: l10n.faqStep2Body),
        _StepCard(step: 3, title: l10n.faqStep3Title, body: l10n.faqStep3Body),
        _StepCard(step: 4, title: l10n.faqStep4Title, body: l10n.faqStep4Body),
        _StepCard(step: 5, title: l10n.faqStep5Title, body: l10n.faqStep5Body),
        const SizedBox(height: 20),
        _SectionLabel(l10n.faqTipsTitle),
        const SizedBox(height: 8),
        _TipCard(icon: Icons.swipe_right_alt_outlined, text: l10n.faqTip1),
        _TipCard(icon: Icons.touch_app_outlined, text: l10n.faqTip2),
        _TipCard(icon: Icons.calendar_month_outlined, text: l10n.faqTip3),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int step;
  final String title;
  final String body;
  const _StepCard({required this.step, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$step',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(body, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final IconData icon;
  final String text;
  const _TipCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.tertiary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(text, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface)),
            ),
          ],
        ),
      ),
    );
  }
}

// ── PRO Tab ──────────────────────────────────────────────────────────────────

class _ProTab extends StatelessWidget {
  final AppLocalizations l10n;
  const _ProTab({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final proItems = [
      (Icons.home_work_outlined, l10n.faqProProperties),
      (Icons.picture_as_pdf_outlined, l10n.exportPdf),
      (Icons.backup_outlined, l10n.backupToGoogleDrive),
      (Icons.alarm_outlined, l10n.faqProNotifications),
      (Icons.table_chart_outlined, l10n.exportCsv),
      (Icons.label_outline, l10n.customCategories),
      (Icons.repeat, l10n.faqProRecurring),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
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
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('PRO', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(height: 8),
                    Text(l10n.proDescription, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(l10n.proCta, style: const TextStyle(color: Color(0xFF4F6AF0), fontSize: 13, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(l10n.proCtaYearly, style: TextStyle(color: const Color(0xFF4F6AF0).withValues(alpha: 0.6), fontSize: 11)),
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
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Column(
            children: [
              for (int i = 0; i < proItems.length; i++) ...[
                if (i > 0) Divider(height: 1, indent: 16, color: theme.colorScheme.outlineVariant),
                _ProFeatureRow(icon: proItems[i].$1, label: proItems[i].$2),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _ProFeatureRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ProFeatureRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF4F6AF0)),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
          const Icon(Icons.check_circle, size: 18, color: Color(0xFF34C759)),
        ],
      ),
    );
  }
}
