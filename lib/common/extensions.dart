extension E<X extends Object?> on X {
  bool get isNullOrEmptyList {
    final isEmptyList = this is List<dynamic> && (this as List<dynamic>?)!.isEmpty;
    return this == null || isEmptyList;
  }
}