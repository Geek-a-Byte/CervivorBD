class Post {
  String? postid;
  String? ownerid;
  String? fullname;
  String? details;
  DateTime? timeAgo;
  int? comments;
  dynamic likes;

  Post({
    this.fullname,
    this.ownerid,
    this.postid,
    this.details,
    this.timeAgo,
    this.comments,
    this.likes,
  });

  //posting data to server
  factory Post.fromMap(map) {
    return Post(
      postid: map['postid'],
      ownerid: map['ownerid'],
      fullname: map['fullname'],
      details: map['details'],
      timeAgo: map['timeAgo'],
      comments: map['comments'],
      likes: map['likes'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMapPost() {
    return {
      'ownerid': ownerid,
      'postid': postid,
      'fullname': fullname,
      'details': details,
      'timeAgo': timeAgo,
      'comments': comments,
      'likes': likes,
    };
  }

   
}
