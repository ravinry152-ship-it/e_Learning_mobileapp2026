class VideoList {
  int? id;
  String? category;
  String? courseTitle;
  String? title;
  String? videoUrl;
  String? duration;

  VideoList(
      {this.id,
      this.category,
      this.courseTitle,
      this.title,
      this.videoUrl,
      this.duration});

  VideoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    courseTitle = json['course_title'];
    title = json['title'];
    videoUrl = json['video_url'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['course_title'] = this.courseTitle;
    data['title'] = this.title;
    data['video_url'] = this.videoUrl;
    data['duration'] = this.duration;
    return data;
  }
}
