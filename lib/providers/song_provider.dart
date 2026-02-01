import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import '../models/song.dart';

class SongProvider extends ChangeNotifier {
  List<Song> _songs = [];
  List<String> _categories = [];
  Song? _selectedSong;
  int _selectedVerseIndex = -1;

  List<Song> get songs => _songs;
  List<String> get categories => _categories;
  Song? get selectedSong => _selectedSong;
  int get selectedVerseIndex => _selectedVerseIndex;

  SongProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load categories
    final categoriesJson = prefs.getString('categories');
    if (categoriesJson != null) {
      _categories = List<String>.from(jsonDecode(categoriesJson));
    }
    
    // Load songs
    final songsJson = prefs.getString('songs');
    if (songsJson != null) {
      final List<dynamic> songsList = jsonDecode(songsJson);
      _songs = songsList.map((json) => Song.fromJson(json)).toList();
    }
    
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Save categories
    await prefs.setString('categories', jsonEncode(_categories));
    
    // Save songs
    final songsJson = _songs.map((song) => song.toJson()).toList();
    await prefs.setString('songs', jsonEncode(songsJson));
  }

  // Category management
  void addCategory(String category) {
    if (!_categories.contains(category) && category.isNotEmpty) {
      _categories.add(category);
      _saveData();
      notifyListeners();
    }
  }

  void deleteCategory(String category) {
    _categories.remove(category);
    // Remove category from all songs
    for (var song in _songs) {
      song.categories.remove(category);
    }
    _saveData();
    notifyListeners();
  }

  // Song management
  void addSong(Song song) {
    _songs.add(song);
    _saveData();
    notifyListeners();
  }

  void updateSong(Song updatedSong) {
    final index = _songs.indexWhere((s) => s.id == updatedSong.id);
    if (index != -1) {
      updatedSong.dateModified = DateTime.now();
      _songs[index] = updatedSong;
      _saveData();
      notifyListeners();
    }
  }

  void deleteSong(String songId) {
    _songs.removeWhere((s) => s.id == songId);
    if (_selectedSong?.id == songId) {
      _selectedSong = null;
    }
    _saveData();
    notifyListeners();
  }

  void duplicateSong(Song song) {
    final copy = song.copy();
    _songs.add(copy);
    _saveData();
    notifyListeners();
  }

  // Selection
  void selectSong(Song? song) {
    _selectedSong = song;
    _selectedVerseIndex = -1;
    notifyListeners();
  }

  void selectVerse(int index) {
    _selectedVerseIndex = index;
    notifyListeners();
  }

  // Filtering and sorting
  List<Song> getFilteredSongs({String? category, String? sortBy}) {
    var filtered = List<Song>.from(_songs);
    
    if (category != null && category.isNotEmpty) {
      filtered = filtered.where((s) => s.categories.contains(category)).toList();
    }
    
    switch (sortBy) {
      case 'title':
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'composer':
        filtered.sort((a, b) => a.composer.compareTo(b.composer));
        break;
      case 'date':
        filtered.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
        break;
      case 'skill':
        filtered.sort((a, b) => b.skillRating.compareTo(a.skillRating));
        break;
      case 'like':
        filtered.sort((a, b) => b.likeRating.compareTo(a.likeRating));
        break;
    }
    
    return filtered;
  }

  // File operations
  Future<String> exportSongToTxt(Song song) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${song.title}.txt');
    await file.writeAsString(song.toTxtFormat());
    return file.path;
  }

  Future<void> exportAllSongsToDirectory(String directoryPath) async {
    for (var song in _songs) {
      final file = File('$directoryPath/${song.title}.txt');
      await file.writeAsString(song.toTxtFormat());
    }
  }

  Future<void> importSongFromTxt(File file) async {
    final content = await file.readAsString();
    final filename = file.path.split('/').last;
    final song = Song.fromTxtFormat(content, filename);
    addSong(song);
  }

  Future<void> importSongsFromDirectory(String directoryPath) async {
    final directory = Directory(directoryPath);
    final files = directory.listSync().whereType<File>().where(
      (f) => f.path.endsWith('.txt')
    );
    
    for (var file in files) {
      await importSongFromTxt(file);
    }
  }
}
