import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:beldex_coin/beldex_coin_structs.dart';
import 'package:beldex_coin/src/structs/status_and_error.dart';

typedef CreateWalletNative = status_and_error Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Int32);

typedef RestoreWalletFromSeedNative = status_and_error Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Int32, Int64);

typedef RestoreWalletFromKeysNative = status_and_error Function(
    Pointer<Utf8>,
    Pointer<Utf8>,
    Pointer<Utf8>,
    Pointer<Utf8>,
    Pointer<Utf8>,
    Pointer<Utf8>,
    Int32,
    Int64);

typedef IsWalletExistNative = Int8 Function(Pointer<Utf8>);

typedef LoadWalletNative = Void Function(Pointer<Utf8>, Pointer<Utf8>, Int8);

typedef GetFilenameNative = Pointer<Utf8> Function();

typedef GetSeedNative = Pointer<Utf8> Function();

typedef GetAddressNative = Pointer<Utf8> Function(Int32, Int32);

typedef GetFullBalanceNative = Int64 Function(Int32);

typedef GetUnlockedBalanceNative = Int64 Function(Int32);

typedef GetCurrentHeightNative = Int64 Function();

typedef GetNodeHeightNative = Int64 Function();

typedef IsRefreshingNative = Int8 Function();

typedef IsConnectedNative = Int8 Function();

typedef SetupNodeNative = status_and_error Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Int8, Int8);

typedef StartRefreshNative = Void Function();

typedef ConnectToNodeNative = status_and_error Function();

typedef SetRefreshFromBlockHeightNative = Void Function(Int64);

typedef SetRecoveringFromSeedNative = Void Function(Int8);

typedef StoreCNative = Void Function(Pointer<Utf8>);

typedef SetListenerNative = Void Function();

typedef GetSyncingHeightNative = Int64 Function();

typedef IsNeededToRefreshNative = Int8 Function();

typedef IsNewTransactionExistNative = Int8 Function();

typedef SubaddressSizeNative = Int32 Function();

typedef SubaddressRefreshNative = Void Function(Int32);

typedef SubaddressGetAllNative = Pointer<Int64> Function();

typedef SubaddressGetAllWithSizeNative = Pointer<Int64> Function(Pointer<Int32>);

typedef SubaddressFreeAllNative = Void Function(Pointer<Int64>, Int32);

typedef SubaddressAddNewNative = Void Function(
    Int32 accountIndex, Pointer<Utf8> label);

typedef SubaddressSetLabelNative = Void Function(
    Int32 accountIndex, Int32 addressIndex, Pointer<Utf8> label);

typedef AccountSizeNative = Int32 Function();

typedef AccountRefreshNative = Void Function();

typedef AccountGetAllNative = Pointer<Int64> Function();

typedef AccountGetAllWithSizeNative = Pointer<Int64> Function(Pointer<Int32>);

typedef AccountFreeAllNative = Void Function(Pointer<Int64>, Int32);

typedef AccountAddNewNative = Void Function(Pointer<Utf8> label);

typedef AccountSetLabelNative = Void Function(
    Int32 accountIndex, Pointer<Utf8> label);

typedef TransactionsRefreshNative = Void Function();

typedef TransactionsCountNative = Int64 Function();

typedef TransactionsGetAllNative = Pointer<Int64> Function();

typedef TransactionCreateNative = status_and_error Function(
    Pointer<Utf8> address,
    Pointer<Utf8> amount,
    Int8 priorityRaw,
    Int32 subaddrAccount,
    Pointer<PendingTransactionRaw> pendingTransaction);

typedef BnsBuyNative = status_and_error Function(
    Pointer<Utf8> owner,
    Pointer<Utf8> backUpOwner,
    Pointer<Utf8> mappingYears,
    Pointer<Utf8> bchatId,
    Pointer<Utf8> walletAddress,
    Pointer<Utf8> belnetId,
    Pointer<Utf8> ethAddress,
    Pointer<Utf8> bnsName,
    Int8 priorityRaw,
    Int32 subaddrAccount,
    Pointer<PendingTransactionRaw> pendingTransaction);

typedef BnsUpdateNative = status_and_error Function(
    Pointer<Utf8> owner,
    Pointer<Utf8> backUpOwner,
    Pointer<Utf8> bchatId,
    Pointer<Utf8> walletAddress,
    Pointer<Utf8> belnetId,
    Pointer<Utf8> ethAddress,
    Pointer<Utf8> bnsName,
    Int8 priorityRaw,
    Int32 subaddrAccount,
    Pointer<PendingTransactionRaw> pendingTransaction);

typedef BnsRenewNative = status_and_error Function(
    Pointer<Utf8> bnsName,
    Pointer<Utf8> mappingYears,
    Int8 priorityRaw,
    Int32 subaddrAccount,
    Pointer<PendingTransactionRaw> pendingTransaction);

typedef CreateSweepAllTransactionNative = status_and_error Function(
    Int8 priorityRaw,
    Int32 subaddrAccount,
    Pointer<PendingTransactionRaw> pendingTransaction);

typedef TransactionCommitNative = status_and_error Function(
    Pointer<PendingTransactionRaw>);

typedef TransactionEstimateFeeNative = Int64 Function(Int32, Int32);

typedef StakeCountNative = Int32 Function();

typedef StakeGetAllNative = Pointer<Int64> Function();

typedef BnsCountNative = Int32 Function();

typedef BnsGetAllNative = Pointer<Int64> Function();

typedef StakeCreateNative = status_and_error Function(Pointer<Utf8> masterNodeKey,
    Pointer<Utf8> amount, Pointer<PendingTransactionRaw> pendingTransaction);

typedef CanRequestUnstakeNative = Int8 Function(Pointer<Utf8> masterNodeKey);

typedef BnsSetRecordNative = Int8 Function(Pointer<Utf8> name);

typedef SubmitStakeUnlockNative = status_and_error Function(
    Pointer<Utf8> masterNodeKey,
    Pointer<PendingTransactionRaw> pendingTransaction);

typedef SecretViewKeyNative = Pointer<Utf8> Function();

typedef PublicViewKeyNative = Pointer<Utf8> Function();

typedef SecretSpendKeyNative = Pointer<Utf8> Function();

typedef PublicSpendKeyNative = Pointer<Utf8> Function();

typedef CloseCurrentWalletNative = Void Function();

typedef OnStartupNative = Void Function();

typedef RescanBlockchainNative = Void Function();
