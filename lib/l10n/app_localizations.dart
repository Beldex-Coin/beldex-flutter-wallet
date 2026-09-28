import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to\nBeldex Wallet'**
  String get welcome;

  /// No description provided for @first_wallet_text.
  ///
  /// In en, this message translates to:
  /// **'Awesome wallet\nfor Beldex'**
  String get first_wallet_text;

  /// No description provided for @please_make_selection.
  ///
  /// In en, this message translates to:
  /// **'Select from the options below to\neither create or recover your wallet.'**
  String get please_make_selection;

  /// No description provided for @create_new.
  ///
  /// In en, this message translates to:
  /// **'Create New Wallet'**
  String get create_new;

  /// No description provided for @restore_wallet.
  ///
  /// In en, this message translates to:
  /// **'Use Existing Wallet'**
  String get restore_wallet;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @address_book.
  ///
  /// In en, this message translates to:
  /// **'Address Book'**
  String get address_book;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @please_select.
  ///
  /// In en, this message translates to:
  /// **'Please select:'**
  String get please_select;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @contact_name.
  ///
  /// In en, this message translates to:
  /// **'Contact Name'**
  String get contact_name;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @authenticated.
  ///
  /// In en, this message translates to:
  /// **'Authenticated'**
  String get authenticated;

  /// No description provided for @authentication.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get authentication;

  /// No description provided for @failed_authentication.
  ///
  /// In en, this message translates to:
  /// **'Failed authentication. {state_error}'**
  String failed_authentication(Object state_error);

  /// No description provided for @wallet_menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get wallet_menu;

  /// No description provided for @blocksRemaining.
  ///
  /// In en, this message translates to:
  /// **'{status} Blocks Remaining'**
  String blocksRemaining(Object status);

  /// No description provided for @please_try_to_connect_to_another_node.
  ///
  /// In en, this message translates to:
  /// **'Please try to connect to another node'**
  String get please_try_to_connect_to_another_node;

  /// No description provided for @beldex_hidden.
  ///
  /// In en, this message translates to:
  /// **'Beldex Hidden'**
  String get beldex_hidden;

  /// No description provided for @beldex_available_balance.
  ///
  /// In en, this message translates to:
  /// **'Beldex Available Balance'**
  String get beldex_available_balance;

  /// No description provided for @beldex_full_balance.
  ///
  /// In en, this message translates to:
  /// **'Beldex Full Balance'**
  String get beldex_full_balance;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @receive.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get receive;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @incoming.
  ///
  /// In en, this message translates to:
  /// **'Incoming'**
  String get incoming;

  /// No description provided for @outgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get outgoing;

  /// No description provided for @transactions_by_date.
  ///
  /// In en, this message translates to:
  /// **'Transactions by Date'**
  String get transactions_by_date;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **' (pending)'**
  String get pending;

  /// No description provided for @rescan.
  ///
  /// In en, this message translates to:
  /// **'Rescan'**
  String get rescan;

  /// No description provided for @reconnect.
  ///
  /// In en, this message translates to:
  /// **'Reconnect'**
  String get reconnect;

  /// No description provided for @wallets.
  ///
  /// In en, this message translates to:
  /// **'Wallets'**
  String get wallets;

  /// No description provided for @show_seed.
  ///
  /// In en, this message translates to:
  /// **'Show Seed'**
  String get show_seed;

  /// No description provided for @show_keys.
  ///
  /// In en, this message translates to:
  /// **'Show keys'**
  String get show_keys;

  /// No description provided for @reconnection.
  ///
  /// In en, this message translates to:
  /// **'Reconnection'**
  String get reconnection;

  /// No description provided for @reconnect_alert_text.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to reconnect?'**
  String get reconnect_alert_text;

  /// No description provided for @reload_fiat.
  ///
  /// In en, this message translates to:
  /// **'Reload Fiat data'**
  String get reload_fiat;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @copied_to_clipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard!'**
  String get copied_to_clipboard;

  /// No description provided for @fetching.
  ///
  /// In en, this message translates to:
  /// **'Fetching'**
  String get fetching;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID: '**
  String get id;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount '**
  String get amount;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status: '**
  String get status;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirm_sending.
  ///
  /// In en, this message translates to:
  /// **'Confirm sending'**
  String get confirm_sending;

  /// No description provided for @commit_transaction_amount_fee.
  ///
  /// In en, this message translates to:
  /// **'Commit transaction\nAmount: {amount}\nFee: {fee}'**
  String commit_transaction_amount_fee(Object amount, Object fee);

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get sending;

  /// No description provided for @transaction_sent.
  ///
  /// In en, this message translates to:
  /// **'Transaction sent!'**
  String get transaction_sent;

  /// No description provided for @send_beldex.
  ///
  /// In en, this message translates to:
  /// **'Send Beldex'**
  String get send_beldex;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @changelog.
  ///
  /// In en, this message translates to:
  /// **'Changelog'**
  String get changelog;

  /// No description provided for @loading_your_wallet.
  ///
  /// In en, this message translates to:
  /// **'Loading your wallet'**
  String get loading_your_wallet;

  /// No description provided for @new_wallet.
  ///
  /// In en, this message translates to:
  /// **'New Wallet'**
  String get new_wallet;

  /// No description provided for @wallet_name.
  ///
  /// In en, this message translates to:
  /// **'Wallet Name'**
  String get wallet_name;

  /// No description provided for @continue_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;

  /// No description provided for @node_new.
  ///
  /// In en, this message translates to:
  /// **'New Node'**
  String get node_new;

  /// No description provided for @node_address.
  ///
  /// In en, this message translates to:
  /// **'Node Address'**
  String get node_address;

  /// No description provided for @node_port.
  ///
  /// In en, this message translates to:
  /// **'Node Port'**
  String get node_port;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @nodes.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get nodes;

  /// No description provided for @node_reset_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Reset settings'**
  String get node_reset_settings_title;

  /// No description provided for @nodes_list_reset_to_default_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure that you want to reset settings to default?'**
  String get nodes_list_reset_to_default_message;

  /// No description provided for @change_current_node.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to change current node to {node}?'**
  String change_current_node(Object node);

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @remove_node.
  ///
  /// In en, this message translates to:
  /// **'Remove node'**
  String get remove_node;

  /// No description provided for @remove_node_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure that you want to remove selected node?'**
  String get remove_node_message;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @use.
  ///
  /// In en, this message translates to:
  /// **'Switch to '**
  String get use;

  /// No description provided for @digit_pin.
  ///
  /// In en, this message translates to:
  /// **'-digit PIN'**
  String get digit_pin;

  /// No description provided for @share_address.
  ///
  /// In en, this message translates to:
  /// **'Share address'**
  String get share_address;

  /// No description provided for @receive_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get receive_amount;

  /// No description provided for @subaddresses.
  ///
  /// In en, this message translates to:
  /// **'Subaddresses'**
  String get subaddresses;

  /// No description provided for @restore_restore_wallet.
  ///
  /// In en, this message translates to:
  /// **'Restore Wallet'**
  String get restore_restore_wallet;

  /// No description provided for @restore_title_from_seed_keys.
  ///
  /// In en, this message translates to:
  /// **'Restore from seed/keys'**
  String get restore_title_from_seed_keys;

  /// No description provided for @restore_description_from_seed_keys.
  ///
  /// In en, this message translates to:
  /// **'Get back your wallet from seed/keys that you\'ve saved to secure place'**
  String get restore_description_from_seed_keys;

  /// No description provided for @restore_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get restore_next;

  /// No description provided for @restore_title_from_backup.
  ///
  /// In en, this message translates to:
  /// **'Restore from a back-up file'**
  String get restore_title_from_backup;

  /// No description provided for @restore_description_from_backup.
  ///
  /// In en, this message translates to:
  /// **'You can restore the whole Beldex Wallet app from your back-up file'**
  String get restore_description_from_backup;

  /// No description provided for @restore_seed_keys_restore.
  ///
  /// In en, this message translates to:
  /// **'Seed/Keys Restore'**
  String get restore_seed_keys_restore;

  /// No description provided for @restore_title_from_seed.
  ///
  /// In en, this message translates to:
  /// **'Restore from Seed'**
  String get restore_title_from_seed;

  /// No description provided for @restore_description_from_seed.
  ///
  /// In en, this message translates to:
  /// **'Use the 25-word Mnemonic Key or Seed Phrase to Restore your Wallet.'**
  String get restore_description_from_seed;

  /// No description provided for @restore_title_from_keys.
  ///
  /// In en, this message translates to:
  /// **'Restore from Keys'**
  String get restore_title_from_keys;

  /// No description provided for @restore_description_from_keys.
  ///
  /// In en, this message translates to:
  /// **'Use the generated keystrokes saved from private keys to Restore your Wallet '**
  String get restore_description_from_keys;

  /// No description provided for @restore_wallet_name.
  ///
  /// In en, this message translates to:
  /// **'Wallet Name'**
  String get restore_wallet_name;

  /// No description provided for @restore_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get restore_address;

  /// No description provided for @restore_view_key_private.
  ///
  /// In en, this message translates to:
  /// **'View key (private)'**
  String get restore_view_key_private;

  /// No description provided for @restore_spend_key_private.
  ///
  /// In en, this message translates to:
  /// **'Spend key (private)'**
  String get restore_spend_key_private;

  /// No description provided for @restore_recover.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore_recover;

  /// No description provided for @restore_wallet_restore_description.
  ///
  /// In en, this message translates to:
  /// **'Wallet restore description'**
  String get restore_wallet_restore_description;

  /// No description provided for @seed_title.
  ///
  /// In en, this message translates to:
  /// **'Seed'**
  String get seed_title;

  /// No description provided for @seed_share.
  ///
  /// In en, this message translates to:
  /// **'Share seed'**
  String get seed_share;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @seed_language_choose.
  ///
  /// In en, this message translates to:
  /// **'Please choose a seed language'**
  String get seed_language_choose;

  /// No description provided for @seed_language_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get seed_language_next;

  /// No description provided for @seed_language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get seed_language_english;

  /// No description provided for @seed_language_chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get seed_language_chinese;

  /// No description provided for @seed_language_dutch.
  ///
  /// In en, this message translates to:
  /// **'Dutch'**
  String get seed_language_dutch;

  /// No description provided for @seed_language_german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get seed_language_german;

  /// No description provided for @seed_language_japanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get seed_language_japanese;

  /// No description provided for @seed_language_portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get seed_language_portuguese;

  /// No description provided for @seed_language_russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get seed_language_russian;

  /// No description provided for @seed_language_spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get seed_language_spanish;

  /// No description provided for @seed_language_french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get seed_language_french;

  /// No description provided for @seed_language_italian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get seed_language_italian;

  /// No description provided for @send_title.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send_title;

  /// No description provided for @send_your_wallet.
  ///
  /// In en, this message translates to:
  /// **'Your wallet'**
  String get send_your_wallet;

  /// No description provided for @send_beldex_address.
  ///
  /// In en, this message translates to:
  /// **'Beldex address or BNS name'**
  String get send_beldex_address;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'ALL'**
  String get all;

  /// No description provided for @send_error_currency.
  ///
  /// In en, this message translates to:
  /// **'Currency can only contain numbers'**
  String get send_error_currency;

  /// No description provided for @send_estimated_fee.
  ///
  /// In en, this message translates to:
  /// **'Estimated Fee:'**
  String get send_estimated_fee;

  /// No description provided for @send_priority.
  ///
  /// In en, this message translates to:
  /// **'{transactionPriority} priority is set as the default fee.\nGo to setting to change the transaction priority.'**
  String send_priority(Object transactionPriority);

  /// No description provided for @send_creating_transaction.
  ///
  /// In en, this message translates to:
  /// **'Creating transaction'**
  String get send_creating_transaction;

  /// No description provided for @title_stakes.
  ///
  /// In en, this message translates to:
  /// **'Stakes'**
  String get title_stakes;

  /// No description provided for @title_new_stake.
  ///
  /// In en, this message translates to:
  /// **'New Stake'**
  String get title_new_stake;

  /// No description provided for @your_contributions.
  ///
  /// In en, this message translates to:
  /// **'Your Contributions'**
  String get your_contributions;

  /// No description provided for @start_staking.
  ///
  /// In en, this message translates to:
  /// **'Start staking'**
  String get start_staking;

  /// No description provided for @stake_more.
  ///
  /// In en, this message translates to:
  /// **'Stake more'**
  String get stake_more;

  /// No description provided for @nothing_staked.
  ///
  /// In en, this message translates to:
  /// **'Nothing staked yet'**
  String get nothing_staked;

  /// No description provided for @service_node_key.
  ///
  /// In en, this message translates to:
  /// **'Master Node Key'**
  String get service_node_key;

  /// No description provided for @stake_beldex.
  ///
  /// In en, this message translates to:
  /// **'Stake Beldex'**
  String get stake_beldex;

  /// No description provided for @title_confirm_unlock_stake.
  ///
  /// In en, this message translates to:
  /// **'Unlock Stake'**
  String get title_confirm_unlock_stake;

  /// No description provided for @body_confirm_unlock_stake.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to unlock your stake from {masterNodeKey}?'**
  String body_confirm_unlock_stake(Object masterNodeKey);

  /// No description provided for @unlock_stake_requested.
  ///
  /// In en, this message translates to:
  /// **'Stake unlock requested'**
  String get unlock_stake_requested;

  /// No description provided for @unable_unlock_stake.
  ///
  /// In en, this message translates to:
  /// **'Unable to unlock stake'**
  String get unable_unlock_stake;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_nodes.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get settings_nodes;

  /// No description provided for @settings_current_node.
  ///
  /// In en, this message translates to:
  /// **'Current node'**
  String get settings_current_node;

  /// No description provided for @settings_wallets.
  ///
  /// In en, this message translates to:
  /// **'Wallets'**
  String get settings_wallets;

  /// No description provided for @settings_display_balance_as.
  ///
  /// In en, this message translates to:
  /// **'Display Balance As'**
  String get settings_display_balance_as;

  /// No description provided for @settings_balance_detail.
  ///
  /// In en, this message translates to:
  /// **'Decimals'**
  String get settings_balance_detail;

  /// No description provided for @settings_currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get settings_currency;

  /// No description provided for @settings_fee_priority.
  ///
  /// In en, this message translates to:
  /// **'Fee Priority'**
  String get settings_fee_priority;

  /// No description provided for @settings_save_recipient_address.
  ///
  /// In en, this message translates to:
  /// **'Save recipient address'**
  String get settings_save_recipient_address;

  /// No description provided for @settings_personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get settings_personal;

  /// No description provided for @settings_change_pin.
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get settings_change_pin;

  /// No description provided for @settings_change_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settings_change_language;

  /// No description provided for @settings_allow_biometric_authentication.
  ///
  /// In en, this message translates to:
  /// **'Allow biometric authentication'**
  String get settings_allow_biometric_authentication;

  /// No description provided for @settings_dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get settings_dark_mode;

  /// No description provided for @settings_display_on_dashboard_list.
  ///
  /// In en, this message translates to:
  /// **'Display on dashboard list'**
  String get settings_display_on_dashboard_list;

  /// No description provided for @settings_all.
  ///
  /// In en, this message translates to:
  /// **'ALL'**
  String get settings_all;

  /// No description provided for @settings_none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get settings_none;

  /// No description provided for @settings_support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settings_support;

  /// No description provided for @settings_terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get settings_terms_and_conditions;

  /// No description provided for @settings_enable_fiat_currency.
  ///
  /// In en, this message translates to:
  /// **'Enable Fiat Currency conversion'**
  String get settings_enable_fiat_currency;

  /// No description provided for @pin_is_incorrect.
  ///
  /// In en, this message translates to:
  /// **'PIN is incorrect'**
  String get pin_is_incorrect;

  /// No description provided for @amount_detail_ultra.
  ///
  /// In en, this message translates to:
  /// **'9 - Ultra'**
  String get amount_detail_ultra;

  /// No description provided for @amount_detail_none.
  ///
  /// In en, this message translates to:
  /// **'0 - None'**
  String get amount_detail_none;

  /// No description provided for @amount_detail_detailed.
  ///
  /// In en, this message translates to:
  /// **'4 - Detailed'**
  String get amount_detail_detailed;

  /// No description provided for @amount_detail_normal.
  ///
  /// In en, this message translates to:
  /// **'2 - Normal'**
  String get amount_detail_normal;

  /// No description provided for @setup_pin.
  ///
  /// In en, this message translates to:
  /// **'Setup PIN'**
  String get setup_pin;

  /// No description provided for @re_enter_your_pin.
  ///
  /// In en, this message translates to:
  /// **'Re-Enter your PIN'**
  String get re_enter_your_pin;

  /// No description provided for @setup_successful.
  ///
  /// In en, this message translates to:
  /// **'Your PIN has been set up \nsuccessfully!'**
  String get setup_successful;

  /// No description provided for @wallet_keys.
  ///
  /// In en, this message translates to:
  /// **'Wallet keys'**
  String get wallet_keys;

  /// No description provided for @view_key_private.
  ///
  /// In en, this message translates to:
  /// **'View key (private)'**
  String get view_key_private;

  /// No description provided for @view_key_public.
  ///
  /// In en, this message translates to:
  /// **'View key (public)'**
  String get view_key_public;

  /// No description provided for @spend_key_private.
  ///
  /// In en, this message translates to:
  /// **'Spend key (private)'**
  String get spend_key_private;

  /// No description provided for @spend_key_public.
  ///
  /// In en, this message translates to:
  /// **'Spend key (public)'**
  String get spend_key_public;

  /// No description provided for @copied_key_to_clipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied {key} to Clipboard'**
  String copied_key_to_clipboard(Object key);

  /// No description provided for @new_subaddress_title.
  ///
  /// In en, this message translates to:
  /// **'New subaddress'**
  String get new_subaddress_title;

  /// No description provided for @new_subaddress_label_name.
  ///
  /// In en, this message translates to:
  /// **'Label name'**
  String get new_subaddress_label_name;

  /// No description provided for @new_subaddress_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get new_subaddress_create;

  /// No description provided for @subaddress_title.
  ///
  /// In en, this message translates to:
  /// **'Subaddress list'**
  String get subaddress_title;

  /// No description provided for @transaction_details_title.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transaction_details_title;

  /// No description provided for @transaction_details_transaction_id.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transaction_details_transaction_id;

  /// No description provided for @transaction_details_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get transaction_details_date;

  /// No description provided for @transaction_details_height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get transaction_details_height;

  /// No description provided for @transaction_details_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get transaction_details_amount;

  /// No description provided for @transaction_details_payment_id.
  ///
  /// In en, this message translates to:
  /// **'Payment ID'**
  String get transaction_details_payment_id;

  /// No description provided for @transaction_details_copied.
  ///
  /// In en, this message translates to:
  /// **'{title} copied to Clipboard'**
  String transaction_details_copied(Object title);

  /// No description provided for @transaction_details_recipient_address.
  ///
  /// In en, this message translates to:
  /// **'Recipient Address'**
  String get transaction_details_recipient_address;

  /// No description provided for @swap_wallet_address.
  ///
  /// In en, this message translates to:
  /// **'Wallet Address'**
  String get swap_wallet_address;

  /// No description provided for @swap_recipient_address.
  ///
  /// In en, this message translates to:
  /// **'Recipient Address'**
  String get swap_recipient_address;

  /// No description provided for @swap_correct_chain_address.
  ///
  /// In en, this message translates to:
  /// **'Please make sure to enter the correct address for the selected chain - {blockchain}. Otherwise you will lose your funds.'**
  String swap_correct_chain_address(Object blockchain);

  /// No description provided for @swap_enter_recipient_address.
  ///
  /// In en, this message translates to:
  /// **'Enter your {currency} recipient address'**
  String swap_enter_recipient_address(Object currency);

  /// No description provided for @swap_refund_wallet_address.
  ///
  /// In en, this message translates to:
  /// **'Refund wallet Address'**
  String get swap_refund_wallet_address;

  /// No description provided for @swap_enter_refund_address.
  ///
  /// In en, this message translates to:
  /// **'Enter your {currency} refund address'**
  String swap_enter_refund_address(Object currency);

  /// No description provided for @swap_extra_id_info.
  ///
  /// In en, this message translates to:
  /// **'Please specify the {extraIdName} for your {currency} receiving address if your wallet provides it. Your transaction will not go through if you omit it. If your wallet doesn’t require a {extraIdName}, remove the tick.'**
  String swap_extra_id_info(Object currency, Object extraIdName);

  /// No description provided for @swap_my_wallet_requires_extra_id.
  ///
  /// In en, this message translates to:
  /// **'My wallet requires {extraIdName}'**
  String swap_my_wallet_requires_extra_id(Object extraIdName);

  /// No description provided for @swap_enter_extra_id.
  ///
  /// In en, this message translates to:
  /// **'Enter {extraIdName}'**
  String swap_enter_extra_id(Object extraIdName);

  /// No description provided for @swap_please_enter_extra_id.
  ///
  /// In en, this message translates to:
  /// **'Please enter {extraIdName}'**
  String swap_please_enter_extra_id(Object extraIdName);

  /// No description provided for @swap_minimum_amount_changed.
  ///
  /// In en, this message translates to:
  /// **'The minimum amount value has changed, The new value is '**
  String get swap_minimum_amount_changed;

  /// No description provided for @swap_maximum_amount_changed.
  ///
  /// In en, this message translates to:
  /// **'The maximum amount value has changed, The new value is '**
  String get swap_maximum_amount_changed;

  /// No description provided for @swap_transaction_preview.
  ///
  /// In en, this message translates to:
  /// **'Transaction Preview'**
  String get swap_transaction_preview;

  /// No description provided for @swap_exchange_rate.
  ///
  /// In en, this message translates to:
  /// **'Exchange rate'**
  String get swap_exchange_rate;

  /// No description provided for @swap_service_fee.
  ///
  /// In en, this message translates to:
  /// **'Service fee 0.25%'**
  String get swap_service_fee;

  /// No description provided for @service_fee.
  ///
  /// In en, this message translates to:
  /// **'Service Fee 0.25%'**
  String get service_fee;

  /// No description provided for @network_fee.
  ///
  /// In en, this message translates to:
  /// **'Network Fee'**
  String get network_fee;

  /// No description provided for @swap_refund_address.
  ///
  /// In en, this message translates to:
  /// **'Refund Address'**
  String get swap_refund_address;

  /// No description provided for @swap_network_fee.
  ///
  /// In en, this message translates to:
  /// **'Network fee'**
  String get swap_network_fee;

  /// No description provided for @swap_you_get.
  ///
  /// In en, this message translates to:
  /// **'You Get'**
  String get swap_you_get;

  /// No description provided for @swap_checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get swap_checkout;

  /// No description provided for @swap_network_label.
  ///
  /// In en, this message translates to:
  /// **'NETWORK: '**
  String get swap_network_label;

  /// No description provided for @swap_estimated_time.
  ///
  /// In en, this message translates to:
  /// **'Estimated Time'**
  String get swap_estimated_time;

  /// No description provided for @swap_estimated_time_value.
  ///
  /// In en, this message translates to:
  /// **'5-30 mins'**
  String get swap_estimated_time_value;

  /// No description provided for @swap_confirm_and_make_payment.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Make Payment'**
  String get swap_confirm_and_make_payment;

  /// No description provided for @swap_send_funds_to_address_below.
  ///
  /// In en, this message translates to:
  /// **'Send funds to the address below'**
  String get swap_send_funds_to_address_below;

  /// No description provided for @swap_time_left_to_send.
  ///
  /// In en, this message translates to:
  /// **'Time left to send {amount} {currency}'**
  String swap_time_left_to_send(Object amount, Object currency);

  /// No description provided for @swap_time_remaining.
  ///
  /// In en, this message translates to:
  /// **'Time Remaining : {value}'**
  String swap_time_remaining(Object value);

  /// No description provided for @swap_send_funds_notice.
  ///
  /// In en, this message translates to:
  /// **'You Have 3 Hours to send funds otherwise the transaction will be cancelled automatically.\n\nThe exchange will be initiated once the funds are received.'**
  String get swap_send_funds_notice;

  /// No description provided for @swap_confirmations.
  ///
  /// In en, this message translates to:
  /// **'Confirmations'**
  String get swap_confirmations;

  /// No description provided for @swap_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get swap_completed;

  /// No description provided for @swap_amount_from.
  ///
  /// In en, this message translates to:
  /// **'Amount from'**
  String get swap_amount_from;

  /// No description provided for @swap_amount_to.
  ///
  /// In en, this message translates to:
  /// **'Amount to'**
  String get swap_amount_to;

  /// No description provided for @swap_received_time.
  ///
  /// In en, this message translates to:
  /// **'Received Time'**
  String get swap_received_time;

  /// No description provided for @swap_amount_sent.
  ///
  /// In en, this message translates to:
  /// **'Amount Sent'**
  String get swap_amount_sent;

  /// No description provided for @swap_input_output_hash.
  ///
  /// In en, this message translates to:
  /// **'Input/Output Hash'**
  String get swap_input_output_hash;

  /// No description provided for @swap_input_hash.
  ///
  /// In en, this message translates to:
  /// **'Input Hash'**
  String get swap_input_hash;

  /// No description provided for @swap_output_hash.
  ///
  /// In en, this message translates to:
  /// **'Output Hash'**
  String get swap_output_hash;

  /// No description provided for @swap_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get swap_failed;

  /// No description provided for @swap_expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get swap_expired;

  /// No description provided for @swap_overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get swap_overdue;

  /// No description provided for @swap_funds_not_received.
  ///
  /// In en, this message translates to:
  /// **'The funds were not received within 3 hours. Please check the rates and create a new transaction'**
  String get swap_funds_not_received;

  /// No description provided for @swap_start_over.
  ///
  /// In en, this message translates to:
  /// **'Start Over'**
  String get swap_start_over;

  /// No description provided for @swap_exchanging.
  ///
  /// In en, this message translates to:
  /// **'Exchanging'**
  String get swap_exchanging;

  /// No description provided for @swap_confirming_in_progress.
  ///
  /// In en, this message translates to:
  /// **'Confirming in progress'**
  String get swap_confirming_in_progress;

  /// No description provided for @swap_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get swap_confirmed;

  /// No description provided for @swap_confirmed_in_blockchain.
  ///
  /// In en, this message translates to:
  /// **'Once {currencyFrom} is confirmed in the blockchain, we\'ll start exchanging it to {currencyTo}'**
  String swap_confirmed_in_blockchain(Object currencyFrom, Object currencyTo);

  /// No description provided for @swap_see_input_hash_in_explorer.
  ///
  /// In en, this message translates to:
  /// **'See input hash in explorer'**
  String get swap_see_input_hash_in_explorer;

  /// No description provided for @swap_done_exchanging.
  ///
  /// In en, this message translates to:
  /// **'Done Exchanging {currencyFrom} to {currencyTo}'**
  String swap_done_exchanging(Object currencyFrom, Object currencyTo);

  /// No description provided for @swap_exchanging_currency.
  ///
  /// In en, this message translates to:
  /// **'Exchanging {currencyFrom} to {currencyTo}'**
  String swap_exchanging_currency(Object currencyFrom, Object currencyTo);

  /// No description provided for @swap_process_wait.
  ///
  /// In en, this message translates to:
  /// **'The process will take a few minutes. please wait.'**
  String get swap_process_wait;

  /// No description provided for @swap_sending_funds_to_wallet.
  ///
  /// In en, this message translates to:
  /// **'Sending funds to your wallet'**
  String get swap_sending_funds_to_wallet;

  /// No description provided for @swap_funds_sent_to_wallet.
  ///
  /// In en, this message translates to:
  /// **'Funds send to your wallet'**
  String get swap_funds_sent_to_wallet;

  /// No description provided for @swap_you_dont_have_to_wait_here.
  ///
  /// In en, this message translates to:
  /// **'You don’t have to wait here'**
  String get swap_you_dont_have_to_wait_here;

  /// No description provided for @swap_you_can_initiate_new_transaction.
  ///
  /// In en, this message translates to:
  /// **'You can initiate a new transaction. You can always check the status of this transaction in transaction '**
  String get swap_you_can_initiate_new_transaction;

  /// No description provided for @swap_history.
  ///
  /// In en, this message translates to:
  /// **'history'**
  String get swap_history;

  /// No description provided for @swap_you_sent.
  ///
  /// In en, this message translates to:
  /// **'You sent'**
  String get swap_you_sent;

  /// No description provided for @swap_exchange_address.
  ///
  /// In en, this message translates to:
  /// **'{exchangeName} address ({currency})'**
  String swap_exchange_address(Object currency, Object exchangeName);

  /// No description provided for @swap_recipient_address_with_currency.
  ///
  /// In en, this message translates to:
  /// **'Recipient address ({currency})'**
  String swap_recipient_address_with_currency(Object currency);

  /// No description provided for @swap_open_history.
  ///
  /// In en, this message translates to:
  /// **'Open History'**
  String get swap_open_history;

  /// No description provided for @swap_new_transaction.
  ///
  /// In en, this message translates to:
  /// **'New Transaction'**
  String get swap_new_transaction;

  /// No description provided for @swap_i_agree_with.
  ///
  /// In en, this message translates to:
  /// **'I agree with '**
  String get swap_i_agree_with;

  /// No description provided for @swap_terms_of_use.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get swap_terms_of_use;

  /// No description provided for @swap_and.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get swap_and;

  /// No description provided for @swap_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get swap_privacy_policy;

  /// No description provided for @swap_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get swap_next;

  /// No description provided for @wallet_list_title.
  ///
  /// In en, this message translates to:
  /// **'Beldex Wallet'**
  String get wallet_list_title;

  /// No description provided for @wallet_list_create_new_wallet.
  ///
  /// In en, this message translates to:
  /// **'Create New Wallet'**
  String get wallet_list_create_new_wallet;

  /// No description provided for @wallet_list_restore_wallet.
  ///
  /// In en, this message translates to:
  /// **'Use Existing Wallet'**
  String get wallet_list_restore_wallet;

  /// No description provided for @wallet_list_load_wallet.
  ///
  /// In en, this message translates to:
  /// **'Load wallet'**
  String get wallet_list_load_wallet;

  /// No description provided for @wallet_list_loading_wallet.
  ///
  /// In en, this message translates to:
  /// **'Loading {wallet_name} wallet'**
  String wallet_list_loading_wallet(Object wallet_name);

  /// No description provided for @wallet_list_failed_to_load.
  ///
  /// In en, this message translates to:
  /// **'Failed to load {wallet_name} wallet. {error}'**
  String wallet_list_failed_to_load(Object error, Object wallet_name);

  /// No description provided for @wallet_list_removing_wallet.
  ///
  /// In en, this message translates to:
  /// **'Removing {wallet_name} wallet'**
  String wallet_list_removing_wallet(Object wallet_name);

  /// No description provided for @wallet_list_failed_to_remove.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove {wallet_name} wallet. {error}'**
  String wallet_list_failed_to_remove(Object error, Object wallet_name);

  /// No description provided for @widgets_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get widgets_address;

  /// No description provided for @widgets_restore_from_blockheight.
  ///
  /// In en, this message translates to:
  /// **'Restore from Blockheight'**
  String get widgets_restore_from_blockheight;

  /// No description provided for @widgets_restore_from_date.
  ///
  /// In en, this message translates to:
  /// **'Restore from Date'**
  String get widgets_restore_from_date;

  /// No description provided for @widgets_or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get widgets_or;

  /// No description provided for @widgets_seed.
  ///
  /// In en, this message translates to:
  /// **'Seed'**
  String get widgets_seed;

  /// No description provided for @router_no_route.
  ///
  /// In en, this message translates to:
  /// **'No route defined for {name}'**
  String router_no_route(Object name);

  /// No description provided for @error_text_account_name.
  ///
  /// In en, this message translates to:
  /// **'Account name can only contain letters, numbers\nand must be between 1 and 15 characters long'**
  String get error_text_account_name;

  /// No description provided for @error_text_contact_name.
  ///
  /// In en, this message translates to:
  /// **'Contact name can\'t contain ` , \' \" symbols\nand must be between 1 and 32 characters long'**
  String get error_text_contact_name;

  /// No description provided for @error_text_address.
  ///
  /// In en, this message translates to:
  /// **'Invalid BDX address'**
  String get error_text_address;

  /// No description provided for @error_text_node_address.
  ///
  /// In en, this message translates to:
  /// **'Please enter a iPv4 address'**
  String get error_text_node_address;

  /// No description provided for @error_text_node_port.
  ///
  /// In en, this message translates to:
  /// **'Node port can only contain numbers between 0 and 65535'**
  String get error_text_node_port;

  /// No description provided for @error_text_payment_id.
  ///
  /// In en, this message translates to:
  /// **'Payment ID can only contain from 16 to 64 chars in hex'**
  String get error_text_payment_id;

  /// No description provided for @error_text_beldex.
  ///
  /// In en, this message translates to:
  /// **'Beldex value can\'t exceed available balance.\nThe number of fraction digits must be less or equal to 9'**
  String get error_text_beldex;

  /// No description provided for @error_text_fiat.
  ///
  /// In en, this message translates to:
  /// **'Value of amount can\'t exceed available balance.\nThe number of fraction digits must be less or equal to 2'**
  String get error_text_fiat;

  /// No description provided for @error_text_subaddress_name.
  ///
  /// In en, this message translates to:
  /// **'Subaddress name can\'t contain ` , \' \" symbols\nand must be between 1 and 20 characters long'**
  String get error_text_subaddress_name;

  /// No description provided for @error_text_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount can only contain numbers'**
  String get error_text_amount;

  /// No description provided for @error_text_wallet_name.
  ///
  /// In en, this message translates to:
  /// **'Wallet name can only contain letters, numbers\nand must be between 1 and 15 characters long'**
  String get error_text_wallet_name;

  /// No description provided for @error_text_keys.
  ///
  /// In en, this message translates to:
  /// **'Wallet keys can only contain 64 chars in hex'**
  String get error_text_keys;

  /// No description provided for @error_text_crypto_currency.
  ///
  /// In en, this message translates to:
  /// **'The number of fraction digits\nmust be less or equal to 12'**
  String get error_text_crypto_currency;

  /// No description provided for @error_text_service_node.
  ///
  /// In en, this message translates to:
  /// **'A Master Node key can only contain 64 chars in hex'**
  String get error_text_service_node;

  /// No description provided for @auth_store_ban_timeout.
  ///
  /// In en, this message translates to:
  /// **'ban_timeout'**
  String get auth_store_ban_timeout;

  /// No description provided for @auth_store_banned_for.
  ///
  /// In en, this message translates to:
  /// **'Banned for '**
  String get auth_store_banned_for;

  /// No description provided for @auth_store_banned_minutes.
  ///
  /// In en, this message translates to:
  /// **' minutes'**
  String get auth_store_banned_minutes;

  /// No description provided for @auth_store_incorrect_password.
  ///
  /// In en, this message translates to:
  /// **'Wrong PIN'**
  String get auth_store_incorrect_password;

  /// No description provided for @wallet_restoration_store_incorrect_seed_length.
  ///
  /// In en, this message translates to:
  /// **'Incorrect seed length'**
  String get wallet_restoration_store_incorrect_seed_length;

  /// No description provided for @full_balance.
  ///
  /// In en, this message translates to:
  /// **'Full Balance'**
  String get full_balance;

  /// No description provided for @available_balance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get available_balance;

  /// No description provided for @hidden_balance.
  ///
  /// In en, this message translates to:
  /// **'Hidden Balance'**
  String get hidden_balance;

  /// No description provided for @sync_status_synchronizing.
  ///
  /// In en, this message translates to:
  /// **'SYNCHRONIZING'**
  String get sync_status_synchronizing;

  /// No description provided for @sync_status_synchronized.
  ///
  /// In en, this message translates to:
  /// **'SYNCHRONIZED'**
  String get sync_status_synchronized;

  /// No description provided for @sync_status_not_connected.
  ///
  /// In en, this message translates to:
  /// **'NOT CONNECTED'**
  String get sync_status_not_connected;

  /// No description provided for @sync_status_starting_sync.
  ///
  /// In en, this message translates to:
  /// **'STARTING SYNC'**
  String get sync_status_starting_sync;

  /// No description provided for @sync_status_failed_connect.
  ///
  /// In en, this message translates to:
  /// **'FAILED CONNECT TO THE NODE'**
  String get sync_status_failed_connect;

  /// No description provided for @sync_status_connecting.
  ///
  /// In en, this message translates to:
  /// **'CONNECTING'**
  String get sync_status_connecting;

  /// No description provided for @sync_status_connected.
  ///
  /// In en, this message translates to:
  /// **'CONNECTED'**
  String get sync_status_connected;

  /// No description provided for @transaction_priority_slow.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get transaction_priority_slow;

  /// No description provided for @transaction_priority_blink.
  ///
  /// In en, this message translates to:
  /// **'Flash'**
  String get transaction_priority_blink;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language;

  /// No description provided for @change_language_to.
  ///
  /// In en, this message translates to:
  /// **'Change language to {language}?'**
  String change_language_to(Object language);

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @restore_from_seed_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Please enter or paste your seed here'**
  String get restore_from_seed_placeholder;

  /// No description provided for @add_new_word.
  ///
  /// In en, this message translates to:
  /// **'Add new word'**
  String get add_new_word;

  /// No description provided for @incorrect_seed.
  ///
  /// In en, this message translates to:
  /// **'The text entered is not valid.'**
  String get incorrect_seed;

  /// No description provided for @biometric_auth_reason.
  ///
  /// In en, this message translates to:
  /// **'Scan your fingerprint to authenticate'**
  String get biometric_auth_reason;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {currentVersion}'**
  String version(Object currentVersion);

  /// No description provided for @openalias_alert_title.
  ///
  /// In en, this message translates to:
  /// **'Beldex Recipient Detected'**
  String get openalias_alert_title;

  /// No description provided for @openalias_alert_content.
  ///
  /// In en, this message translates to:
  /// **'You will be sending funds to\n{recipient_name}'**
  String openalias_alert_content(Object recipient_name);

  /// No description provided for @dangerzone.
  ///
  /// In en, this message translates to:
  /// **'Dangerzone'**
  String get dangerzone;

  /// No description provided for @yes_im_sure.
  ///
  /// In en, this message translates to:
  /// **'Yes, I\'m sure!'**
  String get yes_im_sure;

  /// No description provided for @never_give_your.
  ///
  /// In en, this message translates to:
  /// **'Never Give your Beldex Wallet {item} to Anyone!'**
  String never_give_your(Object item);

  /// No description provided for @dangerzone_warning.
  ///
  /// In en, this message translates to:
  /// **'NEVER input your Beldex wallet {item} into any software or website other than the OFFICIAL Beldex wallets downloaded directly from the {app_store}, the Beldex website, or the Beldex GitHub.\nAre you sure you want to access your wallet {item}?'**
  String dangerzone_warning(Object app_store, Object item);

  /// No description provided for @keys_title.
  ///
  /// In en, this message translates to:
  /// **'Keys'**
  String get keys_title;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get are_you_sure;

  /// No description provided for @do_you_want_to_exit_an_app.
  ///
  /// In en, this message translates to:
  /// **'Do you want to exit an App'**
  String get do_you_want_to_exit_an_app;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @byUsingThisAppYouAgreeToTheTermsOf.
  ///
  /// In en, this message translates to:
  /// **'By using this app, you agree to the Terms of Agreement set forth to below'**
  String get byUsingThisAppYouAgreeToTheTermsOf;

  /// No description provided for @iAgreeToTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'I agree to Terms of Use'**
  String get iAgreeToTermsOfUse;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @pleaseEnterAValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get pleaseEnterAValidAmount;

  /// No description provided for @pleaseEnterAValidSeed.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid seed'**
  String get pleaseEnterAValidSeed;

  /// No description provided for @changeWallet.
  ///
  /// In en, this message translates to:
  /// **'Change Wallet'**
  String get changeWallet;

  /// No description provided for @removeWallet.
  ///
  /// In en, this message translates to:
  /// **'Remove Wallet'**
  String get removeWallet;

  /// No description provided for @reconnectWallet.
  ///
  /// In en, this message translates to:
  /// **'Reconnect Wallet'**
  String get reconnectWallet;

  /// No description provided for @rescanWallet.
  ///
  /// In en, this message translates to:
  /// **'Rescan Wallet'**
  String get rescanWallet;

  /// No description provided for @enterWalletName.
  ///
  /// In en, this message translates to:
  /// **'Enter Wallet Name'**
  String get enterWalletName;

  /// No description provided for @noTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No Transactions Yet!'**
  String get noTransactionsYet;

  /// No description provided for @afterYourFirstTransactionnYouWillBeAbleToView.
  ///
  /// In en, this message translates to:
  /// **'After your first transaction,\n you will be able to view it here.'**
  String get afterYourFirstTransactionnYouWillBeAbleToView;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addAddress;

  /// No description provided for @important.
  ///
  /// In en, this message translates to:
  /// **'IMPORTANT'**
  String get important;

  /// No description provided for @neverInputYourBeldexWalletItemIntoAnySoftwareOr.
  ///
  /// In en, this message translates to:
  /// **'Never input your Beldex wallet {item} into any software or website other than the official Beldex wallets downloaded directly from the {appStore},the beldex website, or the beldex GitHub.'**
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item);

  /// No description provided for @enterWalletName_.
  ///
  /// In en, this message translates to:
  /// **'Enter wallet name'**
  String get enterWalletName_;

  /// No description provided for @chooseSeedLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Seed Language'**
  String get chooseSeedLanguage;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @seedKeys.
  ///
  /// In en, this message translates to:
  /// **'Seed & Keys'**
  String get seedKeys;

  /// No description provided for @walletAddress.
  ///
  /// In en, this message translates to:
  /// **'Wallet Address'**
  String get walletAddress;

  /// No description provided for @recoverySeedkey.
  ///
  /// In en, this message translates to:
  /// **'Recovery Seed/Key'**
  String get recoverySeedkey;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @welcomeToBeldexWallet.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Beldex Wallet :)'**
  String get welcomeToBeldexWallet;

  /// No description provided for @selectAnOptionBelowToCreateOrnRecoverExistingWallet.
  ///
  /// In en, this message translates to:
  /// **'Select an option below to create or\n recover existing wallet'**
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet;

  /// No description provided for @enterAValidNameUpto15Characters.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid name upto 15 characters'**
  String get enterAValidNameUpto15Characters;

  /// No description provided for @enterAValidNameUpto20Characters.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid name upto 20 characters'**
  String get enterAValidNameUpto20Characters;

  /// No description provided for @fiveDecimals.
  ///
  /// In en, this message translates to:
  /// **'5 - Five (0.00000)'**
  String get fiveDecimals;

  /// No description provided for @fourDecimals.
  ///
  /// In en, this message translates to:
  /// **'4 - Four (0.0000)'**
  String get fourDecimals;

  /// No description provided for @twoDecimals.
  ///
  /// In en, this message translates to:
  /// **'2 - Two (0.00)'**
  String get twoDecimals;

  /// No description provided for @zeroDecimal.
  ///
  /// In en, this message translates to:
  /// **'0 - Zero (000)'**
  String get zeroDecimal;

  /// No description provided for @doYouWantToExitTheWallet.
  ///
  /// In en, this message translates to:
  /// **'Do you want to exit the wallet?'**
  String get doYouWantToExitTheWallet;

  /// No description provided for @makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate.
  ///
  /// In en, this message translates to:
  /// **'Make sure to take backup of your\nrecovery Seed, wallet address\nand private keys'**
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate;

  /// No description provided for @blockRemaining.
  ///
  /// In en, this message translates to:
  /// **'{status} Block Remaining'**
  String blockRemaining(Object status);

  /// No description provided for @flashTransaction.
  ///
  /// In en, this message translates to:
  /// **'Flash Transaction'**
  String get flashTransaction;

  /// No description provided for @transferYourBdxMoreFasternWithFlashTransaction.
  ///
  /// In en, this message translates to:
  /// **'Transfer your BDX more faster with\n Flash Transaction!'**
  String get transferYourBdxMoreFasternWithFlashTransaction;

  /// No description provided for @enterYourPin.
  ///
  /// In en, this message translates to:
  /// **'Enter Your PIN'**
  String get enterYourPin;

  /// No description provided for @walletSettings.
  ///
  /// In en, this message translates to:
  /// **'Wallet Settings'**
  String get walletSettings;

  /// No description provided for @recoverySeed.
  ///
  /// In en, this message translates to:
  /// **'Recovery Seed'**
  String get recoverySeed;

  /// No description provided for @youDontHaveEnoughUnlockedBalance.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have enough unlocked balance'**
  String get youDontHaveEnoughUnlockedBalance;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get alert;

  /// No description provided for @touchTheFingerprintSensor.
  ///
  /// In en, this message translates to:
  /// **'Touch the Fingerprint sensor'**
  String get touchTheFingerprintSensor;

  /// No description provided for @usePattern.
  ///
  /// In en, this message translates to:
  /// **'USE PATTERN'**
  String get usePattern;

  /// No description provided for @enterBdxToSend.
  ///
  /// In en, this message translates to:
  /// **'Enter BDX to send'**
  String get enterBdxToSend;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get enterAmount;

  /// No description provided for @pleaseEnterAAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a amount'**
  String get pleaseEnterAAmount;

  /// No description provided for @committingTheTransaction.
  ///
  /// In en, this message translates to:
  /// **'Committing the Transaction'**
  String get committingTheTransaction;

  /// No description provided for @availableBdx.
  ///
  /// In en, this message translates to:
  /// **'Available BDX : '**
  String get availableBdx;

  /// No description provided for @pleaseEnterABdxAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter a bdx address'**
  String get pleaseEnterABdxAddress;

  /// No description provided for @enterAValidAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid address'**
  String get enterAValidAddress;

  /// No description provided for @biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside.
  ///
  /// In en, this message translates to:
  /// **'Biometric feature currenly disabled.Kindly enable allow biometric authentication feature inside the app settings'**
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside;

  /// No description provided for @unlockBeldexWallet.
  ///
  /// In en, this message translates to:
  /// **'Unlock Beldex Wallet'**
  String get unlockBeldexWallet;

  /// No description provided for @confirmYourScreenLockPinpatternAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your screen lock PIN,Pattern and password'**
  String get confirmYourScreenLockPinpatternAndPassword;

  /// No description provided for @doYouWantToChangeYournPrimaryAccount.
  ///
  /// In en, this message translates to:
  /// **'Do you want to change your\n primary account?'**
  String get doYouWantToChangeYournPrimaryAccount;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @addAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get addAccount;

  /// No description provided for @noAddressesInBook.
  ///
  /// In en, this message translates to:
  /// **'No addresses in book'**
  String get noAddressesInBook;

  /// No description provided for @bdx.
  ///
  /// In en, this message translates to:
  /// **'BDX'**
  String get bdx;

  /// No description provided for @howeverWeRecommendToScanTheBlockchainFromTheBlock.
  ///
  /// In en, this message translates to:
  /// **'However we recommend to scan the blockchain from the block height at which you created the wallet to get all transactions and correct balance'**
  String get howeverWeRecommendToScanTheBlockchainFromTheBlock;

  /// No description provided for @youHaveScannedFromTheBlockHeight.
  ///
  /// In en, this message translates to:
  /// **'You have scanned from the block height'**
  String get youHaveScannedFromTheBlockHeight;

  /// No description provided for @syncInfo.
  ///
  /// In en, this message translates to:
  /// **'Sync info'**
  String get syncInfo;

  /// No description provided for @doYouWantToReconnectnTheWallet.
  ///
  /// In en, this message translates to:
  /// **'Do you want to reconnect\n the wallet?'**
  String get doYouWantToReconnectnTheWallet;

  /// No description provided for @enterValidNameUpto15Characters.
  ///
  /// In en, this message translates to:
  /// **'Enter valid name upto 15 characters'**
  String get enterValidNameUpto15Characters;

  /// No description provided for @checkingNodeConnection.
  ///
  /// In en, this message translates to:
  /// **'Checking node connection...'**
  String get checkingNodeConnection;

  /// No description provided for @enterBdxToReceive.
  ///
  /// In en, this message translates to:
  /// **'Enter BDX to Receive'**
  String get enterBdxToReceive;

  /// No description provided for @addSubAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Sub Address'**
  String get addSubAddress;

  /// No description provided for @shareQr.
  ///
  /// In en, this message translates to:
  /// **'Share QR'**
  String get shareQr;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enterValidHeightWithoutSpace.
  ///
  /// In en, this message translates to:
  /// **'Enter valid height without space'**
  String get enterValidHeightWithoutSpace;

  /// No description provided for @dateShouldNotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Date should not be empty'**
  String get dateShouldNotBeEmpty;

  /// No description provided for @walletRestore.
  ///
  /// In en, this message translates to:
  /// **'Wallet Restore'**
  String get walletRestore;

  /// No description provided for @youCantViewTheSeedBecauseYouveRestoredUsingKeys.
  ///
  /// In en, this message translates to:
  /// **'You can\'t view the seed because you\'ve restored using keys'**
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys;

  /// No description provided for @neverShareYourSeedToAnyoneCheckYourSurroundingsTo.
  ///
  /// In en, this message translates to:
  /// **'Never share your seed to anyone! Check your surroundings to ensure no one is overlooking'**
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note :'**
  String get note;

  /// No description provided for @copySeed.
  ///
  /// In en, this message translates to:
  /// **'Copy Seed'**
  String get copySeed;

  /// No description provided for @accountAlreadyExist.
  ///
  /// In en, this message translates to:
  /// **'Account already exist'**
  String get accountAlreadyExist;

  /// No description provided for @transactionInitiatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Transaction initiated successfully'**
  String get transactionInitiatedSuccessfully;

  /// No description provided for @enterAValidSubAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid sub address'**
  String get enterAValidSubAddress;

  /// No description provided for @subaddressAlreadyExist.
  ///
  /// In en, this message translates to:
  /// **'Subaddress already exist'**
  String get subaddressAlreadyExist;

  /// No description provided for @labelName.
  ///
  /// In en, this message translates to:
  /// **'Label name'**
  String get labelName;

  /// No description provided for @subAddress.
  ///
  /// In en, this message translates to:
  /// **'Sub Address'**
  String get subAddress;

  /// No description provided for @loadingTheWallet.
  ///
  /// In en, this message translates to:
  /// **'Loading the wallet...'**
  String get loadingTheWallet;

  /// No description provided for @youAreAboutToDeletenYourWallet.
  ///
  /// In en, this message translates to:
  /// **'You are about to delete\n your wallet!'**
  String get youAreAboutToDeletenYourWallet;

  /// No description provided for @creatingTheTransaction.
  ///
  /// In en, this message translates to:
  /// **'Creating the Transaction'**
  String get creatingTheTransaction;

  /// No description provided for @copyAndSaveTheSeedToContinue.
  ///
  /// In en, this message translates to:
  /// **'Copy and save the seed to continue'**
  String get copyAndSaveTheSeedToContinue;

  /// No description provided for @enterPin.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN'**
  String get enterPin;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @connectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection Failed'**
  String get connectionFailed;

  /// No description provided for @checking.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get checking;

  /// No description provided for @testResult.
  ///
  /// In en, this message translates to:
  /// **'Test Result:'**
  String get testResult;

  /// No description provided for @passwordOptional.
  ///
  /// In en, this message translates to:
  /// **'Password (optional)'**
  String get passwordOptional;

  /// No description provided for @userNameOptional.
  ///
  /// In en, this message translates to:
  /// **'User Name (optional)'**
  String get userNameOptional;

  /// No description provided for @nodeNameOptional.
  ///
  /// In en, this message translates to:
  /// **'Node Name (optional)'**
  String get nodeNameOptional;

  /// No description provided for @addNode.
  ///
  /// In en, this message translates to:
  /// **'Add Node'**
  String get addNode;

  /// No description provided for @legalDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Legal Disclaimer'**
  String get legalDisclaimer;

  /// No description provided for @howCanWenhelpYou.
  ///
  /// In en, this message translates to:
  /// **'How can we\nhelp you?'**
  String get howCanWenhelpYou;

  /// No description provided for @removeContact.
  ///
  /// In en, this message translates to:
  /// **'Remove Contact'**
  String get removeContact;

  /// No description provided for @areYouSureYouWantToRemoveSelectedContact.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove selected contact?'**
  String get areYouSureYouWantToRemoveSelectedContact;

  /// No description provided for @theAddressAlreadyExist.
  ///
  /// In en, this message translates to:
  /// **'The Address already Exist'**
  String get theAddressAlreadyExist;

  /// No description provided for @thisNameAlreadyExist.
  ///
  /// In en, this message translates to:
  /// **'This Name already Exist'**
  String get thisNameAlreadyExist;

  /// No description provided for @enterAValidName.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid name'**
  String get enterAValidName;

  /// No description provided for @addressShouldNotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Address should not be empty'**
  String get addressShouldNotBeEmpty;

  /// No description provided for @nameShouldNotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name should not be empty'**
  String get nameShouldNotBeEmpty;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter Name'**
  String get enterName;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountName;

  /// No description provided for @playStore.
  ///
  /// In en, this message translates to:
  /// **'Play Store'**
  String get playStore;

  /// No description provided for @appstore.
  ///
  /// In en, this message translates to:
  /// **'AppStore'**
  String get appstore;

  /// No description provided for @allowFaceIdAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Allow face id authentication'**
  String get allowFaceIdAuthentication;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter Address'**
  String get enterAddress;

  /// No description provided for @pleaseAddAMainnetNode.
  ///
  /// In en, this message translates to:
  /// **'Please add a mainnet node'**
  String get pleaseAddAMainnetNode;

  /// No description provided for @flashTransactionPriority.
  ///
  /// In en, this message translates to:
  /// **'Flash transaction are instant transactions.\n{transactionPriority} priority is set as a default fee.'**
  String flashTransactionPriority(Object transactionPriority);

  /// No description provided for @initiatingTransactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Initiating Transaction..'**
  String get initiatingTransactionTitle;

  /// No description provided for @initiatingTransactionDescription.
  ///
  /// In en, this message translates to:
  /// **'Please don\'t close this window or navigate to another app until the transaction gets initiated'**
  String get initiatingTransactionDescription;

  /// No description provided for @subAddresses.
  ///
  /// In en, this message translates to:
  /// **'Sub Addresses'**
  String get subAddresses;

  /// No description provided for @loadingTheWalletDescription.
  ///
  /// In en, this message translates to:
  /// **'Please don\'t close this window or navigate to another app until we load the wallet'**
  String get loadingTheWalletDescription;

  /// No description provided for @buyBns.
  ///
  /// In en, this message translates to:
  /// **'Buy BNS'**
  String get buyBns;

  /// No description provided for @myBns.
  ///
  /// In en, this message translates to:
  /// **'My BNS'**
  String get myBns;

  /// No description provided for @addBns.
  ///
  /// In en, this message translates to:
  /// **'Add BNS'**
  String get addBns;

  /// No description provided for @bns.
  ///
  /// In en, this message translates to:
  /// **'BNS'**
  String get bns;

  /// No description provided for @bnsPurchaseDescription.
  ///
  /// In en, this message translates to:
  /// **'Purchase or update an BNS record. If you purchase a name, it may take a minute or two for it to show up in the list'**
  String get bnsPurchaseDescription;

  /// No description provided for @bnsPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get bnsPrice;

  /// No description provided for @bnsYearOneShort.
  ///
  /// In en, this message translates to:
  /// **'1 Yr'**
  String get bnsYearOneShort;

  /// No description provided for @bnsYearTwoShort.
  ///
  /// In en, this message translates to:
  /// **'2 Yrs'**
  String get bnsYearTwoShort;

  /// No description provided for @bnsYearFiveShort.
  ///
  /// In en, this message translates to:
  /// **'5 Yrs'**
  String get bnsYearFiveShort;

  /// No description provided for @bnsYearTenShort.
  ///
  /// In en, this message translates to:
  /// **'10 Yrs'**
  String get bnsYearTenShort;

  /// No description provided for @bnsYearOne.
  ///
  /// In en, this message translates to:
  /// **'1 Year'**
  String get bnsYearOne;

  /// No description provided for @bnsYearTwo.
  ///
  /// In en, this message translates to:
  /// **'2 Years'**
  String get bnsYearTwo;

  /// No description provided for @bnsYearFive.
  ///
  /// In en, this message translates to:
  /// **'5 Years'**
  String get bnsYearFive;

  /// No description provided for @bnsYearTen.
  ///
  /// In en, this message translates to:
  /// **'10 Years'**
  String get bnsYearTen;

  /// No description provided for @bnsYouSave.
  ///
  /// In en, this message translates to:
  /// **'You Save '**
  String get bnsYouSave;

  /// No description provided for @bnsNameHint.
  ///
  /// In en, this message translates to:
  /// **'The name to purchase via Beldex Name Service'**
  String get bnsNameHint;

  /// No description provided for @bnsOwnerOptional.
  ///
  /// In en, this message translates to:
  /// **'Owner (optional)'**
  String get bnsOwnerOptional;

  /// No description provided for @bnsOwnerHint.
  ///
  /// In en, this message translates to:
  /// **'The wallet address of the owner'**
  String get bnsOwnerHint;

  /// No description provided for @bnsWalletAddress.
  ///
  /// In en, this message translates to:
  /// **'Wallet Address'**
  String get bnsWalletAddress;

  /// No description provided for @bnsBchatId.
  ///
  /// In en, this message translates to:
  /// **'BChat ID'**
  String get bnsBchatId;

  /// No description provided for @bnsBelnetId.
  ///
  /// In en, this message translates to:
  /// **'Belnet ID'**
  String get bnsBelnetId;

  /// No description provided for @bnsEthAddress.
  ///
  /// In en, this message translates to:
  /// **'ETH Address'**
  String get bnsEthAddress;

  /// No description provided for @bnsUpdateOwner.
  ///
  /// In en, this message translates to:
  /// **'Update Owner'**
  String get bnsUpdateOwner;

  /// No description provided for @bnsUpdateValues.
  ///
  /// In en, this message translates to:
  /// **'Update Values'**
  String get bnsUpdateValues;

  /// No description provided for @bnsNewOwnerHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the wallet address of new owner'**
  String get bnsNewOwnerHint;

  /// No description provided for @bnsUpdateNote.
  ///
  /// In en, this message translates to:
  /// **'You can only update owner address or values at a time. If you want to update both, you can either update the value before ownership or after transferring ownership.'**
  String get bnsUpdateNote;

  /// No description provided for @bnsAddRecord.
  ///
  /// In en, this message translates to:
  /// **'Add Record'**
  String get bnsAddRecord;

  /// No description provided for @bnsRecordsDescription.
  ///
  /// In en, this message translates to:
  /// **'Here you can find all the BNS Names owned by this wallet. Decrypting a record you own will return the name and value at the BNS record.'**
  String get bnsRecordsDescription;

  /// No description provided for @bnsRecordNameHint.
  ///
  /// In en, this message translates to:
  /// **'A BNS name that belongs to you'**
  String get bnsRecordNameHint;

  /// No description provided for @bnsFetchingRecords.
  ///
  /// In en, this message translates to:
  /// **'Fetching BNS records from the network...'**
  String get bnsFetchingRecords;

  /// No description provided for @bnsDecryptionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully decrypted BNS Record for {bnsName}'**
  String bnsDecryptionSuccess(Object bnsName);

  /// No description provided for @bnsDecryptionFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to decrypt BNS Record for {bnsName}'**
  String bnsDecryptionFailure(Object bnsName);

  /// No description provided for @bnsRecordNotFound.
  ///
  /// In en, this message translates to:
  /// **'The given BNS record doesn\'t exist or does not belong to this wallet.'**
  String get bnsRecordNotFound;

  /// No description provided for @bnsWaitForFetch.
  ///
  /// In en, this message translates to:
  /// **'Please wait until we fetch the BNS record from Network'**
  String get bnsWaitForFetch;

  /// No description provided for @bnsRecords.
  ///
  /// In en, this message translates to:
  /// **'BNS Records'**
  String get bnsRecords;

  /// No description provided for @bnsExpirationHeight.
  ///
  /// In en, this message translates to:
  /// **'Expiration Height : '**
  String get bnsExpirationHeight;

  /// No description provided for @bnsUpdateHeight.
  ///
  /// In en, this message translates to:
  /// **'Update Height'**
  String get bnsUpdateHeight;

  /// No description provided for @bnsBackupOwner.
  ///
  /// In en, this message translates to:
  /// **'Backup Owner'**
  String get bnsBackupOwner;

  /// No description provided for @bnsEncryptedWalletValue.
  ///
  /// In en, this message translates to:
  /// **'Encrypted Wallet Value'**
  String get bnsEncryptedWalletValue;

  /// No description provided for @bnsEncryptedBchatValue.
  ///
  /// In en, this message translates to:
  /// **'Encrypted BChat Value'**
  String get bnsEncryptedBchatValue;

  /// No description provided for @bnsEncryptedBelnetValue.
  ///
  /// In en, this message translates to:
  /// **'Encrypted Belnet Value'**
  String get bnsEncryptedBelnetValue;

  /// No description provided for @bnsEncryptedEthValue.
  ///
  /// In en, this message translates to:
  /// **'Encrypted ETH Value'**
  String get bnsEncryptedEthValue;

  /// No description provided for @bnsUpdateAction.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get bnsUpdateAction;

  /// No description provided for @bnsRenewAction.
  ///
  /// In en, this message translates to:
  /// **'Renew'**
  String get bnsRenewAction;

  /// No description provided for @bnsNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note : '**
  String get bnsNoteLabel;

  /// No description provided for @bnsEthAddressDescription.
  ///
  /// In en, this message translates to:
  /// **'Our eth address is compatible across all EVM chains'**
  String get bnsEthAddressDescription;

  /// No description provided for @bnsPurchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get bnsPurchase;

  /// No description provided for @bnsPleaseFillField.
  ///
  /// In en, this message translates to:
  /// **'Please fill in this field'**
  String get bnsPleaseFillField;

  /// No description provided for @bnsInvalidName.
  ///
  /// In en, this message translates to:
  /// **'Invalid BNS Name'**
  String get bnsInvalidName;

  /// No description provided for @bnsInvalidBchatId.
  ///
  /// In en, this message translates to:
  /// **'Invalid BChat ID'**
  String get bnsInvalidBchatId;

  /// No description provided for @bnsInvalidBelnetId.
  ///
  /// In en, this message translates to:
  /// **'Invalid Belnet ID'**
  String get bnsInvalidBelnetId;

  /// No description provided for @bnsInvalidEthAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid ETH Address'**
  String get bnsInvalidEthAddress;

  /// No description provided for @bnsEnterValidWalletAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid wallet address.'**
  String get bnsEnterValidWalletAddress;

  /// No description provided for @bnsConfirmPurchase.
  ///
  /// In en, this message translates to:
  /// **'Confirm Purchase'**
  String get bnsConfirmPurchase;

  /// No description provided for @bnsNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get bnsNameLabel;

  /// No description provided for @bnsYearLabel.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get bnsYearLabel;

  /// No description provided for @bnsOwnerLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get bnsOwnerLabel;

  /// No description provided for @bnsAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get bnsAddressLabel;

  /// No description provided for @bnsNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get bnsNone;

  /// No description provided for @bnsSameOwnerAddress.
  ///
  /// In en, this message translates to:
  /// **'same owner address'**
  String get bnsSameOwnerAddress;

  /// No description provided for @bnsSameWalletAddress.
  ///
  /// In en, this message translates to:
  /// **'same wallet address'**
  String get bnsSameWalletAddress;

  /// No description provided for @bnsSameBchatId.
  ///
  /// In en, this message translates to:
  /// **'same Bchat id'**
  String get bnsSameBchatId;

  /// No description provided for @bnsSameBelnetId.
  ///
  /// In en, this message translates to:
  /// **'same Belnet id'**
  String get bnsSameBelnetId;

  /// No description provided for @bnsSameEthAddress.
  ///
  /// In en, this message translates to:
  /// **'same ETH Address'**
  String get bnsSameEthAddress;

  /// No description provided for @bnsInvalidOwnerAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid Owner address.'**
  String get bnsInvalidOwnerAddress;

  /// No description provided for @bnsNameIsTaken.
  ///
  /// In en, this message translates to:
  /// **'BNS name is taken. Choose a different one.'**
  String get bnsNameIsTaken;

  /// No description provided for @bnsInvalidWalletAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid wallet address. Leave blank if you want to use the current wallet as the BNS owner.'**
  String get bnsInvalidWalletAddress;

  /// No description provided for @bnsOwnerAndBackupDifferent.
  ///
  /// In en, this message translates to:
  /// **'Owner and backup address must be different.'**
  String get bnsOwnerAndBackupDifferent;

  /// No description provided for @bnsPurchasedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'BNS Purchased Successfully'**
  String get bnsPurchasedSuccessfully;

  /// No description provided for @bnsUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'BNS Updated Successfully'**
  String get bnsUpdatedSuccessfully;

  /// No description provided for @bnsRenewedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'BNS Renewed Successfully'**
  String get bnsRenewedSuccessfully;

  /// No description provided for @bnsUpdate.
  ///
  /// In en, this message translates to:
  /// **'BNS Update'**
  String get bnsUpdate;

  /// No description provided for @bnsRenewal.
  ///
  /// In en, this message translates to:
  /// **'BNS Renewal'**
  String get bnsRenewal;

  /// No description provided for @swap.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get swap;

  /// No description provided for @unsupportedExchangePair.
  ///
  /// In en, this message translates to:
  /// **'Unsupported exchange pair'**
  String get unsupportedExchangePair;

  /// No description provided for @blockConfirmed.
  ///
  /// In en, this message translates to:
  /// **'{count} Block'**
  String blockConfirmed(Object count);

  /// No description provided for @blocksConfirmed.
  ///
  /// In en, this message translates to:
  /// **'{count} Blocks'**
  String blocksConfirmed(Object count);

  /// No description provided for @restoredViaKeys.
  ///
  /// In en, this message translates to:
  /// **'You restored via keys'**
  String get restoredViaKeys;

  /// No description provided for @walletAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Wallet with name {name} is already exist!'**
  String walletAlreadyExists(Object name);

  /// No description provided for @nodeAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'This node already exists'**
  String get nodeAlreadyExists;

  /// No description provided for @fee.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get fee;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No Internet!'**
  String get noInternet;

  /// No description provided for @noInternetMessage.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet Connection\nand try again.'**
  String get noInternetMessage;

  /// No description provided for @swapNotAvailable.
  ///
  /// In en, this message translates to:
  /// **' Swap is not available\nat the moment'**
  String get swapNotAvailable;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Please try again after some times.'**
  String get tryAgain;

  /// No description provided for @exchange.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get exchange;

  /// No description provided for @youSend.
  ///
  /// In en, this message translates to:
  /// **'You send'**
  String get youSend;

  /// No description provided for @youGet.
  ///
  /// In en, this message translates to:
  /// **'You get'**
  String get youGet;

  /// No description provided for @floatingExchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Floating Exchange Rate'**
  String get floatingExchangeRate;

  /// No description provided for @floatingRateDescription.
  ///
  /// In en, this message translates to:
  /// **'The floating rate can change at any point due to market conditions, so you might receive more or less crypto than expected.'**
  String get floatingRateDescription;

  /// No description provided for @searchCoins.
  ///
  /// In en, this message translates to:
  /// **'Search Coins'**
  String get searchCoins;

  /// No description provided for @minimumAmount.
  ///
  /// In en, this message translates to:
  /// **'Minimum amount is '**
  String get minimumAmount;

  /// No description provided for @maximumAmount.
  ///
  /// In en, this message translates to:
  /// **'Maximum amount is '**
  String get maximumAmount;

  /// No description provided for @exchangeAmount.
  ///
  /// In en, this message translates to:
  /// **'Exchange Amount'**
  String get exchangeAmount;

  /// No description provided for @exchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate'**
  String get exchangeRate;

  /// No description provided for @receiver.
  ///
  /// In en, this message translates to:
  /// **'Receiver'**
  String get receiver;

  /// No description provided for @amountReceived.
  ///
  /// In en, this message translates to:
  /// **'Amount Received'**
  String get amountReceived;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @expandDetails.
  ///
  /// In en, this message translates to:
  /// **'Expand Details'**
  String get expandDetails;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @noTransactionsMessage.
  ///
  /// In en, this message translates to:
  /// **'There are no Transactions or\nexchanges made to show..'**
  String get noTransactionsMessage;

  /// No description provided for @networkErrorCheckConnection.
  ///
  /// In en, this message translates to:
  /// **'Network Error! Please check internet connection.'**
  String get networkErrorCheckConnection;

  /// No description provided for @swapTransactionReport.
  ///
  /// In en, this message translates to:
  /// **'Beldex_wallet_swap_transaction_report'**
  String get swapTransactionReport;

  /// No description provided for @transactionReport.
  ///
  /// In en, this message translates to:
  /// **'Transaction Report'**
  String get transactionReport;

  /// No description provided for @failedToGetOutputDistribution.
  ///
  /// In en, this message translates to:
  /// **'Failed to get output distribution'**
  String get failedToGetOutputDistribution;

  /// No description provided for @sendValueExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'Value of amount can\'t exceed available balance.\nThe number of fraction digits must be less or equal to 2'**
  String get sendValueExceedBalance;

  /// No description provided for @noPendingTransaction.
  ///
  /// In en, this message translates to:
  /// **'No pending transaction'**
  String get noPendingTransaction;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @addressCopied.
  ///
  /// In en, this message translates to:
  /// **'Address Copied'**
  String get addressCopied;

  /// No description provided for @searchCurrency.
  ///
  /// In en, this message translates to:
  /// **'Search Currency'**
  String get searchCurrency;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'de', 'en', 'es', 'fr', 'ja', 'ko', 'pt', 'ru', 'tr', 'vi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'ja': return AppLocalizationsJa();
    case 'ko': return AppLocalizationsKo();
    case 'pt': return AppLocalizationsPt();
    case 'ru': return AppLocalizationsRu();
    case 'tr': return AppLocalizationsTr();
    case 'vi': return AppLocalizationsVi();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
