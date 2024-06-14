class PageRequest {
  final int page;

  PageRequest({required this.page});

  factory PageRequest.fromJson(Map<String, dynamic> json) {
    return PageRequest(
      page: json['page'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'page': page,
    };
  }
}
