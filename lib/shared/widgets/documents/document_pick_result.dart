class DocumentPickResult {
  final String? path;
  final bool exceedsMaxSize;
  final bool isUnsupportedType;

  const DocumentPickResult.picked(this.path)
    : exceedsMaxSize = false,
      isUnsupportedType = false;

  const DocumentPickResult.tooLarge()
    : path = null,
      exceedsMaxSize = true,
      isUnsupportedType = false;

  const DocumentPickResult.unsupportedType()
    : path = null,
      exceedsMaxSize = false,
      isUnsupportedType = true;
}
