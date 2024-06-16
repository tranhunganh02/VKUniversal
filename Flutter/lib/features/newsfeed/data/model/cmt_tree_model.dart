class CmtTreeModel<T> {
  T node;
  List<CmtTreeModel<T>> children = [];

  CmtTreeModel(this.node, this.children);
}
