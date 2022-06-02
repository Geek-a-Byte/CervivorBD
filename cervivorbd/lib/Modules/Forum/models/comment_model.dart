class Comment {
  String? commentid;
  String? fullname;
  String? details;
  DateTime? timeAgo;
  int? likes;

  Comment({
    this.fullname,
    this.commentid,
    this.details,
    this.timeAgo,
    this.likes,
  });

  //comment4ing data to server
  factory Comment.fromMap(map) {
    return Comment(
      commentid: map['commentid'],
      fullname: map['fullname'],
      details: map['details'],
      timeAgo: map['timeAgo'],
      likes: map['likes'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMapComment() {
    return {
      'commentid': commentid,
      'fullname': fullname,
      'details': details,
      'timeAgo': timeAgo,
      'likes': likes,
    };
  }
}
