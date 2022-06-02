class Post {
  String? postid;
  String? fullname;
  String? details;
  DateTime? timeAgo;
  int? likes;
  int? comments;

  Post({
    this.fullname,
    this.postid,
    this.details,
    this.timeAgo,
    this.likes,
    this.comments,
  });

  //posting data to server
  factory Post.fromMap(map) {
    return Post(
      postid: map['postid'],
      fullname: map['fullname'],
      details: map['details'],
      timeAgo: map['timeAgo'],
      likes: map['likes'],
      comments: map['comments'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMapPost() {
    return {
      'postid': postid,
      'fullname': fullname,
      'details': details,
      'timeAgo': timeAgo,
      'likes': likes,
      'comments': comments,
    };
  }
}
