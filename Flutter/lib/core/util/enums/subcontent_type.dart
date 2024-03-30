enum SubContentType {
  attachment("Attachment"),
  postShared("PostShares");

  const SubContentType(this.name);

  final String name;

  @override
  String toString() => name;
}
