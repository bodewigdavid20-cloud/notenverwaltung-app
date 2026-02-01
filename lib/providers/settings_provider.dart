import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StorageType { local, folder }

class SettingsProvider extends ChangeNotifier {
  StorageType _storageType = StorageType.local;
  String _folderPath = '';

  StorageType get storageType => _storageType;
  String get folderPath => _folderPath;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final typeIndex = prefs.getInt('storageType') ?? 0;
    _storageType = StorageType.values[typeIndex];
    _folderPath = prefs.getString('folderPath') ?? '';
    notifyListeners();
  }

  Future<void> setStorageType(StorageType type) async {
    _storageType = type;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('storageType', type.index);
    notifyListeners();
  }

  Future<void> setFolderPath(String path) async {
    _folderPath = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('folderPath', path);
    notifyListeners();
  }

  String get storageTypeDescription {
    switch (_storageType) {
      case StorageType.local:
        return 'Lokal im App-Speicher';
      case StorageType.folder:
        return _folderPath.isEmpty ? 'Ordner nicht ausgewählt' : _folderPath;
    }
  }
}
