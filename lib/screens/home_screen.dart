import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/song_provider.dart';
import '../providers/settings_provider.dart';
import '../models/song.dart';
import 'song_edit_screen.dart';
import 'projector_screen.dart';
import 'settings_screen.dart';
import 'category_management_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory;
  String _sortBy = 'title';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('♪ Notenverwaltung'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder),
            tooltip: 'Kategorien verwalten',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryManagementScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Einstellungen',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Left Panel - Song List
          Expanded(
            flex: 2,
            child: _buildSongList(),
          ),
          
          // Right Panel - Selected Song Details or Projector Controls
          Expanded(
            flex: 1,
            child: _buildRightPanel(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SongEditScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Neues Lied'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.black,
      ),
    );
  }

  Widget _buildSongList() {
    return Consumer<SongProvider>(
      builder: (context, songProvider, child) {
        final songs = songProvider.getFilteredSongs(
          category: _selectedCategory,
          sortBy: _sortBy,
        );

        return Column(
          children: [
            // Filter and Sort Controls
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Kategorie filtern',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('Alle Kategorien'),
                        ),
                        ...songProvider.categories.map(
                          (cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _sortBy,
                      decoration: const InputDecoration(
                        labelText: 'Sortieren',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'title', child: Text('Titel')),
                        DropdownMenuItem(value: 'composer', child: Text('Komponist')),
                        DropdownMenuItem(value: 'date', child: Text('Datum')),
                        DropdownMenuItem(value: 'skill', child: Text('Können')),
                        DropdownMenuItem(value: 'like', child: Text('Beliebtheit')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _sortBy = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Song List
            Expanded(
              child: songs.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.music_note, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Keine Lieder vorhanden',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        final isSelected = songProvider.selectedSong?.id == song.id;
                        
                        return Card(
                          elevation: isSelected ? 8 : 2,
                          color: isSelected 
                              ? Theme.of(context).colorScheme.surface
                              : null,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () {
                              songProvider.selectSong(song);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              song.title,
                                              style: Theme.of(context).textTheme.headlineMedium,
                                            ),
                                            if (song.composer.isNotEmpty)
                                              Text(
                                                song.composer,
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                            if (song.key.isNotEmpty)
                                              Text(
                                                'Tonart: ${song.key}',
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuButton<String>(
                                        icon: const Icon(Icons.more_vert),
                                        onSelected: (value) {
                                          _handleSongAction(value, song);
                                        },
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 'edit',
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit),
                                                SizedBox(width: 8),
                                                Text('Bearbeiten'),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'duplicate',
                                            child: Row(
                                              children: [
                                                Icon(Icons.copy),
                                                SizedBox(width: 8),
                                                Text('Duplizieren'),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'export',
                                            child: Row(
                                              children: [
                                                Icon(Icons.download),
                                                SizedBox(width: 8),
                                                Text('Exportieren'),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete, color: Colors.red),
                                                SizedBox(width: 8),
                                                Text('Löschen', style: TextStyle(color: Colors.red)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      _buildRatingDisplay('Können', song.skillRating),
                                      const SizedBox(width: 24),
                                      _buildRatingDisplay('Mögen', song.likeRating),
                                    ],
                                  ),
                                  if (song.categories.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      children: song.categories.map(
                                        (cat) => Chip(
                                          label: Text(cat),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.2),
                                        ),
                                      ).toList(),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRightPanel() {
    return Consumer<SongProvider>(
      builder: (context, songProvider, child) {
        if (songProvider.selectedSong == null) {
          return Container(
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.music_note, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Kein Lied ausgewählt',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProjectorScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.slideshow),
                    label: const Text('Beamer öffnen'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final song = songProvider.selectedSong!;
        
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              // Header with projector button
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        song.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProjectorScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.slideshow),
                      label: const Text('Beamer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Full lyrics with verse selection
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: song.verses.length,
                  itemBuilder: (context, index) {
                    final verse = song.verses[index];
                    final isSelected = songProvider.selectedVerseIndex == index;
                    
                    return Card(
                      color: isSelected 
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                          : null,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          if (isSelected) {
                            songProvider.selectVerse(-1); // Deselect
                          } else {
                            songProvider.selectVerse(index);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Strophe ${index + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                verse,
                                style: const TextStyle(fontSize: 16, height: 1.5),
                              ),
                            ],
                          ),
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
    );
  }

  Widget _buildRatingDisplay(String label, int rating) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: index < rating ? Colors.amber : Colors.grey,
            size: 16,
          ),
        ),
      ],
    );
  }

  void _handleSongAction(String action, Song song) {
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    
    switch (action) {
      case 'edit':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongEditScreen(song: song),
          ),
        );
        break;
      case 'duplicate':
        songProvider.duplicateSong(song);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lied dupliziert')),
        );
        break;
      case 'export':
        _exportSong(song);
        break;
      case 'delete':
        _confirmDelete(song);
        break;
    }
  }

  Future<void> _exportSong(Song song) async {
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    try {
      final path = await songProvider.exportSongToTxt(song);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exportiert nach: $path')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Export: $e')),
        );
      }
    }
  }

  void _confirmDelete(Song song) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lied löschen?'),
        content: Text('Möchtest du "${song.title}" wirklich löschen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () {
              final songProvider = Provider.of<SongProvider>(context, listen: false);
              songProvider.deleteSong(song.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Lied gelöscht')),
              );
            },
            child: const Text('Löschen', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
