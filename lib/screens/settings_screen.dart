import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/settings_provider.dart';
import '../providers/song_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Speicherort',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Consumer<SettingsProvider>(
                    builder: (context, settings, child) {
                      return Column(
                        children: [
                          RadioListTile<StorageType>(
                            title: const Text('Lokal im App-Speicher'),
                            subtitle: const Text('Daten bleiben in der App gespeichert'),
                            value: StorageType.local,
                            groupValue: settings.storageType,
                            onChanged: (value) {
                              if (value != null) {
                                settings.setStorageType(value);
                              }
                            },
                          ),
                          RadioListTile<StorageType>(
                            title: const Text('Ordner auf dem Computer'),
                            subtitle: Text(
                              settings.folderPath.isEmpty 
                                  ? 'Noch kein Ordner ausgewählt'
                                  : settings.folderPath,
                            ),
                            value: StorageType.folder,
                            groupValue: settings.storageType,
                            onChanged: (value) {
                              if (value != null) {
                                settings.setStorageType(value);
                              }
                            },
                          ),
                          if (settings.storageType == StorageType.folder)
                            Padding(
                              padding: const EdgeInsets.only(left: 56, top: 8),
                              child: ElevatedButton.icon(
                                onPressed: () => _selectFolder(context, settings),
                                icon: const Icon(Icons.folder_open),
                                label: const Text('Ordner auswählen'),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Import & Export',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.upload_file),
                    title: const Text('Lied importieren'),
                    subtitle: const Text('Einzelne .txt Datei importieren'),
                    onTap: () => _importSong(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.folder_open),
                    title: const Text('Ordner importieren'),
                    subtitle: const Text('Alle .txt Dateien aus einem Ordner'),
                    onTap: () => _importFolder(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.download),
                    title: const Text('Alle exportieren'),
                    subtitle: const Text('Alle Lieder als .txt in einen Ordner'),
                    onTap: () => _exportAll(context),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Über',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  const ListTile(
                    leading: Icon(Icons.music_note),
                    title: Text('Notenverwaltung'),
                    subtitle: Text('Version 1.0.0'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Professionelle Notenverwaltung mit Beamer-Funktion'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectFolder(BuildContext context, SettingsProvider settings) async {
    try {
      final result = await FilePicker.platform.getDirectoryPath();
      if (result != null) {
        await settings.setFolderPath(result);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ordner ausgewählt: $result')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler: $e')),
        );
      }
    }
  }

  Future<void> _importSong(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );
      
      if (result != null && result.files.single.path != null) {
        final file = result.files.single.path!;
        final songProvider = Provider.of<SongProvider>(context, listen: false);
        await songProvider.importSongFromTxt(
          // ignore: avoid_dynamic_calls
          file as dynamic,
        );
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lied importiert')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Import: $e')),
        );
      }
    }
  }

  Future<void> _importFolder(BuildContext context) async {
    try {
      final result = await FilePicker.platform.getDirectoryPath();
      
      if (result != null) {
        final songProvider = Provider.of<SongProvider>(context, listen: false);
        await songProvider.importSongsFromDirectory(result);
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lieder importiert')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Import: $e')),
        );
      }
    }
  }

  Future<void> _exportAll(BuildContext context) async {
    try {
      final result = await FilePicker.platform.getDirectoryPath();
      
      if (result != null) {
        final songProvider = Provider.of<SongProvider>(context, listen: false);
        await songProvider.exportAllSongsToDirectory(result);
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Alle Lieder exportiert nach: $result')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Export: $e')),
        );
      }
    }
  }
}
