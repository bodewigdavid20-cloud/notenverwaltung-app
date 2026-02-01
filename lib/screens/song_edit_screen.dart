import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/song_provider.dart';
import '../models/song.dart';

class SongEditScreen extends StatefulWidget {
  final Song? song;

  const SongEditScreen({super.key, this.song});

  @override
  State<SongEditScreen> createState() => _SongEditScreenState();
}

class _SongEditScreenState extends State<SongEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _composerController;
  late TextEditingController _keyController;
  late TextEditingController _notesController;
  late TextEditingController _lyricsController;
  
  int _skillRating = 0;
  int _likeRating = 0;
  final Set<String> _selectedCategories = {};

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.song?.title ?? '');
    _composerController = TextEditingController(text: widget.song?.composer ?? '');
    _keyController = TextEditingController(text: widget.song?.key ?? '');
    _notesController = TextEditingController(text: widget.song?.notes ?? '');
    _lyricsController = TextEditingController(text: widget.song?.fullLyrics ?? '');
    
    if (widget.song != null) {
      _skillRating = widget.song!.skillRating;
      _likeRating = widget.song!.likeRating;
      _selectedCategories.addAll(widget.song!.categories);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _composerController.dispose();
    _keyController.dispose();
    _notesController.dispose();
    _lyricsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song == null ? 'Neues Lied' : 'Lied bearbeiten'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSong,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titel *',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte Titel eingeben';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _composerController,
              decoration: const InputDecoration(
                labelText: 'Komponist',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _keyController,
              decoration: const InputDecoration(
                labelText: 'Tonart',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notizen',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _lyricsController,
              decoration: const InputDecoration(
                labelText: 'Liedtext (Absätze mit Leerzeile trennen)',
                border: OutlineInputBorder(),
                hintText: 'Strophe 1\n\nStrophe 2\n\nRefrain...',
              ),
              maxLines: 10,
            ),
            const SizedBox(height: 24),
            
            _buildRatingSection('Wie gut können wir das?', _skillRating, (rating) {
              setState(() {
                _skillRating = rating;
              });
            }),
            const SizedBox(height: 16),
            
            _buildRatingSection('Wie gerne mögen wir das?', _likeRating, (rating) {
              setState(() {
                _likeRating = rating;
              });
            }),
            const SizedBox(height: 24),
            
            Consumer<SongProvider>(
              builder: (context, songProvider, child) {
                if (songProvider.categories.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Keine Kategorien vorhanden'),
                    ),
                  );
                }
                
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kategorien',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        ...songProvider.categories.map((category) {
                          return CheckboxListTile(
                            title: Text(category),
                            value: _selectedCategories.contains(category),
                            onChanged: (checked) {
                              setState(() {
                                if (checked == true) {
                                  _selectedCategories.add(category);
                                } else {
                                  _selectedCategories.remove(category);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            
            ElevatedButton.icon(
              onPressed: _saveSong,
              icon: const Icon(Icons.save),
              label: const Text('Speichern'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection(String label, int rating, Function(int) onRatingChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: index < rating ? Colors.amber : Colors.grey,
              ),
              iconSize: 40,
              onPressed: () {
                onRatingChanged(index + 1);
              },
            );
          }),
        ),
      ],
    );
  }

  void _saveSong() {
    if (_formKey.currentState!.validate()) {
      final songProvider = Provider.of<SongProvider>(context, listen: false);
      
      // Parse verses from lyrics
      final verses = _lyricsController.text
          .split(RegExp(r'\n\s*\n'))
          .where((v) => v.trim().isNotEmpty)
          .toList();
      
      if (widget.song == null) {
        // Create new song
        final newSong = Song(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleController.text,
          composer: _composerController.text,
          key: _keyController.text,
          notes: _notesController.text,
          fullLyrics: _lyricsController.text,
          verses: verses,
          categories: _selectedCategories.toList(),
          skillRating: _skillRating,
          likeRating: _likeRating,
        );
        songProvider.addSong(newSong);
      } else {
        // Update existing song
        final updatedSong = Song(
          id: widget.song!.id,
          title: _titleController.text,
          composer: _composerController.text,
          key: _keyController.text,
          notes: _notesController.text,
          fullLyrics: _lyricsController.text,
          verses: verses,
          categories: _selectedCategories.toList(),
          skillRating: _skillRating,
          likeRating: _likeRating,
          dateCreated: widget.song!.dateCreated,
        );
        songProvider.updateSong(updatedSong);
      }
      
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lied gespeichert')),
      );
    }
  }
}
