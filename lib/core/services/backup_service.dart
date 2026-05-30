import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class BackupService {
  static final _googleSignIn = GoogleSignIn(
    scopes: [drive.DriveApi.driveAppdataScope],
  );

  static const _backupFileName = 'rentflow_backup.db';

  static Future<GoogleSignInAccount?> signIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (e) {
      debugPrint('Google Sign In error: $e');
      return null;
    }
  }

  static Future<void> signOut() => _googleSignIn.signOut();

  static Future<GoogleSignInAccount?> get currentUser async =>
      _googleSignIn.currentUser ?? await _googleSignIn.signInSilently();

  static Future<drive.DriveApi?> _getDriveApi() async {
    final account = await currentUser;
    if (account == null) return null;
    final headers = await account.authHeaders;
    return drive.DriveApi(_AuthClient(headers));
  }

  static Future<GoogleSignInAccount> _requireAccount() async {
    final existing = _googleSignIn.currentUser ?? await _googleSignIn.signInSilently();
    if (existing != null) return existing;
    final account = await _googleSignIn.signIn();
    if (account == null) throw Exception('sign_in_cancelled');
    return account;
  }

  static Future<void> uploadBackup() async {
    final account = await _requireAccount();

    final headers = await account.authHeaders;
    final api = drive.DriveApi(_AuthClient(headers));

    final dbFile = await _getDbFile();
    debugPrint('DB path: ${dbFile.path}, exists: ${await dbFile.exists()}');
    if (!await dbFile.exists()) throw Exception('db_file_not_found: ${dbFile.path}');

    final fileList = await api.files.list(
      spaces: 'appDataFolder',
      $fields: 'files(id)',
      q: "name='$_backupFileName'",
    );

    final media = drive.Media(dbFile.openRead(), await dbFile.length());

    if (fileList.files != null && fileList.files!.isNotEmpty) {
      final updateFile = drive.File()..name = _backupFileName;
      await api.files.update(updateFile, fileList.files!.first.id!, uploadMedia: media);
    } else {
      final createFile = drive.File()
        ..name = _backupFileName
        ..parents = ['appDataFolder'];
      await api.files.create(createFile, uploadMedia: media);
    }
  }

  static Future<void> downloadBackup() async {
    final account = await _requireAccount();

    final headers = await account.authHeaders;
    final api = drive.DriveApi(_AuthClient(headers));

    final fileList = await api.files.list(
      spaces: 'appDataFolder',
      $fields: 'files(id,modifiedTime)',
      q: "name='$_backupFileName'",
    );

    if (fileList.files == null || fileList.files!.isEmpty) {
      throw Exception('backup_not_found');
    }

    final fileId = fileList.files!.first.id!;
    final response = await api.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    final dbFile = await _getDbFile();
    final bytes = <int>[];
    await for (final chunk in response.stream) {
      bytes.addAll(chunk);
    }
    await dbFile.writeAsBytes(bytes);
  }

  static Future<DateTime?> getLastBackupTime() async {
    try {
      final api = await _getDriveApi();
      if (api == null) return null;

      final fileList = await api.files.list(
        spaces: 'appDataFolder',
        $fields: 'files(modifiedTime)',
        q: "name='$_backupFileName'",
      );

      if (fileList.files == null || fileList.files!.isEmpty) return null;
      return fileList.files!.first.modifiedTime;
    } catch (_) {
      return null;
    }
  }

  static Future<File> _getDbFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/rentflow_db.sqlite');
  }
}

class _AuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _inner = http.Client();
  _AuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _inner.send(request);
  }
}
