class NoteModel {
  String noteId, userId, title, deskripsi, createdAt;
  bool isPin;

  NoteModel({
    required this.noteId,
    required this.userId,
    required this.title,
    required this.deskripsi,
    required this.isPin,
    required this.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteId: json["note_id"] ?? "",
      userId: json["user_id"] ?? "",
      title: json["title"] ?? "",
      deskripsi: json["deskripsi"] ?? "",
      isPin: json["is_pin"] ?? false,
      createdAt: json["created_at"] ?? "",
    );
  }
}
