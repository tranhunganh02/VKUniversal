enum Privacy {
  public("Public"),
  follow("Follow"),
  private("Private");

  const Privacy(this.name);

  final String name;

  @override
  String toString() => name;
}
