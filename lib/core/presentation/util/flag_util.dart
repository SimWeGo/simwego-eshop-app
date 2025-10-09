// /// Represents different types of bundles with serialization support
enum BundleType {
  global("global"),
  regional("regional"),
  country("country");

  const BundleType(this.type);

  final String type;

  /// Creates a [BundleType] from a string value
  /// Returns null if no matching type is found
  static BundleType? fromString(String value) {
    return BundleType.values.cast<BundleType?>().firstWhere(
          (BundleType? type) => type!.type.toLowerCase() == value.toLowerCase(),
          orElse: () => null,
        );
  }

  /// Gets the string representation of the bundle type
  @override
  String toString() => type;
}
