import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
typedef FutureVoid = Future<void>;

class Failure{
  final String message;
  final StackTrace stackTrace;
  const Failure(
     this.message,
     this.stackTrace
    );
}