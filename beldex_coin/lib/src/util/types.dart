import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:beldex_coin/beldex_coin_structs.dart';
import 'package:beldex_coin/src/structs/ut8_box.dart';

typedef CreateWallet = int Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, int, Pointer<Utf8>);

typedef RestoreWalletFromSeed = int Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, int, int, Pointer<Utf8>);

typedef RestoreWalletFromKeys = int Function(
    Pointer<Utf8>,
    Pointer<Utf8>,
    Pointer<Utf8>,
    Pointer<Utf8>,
    Pointer<Utf8>,
    Pointer<Utf8>,
    int,
    int,
    Pointer<Utf8>);

typedef IsWalletExist = int Function(Pointer<Utf8>);

typedef LoadWallet = void Function(Pointer<Utf8>, Pointer<Utf8>, int);

typedef GetFilename = Pointer<Utf8> Function();

typedef GetSeed = Pointer<Utf8> Function();

typedef GetAddress = Pointer<Utf8> Function(int, int);

typedef GetFullBalance = int Function(int);

typedef GetUnlockedBalance = int Function(int);

typedef GetCurrentHeight = int Function();

typedef GetNodeHeight = int Function();

typedef IsRefreshing = int Function();

typedef IsConnected = int Function();

typedef SetupNode = int Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, int, int, Pointer<Utf8>);

typedef StartRefresh = void Function();

typedef ConnectToNode = int Function();

typedef SetRefreshFromBlockHeight = void Function(int);

typedef SetRecoveringFromSeed = void Function(int);

typedef Store = void Function(Pointer<Utf8>);

typedef SetListener = void Function();

typedef GetSyncingHeight = int Function();

typedef IsNeededToRefresh = int Function();

typedef IsNewTransactionExist = int Function();

typedef SubaddressSize = int Function();

typedef SubaddressRefresh = void Function(int);

typedef SubaddressGetAll = Pointer<Int64> Function();

typedef SubaddressAddNew = void Function(int accountIndex, Pointer<Utf8> label);

typedef SubaddressSetLabel = void Function(
    int accountIndex, int addressIndex, Pointer<Utf8> label);

typedef AccountSize = int Function();

typedef AccountRefresh = void Function();

typedef AccountGetAll = Pointer<Int64> Function();

typedef AccountAddNew = void Function(Pointer<Utf8> label);

typedef AccountSetLabel = void Function(int accountIndex, Pointer<Utf8> label);

typedef TransactionsRefresh = void Function();

typedef TransactionsCount = int Function();

typedef TransactionsGetAll = Pointer<Int64> Function();

typedef TransactionCreate = int Function(
    Pointer<Utf8> address,
    Pointer<Utf8> amount,
    int priorityRaw,
    int subaddrAccount,
    Pointer<Utf8Box> error,
    Pointer<PendingTransactionRaw> pendingTransaction);

typedef BnsBuy = int Function(
    Pointer<Utf8> owner,
    Pointer<Utf8> backUpOwner,
    Pointer<Utf8> mappingYears,
    Pointer<Utf8> bchatId,
    Pointer<Utf8> walletAddress,
    Pointer<Utf8> belnetId,
    Pointer<Utf8> bnsName,
    int priorityRaw,
    int subaddrAccount,
    Pointer<Utf8Box> error,
    Pointer<PendingTransactionRaw> pendingTransaction);

typedef CreateSweepAllTransaction = int Function(
    int priorityRaw,
    int subaddrAccount,
    Pointer<Utf8Box> error,
    Pointer<PendingTransactionRaw> pendingTransaction);

typedef TransactionCommit = int Function(
    Pointer<PendingTransactionRaw>, Pointer<Utf8Box>);

typedef TransactionEstimateFee = int Function(int priorityRaw, int recipients);

typedef StakeCount = int Function();

typedef StakeGetAll = Pointer<Int64> Function();

typedef BnsCount = int Function();

typedef BnsGetAll = Pointer<Int64> Function();

typedef StakeCreate = int Function(
    Pointer<Utf8> masterNodeKey,
    Pointer<Utf8> amount,
    Pointer<Utf8Box> error,
    Pointer<PendingTransactionRaw> pendingTransaction);

typedef CanRequestUnstake = int Function(Pointer<Utf8> masterNodeKey);

typedef BnsSetRecord = int Function(Pointer<Utf8> name);

typedef GetNameToNameHash = Pointer<Utf8> Function(Pointer<Utf8> name);

typedef get_names_to_namehash = Pointer<Utf8> Function(Pointer<Utf8> name);

typedef SubmitStakeUnlock = int Function(Pointer<Utf8> masterNodeKey,
    Pointer<Utf8Box> error, Pointer<PendingTransactionRaw> pendingTransaction);

typedef SecretViewKey = Pointer<Utf8> Function();

typedef PublicViewKey = Pointer<Utf8> Function();

typedef SecretSpendKey = Pointer<Utf8> Function();

typedef PublicSpendKey = Pointer<Utf8> Function();

typedef CloseCurrentWallet = void Function();

typedef OnStartup = void Function();

typedef RescanBlockchainAsync = void Function();
