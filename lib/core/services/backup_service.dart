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

  static Future<bool> uploadBackup() async {
    try {
      final api = await _getDriveApi();
      if (api == null) return false;

      final dbFile = await _getDbFile();
      if (!await dbFile.exists()) return false;

      // Ищем существующий файл бэкапа
      final fileList = await api.files.list(
        spaces: 'appDataFolder',
        $fields: 'files(id)',
        q: "name='$_backupFileName'",
      );

      final media = drive.Media(dbFile.openRead(), await dbFile.length());
      final driveFile = drive.File()
        ..name = _backupFileName
        ..parents = ['appDataFolder'];

      if (fileList.files != null && fileList.files!.isNotEmpty) {
        final existingId = fileList.files!.first.id!;
        await api.files.update(driveFile, existingId, uploadMedia: media);
      } else {
        await api.files.create(driveFile, uploadMedia: media);
      }
      return true;
    } catch (e) {
      debugPrint('Backup upload error: $e');
      return false;
    }
  }

  static Future<bool> downloadBackup() async {
    try {
      final api = await _getDriveApi();
      if (api == null) return false;

      final fileList = await api.files.list(
        spaces: 'appDataFolder',
        $fields: 'files(id,modifiedTime)',
        q: "name='$_backupFileName'",
      );

      if (fileList.files == null || fileList.files!.isEmpty) return false;

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
      return true;
    } catch (e) {
      debugPrint('Backup download error: $e');
      return false;
    }
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
