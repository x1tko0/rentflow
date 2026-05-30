import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/enums.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/database/app_database.dart';
import '../../../features/dashboard/dashboard_providers.dart';
import '../../../generated/app_localizations.dart';
import '../../../shared/providers/pro_status_provider.dart';
import '../../../shared/providers/repository_providers.dart';
import '../../../features/settings/settings_provider.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/pro_gate_sheet.dart';
import 'property_detail_screen.dart';
import 'property_form_screen.dart';

class PropertiesScreen extends ConsumerStatefulWidget {
  const PropertiesScreen({super.key});

  @override
  ConsumerState<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends ConsumerState<PropertiesScreen> {
  bool _searchActive = false;
  String _query = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final properties = ref.watch(propertiesProvider);
    final currency = ref.watch(settingsProvider).currency;

    return Scaffold(
      appBar: AppBar(
        title: _searchActive
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(hintText: l10n.search, border: InputBorder.none),
                onChanged: (v) => setState(() => _query = v.toLowerCase()),
              )
            : Text(l10n.propertiesTitle),
        actions: [
          IconButton(
            icon: Icon(_searchActive ? Icons.close : Icons.search),
            onPressed: () => setState(() {
              _searchActive = !_searchActive;
              if (!_searchActive) { _query = ''; _searchController.clear(); }
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context, null),
        icon: const Icon(Icons.add),
        label: Text(l10n.add),
      ),
      body: properties.when(
        data: (list) {
          final filtered = _query.isEmpty
              ? list
              : list.where((p) =>
                  p.name.toLowerCase().contains(_query) ||
                  p.address.toLowerCase().contains(_query)).toList();
          if (filtered.isEmpty) {
            return _query.isNotEmpty
                ? Center(child: Text(l10n.noResults, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)))
                : _EmptyState(l10n: l10n);
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            itemCount: filtered.length,
            itemBuilder: (ctx, i) => _PropertyCard(
              property: filtered[i],
              currency: currency,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyDetailScreen(property: filtered[i]))),
              onEdit: () => _openForm(context, filtered[i]),
              onDelete: () => _delete(context, filtered[i], l10n),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  Future<void> _openForm(BuildContext context, Property? property) async {
    final isPro = ref.read(proStatusProvider).valueOrNull ?? false;
    if (property == null && !isPro) {
      final list = ref.read(propertiesProvider).valueOrNull ?? [];
      if (list.length >= AppConstants.freePropertyLimit) {
        if (context.mounted) showProGateSheet(context);
        return;
      }
    }
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => PropertyFormScreen(property: property)),
    );
    if (result == true) ref.invalidate(propertiesProvider);
  }

  Future<void> _delete(BuildContext context, Property property, AppLocalizations l10n) async {
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.deletePropertyTitle,
      message: l10n.deletePropertyMessage(property.name),
    );
    if (confirmed) {
      await ref.read(propertyRepositoryProvider).delete(property.id);
    }
  }
}

class _PropertyCard extends StatelessWidget {
  final Property property;
  final String currency;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _PropertyCard({required this.property, required this.currency, required this.onTap, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final type = PropertyType.fromValue(property.type);

    return GestureDetector(
      onTap: onTap,
      child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(12)),
                  child: Icon(_typeIcon(type), color: theme.colorScheme.primary, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(property.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(property.address, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: theme.colorScheme.onSurfaceVariant),
                  onSelected: (v) {
                    if (v == 'edit') onEdit();
                    if (v == 'delete') onDelete();
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(value: 'edit', child: Text(l10n.edit)),
                    PopupMenuItem(value: 'delete', child: Text(l10n.delete, style: const TextStyle(color: Color(0xFFFF3B30)))),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                _Chip(label: type.l10n(l10n), icon: Icons.category_outlined),
                if (property.area != null) ...[
                  const SizedBox(width: 8),
                  _Chip(label: '${property.area!.toStringAsFixed(0)} м²', icon: Icons.square_foot),
                ],
                if (property.purchasePrice != null) ...[
                  const SizedBox(width: 8),
                  _Chip(label: formatMoney(property.purchasePrice!, currency: currency), icon: Icons.sell_outlined),
                ],
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  IconData _typeIcon(PropertyType type) => switch (type) {
        PropertyType.apartment => Icons.apartment,
        PropertyType.house => Icons.house_outlined,
        PropertyType.room => Icons.meeting_room_outlined,
      };
}

class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _Chip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(label, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final AppLocalizations l10n;
  const _EmptyState({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home_outlined, size: 64, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 16),
          Text(l10n.noProperties, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(l10n.tapToStart, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
