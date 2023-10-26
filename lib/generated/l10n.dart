// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to\nBeldex Wallet`
  String get welcome {
    return Intl.message(
      'Welcome to\nBeldex Wallet',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Awesome wallet\nfor Beldex`
  String get first_wallet_text {
    return Intl.message(
      'Awesome wallet\nfor Beldex',
      name: 'first_wallet_text',
      desc: '',
      args: [],
    );
  }

  /// `Select from the options below to\neither create or recover your wallet.`
  String get please_make_selection {
    return Intl.message(
      'Select from the options below to\neither create or recover your wallet.',
      name: 'please_make_selection',
      desc: '',
      args: [],
    );
  }

  /// `Create New Wallet`
  String get create_new {
    return Intl.message(
      'Create New Wallet',
      name: 'create_new',
      desc: '',
      args: [],
    );
  }

  /// `Use Existing Wallet`
  String get restore_wallet {
    return Intl.message(
      'Use Existing Wallet',
      name: 'restore_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Accounts`
  String get accounts {
    return Intl.message(
      'Accounts',
      name: 'accounts',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Address Book`
  String get address_book {
    return Intl.message(
      'Address Book',
      name: 'address_book',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Please select:`
  String get please_select {
    return Intl.message(
      'Please select:',
      name: 'please_select',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Contact Name`
  String get contact_name {
    return Intl.message(
      'Contact Name',
      name: 'contact_name',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Authenticated`
  String get authenticated {
    return Intl.message(
      'Authenticated',
      name: 'authenticated',
      desc: '',
      args: [],
    );
  }

  /// `Authentication`
  String get authentication {
    return Intl.message(
      'Authentication',
      name: 'authentication',
      desc: '',
      args: [],
    );
  }

  /// `Failed authentication. {state_error}`
  String failed_authentication(Object state_error) {
    return Intl.message(
      'Failed authentication. $state_error',
      name: 'failed_authentication',
      desc: '',
      args: [state_error],
    );
  }

  /// `Menu`
  String get wallet_menu {
    return Intl.message(
      'Menu',
      name: 'wallet_menu',
      desc: '',
      args: [],
    );
  }

  /// `{status} Blocks Remaining`
  String Blocks_remaining(Object status) {
    return Intl.message(
      '$status Blocks Remaining',
      name: 'Blocks_remaining',
      desc: '',
      args: [status],
    );
  }

  /// `Please try to connect to another node`
  String get please_try_to_connect_to_another_node {
    return Intl.message(
      'Please try to connect to another node',
      name: 'please_try_to_connect_to_another_node',
      desc: '',
      args: [],
    );
  }

  /// `Beldex Hidden`
  String get beldex_hidden {
    return Intl.message(
      'Beldex Hidden',
      name: 'beldex_hidden',
      desc: '',
      args: [],
    );
  }

  /// `Beldex Available Balance`
  String get beldex_available_balance {
    return Intl.message(
      'Beldex Available Balance',
      name: 'beldex_available_balance',
      desc: '',
      args: [],
    );
  }

  /// `Beldex Full Balance`
  String get beldex_full_balance {
    return Intl.message(
      'Beldex Full Balance',
      name: 'beldex_full_balance',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Receive`
  String get receive {
    return Intl.message(
      'Receive',
      name: 'receive',
      desc: '',
      args: [],
    );
  }

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: '',
      args: [],
    );
  }

  /// `Incoming`
  String get incoming {
    return Intl.message(
      'Incoming',
      name: 'incoming',
      desc: '',
      args: [],
    );
  }

  /// `Outgoing`
  String get outgoing {
    return Intl.message(
      'Outgoing',
      name: 'outgoing',
      desc: '',
      args: [],
    );
  }

  /// `Transactions by Date`
  String get transactions_by_date {
    return Intl.message(
      'Transactions by Date',
      name: 'transactions_by_date',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Received`
  String get received {
    return Intl.message(
      'Received',
      name: 'received',
      desc: '',
      args: [],
    );
  }

  /// `Sent`
  String get sent {
    return Intl.message(
      'Sent',
      name: 'sent',
      desc: '',
      args: [],
    );
  }

  /// ` (pending)`
  String get pending {
    return Intl.message(
      ' (pending)',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Rescan`
  String get rescan {
    return Intl.message(
      'Rescan',
      name: 'rescan',
      desc: '',
      args: [],
    );
  }

  /// `Reconnect`
  String get reconnect {
    return Intl.message(
      'Reconnect',
      name: 'reconnect',
      desc: '',
      args: [],
    );
  }

  /// `Wallets`
  String get wallets {
    return Intl.message(
      'Wallets',
      name: 'wallets',
      desc: '',
      args: [],
    );
  }

  /// `Show Seed`
  String get show_seed {
    return Intl.message(
      'Show Seed',
      name: 'show_seed',
      desc: '',
      args: [],
    );
  }

  /// `Show keys`
  String get show_keys {
    return Intl.message(
      'Show keys',
      name: 'show_keys',
      desc: '',
      args: [],
    );
  }

  /// `Reconnection`
  String get reconnection {
    return Intl.message(
      'Reconnection',
      name: 'reconnection',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to reconnect?`
  String get reconnect_alert_text {
    return Intl.message(
      'Are you sure to reconnect?',
      name: 'reconnect_alert_text',
      desc: '',
      args: [],
    );
  }

  /// `Reload Fiat data`
  String get reload_fiat {
    return Intl.message(
      'Reload Fiat data',
      name: 'reload_fiat',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Copied to clipboard!`
  String get copied_to_clipboard {
    return Intl.message(
      'Copied to clipboard!',
      name: 'copied_to_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `Fetching`
  String get fetching {
    return Intl.message(
      'Fetching',
      name: 'fetching',
      desc: '',
      args: [],
    );
  }

  /// `ID: `
  String get id {
    return Intl.message(
      'ID: ',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Amount `
  String get amount {
    return Intl.message(
      'Amount ',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Status: `
  String get status {
    return Intl.message(
      'Status: ',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Confirm sending`
  String get confirm_sending {
    return Intl.message(
      'Confirm sending',
      name: 'confirm_sending',
      desc: '',
      args: [],
    );
  }

  /// `Commit transaction\nAmount: {amount}\nFee: {fee}`
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return Intl.message(
      'Commit transaction\nAmount: $amount\nFee: $fee',
      name: 'commit_transaction_amount_fee',
      desc: '',
      args: [amount, fee],
    );
  }

  /// `Sending`
  String get sending {
    return Intl.message(
      'Sending',
      name: 'sending',
      desc: '',
      args: [],
    );
  }

  /// `Transaction sent!`
  String get transaction_sent {
    return Intl.message(
      'Transaction sent!',
      name: 'transaction_sent',
      desc: '',
      args: [],
    );
  }

  /// `Send Beldex`
  String get send_beldex {
    return Intl.message(
      'Send Beldex',
      name: 'send_beldex',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Changelog`
  String get changelog {
    return Intl.message(
      'Changelog',
      name: 'changelog',
      desc: '',
      args: [],
    );
  }

  /// `Loading your wallet`
  String get loading_your_wallet {
    return Intl.message(
      'Loading your wallet',
      name: 'loading_your_wallet',
      desc: '',
      args: [],
    );
  }

  /// `New Wallet`
  String get new_wallet {
    return Intl.message(
      'New Wallet',
      name: 'new_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Name`
  String get wallet_name {
    return Intl.message(
      'Wallet Name',
      name: 'wallet_name',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_text {
    return Intl.message(
      'Continue',
      name: 'continue_text',
      desc: '',
      args: [],
    );
  }

  /// `New Node`
  String get node_new {
    return Intl.message(
      'New Node',
      name: 'node_new',
      desc: '',
      args: [],
    );
  }

  /// `Node Address`
  String get node_address {
    return Intl.message(
      'Node Address',
      name: 'node_address',
      desc: '',
      args: [],
    );
  }

  /// `Node Port`
  String get node_port {
    return Intl.message(
      'Node Port',
      name: 'node_port',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Nodes`
  String get nodes {
    return Intl.message(
      'Nodes',
      name: 'nodes',
      desc: '',
      args: [],
    );
  }

  /// `Reset settings`
  String get node_reset_settings_title {
    return Intl.message(
      'Reset settings',
      name: 'node_reset_settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure that you want to reset settings to default?`
  String get nodes_list_reset_to_default_message {
    return Intl.message(
      'Are you sure that you want to reset settings to default?',
      name: 'nodes_list_reset_to_default_message',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to change current node to {node}?`
  String change_current_node(Object node) {
    return Intl.message(
      'Are you sure to change current node to $node?',
      name: 'change_current_node',
      desc: '',
      args: [node],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Remove node`
  String get remove_node {
    return Intl.message(
      'Remove node',
      name: 'remove_node',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure that you want to remove selected node?`
  String get remove_node_message {
    return Intl.message(
      'Are you sure that you want to remove selected node?',
      name: 'remove_node_message',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Switch to `
  String get use {
    return Intl.message(
      'Switch to ',
      name: 'use',
      desc: '',
      args: [],
    );
  }

  /// `-digit PIN`
  String get digit_pin {
    return Intl.message(
      '-digit PIN',
      name: 'digit_pin',
      desc: '',
      args: [],
    );
  }

  /// `Share address`
  String get share_address {
    return Intl.message(
      'Share address',
      name: 'share_address',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get receive_amount {
    return Intl.message(
      'Amount',
      name: 'receive_amount',
      desc: '',
      args: [],
    );
  }

  /// `Subaddresses`
  String get subaddresses {
    return Intl.message(
      'Subaddresses',
      name: 'subaddresses',
      desc: '',
      args: [],
    );
  }

  /// `Restore Wallet`
  String get restore_restore_wallet {
    return Intl.message(
      'Restore Wallet',
      name: 'restore_restore_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Restore from seed/keys`
  String get restore_title_from_seed_keys {
    return Intl.message(
      'Restore from seed/keys',
      name: 'restore_title_from_seed_keys',
      desc: '',
      args: [],
    );
  }

  /// `Get back your wallet from seed/keys that you've saved to secure place`
  String get restore_description_from_seed_keys {
    return Intl.message(
      'Get back your wallet from seed/keys that you\'ve saved to secure place',
      name: 'restore_description_from_seed_keys',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get restore_next {
    return Intl.message(
      'Next',
      name: 'restore_next',
      desc: '',
      args: [],
    );
  }

  /// `Restore from a back-up file`
  String get restore_title_from_backup {
    return Intl.message(
      'Restore from a back-up file',
      name: 'restore_title_from_backup',
      desc: '',
      args: [],
    );
  }

  /// `You can restore the whole Beldex Wallet app from your back-up file`
  String get restore_description_from_backup {
    return Intl.message(
      'You can restore the whole Beldex Wallet app from your back-up file',
      name: 'restore_description_from_backup',
      desc: '',
      args: [],
    );
  }

  /// `Seed/Keys Restore`
  String get restore_seed_keys_restore {
    return Intl.message(
      'Seed/Keys Restore',
      name: 'restore_seed_keys_restore',
      desc: '',
      args: [],
    );
  }

  /// `Restore from Seed`
  String get restore_title_from_seed {
    return Intl.message(
      'Restore from Seed',
      name: 'restore_title_from_seed',
      desc: '',
      args: [],
    );
  }

  /// `Use the 25-word Mnemonic Key or Seed Phrase to Restore your Wallet.`
  String get restore_description_from_seed {
    return Intl.message(
      'Use the 25-word Mnemonic Key or Seed Phrase to Restore your Wallet.',
      name: 'restore_description_from_seed',
      desc: '',
      args: [],
    );
  }

  /// `Restore from Keys`
  String get restore_title_from_keys {
    return Intl.message(
      'Restore from Keys',
      name: 'restore_title_from_keys',
      desc: '',
      args: [],
    );
  }

  /// `Use the generated keystrokes saved from private keys to Restore your Wallet `
  String get restore_description_from_keys {
    return Intl.message(
      'Use the generated keystrokes saved from private keys to Restore your Wallet ',
      name: 'restore_description_from_keys',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Name`
  String get restore_wallet_name {
    return Intl.message(
      'Wallet Name',
      name: 'restore_wallet_name',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get restore_address {
    return Intl.message(
      'Address',
      name: 'restore_address',
      desc: '',
      args: [],
    );
  }

  /// `View key (private)`
  String get restore_view_key_private {
    return Intl.message(
      'View key (private)',
      name: 'restore_view_key_private',
      desc: '',
      args: [],
    );
  }

  /// `Spend key (private)`
  String get restore_spend_key_private {
    return Intl.message(
      'Spend key (private)',
      name: 'restore_spend_key_private',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get restore_recover {
    return Intl.message(
      'Restore',
      name: 'restore_recover',
      desc: '',
      args: [],
    );
  }

  /// `Wallet restore description`
  String get restore_wallet_restore_description {
    return Intl.message(
      'Wallet restore description',
      name: 'restore_wallet_restore_description',
      desc: '',
      args: [],
    );
  }

  /// `Seed`
  String get seed_title {
    return Intl.message(
      'Seed',
      name: 'seed_title',
      desc: '',
      args: [],
    );
  }

  /// `Share seed`
  String get seed_share {
    return Intl.message(
      'Share seed',
      name: 'seed_share',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a seed language`
  String get seed_language_choose {
    return Intl.message(
      'Please choose a seed language',
      name: 'seed_language_choose',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get seed_language_next {
    return Intl.message(
      'Next',
      name: 'seed_language_next',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get seed_language_english {
    return Intl.message(
      'English',
      name: 'seed_language_english',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get seed_language_chinese {
    return Intl.message(
      'Chinese',
      name: 'seed_language_chinese',
      desc: '',
      args: [],
    );
  }

  /// `Dutch`
  String get seed_language_dutch {
    return Intl.message(
      'Dutch',
      name: 'seed_language_dutch',
      desc: '',
      args: [],
    );
  }

  /// `German`
  String get seed_language_german {
    return Intl.message(
      'German',
      name: 'seed_language_german',
      desc: '',
      args: [],
    );
  }

  /// `Japanese`
  String get seed_language_japanese {
    return Intl.message(
      'Japanese',
      name: 'seed_language_japanese',
      desc: '',
      args: [],
    );
  }

  /// `Portuguese`
  String get seed_language_portuguese {
    return Intl.message(
      'Portuguese',
      name: 'seed_language_portuguese',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get seed_language_russian {
    return Intl.message(
      'Russian',
      name: 'seed_language_russian',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get seed_language_spanish {
    return Intl.message(
      'Spanish',
      name: 'seed_language_spanish',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get seed_language_french {
    return Intl.message(
      'French',
      name: 'seed_language_french',
      desc: '',
      args: [],
    );
  }

  /// `Italian`
  String get seed_language_italian {
    return Intl.message(
      'Italian',
      name: 'seed_language_italian',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send_title {
    return Intl.message(
      'Send',
      name: 'send_title',
      desc: '',
      args: [],
    );
  }

  /// `Your wallet`
  String get send_your_wallet {
    return Intl.message(
      'Your wallet',
      name: 'send_your_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Beldex address`
  String get send_beldex_address {
    return Intl.message(
      'Beldex address',
      name: 'send_beldex_address',
      desc: '',
      args: [],
    );
  }

  /// `ALL`
  String get all {
    return Intl.message(
      'ALL',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Currency can only contain numbers`
  String get send_error_currency {
    return Intl.message(
      'Currency can only contain numbers',
      name: 'send_error_currency',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Fee:`
  String get send_estimated_fee {
    return Intl.message(
      'Estimated Fee:',
      name: 'send_estimated_fee',
      desc: '',
      args: [],
    );
  }

  /// `{transactionPriority} priority is set as the default fee.\nGo to setting to change the transaction priority.`
  String send_priority(Object transactionPriority) {
    return Intl.message(
      '$transactionPriority priority is set as the default fee.\nGo to setting to change the transaction priority.',
      name: 'send_priority',
      desc: '',
      args: [transactionPriority],
    );
  }

  /// `Creating transaction`
  String get send_creating_transaction {
    return Intl.message(
      'Creating transaction',
      name: 'send_creating_transaction',
      desc: '',
      args: [],
    );
  }

  /// `Stakes`
  String get title_stakes {
    return Intl.message(
      'Stakes',
      name: 'title_stakes',
      desc: '',
      args: [],
    );
  }

  /// `New Stake`
  String get title_new_stake {
    return Intl.message(
      'New Stake',
      name: 'title_new_stake',
      desc: '',
      args: [],
    );
  }

  /// `Your Contributions`
  String get your_contributions {
    return Intl.message(
      'Your Contributions',
      name: 'your_contributions',
      desc: '',
      args: [],
    );
  }

  /// `Start staking`
  String get start_staking {
    return Intl.message(
      'Start staking',
      name: 'start_staking',
      desc: '',
      args: [],
    );
  }

  /// `Stake more`
  String get stake_more {
    return Intl.message(
      'Stake more',
      name: 'stake_more',
      desc: '',
      args: [],
    );
  }

  /// `Nothing staked yet`
  String get nothing_staked {
    return Intl.message(
      'Nothing staked yet',
      name: 'nothing_staked',
      desc: '',
      args: [],
    );
  }

  /// `Master Node Key`
  String get service_node_key {
    return Intl.message(
      'Master Node Key',
      name: 'service_node_key',
      desc: '',
      args: [],
    );
  }

  /// `Stake Beldex`
  String get stake_beldex {
    return Intl.message(
      'Stake Beldex',
      name: 'stake_beldex',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Stake`
  String get title_confirm_unlock_stake {
    return Intl.message(
      'Unlock Stake',
      name: 'title_confirm_unlock_stake',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to unlock your stake from {masterNodeKey}?`
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return Intl.message(
      'Do you really want to unlock your stake from $masterNodeKey?',
      name: 'body_confirm_unlock_stake',
      desc: '',
      args: [masterNodeKey],
    );
  }

  /// `Stake unlock requested`
  String get unlock_stake_requested {
    return Intl.message(
      'Stake unlock requested',
      name: 'unlock_stake_requested',
      desc: '',
      args: [],
    );
  }

  /// `Unable to unlock stake`
  String get unable_unlock_stake {
    return Intl.message(
      'Unable to unlock stake',
      name: 'unable_unlock_stake',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_title {
    return Intl.message(
      'Settings',
      name: 'settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Nodes`
  String get settings_nodes {
    return Intl.message(
      'Nodes',
      name: 'settings_nodes',
      desc: '',
      args: [],
    );
  }

  /// `Current node`
  String get settings_current_node {
    return Intl.message(
      'Current node',
      name: 'settings_current_node',
      desc: '',
      args: [],
    );
  }

  /// `Wallets`
  String get settings_wallets {
    return Intl.message(
      'Wallets',
      name: 'settings_wallets',
      desc: '',
      args: [],
    );
  }

  /// `Display Balance As`
  String get settings_display_balance_as {
    return Intl.message(
      'Display Balance As',
      name: 'settings_display_balance_as',
      desc: '',
      args: [],
    );
  }

  /// `Decimals`
  String get settings_balance_detail {
    return Intl.message(
      'Decimals',
      name: 'settings_balance_detail',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get settings_currency {
    return Intl.message(
      'Currency',
      name: 'settings_currency',
      desc: '',
      args: [],
    );
  }

  /// `Fee Priority`
  String get settings_fee_priority {
    return Intl.message(
      'Fee Priority',
      name: 'settings_fee_priority',
      desc: '',
      args: [],
    );
  }

  /// `Save recipient address`
  String get settings_save_recipient_address {
    return Intl.message(
      'Save recipient address',
      name: 'settings_save_recipient_address',
      desc: '',
      args: [],
    );
  }

  /// `Personal`
  String get settings_personal {
    return Intl.message(
      'Personal',
      name: 'settings_personal',
      desc: '',
      args: [],
    );
  }

  /// `Change PIN`
  String get settings_change_pin {
    return Intl.message(
      'Change PIN',
      name: 'settings_change_pin',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get settings_change_language {
    return Intl.message(
      'Select Language',
      name: 'settings_change_language',
      desc: '',
      args: [],
    );
  }

  /// `Allow biometric authentication`
  String get settings_allow_biometric_authentication {
    return Intl.message(
      'Allow biometric authentication',
      name: 'settings_allow_biometric_authentication',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get settings_dark_mode {
    return Intl.message(
      'Dark mode',
      name: 'settings_dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Transactions`
  String get settings_transactions {
    return Intl.message(
      'Transactions',
      name: 'settings_transactions',
      desc: '',
      args: [],
    );
  }

  /// `Display on dashboard list`
  String get settings_display_on_dashboard_list {
    return Intl.message(
      'Display on dashboard list',
      name: 'settings_display_on_dashboard_list',
      desc: '',
      args: [],
    );
  }

  /// `ALL`
  String get settings_all {
    return Intl.message(
      'ALL',
      name: 'settings_all',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get settings_none {
    return Intl.message(
      'None',
      name: 'settings_none',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get settings_support {
    return Intl.message(
      'Support',
      name: 'settings_support',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get settings_terms_and_conditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'settings_terms_and_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Enable Fiat Currency conversion`
  String get settings_enable_fiat_currency {
    return Intl.message(
      'Enable Fiat Currency conversion',
      name: 'settings_enable_fiat_currency',
      desc: '',
      args: [],
    );
  }

  /// `PIN is incorrect`
  String get pin_is_incorrect {
    return Intl.message(
      'PIN is incorrect',
      name: 'pin_is_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `9 - Ultra`
  String get amount_detail_ultra {
    return Intl.message(
      '9 - Ultra',
      name: 'amount_detail_ultra',
      desc: '',
      args: [],
    );
  }

  /// `0 - None`
  String get amount_detail_none {
    return Intl.message(
      '0 - None',
      name: 'amount_detail_none',
      desc: '',
      args: [],
    );
  }

  /// `4 - Detailed`
  String get amount_detail_detailed {
    return Intl.message(
      '4 - Detailed',
      name: 'amount_detail_detailed',
      desc: '',
      args: [],
    );
  }

  /// `2 - Normal`
  String get amount_detail_normal {
    return Intl.message(
      '2 - Normal',
      name: 'amount_detail_normal',
      desc: '',
      args: [],
    );
  }

  /// `Setup PIN`
  String get setup_pin {
    return Intl.message(
      'Setup PIN',
      name: 'setup_pin',
      desc: '',
      args: [],
    );
  }

  /// `Re-Enter your PIN`
  String get re_enter_your_pin {
    return Intl.message(
      'Re-Enter your PIN',
      name: 're_enter_your_pin',
      desc: '',
      args: [],
    );
  }

  /// `Your PIN has been set up \nsuccessfully!`
  String get setup_successful {
    return Intl.message(
      'Your PIN has been set up \nsuccessfully!',
      name: 'setup_successful',
      desc: '',
      args: [],
    );
  }

  /// `Wallet keys`
  String get wallet_keys {
    return Intl.message(
      'Wallet keys',
      name: 'wallet_keys',
      desc: '',
      args: [],
    );
  }

  /// `View key (private)`
  String get view_key_private {
    return Intl.message(
      'View key (private)',
      name: 'view_key_private',
      desc: '',
      args: [],
    );
  }

  /// `View key (public)`
  String get view_key_public {
    return Intl.message(
      'View key (public)',
      name: 'view_key_public',
      desc: '',
      args: [],
    );
  }

  /// `Spend key (private)`
  String get spend_key_private {
    return Intl.message(
      'Spend key (private)',
      name: 'spend_key_private',
      desc: '',
      args: [],
    );
  }

  /// `Spend key (public)`
  String get spend_key_public {
    return Intl.message(
      'Spend key (public)',
      name: 'spend_key_public',
      desc: '',
      args: [],
    );
  }

  /// `Copied {key} to Clipboard`
  String copied_key_to_clipboard(Object key) {
    return Intl.message(
      'Copied $key to Clipboard',
      name: 'copied_key_to_clipboard',
      desc: '',
      args: [key],
    );
  }

  /// `New subaddress`
  String get new_subaddress_title {
    return Intl.message(
      'New subaddress',
      name: 'new_subaddress_title',
      desc: '',
      args: [],
    );
  }

  /// `Label name`
  String get new_subaddress_label_name {
    return Intl.message(
      'Label name',
      name: 'new_subaddress_label_name',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get new_subaddress_create {
    return Intl.message(
      'Create',
      name: 'new_subaddress_create',
      desc: '',
      args: [],
    );
  }

  /// `Subaddress list`
  String get subaddress_title {
    return Intl.message(
      'Subaddress list',
      name: 'subaddress_title',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Details`
  String get transaction_details_title {
    return Intl.message(
      'Transaction Details',
      name: 'transaction_details_title',
      desc: '',
      args: [],
    );
  }

  /// `Transaction ID`
  String get transaction_details_transaction_id {
    return Intl.message(
      'Transaction ID',
      name: 'transaction_details_transaction_id',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get transaction_details_date {
    return Intl.message(
      'Date',
      name: 'transaction_details_date',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get transaction_details_height {
    return Intl.message(
      'Height',
      name: 'transaction_details_height',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get transaction_details_amount {
    return Intl.message(
      'Amount',
      name: 'transaction_details_amount',
      desc: '',
      args: [],
    );
  }

  /// `{title} copied to Clipboard`
  String transaction_details_copied(Object title) {
    return Intl.message(
      '$title copied to Clipboard',
      name: 'transaction_details_copied',
      desc: '',
      args: [title],
    );
  }

  /// `Recipient Address`
  String get transaction_details_recipient_address {
    return Intl.message(
      'Recipient Address',
      name: 'transaction_details_recipient_address',
      desc: '',
      args: [],
    );
  }

  /// `Beldex Wallet`
  String get wallet_list_title {
    return Intl.message(
      'Beldex Wallet',
      name: 'wallet_list_title',
      desc: '',
      args: [],
    );
  }

  /// `Create New Wallet`
  String get wallet_list_create_new_wallet {
    return Intl.message(
      'Create New Wallet',
      name: 'wallet_list_create_new_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Use Existing Wallet`
  String get wallet_list_restore_wallet {
    return Intl.message(
      'Use Existing Wallet',
      name: 'wallet_list_restore_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Load wallet`
  String get wallet_list_load_wallet {
    return Intl.message(
      'Load wallet',
      name: 'wallet_list_load_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Loading {wallet_name} wallet`
  String wallet_list_loading_wallet(Object wallet_name) {
    return Intl.message(
      'Loading $wallet_name wallet',
      name: 'wallet_list_loading_wallet',
      desc: '',
      args: [wallet_name],
    );
  }

  /// `Failed to load {wallet_name} wallet. {error}`
  String wallet_list_failed_to_load(Object wallet_name, Object error) {
    return Intl.message(
      'Failed to load $wallet_name wallet. $error',
      name: 'wallet_list_failed_to_load',
      desc: '',
      args: [wallet_name, error],
    );
  }

  /// `Removing {wallet_name} wallet`
  String wallet_list_removing_wallet(Object wallet_name) {
    return Intl.message(
      'Removing $wallet_name wallet',
      name: 'wallet_list_removing_wallet',
      desc: '',
      args: [wallet_name],
    );
  }

  /// `Failed to remove {wallet_name} wallet. {error}`
  String wallet_list_failed_to_remove(Object wallet_name, Object error) {
    return Intl.message(
      'Failed to remove $wallet_name wallet. $error',
      name: 'wallet_list_failed_to_remove',
      desc: '',
      args: [wallet_name, error],
    );
  }

  /// `Address`
  String get widgets_address {
    return Intl.message(
      'Address',
      name: 'widgets_address',
      desc: '',
      args: [],
    );
  }

  /// `Restore from Blockheight`
  String get widgets_restore_from_blockheight {
    return Intl.message(
      'Restore from Blockheight',
      name: 'widgets_restore_from_blockheight',
      desc: '',
      args: [],
    );
  }

  /// `Restore from Date`
  String get widgets_restore_from_date {
    return Intl.message(
      'Restore from Date',
      name: 'widgets_restore_from_date',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get widgets_or {
    return Intl.message(
      'OR',
      name: 'widgets_or',
      desc: '',
      args: [],
    );
  }

  /// `Seed`
  String get widgets_seed {
    return Intl.message(
      'Seed',
      name: 'widgets_seed',
      desc: '',
      args: [],
    );
  }

  /// `No route defined for {name}`
  String router_no_route(Object name) {
    return Intl.message(
      'No route defined for $name',
      name: 'router_no_route',
      desc: '',
      args: [name],
    );
  }

  /// `Account name can only contain letters, numbers\nand must be between 1 and 15 characters long`
  String get error_text_account_name {
    return Intl.message(
      'Account name can only contain letters, numbers\nand must be between 1 and 15 characters long',
      name: 'error_text_account_name',
      desc: '',
      args: [],
    );
  }

  /// `Contact name can't contain ' , ' " symbols\nand must be between 1 and 32 characters long`
  String get error_text_contact_name {
    return Intl.message(
      'Contact name can\'t contain ` , \' " symbols\nand must be between 1 and 32 characters long',
      name: 'error_text_contact_name',
      desc: '',
      args: [],
    );
  }

  /// `Invalid BDX address`
  String get error_text_address {
    return Intl.message(
      'Invalid BDX address',
      name: 'error_text_address',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a iPv4 address`
  String get error_text_node_address {
    return Intl.message(
      'Please enter a iPv4 address',
      name: 'error_text_node_address',
      desc: '',
      args: [],
    );
  }

  /// `Node port can only contain numbers between 0 and 65535`
  String get error_text_node_port {
    return Intl.message(
      'Node port can only contain numbers between 0 and 65535',
      name: 'error_text_node_port',
      desc: '',
      args: [],
    );
  }

  /// `Payment ID can only contain from 16 to 64 chars in hex`
  String get error_text_payment_id {
    return Intl.message(
      'Payment ID can only contain from 16 to 64 chars in hex',
      name: 'error_text_payment_id',
      desc: '',
      args: [],
    );
  }

  /// `Beldex value can't exceed available balance.\nThe number of fraction digits must be less or equal to 9`
  String get error_text_beldex {
    return Intl.message(
      'Beldex value can\'t exceed available balance.\nThe number of fraction digits must be less or equal to 9',
      name: 'error_text_beldex',
      desc: '',
      args: [],
    );
  }

  /// `Value of amount can't exceed available balance.\nThe number of fraction digits must be less or equal to 2`
  String get error_text_fiat {
    return Intl.message(
      'Value of amount can\'t exceed available balance.\nThe number of fraction digits must be less or equal to 2',
      name: 'error_text_fiat',
      desc: '',
      args: [],
    );
  }

  /// `Subaddress name can't contain ' , ' " symbols\nand must be between 1 and 20 characters long`
  String get error_text_subaddress_name {
    return Intl.message(
      'Subaddress name can\'t contain ` , \' " symbols\nand must be between 1 and 20 characters long',
      name: 'error_text_subaddress_name',
      desc: '',
      args: [],
    );
  }

  /// `Amount can only contain numbers`
  String get error_text_amount {
    return Intl.message(
      'Amount can only contain numbers',
      name: 'error_text_amount',
      desc: '',
      args: [],
    );
  }

  /// `Wallet name can only contain letters, numbers\nand must be between 1 and 15 characters long`
  String get error_text_wallet_name {
    return Intl.message(
      'Wallet name can only contain letters, numbers\nand must be between 1 and 15 characters long',
      name: 'error_text_wallet_name',
      desc: '',
      args: [],
    );
  }

  /// `Wallet keys can only contain 64 chars in hex`
  String get error_text_keys {
    return Intl.message(
      'Wallet keys can only contain 64 chars in hex',
      name: 'error_text_keys',
      desc: '',
      args: [],
    );
  }

  /// `The number of fraction digits\nmust be less or equal to 12`
  String get error_text_crypto_currency {
    return Intl.message(
      'The number of fraction digits\nmust be less or equal to 12',
      name: 'error_text_crypto_currency',
      desc: '',
      args: [],
    );
  }

  /// `A Master Node key can only contain 64 chars in hex`
  String get error_text_service_node {
    return Intl.message(
      'A Master Node key can only contain 64 chars in hex',
      name: 'error_text_service_node',
      desc: '',
      args: [],
    );
  }

  /// `ban_timeout`
  String get auth_store_ban_timeout {
    return Intl.message(
      'ban_timeout',
      name: 'auth_store_ban_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Banned for `
  String get auth_store_banned_for {
    return Intl.message(
      'Banned for ',
      name: 'auth_store_banned_for',
      desc: '',
      args: [],
    );
  }

  /// ` minutes`
  String get auth_store_banned_minutes {
    return Intl.message(
      ' minutes',
      name: 'auth_store_banned_minutes',
      desc: '',
      args: [],
    );
  }

  /// `Wrong PIN`
  String get auth_store_incorrect_password {
    return Intl.message(
      'Wrong PIN',
      name: 'auth_store_incorrect_password',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect seed length`
  String get wallet_restoration_store_incorrect_seed_length {
    return Intl.message(
      'Incorrect seed length',
      name: 'wallet_restoration_store_incorrect_seed_length',
      desc: '',
      args: [],
    );
  }

  /// `Full Balance`
  String get full_balance {
    return Intl.message(
      'Full Balance',
      name: 'full_balance',
      desc: '',
      args: [],
    );
  }

  /// `Available Balance`
  String get available_balance {
    return Intl.message(
      'Available Balance',
      name: 'available_balance',
      desc: '',
      args: [],
    );
  }

  /// `Hidden Balance`
  String get hidden_balance {
    return Intl.message(
      'Hidden Balance',
      name: 'hidden_balance',
      desc: '',
      args: [],
    );
  }

  /// `SYNCHRONIZING`
  String get sync_status_synchronizing {
    return Intl.message(
      'SYNCHRONIZING',
      name: 'sync_status_synchronizing',
      desc: '',
      args: [],
    );
  }

  /// `SYNCHRONIZED`
  String get sync_status_synchronized {
    return Intl.message(
      'SYNCHRONIZED',
      name: 'sync_status_synchronized',
      desc: '',
      args: [],
    );
  }

  /// `NOT CONNECTED`
  String get sync_status_not_connected {
    return Intl.message(
      'NOT CONNECTED',
      name: 'sync_status_not_connected',
      desc: '',
      args: [],
    );
  }

  /// `STARTING SYNC`
  String get sync_status_starting_sync {
    return Intl.message(
      'STARTING SYNC',
      name: 'sync_status_starting_sync',
      desc: '',
      args: [],
    );
  }

  /// `FAILED CONNECT TO THE NODE`
  String get sync_status_failed_connect {
    return Intl.message(
      'FAILED CONNECT TO THE NODE',
      name: 'sync_status_failed_connect',
      desc: '',
      args: [],
    );
  }

  /// `CONNECTING`
  String get sync_status_connecting {
    return Intl.message(
      'CONNECTING',
      name: 'sync_status_connecting',
      desc: '',
      args: [],
    );
  }

  /// `CONNECTED`
  String get sync_status_connected {
    return Intl.message(
      'CONNECTED',
      name: 'sync_status_connected',
      desc: '',
      args: [],
    );
  }

  /// `Slow`
  String get transaction_priority_slow {
    return Intl.message(
      'Slow',
      name: 'transaction_priority_slow',
      desc: '',
      args: [],
    );
  }

  /// `Flash`
  String get transaction_priority_blink {
    return Intl.message(
      'Flash',
      name: 'transaction_priority_blink',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Change language to {language}?`
  String change_language_to(Object language) {
    return Intl.message(
      'Change language to $language?',
      name: 'change_language_to',
      desc: '',
      args: [language],
    );
  }

  /// `Paste`
  String get paste {
    return Intl.message(
      'Paste',
      name: 'paste',
      desc: '',
      args: [],
    );
  }

  /// `Please enter or paste your seed here`
  String get restore_from_seed_placeholder {
    return Intl.message(
      'Please enter or paste your seed here',
      name: 'restore_from_seed_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Add new word`
  String get add_new_word {
    return Intl.message(
      'Add new word',
      name: 'add_new_word',
      desc: '',
      args: [],
    );
  }

  /// `The text entered is not valid.`
  String get incorrect_seed {
    return Intl.message(
      'The text entered is not valid.',
      name: 'incorrect_seed',
      desc: '',
      args: [],
    );
  }

  /// `Scan your fingerprint to authenticate`
  String get biometric_auth_reason {
    return Intl.message(
      'Scan your fingerprint to authenticate',
      name: 'biometric_auth_reason',
      desc: '',
      args: [],
    );
  }

  /// `Version {currentVersion}`
  String version(Object currentVersion) {
    return Intl.message(
      'Version $currentVersion',
      name: 'version',
      desc: '',
      args: [currentVersion],
    );
  }

  /// `Beldex Recipient Detected`
  String get openalias_alert_title {
    return Intl.message(
      'Beldex Recipient Detected',
      name: 'openalias_alert_title',
      desc: '',
      args: [],
    );
  }

  /// `You will be sending funds to\n{recipient_name}`
  String openalias_alert_content(Object recipient_name) {
    return Intl.message(
      'You will be sending funds to\n$recipient_name',
      name: 'openalias_alert_content',
      desc: '',
      args: [recipient_name],
    );
  }

  /// `Dangerzone`
  String get dangerzone {
    return Intl.message(
      'Dangerzone',
      name: 'dangerzone',
      desc: '',
      args: [],
    );
  }

  /// `Yes, I'm sure!`
  String get yes_im_sure {
    return Intl.message(
      'Yes, I\'m sure!',
      name: 'yes_im_sure',
      desc: '',
      args: [],
    );
  }

  /// `Never Give your Beldex Wallet {item} to Anyone!`
  String never_give_your(Object item) {
    return Intl.message(
      'Never Give your Beldex Wallet $item to Anyone!',
      name: 'never_give_your',
      desc: '',
      args: [item],
    );
  }

  /// `NEVER input your Beldex wallet {item} into any software or website other than the OFFICIAL Beldex wallets downloaded directly from the {app_store}, the Beldex website, or the Beldex GitHub.\nAre you sure you want to access your wallet {item}?`
  String dangerzone_warning(Object item, Object app_store) {
    return Intl.message(
      'NEVER input your Beldex wallet $item into any software or website other than the OFFICIAL Beldex wallets downloaded directly from the $app_store, the Beldex website, or the Beldex GitHub.\nAre you sure you want to access your wallet $item?',
      name: 'dangerzone_warning',
      desc: '',
      args: [item, app_store],
    );
  }

  /// `Keys`
  String get keys_title {
    return Intl.message(
      'Keys',
      name: 'keys_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get are_you_sure {
    return Intl.message(
      'Are you sure?',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to exit an App`
  String get do_you_want_to_exit_an_app {
    return Intl.message(
      'Do you want to exit an App',
      name: 'do_you_want_to_exit_an_app',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `By using this app, you agree to the Terms of Agreement set forth to below`
  String get byUsingThisAppYouAgreeToTheTermsOf {
    return Intl.message(
      'By using this app, you agree to the Terms of Agreement set forth to below',
      name: 'byUsingThisAppYouAgreeToTheTermsOf',
      desc: '',
      args: [],
    );
  }

  /// `I agree to Terms of Use`
  String get iAgreeToTermsOfUse {
    return Intl.message(
      'I agree to Terms of Use',
      name: 'iAgreeToTermsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid amount`
  String get pleaseEnterAValidAmount {
    return Intl.message(
      'Please enter a valid amount',
      name: 'pleaseEnterAValidAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid seed`
  String get pleaseEnterAValidSeed {
    return Intl.message(
      'Please enter a valid seed',
      name: 'pleaseEnterAValidSeed',
      desc: '',
      args: [],
    );
  }

  /// `Change Wallet`
  String get changeWallet {
    return Intl.message(
      'Change Wallet',
      name: 'changeWallet',
      desc: '',
      args: [],
    );
  }

  /// `Remove Wallet`
  String get removeWallet {
    return Intl.message(
      'Remove Wallet',
      name: 'removeWallet',
      desc: '',
      args: [],
    );
  }

  /// `Reconnect Wallet`
  String get reconnectWallet {
    return Intl.message(
      'Reconnect Wallet',
      name: 'reconnectWallet',
      desc: '',
      args: [],
    );
  }

  /// `Rescan Wallet`
  String get rescanWallet {
    return Intl.message(
      'Rescan Wallet',
      name: 'rescanWallet',
      desc: '',
      args: [],
    );
  }

  /// `Enter Wallet Name`
  String get enterWalletName {
    return Intl.message(
      'Enter Wallet Name',
      name: 'enterWalletName',
      desc: '',
      args: [],
    );
  }

  /// `No transactions yet!`
  String get noTransactionsYet {
    return Intl.message(
      'No transactions yet!',
      name: 'noTransactionsYet',
      desc: '',
      args: [],
    );
  }

  /// `After your first transaction,\n you will be able to view it here.`
  String get afterYourFirstTransactionnYouWillBeAbleToView {
    return Intl.message(
      'After your first transaction,\n you will be able to view it here.',
      name: 'afterYourFirstTransactionnYouWillBeAbleToView',
      desc: '',
      args: [],
    );
  }

  /// `Copied`
  String get copied {
    return Intl.message(
      'Copied',
      name: 'copied',
      desc: '',
      args: [],
    );
  }

  /// `Add Address`
  String get addAddress {
    return Intl.message(
      'Add Address',
      name: 'addAddress',
      desc: '',
      args: [],
    );
  }

  /// `IMPORTANT`
  String get important {
    return Intl.message(
      'IMPORTANT',
      name: 'important',
      desc: '',
      args: [],
    );
  }

  /// `Never input your Beldex wallet {item} into any software or website other than the official Beldex wallets downloaded directly from the {appStore},the beldex website, or the beldex GitHub.`
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object item, Object appStore) {
    return Intl.message(
      'Never input your Beldex wallet $item into any software or website other than the official Beldex wallets downloaded directly from the $appStore,the beldex website, or the beldex GitHub.',
      name: 'neverInputYourBeldexWalletItemIntoAnySoftwareOr',
      desc: '',
      args: [item, appStore],
    );
  }

  /// `Enter wallet name`
  String get enterWalletName_ {
    return Intl.message(
      'Enter wallet name',
      name: 'enterWalletName_',
      desc: '',
      args: [],
    );
  }

  /// `Choose Seed Language`
  String get chooseSeedLanguage {
    return Intl.message(
      'Choose Seed Language',
      name: 'chooseSeedLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Seed & Keys`
  String get seedKeys {
    return Intl.message(
      'Seed & Keys',
      name: 'seedKeys',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Address`
  String get walletAddress {
    return Intl.message(
      'Wallet Address',
      name: 'walletAddress',
      desc: '',
      args: [],
    );
  }

  /// `Recovery Seed/Key`
  String get recoverySeedkey {
    return Intl.message(
      'Recovery Seed/Key',
      name: 'recoverySeedkey',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get chooseLanguage {
    return Intl.message(
      'Choose Language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Beldex Wallet :)`
  String get welcomeToBeldexWallet {
    return Intl.message(
      'Welcome to Beldex Wallet :)',
      name: 'welcomeToBeldexWallet',
      desc: '',
      args: [],
    );
  }

  /// `Select an option below to create or\n recover existing wallet`
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet {
    return Intl.message(
      'Select an option below to create or\n recover existing wallet',
      name: 'selectAnOptionBelowToCreateOrnRecoverExistingWallet',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid name upto 15 characters`
  String get enterAValidNameUpto15Characters {
    return Intl.message(
      'Enter a valid name upto 15 characters',
      name: 'enterAValidNameUpto15Characters',
      desc: '',
      args: [],
    );
  }

  /// `5 - Five (0.00000)`
  String get fiveDecimals {
    return Intl.message(
      '5 - Five (0.00000)',
      name: 'fiveDecimals',
      desc: '',
      args: [],
    );
  }

  /// `4 - Four (0.0000)`
  String get fourDecimals {
    return Intl.message(
      '4 - Four (0.0000)',
      name: 'fourDecimals',
      desc: '',
      args: [],
    );
  }

  /// `2 - Two (0.00)`
  String get twoDecimals {
    return Intl.message(
      '2 - Two (0.00)',
      name: 'twoDecimals',
      desc: '',
      args: [],
    );
  }

  /// `0 - Zero (000)`
  String get zeroDecimal {
    return Intl.message(
      '0 - Zero (000)',
      name: 'zeroDecimal',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to exit the wallet?`
  String get doYouWantToExitTheWallet {
    return Intl.message(
      'Do you want to exit the wallet?',
      name: 'doYouWantToExitTheWallet',
      desc: '',
      args: [],
    );
  }

  /// `Make sure to backup of your\nrecovery Seed, wallet address\nand private keys`
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate {
    return Intl.message(
      'Make sure to backup of your\nrecovery Seed, wallet address\nand private keys',
      name: 'makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate',
      desc: '',
      args: [],
    );
  }

  /// `{status} Block Remaining`
  String blockRemaining(Object status) {
    return Intl.message(
      '$status Block Remaining',
      name: 'blockRemaining',
      desc: '',
      args: [status],
    );
  }

  /// `Flash Transaction`
  String get flashTransaction {
    return Intl.message(
      'Flash Transaction',
      name: 'flashTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Transfer your BDX more faster\n with Flash Transaction!`
  String get transferYourBdxMoreFasternWithFlashTransaction {
    return Intl.message(
      'Transfer your BDX more faster\n with Flash Transaction!',
      name: 'transferYourBdxMoreFasternWithFlashTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your PIN`
  String get enterYourPin {
    return Intl.message(
      'Enter Your PIN',
      name: 'enterYourPin',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Settings`
  String get walletSettings {
    return Intl.message(
      'Wallet Settings',
      name: 'walletSettings',
      desc: '',
      args: [],
    );
  }

  /// `Recovery Seed`
  String get recoverySeed {
    return Intl.message(
      'Recovery Seed',
      name: 'recoverySeed',
      desc: '',
      args: [],
    );
  }

  /// `You don't have enough unlocked balance`
  String get youDontHaveEnoughUnlockedBalance {
    return Intl.message(
      'You don\'t have enough unlocked balance',
      name: 'youDontHaveEnoughUnlockedBalance',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alert {
    return Intl.message(
      'Alert',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `Touch the Fingerprint sensor`
  String get touchTheFingerprintSensor {
    return Intl.message(
      'Touch the Fingerprint sensor',
      name: 'touchTheFingerprintSensor',
      desc: '',
      args: [],
    );
  }

  /// `USE PATTERN`
  String get usePattern {
    return Intl.message(
      'USE PATTERN',
      name: 'usePattern',
      desc: '',
      args: [],
    );
  }

  /// `Enter BDX to send`
  String get enterBdxToSend {
    return Intl.message(
      'Enter BDX to send',
      name: 'enterBdxToSend',
      desc: '',
      args: [],
    );
  }

  /// `Enter Amount`
  String get enterAmount {
    return Intl.message(
      'Enter Amount',
      name: 'enterAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a amount`
  String get pleaseEnterAAmount {
    return Intl.message(
      'Please enter a amount',
      name: 'pleaseEnterAAmount',
      desc: '',
      args: [],
    );
  }

  /// `Committing the Transaction`
  String get committingTheTransaction {
    return Intl.message(
      'Committing the Transaction',
      name: 'committingTheTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Available BDX : `
  String get availableBdx {
    return Intl.message(
      'Available BDX : ',
      name: 'availableBdx',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a bdx address`
  String get pleaseEnterABdxAddress {
    return Intl.message(
      'Please enter a bdx address',
      name: 'pleaseEnterABdxAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid address`
  String get enterAValidAddress {
    return Intl.message(
      'Enter a valid address',
      name: 'enterAValidAddress',
      desc: '',
      args: [],
    );
  }

  /// `Biometric feature currenly disabled.Kindly enable allow biometric authentication feature inside the app settings`
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside {
    return Intl.message(
      'Biometric feature currenly disabled.Kindly enable allow biometric authentication feature inside the app settings',
      name: 'biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Beldex Wallet`
  String get unlockBeldexWallet {
    return Intl.message(
      'Unlock Beldex Wallet',
      name: 'unlockBeldexWallet',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your screen lock PIN,Pattern and password`
  String get confirmYourScreenLockPinpatternAndPassword {
    return Intl.message(
      'Confirm your screen lock PIN,Pattern and password',
      name: 'confirmYourScreenLockPinpatternAndPassword',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to change your\n primary account?`
  String get doYouWantToChangeYournPrimaryAccount {
    return Intl.message(
      'Do you want to change your\n primary account?',
      name: 'doYouWantToChangeYournPrimaryAccount',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get rename {
    return Intl.message(
      'Rename',
      name: 'rename',
      desc: '',
      args: [],
    );
  }

  /// `Add Account`
  String get addAccount {
    return Intl.message(
      'Add Account',
      name: 'addAccount',
      desc: '',
      args: [],
    );
  }

  /// `No addresses in book`
  String get noAddressesInBook {
    return Intl.message(
      'No addresses in book',
      name: 'noAddressesInBook',
      desc: '',
      args: [],
    );
  }

  /// `BDX`
  String get bdx {
    return Intl.message(
      'BDX',
      name: 'bdx',
      desc: '',
      args: [],
    );
  }

  /// `However we recommend to scan the blockchain from the block height at which you created the wallet to get all transactions and correct balance`
  String get howeverWeRecommendToScanTheBlockchainFromTheBlock {
    return Intl.message(
      'However we recommend to scan the blockchain from the block height at which you created the wallet to get all transactions and correct balance',
      name: 'howeverWeRecommendToScanTheBlockchainFromTheBlock',
      desc: '',
      args: [],
    );
  }

  /// `You have scanned from the block height`
  String get youHaveScannedFromTheBlockHeight {
    return Intl.message(
      'You have scanned from the block height',
      name: 'youHaveScannedFromTheBlockHeight',
      desc: '',
      args: [],
    );
  }

  /// `Sync info`
  String get syncInfo {
    return Intl.message(
      'Sync info',
      name: 'syncInfo',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to reconnect\n the wallet?`
  String get doYouWantToReconnectnTheWallet {
    return Intl.message(
      'Do you want to reconnect\n the wallet?',
      name: 'doYouWantToReconnectnTheWallet',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid name upto 15 characters`
  String get enterValidNameUpto15Characters {
    return Intl.message(
      'Enter valid name upto 15 characters',
      name: 'enterValidNameUpto15Characters',
      desc: '',
      args: [],
    );
  }

  /// `Checking node connection...`
  String get checkingNodeConnection {
    return Intl.message(
      'Checking node connection...',
      name: 'checkingNodeConnection',
      desc: '',
      args: [],
    );
  }

  /// `Enter BDX to Receive`
  String get enterBdxToReceive {
    return Intl.message(
      'Enter BDX to Receive',
      name: 'enterBdxToReceive',
      desc: '',
      args: [],
    );
  }

  /// `Add Sub Address`
  String get addSubAddress {
    return Intl.message(
      'Add Sub Address',
      name: 'addSubAddress',
      desc: '',
      args: [],
    );
  }

  /// `Share QR`
  String get shareQr {
    return Intl.message(
      'Share QR',
      name: 'shareQr',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid height without space`
  String get enterValidHeightWithoutSpace {
    return Intl.message(
      'Enter valid height without space',
      name: 'enterValidHeightWithoutSpace',
      desc: '',
      args: [],
    );
  }

  /// `Date should not be empty`
  String get dateShouldNotBeEmpty {
    return Intl.message(
      'Date should not be empty',
      name: 'dateShouldNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Restore`
  String get walletRestore {
    return Intl.message(
      'Wallet Restore',
      name: 'walletRestore',
      desc: '',
      args: [],
    );
  }

  /// `You can't view the seed because you've restored using keys`
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys {
    return Intl.message(
      'You can\'t view the seed because you\'ve restored using keys',
      name: 'youCantViewTheSeedBecauseYouveRestoredUsingKeys',
      desc: '',
      args: [],
    );
  }

  /// `Never share your seed to anyone! Check your surroundings to ensure no one is overlooking`
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo {
    return Intl.message(
      'Never share your seed to anyone! Check your surroundings to ensure no one is overlooking',
      name: 'neverShareYourSeedToAnyoneCheckYourSurroundingsTo',
      desc: '',
      args: [],
    );
  }

  /// `Note :`
  String get note {
    return Intl.message(
      'Note :',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Copy Seed`
  String get copySeed {
    return Intl.message(
      'Copy Seed',
      name: 'copySeed',
      desc: '',
      args: [],
    );
  }

  /// `Account already exist`
  String get accountAlreadyExist {
    return Intl.message(
      'Account already exist',
      name: 'accountAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Transaction initiated successfully`
  String get transactionInitiatedSuccessfully {
    return Intl.message(
      'Transaction initiated successfully',
      name: 'transactionInitiatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid sub address`
  String get enterAValidSubAddress {
    return Intl.message(
      'Enter a valid sub address',
      name: 'enterAValidSubAddress',
      desc: '',
      args: [],
    );
  }

  /// `Subaddress already exist`
  String get subaddressAlreadyExist {
    return Intl.message(
      'Subaddress already exist',
      name: 'subaddressAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Label name`
  String get labelName {
    return Intl.message(
      'Label name',
      name: 'labelName',
      desc: '',
      args: [],
    );
  }

  /// `Sub Address`
  String get subAddress {
    return Intl.message(
      'Sub Address',
      name: 'subAddress',
      desc: '',
      args: [],
    );
  }

  /// `Loading the wallet...`
  String get loadingTheWallet {
    return Intl.message(
      'Loading the wallet...',
      name: 'loadingTheWallet',
      desc: '',
      args: [],
    );
  }

  /// `You are about to delete\n your wallet!`
  String get youAreAboutToDeletenYourWallet {
    return Intl.message(
      'You are about to delete\n your wallet!',
      name: 'youAreAboutToDeletenYourWallet',
      desc: '',
      args: [],
    );
  }

  /// `Creating the Transaction`
  String get creatingTheTransaction {
    return Intl.message(
      'Creating the Transaction',
      name: 'creatingTheTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Copy and save the seed to continue`
  String get copyAndSaveTheSeedToContinue {
    return Intl.message(
      'Copy and save the seed to continue',
      name: 'copyAndSaveTheSeedToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Enter PIN`
  String get enterPin {
    return Intl.message(
      'Enter PIN',
      name: 'enterPin',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get test {
    return Intl.message(
      'Test',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Connection Failed`
  String get connectionFailed {
    return Intl.message(
      'Connection Failed',
      name: 'connectionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Checking...`
  String get checking {
    return Intl.message(
      'Checking...',
      name: 'checking',
      desc: '',
      args: [],
    );
  }

  /// `Test Result:`
  String get testResult {
    return Intl.message(
      'Test Result:',
      name: 'testResult',
      desc: '',
      args: [],
    );
  }

  /// `Password (optional)`
  String get passwordOptional {
    return Intl.message(
      'Password (optional)',
      name: 'passwordOptional',
      desc: '',
      args: [],
    );
  }

  /// `User Name (optional)`
  String get userNameOptional {
    return Intl.message(
      'User Name (optional)',
      name: 'userNameOptional',
      desc: '',
      args: [],
    );
  }

  /// `Node Name (optional)`
  String get nodeNameOptional {
    return Intl.message(
      'Node Name (optional)',
      name: 'nodeNameOptional',
      desc: '',
      args: [],
    );
  }

  /// `Add Node`
  String get addNode {
    return Intl.message(
      'Add Node',
      name: 'addNode',
      desc: '',
      args: [],
    );
  }

  /// `Legal Disclaimer`
  String get legalDisclaimer {
    return Intl.message(
      'Legal Disclaimer',
      name: 'legalDisclaimer',
      desc: '',
      args: [],
    );
  }

  /// `How can we\nhelp you?`
  String get howCanWenhelpYou {
    return Intl.message(
      'How can we\nhelp you?',
      name: 'howCanWenhelpYou',
      desc: '',
      args: [],
    );
  }

  /// `Remove Contact`
  String get removeContact {
    return Intl.message(
      'Remove Contact',
      name: 'removeContact',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove selected contact?`
  String get areYouSureYouWantToRemoveSelectedContact {
    return Intl.message(
      'Are you sure you want to remove selected contact?',
      name: 'areYouSureYouWantToRemoveSelectedContact',
      desc: '',
      args: [],
    );
  }

  /// `The Address already Exist`
  String get theAddressAlreadyExist {
    return Intl.message(
      'The Address already Exist',
      name: 'theAddressAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `This Name already Exist`
  String get thisNameAlreadyExist {
    return Intl.message(
      'This Name already Exist',
      name: 'thisNameAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid name`
  String get enterAValidName {
    return Intl.message(
      'Enter a valid name',
      name: 'enterAValidName',
      desc: '',
      args: [],
    );
  }

  /// `Name should not be empty`
  String get nameShouldNotBeEmpty {
    return Intl.message(
      'Name should not be empty',
      name: 'nameShouldNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter Name`
  String get enterName {
    return Intl.message(
      'Enter Name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Account Name`
  String get accountName {
    return Intl.message(
      'Account Name',
      name: 'accountName',
      desc: '',
      args: [],
    );
  }

  /// `Play Store`
  String get playStore {
    return Intl.message(
      'Play Store',
      name: 'playStore',
      desc: '',
      args: [],
    );
  }

  /// `AppStore`
  String get appstore {
    return Intl.message(
      'AppStore',
      name: 'appstore',
      desc: '',
      args: [],
    );
  }

  /// `Allow face id authentication`
  String get allowFaceIdAuthentication {
    return Intl.message(
      'Allow face id authentication',
      name: 'allowFaceIdAuthentication',
      desc: '',
      args: [],
    );
  }

  /// `Enter Address`
  String get enterAddress {
    return Intl.message(
      'Enter Address',
      name: 'enterAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please add a mainnet node`
  String get pleaseAddAMainnetNode {
    return Intl.message(
      'Please add a mainnet node',
      name: 'pleaseAddAMainnetNode',
      desc: '',
      args: [],
    );
  }

  /// `Flash transaction are instant transactions.\n{transactionPriority} priority is set as a default fee.`
  String flashTransactionPriority(Object transactionPriority) {
    return Intl.message(
      'Flash transaction are instant transactions.\n$transactionPriority priority is set as a default fee.',
      name: 'flashTransactionPriority',
      desc: '',
      args: [transactionPriority],
    );
  }

  /// `Initiating Transaction..`
  String get initiatingTransactionTitle {
    return Intl.message(
      'Initiating Transaction..',
      name: 'initiatingTransactionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please don't close this window or navigate to another app until the transaction gets initiated`
  String get initiatingTransactionDescription {
    return Intl.message(
      'Please don\'t close this window or navigate to another app until the transaction gets initiated',
      name: 'initiatingTransactionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Sub Addresses`
  String get subAddresses {
    return Intl.message(
      'Sub Addresses',
      name: 'subAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Please don't close this window or navigate to another app until we load the wallet`
  String get loadingTheWalletDescription {
    return Intl.message(
      'Please don\'t close this window or navigate to another app until we load the wallet',
      name: 'loadingTheWalletDescription',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}