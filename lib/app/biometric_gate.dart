import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/biometric_service.dart';
import '../features/settings/settings_provider.dart';
import '../generated/app_localizations.dart';

class BiometricGate extends ConsumerStatefulWidget {
  final Widget child;
  const BiometricGate({super.key, required this.child});

  @override
  ConsumerState<BiometricGate> createState() => _BiometricGateState();
}

class _BiometricGateState extends ConsumerState<BiometricGate> with WidgetsBindingObserver {
  bool _locked = false;
  bool _checking = false;
  bool _isInitialCheck = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkInitialLock());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      final settings = ref.read(settingsProvider);
      if (settings.biometricEnabled) setState(() => _locked = true);
    }
    if (state == AppLifecycleState.resumed && _locked && !_isInitialCheck) {
      _authenticate();
    }
  }

  Future<void> _checkInitialLock() async {
    if (!mounted) return;
    final settings = ref.read(settingsProvider);
    if (!settings.biometricEnabled) return;
    final available = await BiometricService.isAvailable();
    if (available && mounted) {
      _isInitialCheck = true;
      setState(() => _locked = true);
      await _authenticate();
      _isInitialCheck = false;
    }
  }

  Future<void> _authenticate() async {
    if (_checking) return;
    setState(() => _checking = true);
    final l10n = AppLocalizations.of(context);
    final reason = l10n?.enableBiometric ?? 'Unlock RentFlow';
    final ok = await BiometricService.authenticate(reason);
    if (mounted) setState(() { _locked = !ok; _checking = false; });
  }

  @override
  Widget build(BuildContext context) {
    if (!_locked) return widget.child;

    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fingerprint, size: 80, color: theme.colorScheme.primary),
            const SizedBox(height: 24),
            Text(
              'RentFlow',
              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _checking ? null : _authenticate,
              icon: _checking
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Icon(Icons.fingerprint),
              label: Text(l10n?.enableBiometric ?? 'Unlock'),
            ),
          ],
        ),
      ),
    );
  }
}
