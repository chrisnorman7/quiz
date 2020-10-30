/// Provides the [ResponseCodes] enumeration.

enum ResponseCodes {
  success,
  noResults,
  invalidParameter,
  tokenNotFound,
  tokenEmptySession,
}

int dumpResponseCode(ResponseCodes value) => value.index;

ResponseCodes loadResponseCode(int value) => ResponseCodes.values[value];
