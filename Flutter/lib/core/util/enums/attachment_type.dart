enum AttachmentType {
  image("Image"),
  video("Video"),
  file("File");

  const AttachmentType(this.name);

  final String name;

  @override
  String toString() => name;
}
