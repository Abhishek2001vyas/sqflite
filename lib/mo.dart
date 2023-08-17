final String tableNotes = 'po';

class NotesFields {
  static final List<String> values = [
    /// Add all fields
    id, skill, number, name, description, education,Address
  ];
  static final String id = '_id';
  static final String number = 'number';
  static final String name = 'name';
  static final String description = 'description';
  static final String Address = 'Address';
  static final String skill = 'skill';
  static final String education = 'education';

}

class Notes{
  final int? id;
  final String number;
  final String name;
  final String description;
  final String Address;
  final String skill;
  final String education;

  const Notes({
    this.id,
    required this.number,
    required this.name,
    required this.description,
    required this.Address,
    required this.skill,
    required this.education,

  });
  Notes copy({
    int? id,
    bool? isImportant,
    String? number,
    String? name,
    String? description,
    String? Address,
    String? skill,
    String? education,

  }) =>
      Notes(
        id: id ?? this.id,
        skill: skill?? this.skill,
        education: education?? this.education,
        number: number ?? this.number,
        name: name ?? this.name,
        description: description ?? this.description,
       Address:  Address ?? this. Address,

      );

  static Notes fromJson(Map<String, Object?> json) => Notes(
    id: json[NotesFields.id] as int?,
    number: json[NotesFields.number] as String,
    name: json[NotesFields.name] as String,
    skill: json[NotesFields.skill] as String,
    Address: json[NotesFields.Address] as String,
    education: json[NotesFields.education] as String,
    description: json[NotesFields.description] as String,

  );

  Map<String, Object?> toJson() => {
    NotesFields.id: id,
    NotesFields.name: name,
    NotesFields.Address: Address,
    NotesFields.skill: skill,
    NotesFields.education: education,
    NotesFields.number: number,
    NotesFields.description: description,
  };
}