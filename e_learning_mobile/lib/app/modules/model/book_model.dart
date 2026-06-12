class BookModel {
  int? id;
  String? bookCategoryName;
  List<Books>? books;

  BookModel({this.id, this.bookCategoryName, this.books});

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookCategoryName = json['book_category_name'];
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(Books.fromJson(v));
      });
    }
  }
}

class Books {
  int? id;
  String? title;
  String? image;
  String? bookPdf;
  int? bookCategoryName;

  Books({this.id, this.title, this.image, this.bookPdf, this.bookCategoryName});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    bookPdf = json['book_pdf'];
    bookCategoryName = json['book_category_name'];
  }
}