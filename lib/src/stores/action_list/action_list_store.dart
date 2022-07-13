import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/src/domain/common/calculate_fiat_amount_raw.dart';
import 'package:beldex_wallet/src/domain/common/crypto_currency.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_history.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_info.dart';
import 'package:beldex_wallet/src/wallet/wallet.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/wallet/beldex/account.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_amount_format.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_wallet.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_description.dart';
import 'package:beldex_wallet/src/stores/action_list/action_list_item.dart';
import 'package:beldex_wallet/src/stores/action_list/date_section_item.dart';
import 'package:beldex_wallet/src/stores/action_list/transaction_filter_store.dart';
import 'package:beldex_wallet/src/stores/action_list/transaction_list_item.dart';
import 'package:beldex_wallet/src/stores/price/price_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';

part 'action_list_store.g.dart';

class ActionListStore = ActionListBase with _$ActionListStore;

abstract class ActionListBase with Store {
  ActionListBase(
      {@required WalletService walletService,
      @required SettingsStore settingsStore,
      @required PriceStore priceStore,
      @required this.transactionFilterStore,
      @required this.transactionDescriptions}) {
    _transactions = <TransactionListItem>[];
    _walletService = walletService;
    _settingsStore = settingsStore;
    _priceStore = priceStore;

    if (walletService.currentWallet != null) {
      _onWalletChanged(walletService.currentWallet);
    }

    _onWalletChangeSubscription =
        walletService.onWalletChange.listen(_onWalletChanged);

    _onTransactionDescriptions = transactionDescriptions
        .watch()
        .listen((_) async => await _updateTransactionsList());
  }

  static List<ActionListItem> formattedItemsList(List<ActionListItem> items) {
    final formattedList = <ActionListItem>[];
    DateTime lastDate;
    items.sort((a, b) => b.date.compareTo(a.date));

    for (var i = 0; i < items.length; i++) {
      final transaction = items[i];

      if (lastDate == null) {
        lastDate = transaction.date;
        formattedList.add(DateSectionItem(transaction.date));
        formattedList.add(transaction);
        continue;
      }

      final isCurrentDay = lastDate.year == transaction.date.year &&
          lastDate.month == transaction.date.month &&
          lastDate.day == transaction.date.day;

      if (isCurrentDay) {
        formattedList.add(transaction);
        continue;
      }

      lastDate = transaction.date;
      formattedList.add(DateSectionItem(transaction.date));
      formattedList.add(transaction);
    }

    return formattedList;
  }

  @computed
  List<TransactionListItem> get transactions {
    final symbol = PriceStoreBase.generateSymbolForPair(
        fiat: _settingsStore.fiatCurrency, crypto: CryptoCurrency.bdx);
    final price = _priceStore.prices[symbol];

    _transactions.forEach((item) {
      final amount = calculateFiatAmountRaw(
          cryptoAmount: belDexAmountToDouble(item.transaction.amount),
          price: price);
      item.transaction.changeFiatAmount(amount);
    });

    return _transactions;
  }

  @observable
  List<TransactionListItem> _transactions;

  @computed
  List<ActionListItem> get items {
    final _items = <ActionListItem>[];

    _items.addAll(transactionFilterStore.filtered(transactions: transactions));

    return formattedItemsList(_items);
  }

  @computed
  int get totalCount => transactions.length;

  TransactionFilterStore transactionFilterStore;
  Box<TransactionDescription> transactionDescriptions;

  WalletService _walletService;
  TransactionHistory _history;
  SettingsStore _settingsStore;
  PriceStore _priceStore;
  Account _account;
  StreamSubscription<Wallet> _onWalletChangeSubscription;
  StreamSubscription<List<TransactionInfo>> _onTransactionsChangeSubscription;
  StreamSubscription<Account> _onAccountChangeSubscription;
  StreamSubscription<BoxEvent> _onTransactionDescriptions;

//  @override
//  void dispose() {
//    if (_onTransactionsChangeSubscription != null) {
//      _onTransactionsChangeSubscription.cancel();
//    }
//
//    if (_onAccountChangeSubscription != null) {
//      _onAccountChangeSubscription.cancel();
//    }
//
//    _onTransactionDescriptions?.cancel();
//    _onWalletChangeSubscription.cancel();
//    _onTradesChanged?.cancel();
//    super.dispose();
//  }

  Future _updateTransactionsList() async {
    // await _history.refresh();
    final _transactions = await _history.getAll();
    await _setTransactions(_transactions);
  }

  Future _onWalletChanged(Wallet wallet) async {
    if (_onTransactionsChangeSubscription != null) {
      await _onTransactionsChangeSubscription.cancel();
    }

    if (_onAccountChangeSubscription != null) {
      await _onAccountChangeSubscription.cancel();
    }

    _history = wallet.getHistory();
    _onTransactionsChangeSubscription = _history.transactions
        .listen((transactions) => _setTransactions(transactions));

    if (wallet is BelDexWallet) {
      _account = wallet.account;
      _onAccountChangeSubscription = wallet.onAccountChange.listen((account) {
        _account = account;
        _updateTransactionsList();
      });
    }

    await _updateTransactionsList();
  }

  Future _setTransactions(List<TransactionInfo> transactions) async {
    final wallet = _walletService.currentWallet;
    var sortedTransactions = transactions.map((transaction) {
      if (transactionDescriptions.values.isNotEmpty) {
        final description = transactionDescriptions.values.firstWhere(
            (desc) => desc.id == transaction.id,
            orElse: () => null);

        if (description != null && description.recipientAddress != null) {
          transaction.recipientAddress = description.recipientAddress;
        }
      }

      return transaction;
    }).toList();

    if (wallet is BelDexWallet) {
      sortedTransactions =
          transactions.where((tx) => tx.accountIndex == _account.id).toList();
    }

    _transactions = sortedTransactions
        .map((transaction) => TransactionListItem(transaction: transaction))
        .toList();
  }
}
