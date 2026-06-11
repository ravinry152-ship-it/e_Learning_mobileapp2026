class Data {
  List<FullCourses>? _fullCourses;

  Data({List<FullCourses>? fullCourses}) {
    if (fullCourses != null) {
      this._fullCourses = fullCourses;
    }
  }

  List<FullCourses>? get fullCourses => _fullCourses;
  set fullCourses(List<FullCourses>? fullCourses) => _fullCourses = fullCourses;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['full_courses'] != null) {
      _fullCourses = <FullCourses>[];
      json['full_courses'].forEach((v) {
        _fullCourses!.add(new FullCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._fullCourses != null) {
      data['full_courses'] = this._fullCourses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FullCourses {
  int? _id;
  int? _courseName;
  String? _courseDescription;
  String? _videoUrl;
  String? _image;

  FullCourses(
      {int? id,
      int? courseName,
      String? courseDescription,
      String? videoUrl,
      String? image}) {
    if (id != null) {
      this._id = id;
    }
    if (courseName != null) {
      this._courseName = courseName;
    }
    if (courseDescription != null) {
      this._courseDescription = courseDescription;
    }
    if (videoUrl != null) {
      this._videoUrl = videoUrl;
    }
    if (image != null) {
      this._image = image;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get courseName => _courseName;
  set courseName(int? courseName) => _courseName = courseName;
  String? get courseDescription => _courseDescription;
  set courseDescription(String? courseDescription) =>
      _courseDescription = courseDescription;
  String? get videoUrl => _videoUrl;
  set videoUrl(String? videoUrl) => _videoUrl = videoUrl;
  String? get image => _image;
  set image(String? image) => _image = image;

  FullCourses.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _courseName = json['course_name'];
    _courseDescription = json['course_description'];
    _videoUrl = json['video_url'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['course_name'] = this._courseName;
    data['course_description'] = this._courseDescription;
    data['video_url'] = this._videoUrl;
    data['image'] = this._image;
    return data;
  }
}
