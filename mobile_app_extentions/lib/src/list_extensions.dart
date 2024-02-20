import 'dart:collection';

extension AppListExtensions<E> on List<E> {
  List<Map<String, dynamic>> castToListOfMapOfStringDynamic() =>
      map((e) => e).toList().cast<Map<String, dynamic>>();

  List<String> castToListOfString() => cast<String>();

  List<E> _removeAll(Iterable<E> allToRemove) {
    if (allToRemove.isEmpty) {
      return this;
    } else {
      for (final element in allToRemove) {
        remove(element);
      }
      return this;
    }
  }

  List<E> _distinctBy(E Function(E) predicate) {
    final HashSet<dynamic> set = HashSet();
    final List<E> list = [];
    toList().forEach((e) {
      final dynamic key = predicate(e);
      if (set.add(key)) {
        list.add(e);
      }
    });
    return list;
  }

  List<E> getDuplicates({E Function(E)? distinctBy}) {
    final List<E> dupes = List.from(this);
    if (distinctBy == null) {
      return dupes._removeAll(toSet().toList());
    }
    return dupes._removeAll(_distinctBy(distinctBy).toSet().toList());
  }
}
