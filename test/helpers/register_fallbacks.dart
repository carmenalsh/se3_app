import 'package:mocktail/mocktail.dart';

import 'fixtures.dart';


void registerFallbacks() {

 registerFallbackValue(tUpdateAccountParams());
  registerFallbackValue(tCreateAccountParams());
  registerFallbackValue(tDepositParams());
  registerFallbackValue(tWithdrawParams());
  registerFallbackValue(tTransferParams());
  registerFallbackValue(tScheduledParams());
}
