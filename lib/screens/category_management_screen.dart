import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/song_provider.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() => _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  final TextEditingController _categoryController = TextEditingController();

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategorien verwalten'),
      ),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Add category field
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _categoryController,
                        decoration: const InputDecoration(
                          labelText: 'Neue Kategorie',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (value) => _addCategory(songProvider),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () => _addCategory(songProvider),
                      icon: const Icon(Icons.add),
                      label: const Text('Hinzufügen'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Category list
                Expanded(
                  child: songProvider.categories.isEmpty
                      ? const Center(
                          child: Text(
                            'Keine Kategorien vorhanden',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: songProvider.categories.length,
                          itemBuilder: (context, index) {
                            final category = songProvider.categories[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Text(
                                  category,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _confirmDelete(songProvider, category),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _addCategory(SongProvider songProvider) {
    final category = _categoryController.text.trim();
    if (category.isNotEmpty) {
      songProvider.addCategory(category);
      _categoryController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kategorie hinzugefügt')),
      );
    }
  }

  void _confirmDelete(SongProvider songProvider, String category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kategorie löschen?'),
        content: Text(
          'Möchtest du die Kategorie "$category" wirklich löschen?\n\n'
          'Sie wird aus allen Liedern entfernt.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () {
              songProvider.deleteCategory(category);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kategorie gelöscht')),
              );
            },
            child: const Text('Löschen', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
