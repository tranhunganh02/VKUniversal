enum PostType {
  shareExperience("Chia sẽ kiến thức"),
  asking("Hỏi đáp"),
  entertaiment("Giải trí"),
  confession("Confession"),
  stuffs("Đồ thất lạc");

  const PostType(this.name);

  final String name;

  @override
  String toString() => name;
}
