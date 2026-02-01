class Song {
  final String id;
  String title;
  String composer;
  String key; // Tonart
  String notes;
  String fullLyrics;
  List<String> verses;
  List<String> categories;
  int skillRating;
  int likeRating;
  DateTime dateCreated;
  DateTime dateModified;

  Song({
    required this.id,
    required this.title,
    this.composer = '',
    this.key = '',
    this.notes = '',
    this.fullLyrics = '',
    List<String>? verses,
    List<String>? categories,
    this.skillRating = 0,
    this.likeRating = 0,
    DateTime? dateCreated,
    DateTime? dateModified,
  })  : verses = verses ?? [],
        categories = categories ?? [],
        dateCreated = dateCreated ?? DateTime.now(),
        dateModified = dateModified ?? DateTime.now();

  // Convert to TXT format for file export
  String toTxtFormat() {
    final buffer = StringBuffer();
    
    // First section: metadata
    buffer.writeln('Titel: $title');
    if (composer.isNotEmpty) buffer.writeln('Komponist: $composer');
    if (key.isNotEmpty) buffer.writeln('Tonart: $key');
    if (notes.isNotEmpty) buffer.writeln('Notizen: $notes');
    buffer.writeln('Können: ${"★" * skillRating}${"☆" * (5 - skillRating)}');
    buffer.writeln('Mögen: ${"★" * likeRating}${"☆" * (5 - likeRating)}');
    if (categories.isNotEmpty) {
      buffer.writeln('Kategorien: ${categories.join(", ")}');
    }
    buffer.writeln(); // Empty line separator
    
    // Verses as separate sections
    for (var verse in verses) {
      buffer.writeln(verse);
      buffer.writeln(); // Empty line between verses
    }
    
    return buffer.toString();
  }

  // Parse from TXT format
  static Song fromTxtFormat(String content, String filename) {
    final lines = content.split('\n');
    
    String title = '';
    String composer = '';
    String key = '';
    String notes = '';
    int skillRating = 0;
    int likeRating = 0;
    List<String> categories = [];
    List<String> verses = [];
    
    bool inMetadata = true;
    StringBuffer currentVerse = StringBuffer();
    
    for (var line in lines) {
      if (inMetadata) {
        if (line.trim().isEmpty) {
          inMetadata = false;
          continue;
        }
        
        if (line.startsWith('Titel: ')) {
          title = line.substring(7).trim();
        } else if (line.startsWith('Komponist: ')) {
          composer = line.substring(11).trim();
        } else if (line.startsWith('Tonart: ')) {
          key = line.substring(8).trim();
        } else if (line.startsWith('Notizen: ')) {
          notes = line.substring(9).trim();
        } else if (line.startsWith('Können: ')) {
          skillRating = '★'.allMatches(line).length;
        } else if (line.startsWith('Mögen: ')) {
          likeRating = '★'.allMatches(line).length;
        } else if (line.startsWith('Kategorien: ')) {
          final catString = line.substring(12).trim();
          categories = catString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
        }
      } else {
        // Parsing verses
        if (line.trim().isEmpty) {
          if (currentVerse.toString().trim().isNotEmpty) {
            verses.add(currentVerse.toString().trim());
            currentVerse.clear();
          }
        } else {
          if (currentVerse.isNotEmpty) {
            currentVerse.write('\n');
          }
          currentVerse.write(line);
        }
      }
    }
    
    // Add last verse if exists
    if (currentVerse.toString().trim().isNotEmpty) {
      verses.add(currentVerse.toString().trim());
    }
    
    if (title.isEmpty) {
      title = filename.replaceAll('.txt', '');
    }
    
    return Song(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      composer: composer,
      key: key,
      notes: notes,
      verses: verses,
      fullLyrics: verses.join('\n\n'),
      categories: categories,
      skillRating: skillRating,
      likeRating: likeRating,
    );
  }

  // Convert to JSON for local storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'composer': composer,
      'key': key,
      'notes': notes,
      'fullLyrics': fullLyrics,
      'verses': verses,
      'categories': categories,
      'skillRating': skillRating,
      'likeRating': likeRating,
      'dateCreated': dateCreated.toIso8601String(),
      'dateModified': dateModified.toIso8601String(),
    };
  }

  // Create from JSON
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String,
      title: json['title'] as String,
      composer: json['composer'] as String? ?? '',
      key: json['key'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      fullLyrics: json['fullLyrics'] as String? ?? '',
      verses: (json['verses'] as List?)?.cast<String>() ?? [],
      categories: (json['categories'] as List?)?.cast<String>() ?? [],
      skillRating: json['skillRating'] as int? ?? 0,
      likeRating: json['likeRating'] as int? ?? 0,
      dateCreated: json['dateCreated'] != null 
          ? DateTime.parse(json['dateCreated'] as String)
          : DateTime.now(),
      dateModified: json['dateModified'] != null
          ? DateTime.parse(json['dateModified'] as String)
          : DateTime.now(),
    );
  }

  Song copy() {
    return Song(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '$title (Kopie)',
      composer: composer,
      key: key,
      notes: notes,
      fullLyrics: fullLyrics,
      verses: List.from(verses),
      categories: List.from(categories),
      skillRating: skillRating,
      likeRating: likeRating,
    );
  }
}
