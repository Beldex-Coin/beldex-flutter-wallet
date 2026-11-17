enum SecretStoreKey { moneroWalletPassword, pinCodePassword }

const moneroWalletPassword = 'MONERO_WALLET_PASSWORD';
const pinCodePassword = 'PIN_CODE_PASSWORD';

String generateStoreKeyFor({required SecretStoreKey key, String walletName = '',}) {
  var key0 = '';

  switch (key) {
    case SecretStoreKey.moneroWalletPassword:
      key0 =  '${moneroWalletPassword}_${walletName.toUpperCase()}';
      break;

    case SecretStoreKey.pinCodePassword:
      key0 = pinCodePassword;
      break;

    }

  return key0;
}