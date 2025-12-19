import 'package:flutter_test/flutter_test.dart';
import 'package:complaints_app/core/errors/failure.dart';

void main() {
  test('ServerFailure يحمل الرسالة', () {
    final f = ServerFailure(errMessage: 'x');
    expect(f.errMessage, 'x');
  });

  test('ServerFailure instances ليست بالضرورة متساوية', () {
    final f1 = ServerFailure(errMessage: 'x');
    final f2 = ServerFailure(errMessage: 'x');
    expect(identical(f1, f2), false);
    expect(f1.errMessage, f2.errMessage); 
  });
}
