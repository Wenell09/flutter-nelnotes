class NoteModel {
  String noteId, userId, title, deskripsi, createdAt;

  NoteModel({
    required this.noteId,
    required this.userId,
    required this.title,
    required this.deskripsi,
    required this.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        noteId: json["note_id"],
        userId: json["user_id"],
        title: json["title"],
        deskripsi: json["deskripsi"],
        createdAt: json["created_at"]);
  }
}
