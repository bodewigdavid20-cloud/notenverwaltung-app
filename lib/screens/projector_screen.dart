import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/song_provider.dart';
import '../models/song.dart';

class ProjectorScreen extends StatefulWidget {
  const ProjectorScreen({super.key});

  @override
  State<ProjectorScreen> createState() => _ProjectorScreenState();
}

class _ProjectorScreenState extends State<ProjectorScreen> {
  bool _isBlackout = false;
  String? _selectedCategory;
  String _sortBy = 'title';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isBlackout ? Colors.black : Colors.white,
      body: Stack(
        children: [
          // Main content
          if (!_isBlackout) _buildMainContent(),
          
          // Top controls
          Positioned(
            top: 16,
            left: 16,
            child: _buildSongSelector(),
          ),
          
          // Blackout button
          Positioned(
            top: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _isBlackout = !_isBlackout;
                });
              },
              icon: Icon(_isBlackout ? Icons.visibility : Icons.visibility_off),
              label: Text(_isBlackout ? 'Anzeigen' : 'Blackout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
          ),
          
          // Close button
          Positioned(
            top: 16,
            right: 200,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              iconSize: 32,
              onPressed: () => Navigator.pop(context),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Consumer<SongProvider>(
      builder: (context, songProvider, child) {
        if (songProvider.selectedSong == null) {
          return const Center(
            child: Text(
              'Kein Lied ausgewählt',
              style: TextStyle(fontSize: 48, color: Colors.grey),
            ),
          );
        }

        final song = songProvider.selectedSong!;
        final selectedVerse = songProvider.selectedVerseIndex;

        // Display selected verse or nothing if index is -1
        if (selectedVerse >= 0 && selectedVerse < song.verses.length) {
          return Container(
            color: Colors.black,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(64),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      song.title,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (song.composer.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        song.composer,
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 48),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Text(
                          song.verses[selectedVerse],
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            height: 1.8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // No verse selected - show empty black screen or title only
        return Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  song.title,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (song.composer.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    song.composer,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSongSelector() {
    return Consumer<SongProvider>(
      builder: (context, songProvider, child) {
        final songs = songProvider.getFilteredSongs(
          category: _selectedCategory,
          sortBy: _sortBy,
        );

        return Material(
          color: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown button
                ElevatedButton.icon(
                  onPressed: () {
                    _showSongSelectorDialog(songs);
                  },
                  icon: const Icon(Icons.library_music),
                  label: const Text('Lied auswählen'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSongSelectorDialog(List<Song> songs) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF1F1F33),
          child: Container(
            width: 600,
            height: 700,
            padding: const EdgeInsets.all(24),
            child: Consumer<SongProvider>(
              builder: (context, songProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Lied auswählen',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD4AF37),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Filters
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedCategory,
                            decoration: const InputDecoration(
                              labelText: 'Kategorie',
                              border: OutlineInputBorder(),
                            ),
                            dropdownColor: const Color(0xFF1F1F33),
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('Alle'),
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
                              Navigator.pop(context);
                              _showSongSelectorDialog(
                                songProvider.getFilteredSongs(
                                  category: value,
                                  sortBy: _sortBy,
                                ),
                              );
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
                            dropdownColor: const Color(0xFF1F1F33),
                            items: const [
                              DropdownMenuItem(value: 'title', child: Text('Titel')),
                              DropdownMenuItem(value: 'composer', child: Text('Komponist')),
                              DropdownMenuItem(value: 'skill', child: Text('Können')),
                              DropdownMenuItem(value: 'like', child: Text('Beliebtheit')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _sortBy = value!;
                              });
                              Navigator.pop(context);
                              _showSongSelectorDialog(
                                songProvider.getFilteredSongs(
                                  category: _selectedCategory,
                                  sortBy: value,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Song list
                    Expanded(
                      child: ListView.builder(
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          final song = songs[index];
                          final isSelected = songProvider.selectedSong?.id == song.id;
                          
                          return Card(
                            color: isSelected 
                                ? const Color(0xFFD4AF37).withOpacity(0.3)
                                : const Color(0xFF16213E),
                            child: ListTile(
                              title: Text(
                                song.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF4E4B5),
                                ),
                              ),
                              subtitle: song.composer.isNotEmpty
                                  ? Text(song.composer)
                                  : null,
                              trailing: isSelected 
                                  ? const Icon(Icons.check, color: Color(0xFFD4AF37))
                                  : null,
                              onTap: () {
                                songProvider.selectSong(song);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
