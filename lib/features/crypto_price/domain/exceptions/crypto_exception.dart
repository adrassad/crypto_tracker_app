enum CryptoErrorCode { noInternet, fetchFailed, unknown }

class CryptoException implements Exception {
  final CryptoErrorCode code;
  final String? message;

  CryptoException(this.code, [this.message]);
}
