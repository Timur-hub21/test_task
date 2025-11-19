import 'package:fpdart/fpdart.dart';

extension EitherExt<L, R> on Either<L, R> {
  (L?, Option<R>) toRecord() {
    return (getLeft().toNullable(), getRight());
  }
}
