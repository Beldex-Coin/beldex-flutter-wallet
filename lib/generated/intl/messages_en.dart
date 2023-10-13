// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(status) => "${status} Blocks Remaining";

  static m1(status) => "${status} Block Remaining";

  static m2(masterNodeKey) => "Do you really want to unlock your stake from ${masterNodeKey}?";

  static m3(node) => "Are you sure to change current node to ${node}?";

  static m4(language) => "Change language to ${language}?";

  static m5(amount, fee) => "Commit transaction\nAmount: ${amount}\nFee: ${fee}";

  static m6(key) => "Copied ${key} to Clipboard";

  static m7(item, app_store) => "NEVER input your Beldex wallet ${item} into any software or website other than the OFFICIAL Beldex wallets downloaded directly from the ${app_store}, the Beldex website, or the Beldex GitHub.\nAre you sure you want to access your wallet ${item}?";

  static m8(state_error) => "Failed authentication. ${state_error}";

  static m9(transactionPriority) => "Flash transaction are instant transactions.\n${transactionPriority} priority is set as a default fee.";

  static m10(item, appStore) => "Never input your Beldex wallet ${item} into any software or website other than the official Beldex wallets downloaded directly from the ${appStore},the beldex website, or the beldex GitHub.";

  static m11(item) => "Never Give your Beldex Wallet ${item} to Anyone!";

  static m12(recipient_name) => "You will be sending funds to\n${recipient_name}";

  static m13(name) => "No route defined for ${name}";

  static m14(transactionPriority) => "${transactionPriority} priority is set as the default fee.\nGo to setting to change the transaction priority.";

  static m15(title) => "${title} copied to Clipboard";

  static m16(currentVersion) => "Version ${currentVersion}";

  static m17(wallet_name, error) => "Failed to load ${wallet_name} wallet. ${error}";

  static m18(wallet_name, error) => "Failed to remove ${wallet_name} wallet. ${error}";

  static m19(wallet_name) => "Loading ${wallet_name} wallet";

  static m20(wallet_name) => "Removing ${wallet_name} wallet";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "Blocks_remaining" : m0,
    "accept" : MessageLookupByLibrary.simpleMessage("Accept"),
    "account" : MessageLookupByLibrary.simpleMessage("Account"),
    "accountAlreadyExist" : MessageLookupByLibrary.simpleMessage("Account already exist"),
    "accountName" : MessageLookupByLibrary.simpleMessage("Account Name"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Accounts"),
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "addAccount" : MessageLookupByLibrary.simpleMessage("Add Account"),
    "addAddress" : MessageLookupByLibrary.simpleMessage("Add Address"),
    "addNode" : MessageLookupByLibrary.simpleMessage("Add Node"),
    "addSubAddress" : MessageLookupByLibrary.simpleMessage("Add Sub Address"),
    "add_new_word" : MessageLookupByLibrary.simpleMessage("Add new word"),
    "address_book" : MessageLookupByLibrary.simpleMessage("Address Book"),
    "afterYourFirstTransactionnYouWillBeAbleToView" : MessageLookupByLibrary.simpleMessage("After your first transaction,\n you will be able to view it here."),
    "alert" : MessageLookupByLibrary.simpleMessage("Alert"),
    "all" : MessageLookupByLibrary.simpleMessage("ALL"),
    "allowFaceIdAuthentication" : MessageLookupByLibrary.simpleMessage("Allow face id authentication"),
    "amount" : MessageLookupByLibrary.simpleMessage("Amount "),
    "amount_detail_detailed" : MessageLookupByLibrary.simpleMessage("4 - Detailed"),
    "amount_detail_none" : MessageLookupByLibrary.simpleMessage("0 - None"),
    "amount_detail_normal" : MessageLookupByLibrary.simpleMessage("2 - Normal"),
    "amount_detail_ultra" : MessageLookupByLibrary.simpleMessage("9 - Ultra"),
    "appstore" : MessageLookupByLibrary.simpleMessage("AppStore"),
    "areYouSureYouWantToRemoveSelectedContact" : MessageLookupByLibrary.simpleMessage("Are you sure you want to remove selected contact?"),
    "are_you_sure" : MessageLookupByLibrary.simpleMessage("Are you sure?"),
    "auth_store_ban_timeout" : MessageLookupByLibrary.simpleMessage("ban_timeout"),
    "auth_store_banned_for" : MessageLookupByLibrary.simpleMessage("Banned for "),
    "auth_store_banned_minutes" : MessageLookupByLibrary.simpleMessage(" minutes"),
    "auth_store_incorrect_password" : MessageLookupByLibrary.simpleMessage("Wrong PIN"),
    "authenticated" : MessageLookupByLibrary.simpleMessage("Authenticated"),
    "authentication" : MessageLookupByLibrary.simpleMessage("Authentication"),
    "availableBdx" : MessageLookupByLibrary.simpleMessage("Available BDX : "),
    "available_balance" : MessageLookupByLibrary.simpleMessage("Available Balance"),
    "bdx" : MessageLookupByLibrary.simpleMessage("BDX"),
    "beldex_available_balance" : MessageLookupByLibrary.simpleMessage("Beldex Available Balance"),
    "beldex_full_balance" : MessageLookupByLibrary.simpleMessage("Beldex Full Balance"),
    "beldex_hidden" : MessageLookupByLibrary.simpleMessage("Beldex Hidden"),
    "biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside" : MessageLookupByLibrary.simpleMessage("Biometric feature currenly disabled.Kindly enable allow biometric authentication feature inside the app settings"),
    "biometric_auth_reason" : MessageLookupByLibrary.simpleMessage("Scan your fingerprint to authenticate"),
    "blockRemaining" : m1,
    "body_confirm_unlock_stake" : m2,
    "byUsingThisAppYouAgreeToTheTermsOf" : MessageLookupByLibrary.simpleMessage("By using this app, you agree to the Terms of Agreement set forth to below"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "change" : MessageLookupByLibrary.simpleMessage("Change"),
    "changeWallet" : MessageLookupByLibrary.simpleMessage("Change Wallet"),
    "change_current_node" : m3,
    "change_language" : MessageLookupByLibrary.simpleMessage("Change Language"),
    "change_language_to" : m4,
    "changelog" : MessageLookupByLibrary.simpleMessage("Changelog"),
    "checking" : MessageLookupByLibrary.simpleMessage("Checking..."),
    "checkingNodeConnection" : MessageLookupByLibrary.simpleMessage("Checking node connection..."),
    "chooseLanguage" : MessageLookupByLibrary.simpleMessage("Choose Language"),
    "chooseSeedLanguage" : MessageLookupByLibrary.simpleMessage("Choose Seed Language"),
    "clear" : MessageLookupByLibrary.simpleMessage("Clear"),
    "commit_transaction_amount_fee" : m5,
    "committingTheTransaction" : MessageLookupByLibrary.simpleMessage("Committing the Transaction"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmYourScreenLockPinpatternAndPassword" : MessageLookupByLibrary.simpleMessage("Confirm your screen lock PIN,Pattern and password"),
    "confirm_sending" : MessageLookupByLibrary.simpleMessage("Confirm sending"),
    "connectionFailed" : MessageLookupByLibrary.simpleMessage("Connection Failed"),
    "contact" : MessageLookupByLibrary.simpleMessage("Contact"),
    "contact_name" : MessageLookupByLibrary.simpleMessage("Contact Name"),
    "continue_text" : MessageLookupByLibrary.simpleMessage("Continue"),
    "copied" : MessageLookupByLibrary.simpleMessage("Copied"),
    "copied_key_to_clipboard" : m6,
    "copied_to_clipboard" : MessageLookupByLibrary.simpleMessage("Copied to clipboard!"),
    "copy" : MessageLookupByLibrary.simpleMessage("Copy"),
    "copyAndSaveTheSeedToContinue" : MessageLookupByLibrary.simpleMessage("Copy and save the seed to continue"),
    "copySeed" : MessageLookupByLibrary.simpleMessage("Copy Seed"),
    "create_new" : MessageLookupByLibrary.simpleMessage("Create New Wallet"),
    "creatingTheTransaction" : MessageLookupByLibrary.simpleMessage("Creating the Transaction"),
    "dangerzone" : MessageLookupByLibrary.simpleMessage("Dangerzone"),
    "dangerzone_warning" : m7,
    "dateShouldNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Date should not be empty"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "digit_pin" : MessageLookupByLibrary.simpleMessage("-digit PIN"),
    "doYouWantToChangeYournPrimaryAccount" : MessageLookupByLibrary.simpleMessage("Do you want to change your\n primary account?"),
    "doYouWantToExitTheWallet" : MessageLookupByLibrary.simpleMessage("Do you want to exit the wallet?"),
    "doYouWantToReconnectnTheWallet" : MessageLookupByLibrary.simpleMessage("Do you want to reconnect\n the wallet?"),
    "do_you_want_to_exit_an_app" : MessageLookupByLibrary.simpleMessage("Do you want to exit an App"),
    "edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "enterAValidAddress" : MessageLookupByLibrary.simpleMessage("Enter a valid address"),
    "enterAValidName" : MessageLookupByLibrary.simpleMessage("Enter a valid name"),
    "enterAValidNameUpto15Characters" : MessageLookupByLibrary.simpleMessage("Enter a valid name upto 15 characters"),
    "enterAValidSubAddress" : MessageLookupByLibrary.simpleMessage("Enter a valid sub address"),
    "enterAddress" : MessageLookupByLibrary.simpleMessage("Enter Address"),
    "enterAmount" : MessageLookupByLibrary.simpleMessage("Enter Amount"),
    "enterBdxToReceive" : MessageLookupByLibrary.simpleMessage("Enter BDX to Receive"),
    "enterBdxToSend" : MessageLookupByLibrary.simpleMessage("Enter BDX to send"),
    "enterName" : MessageLookupByLibrary.simpleMessage("Enter Name"),
    "enterPin" : MessageLookupByLibrary.simpleMessage("Enter PIN"),
    "enterValidHeightWithoutSpace" : MessageLookupByLibrary.simpleMessage("Enter valid height without space"),
    "enterValidNameUpto15Characters" : MessageLookupByLibrary.simpleMessage("Enter valid name upto 15 characters"),
    "enterWalletName" : MessageLookupByLibrary.simpleMessage("Enter Wallet Name"),
    "enterWalletName_" : MessageLookupByLibrary.simpleMessage("Enter wallet name"),
    "enterYourPin" : MessageLookupByLibrary.simpleMessage("Enter Your PIN"),
    "error" : MessageLookupByLibrary.simpleMessage("Error"),
    "error_text_account_name" : MessageLookupByLibrary.simpleMessage("Account name can only contain letters, numbers\nand must be between 1 and 15 characters long"),
    "error_text_address" : MessageLookupByLibrary.simpleMessage("Invalid BDX address"),
    "error_text_amount" : MessageLookupByLibrary.simpleMessage("Amount can only contain numbers"),
    "error_text_beldex" : MessageLookupByLibrary.simpleMessage("Beldex value can\'t exceed available balance.\nThe number of fraction digits must be less or equal to 9"),
    "error_text_contact_name" : MessageLookupByLibrary.simpleMessage("Contact name can\'t contain ` , \' \" symbols\nand must be between 1 and 32 characters long"),
    "error_text_crypto_currency" : MessageLookupByLibrary.simpleMessage("The number of fraction digits\nmust be less or equal to 12"),
    "error_text_fiat" : MessageLookupByLibrary.simpleMessage("Value of amount can\'t exceed available balance.\nThe number of fraction digits must be less or equal to 2"),
    "error_text_keys" : MessageLookupByLibrary.simpleMessage("Wallet keys can only contain 64 chars in hex"),
    "error_text_node_address" : MessageLookupByLibrary.simpleMessage("Please enter a iPv4 address"),
    "error_text_node_port" : MessageLookupByLibrary.simpleMessage("Node port can only contain numbers between 0 and 65535"),
    "error_text_payment_id" : MessageLookupByLibrary.simpleMessage("Payment ID can only contain from 16 to 64 chars in hex"),
    "error_text_service_node" : MessageLookupByLibrary.simpleMessage("A Master Node key can only contain 64 chars in hex"),
    "error_text_subaddress_name" : MessageLookupByLibrary.simpleMessage("Subaddress name can\'t contain ` , \' \" symbols\nand must be between 1 and 20 characters long"),
    "error_text_wallet_name" : MessageLookupByLibrary.simpleMessage("Wallet name can only contain letters, numbers\nand must be between 1 and 15 characters long"),
    "failed_authentication" : m8,
    "faq" : MessageLookupByLibrary.simpleMessage("FAQ"),
    "fetching" : MessageLookupByLibrary.simpleMessage("Fetching"),
    "filters" : MessageLookupByLibrary.simpleMessage("Filters"),
    "first_wallet_text" : MessageLookupByLibrary.simpleMessage("Awesome wallet\nfor Beldex"),
    "fiveDecimals" : MessageLookupByLibrary.simpleMessage("5 - Five (0.00000)"),
    "flashTransaction" : MessageLookupByLibrary.simpleMessage("Flash Transaction"),
    "flashTransactionPriority" : m9,
    "fourDecimals" : MessageLookupByLibrary.simpleMessage("4 - Four (0.0000)"),
    "full_balance" : MessageLookupByLibrary.simpleMessage("Full Balance"),
    "hidden_balance" : MessageLookupByLibrary.simpleMessage("Hidden Balance"),
    "howCanWenhelpYou" : MessageLookupByLibrary.simpleMessage("How can we\nhelp you?"),
    "howeverWeRecommendToScanTheBlockchainFromTheBlock" : MessageLookupByLibrary.simpleMessage("However we recommend to scan the blockchain from the block height at which you created the wallet to get all transactions and correct balance"),
    "iAgreeToTermsOfUse" : MessageLookupByLibrary.simpleMessage("I agree to Terms of Use"),
    "id" : MessageLookupByLibrary.simpleMessage("ID: "),
    "important" : MessageLookupByLibrary.simpleMessage("IMPORTANT"),
    "incoming" : MessageLookupByLibrary.simpleMessage("Incoming"),
    "incorrect_seed" : MessageLookupByLibrary.simpleMessage("The text entered is not valid."),
    "initiatingTransactionDescription" : MessageLookupByLibrary.simpleMessage("Please don\'t close this window or navigate to another app until the transaction gets initiated"),
    "initiatingTransactionTitle" : MessageLookupByLibrary.simpleMessage("Initiating Transaction.."),
    "keys_title" : MessageLookupByLibrary.simpleMessage("Keys"),
    "labelName" : MessageLookupByLibrary.simpleMessage("Label name"),
    "legalDisclaimer" : MessageLookupByLibrary.simpleMessage("Legal Disclaimer"),
    "loadingTheWallet" : MessageLookupByLibrary.simpleMessage("Loading the wallet..."),
    "loading_your_wallet" : MessageLookupByLibrary.simpleMessage("Loading your wallet"),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate" : MessageLookupByLibrary.simpleMessage("Make sure to backup of your\nrecovery Seed, wallet address\nand private keys"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "nameShouldNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Name should not be empty"),
    "neverInputYourBeldexWalletItemIntoAnySoftwareOr" : m10,
    "neverShareYourSeedToAnyoneCheckYourSurroundingsTo" : MessageLookupByLibrary.simpleMessage("Never share your seed to anyone! Check your surroundings to ensure no one is overlooking"),
    "never_give_your" : m11,
    "new_subaddress_create" : MessageLookupByLibrary.simpleMessage("Create"),
    "new_subaddress_label_name" : MessageLookupByLibrary.simpleMessage("Label name"),
    "new_subaddress_title" : MessageLookupByLibrary.simpleMessage("New subaddress"),
    "new_wallet" : MessageLookupByLibrary.simpleMessage("New Wallet"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noAddressesInBook" : MessageLookupByLibrary.simpleMessage("No addresses in book"),
    "noTransactionsYet" : MessageLookupByLibrary.simpleMessage("No transactions yet!"),
    "nodeNameOptional" : MessageLookupByLibrary.simpleMessage("Node Name (optional)"),
    "node_address" : MessageLookupByLibrary.simpleMessage("Node Address"),
    "node_new" : MessageLookupByLibrary.simpleMessage("New Node"),
    "node_port" : MessageLookupByLibrary.simpleMessage("Node Port"),
    "node_reset_settings_title" : MessageLookupByLibrary.simpleMessage("Reset settings"),
    "nodes" : MessageLookupByLibrary.simpleMessage("Nodes"),
    "nodes_list_reset_to_default_message" : MessageLookupByLibrary.simpleMessage("Are you sure that you want to reset settings to default?"),
    "note" : MessageLookupByLibrary.simpleMessage("Note :"),
    "nothing_staked" : MessageLookupByLibrary.simpleMessage("Nothing staked yet"),
    "ok" : MessageLookupByLibrary.simpleMessage("Ok"),
    "openalias_alert_content" : m12,
    "openalias_alert_title" : MessageLookupByLibrary.simpleMessage("Beldex Recipient Detected"),
    "outgoing" : MessageLookupByLibrary.simpleMessage("Outgoing"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "passwordOptional" : MessageLookupByLibrary.simpleMessage("Password (optional)"),
    "paste" : MessageLookupByLibrary.simpleMessage("Paste"),
    "pending" : MessageLookupByLibrary.simpleMessage(" (pending)"),
    "pin_is_incorrect" : MessageLookupByLibrary.simpleMessage("PIN is incorrect"),
    "playStore" : MessageLookupByLibrary.simpleMessage("Play Store"),
    "pleaseAddAMainnetNode" : MessageLookupByLibrary.simpleMessage("Please add a mainnet node"),
    "pleaseEnterAAmount" : MessageLookupByLibrary.simpleMessage("Please enter a amount"),
    "pleaseEnterABdxAddress" : MessageLookupByLibrary.simpleMessage("Please enter a bdx address"),
    "pleaseEnterAValidAmount" : MessageLookupByLibrary.simpleMessage("Please enter a valid amount"),
    "pleaseEnterAValidSeed" : MessageLookupByLibrary.simpleMessage("Please enter a valid seed"),
    "please_make_selection" : MessageLookupByLibrary.simpleMessage("Select from the options below to\neither create or recover your wallet."),
    "please_select" : MessageLookupByLibrary.simpleMessage("Please select:"),
    "please_try_to_connect_to_another_node" : MessageLookupByLibrary.simpleMessage("Please try to connect to another node"),
    "re_enter_your_pin" : MessageLookupByLibrary.simpleMessage("Re-Enter your PIN"),
    "receive" : MessageLookupByLibrary.simpleMessage("Receive"),
    "receive_amount" : MessageLookupByLibrary.simpleMessage("Amount"),
    "received" : MessageLookupByLibrary.simpleMessage("Received"),
    "reconnect" : MessageLookupByLibrary.simpleMessage("Reconnect"),
    "reconnectWallet" : MessageLookupByLibrary.simpleMessage("Reconnect Wallet"),
    "reconnect_alert_text" : MessageLookupByLibrary.simpleMessage("Are you sure to reconnect?"),
    "reconnection" : MessageLookupByLibrary.simpleMessage("Reconnection"),
    "recoverySeed" : MessageLookupByLibrary.simpleMessage("Recovery Seed"),
    "recoverySeedkey" : MessageLookupByLibrary.simpleMessage("Recovery Seed/Key"),
    "reload_fiat" : MessageLookupByLibrary.simpleMessage("Reload Fiat data"),
    "remove" : MessageLookupByLibrary.simpleMessage("Remove"),
    "removeContact" : MessageLookupByLibrary.simpleMessage("Remove Contact"),
    "removeWallet" : MessageLookupByLibrary.simpleMessage("Remove Wallet"),
    "remove_node" : MessageLookupByLibrary.simpleMessage("Remove node"),
    "remove_node_message" : MessageLookupByLibrary.simpleMessage("Are you sure that you want to remove selected node?"),
    "rename" : MessageLookupByLibrary.simpleMessage("Rename"),
    "rescan" : MessageLookupByLibrary.simpleMessage("Rescan"),
    "rescanWallet" : MessageLookupByLibrary.simpleMessage("Rescan Wallet"),
    "reset" : MessageLookupByLibrary.simpleMessage("Reset"),
    "restore_address" : MessageLookupByLibrary.simpleMessage("Address"),
    "restore_description_from_backup" : MessageLookupByLibrary.simpleMessage("You can restore the whole Beldex Wallet app from your back-up file"),
    "restore_description_from_keys" : MessageLookupByLibrary.simpleMessage("Use the generated keystrokes saved from private keys to Restore your Wallet "),
    "restore_description_from_seed" : MessageLookupByLibrary.simpleMessage("Use the 25-word Mnemonic Key or Seed Phrase to Restore your Wallet."),
    "restore_description_from_seed_keys" : MessageLookupByLibrary.simpleMessage("Get back your wallet from seed/keys that you\'ve saved to secure place"),
    "restore_from_seed_placeholder" : MessageLookupByLibrary.simpleMessage("Please enter or paste your seed here"),
    "restore_next" : MessageLookupByLibrary.simpleMessage("Next"),
    "restore_recover" : MessageLookupByLibrary.simpleMessage("Restore"),
    "restore_restore_wallet" : MessageLookupByLibrary.simpleMessage("Restore Wallet"),
    "restore_seed_keys_restore" : MessageLookupByLibrary.simpleMessage("Seed/Keys Restore"),
    "restore_spend_key_private" : MessageLookupByLibrary.simpleMessage("Spend key (private)"),
    "restore_title_from_backup" : MessageLookupByLibrary.simpleMessage("Restore from a back-up file"),
    "restore_title_from_keys" : MessageLookupByLibrary.simpleMessage("Restore from Keys"),
    "restore_title_from_seed" : MessageLookupByLibrary.simpleMessage("Restore from Seed"),
    "restore_title_from_seed_keys" : MessageLookupByLibrary.simpleMessage("Restore from seed/keys"),
    "restore_view_key_private" : MessageLookupByLibrary.simpleMessage("View key (private)"),
    "restore_wallet" : MessageLookupByLibrary.simpleMessage("Use Existing Wallet"),
    "restore_wallet_name" : MessageLookupByLibrary.simpleMessage("Wallet Name"),
    "restore_wallet_restore_description" : MessageLookupByLibrary.simpleMessage("Wallet restore description"),
    "router_no_route" : m13,
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "seedKeys" : MessageLookupByLibrary.simpleMessage("Seed & Keys"),
    "seed_language_chinese" : MessageLookupByLibrary.simpleMessage("Chinese"),
    "seed_language_choose" : MessageLookupByLibrary.simpleMessage("Please choose a seed language"),
    "seed_language_dutch" : MessageLookupByLibrary.simpleMessage("Dutch"),
    "seed_language_english" : MessageLookupByLibrary.simpleMessage("English"),
    "seed_language_french" : MessageLookupByLibrary.simpleMessage("French"),
    "seed_language_german" : MessageLookupByLibrary.simpleMessage("German"),
    "seed_language_italian" : MessageLookupByLibrary.simpleMessage("Italian"),
    "seed_language_japanese" : MessageLookupByLibrary.simpleMessage("Japanese"),
    "seed_language_next" : MessageLookupByLibrary.simpleMessage("Next"),
    "seed_language_portuguese" : MessageLookupByLibrary.simpleMessage("Portuguese"),
    "seed_language_russian" : MessageLookupByLibrary.simpleMessage("Russian"),
    "seed_language_spanish" : MessageLookupByLibrary.simpleMessage("Spanish"),
    "seed_share" : MessageLookupByLibrary.simpleMessage("Share seed"),
    "seed_title" : MessageLookupByLibrary.simpleMessage("Seed"),
    "selectAnOptionBelowToCreateOrnRecoverExistingWallet" : MessageLookupByLibrary.simpleMessage("Select an option below to create or\n recover existing wallet"),
    "selectLanguage" : MessageLookupByLibrary.simpleMessage("Select Language"),
    "send" : MessageLookupByLibrary.simpleMessage("Send"),
    "send_beldex" : MessageLookupByLibrary.simpleMessage("Send Beldex"),
    "send_beldex_address" : MessageLookupByLibrary.simpleMessage("Beldex address"),
    "send_creating_transaction" : MessageLookupByLibrary.simpleMessage("Creating transaction"),
    "send_error_currency" : MessageLookupByLibrary.simpleMessage("Currency can only contain numbers"),
    "send_estimated_fee" : MessageLookupByLibrary.simpleMessage("Estimated Fee:"),
    "send_priority" : m14,
    "send_title" : MessageLookupByLibrary.simpleMessage("Send"),
    "send_your_wallet" : MessageLookupByLibrary.simpleMessage("Your wallet"),
    "sending" : MessageLookupByLibrary.simpleMessage("Sending"),
    "sent" : MessageLookupByLibrary.simpleMessage("Sent"),
    "service_node_key" : MessageLookupByLibrary.simpleMessage("Master Node Key"),
    "settings_all" : MessageLookupByLibrary.simpleMessage("ALL"),
    "settings_allow_biometric_authentication" : MessageLookupByLibrary.simpleMessage("Allow biometric authentication"),
    "settings_balance_detail" : MessageLookupByLibrary.simpleMessage("Decimals"),
    "settings_change_language" : MessageLookupByLibrary.simpleMessage("Select Language"),
    "settings_change_pin" : MessageLookupByLibrary.simpleMessage("Change PIN"),
    "settings_currency" : MessageLookupByLibrary.simpleMessage("Currency"),
    "settings_current_node" : MessageLookupByLibrary.simpleMessage("Current node"),
    "settings_dark_mode" : MessageLookupByLibrary.simpleMessage("Dark mode"),
    "settings_display_balance_as" : MessageLookupByLibrary.simpleMessage("Display Balance As"),
    "settings_display_on_dashboard_list" : MessageLookupByLibrary.simpleMessage("Display on dashboard list"),
    "settings_enable_fiat_currency" : MessageLookupByLibrary.simpleMessage("Enable Fiat Currency conversion"),
    "settings_fee_priority" : MessageLookupByLibrary.simpleMessage("Fee Priority"),
    "settings_nodes" : MessageLookupByLibrary.simpleMessage("Nodes"),
    "settings_none" : MessageLookupByLibrary.simpleMessage("None"),
    "settings_personal" : MessageLookupByLibrary.simpleMessage("Personal"),
    "settings_save_recipient_address" : MessageLookupByLibrary.simpleMessage("Save recipient address"),
    "settings_support" : MessageLookupByLibrary.simpleMessage("Support"),
    "settings_terms_and_conditions" : MessageLookupByLibrary.simpleMessage("Terms & Conditions"),
    "settings_title" : MessageLookupByLibrary.simpleMessage("Settings"),
    "settings_transactions" : MessageLookupByLibrary.simpleMessage("Transactions"),
    "settings_wallets" : MessageLookupByLibrary.simpleMessage("Wallets"),
    "setup_pin" : MessageLookupByLibrary.simpleMessage("Setup PIN"),
    "setup_successful" : MessageLookupByLibrary.simpleMessage("Your PIN has been set up \nsuccessfully!"),
    "shareQr" : MessageLookupByLibrary.simpleMessage("Share QR"),
    "share_address" : MessageLookupByLibrary.simpleMessage("Share address"),
    "show_keys" : MessageLookupByLibrary.simpleMessage("Show keys"),
    "show_seed" : MessageLookupByLibrary.simpleMessage("Show Seed"),
    "spend_key_private" : MessageLookupByLibrary.simpleMessage("Spend key (private)"),
    "spend_key_public" : MessageLookupByLibrary.simpleMessage("Spend key (public)"),
    "stake_beldex" : MessageLookupByLibrary.simpleMessage("Stake Beldex"),
    "stake_more" : MessageLookupByLibrary.simpleMessage("Stake more"),
    "start_staking" : MessageLookupByLibrary.simpleMessage("Start staking"),
    "status" : MessageLookupByLibrary.simpleMessage("Status: "),
    "subAddress" : MessageLookupByLibrary.simpleMessage("Sub Address"),
    "subaddressAlreadyExist" : MessageLookupByLibrary.simpleMessage("Subaddress already exist"),
    "subaddress_title" : MessageLookupByLibrary.simpleMessage("Subaddress list"),
    "subaddresses" : MessageLookupByLibrary.simpleMessage("Subaddresses"),
    "success" : MessageLookupByLibrary.simpleMessage("Success"),
    "syncInfo" : MessageLookupByLibrary.simpleMessage("Sync info"),
    "sync_status_connected" : MessageLookupByLibrary.simpleMessage("CONNECTED"),
    "sync_status_connecting" : MessageLookupByLibrary.simpleMessage("CONNECTING"),
    "sync_status_failed_connect" : MessageLookupByLibrary.simpleMessage("FAILED CONNECT TO THE NODE"),
    "sync_status_not_connected" : MessageLookupByLibrary.simpleMessage("NOT CONNECTED"),
    "sync_status_starting_sync" : MessageLookupByLibrary.simpleMessage("STARTING SYNC"),
    "sync_status_synchronized" : MessageLookupByLibrary.simpleMessage("SYNCHRONIZED"),
    "sync_status_synchronizing" : MessageLookupByLibrary.simpleMessage("SYNCHRONIZING"),
    "test" : MessageLookupByLibrary.simpleMessage("Test"),
    "testResult" : MessageLookupByLibrary.simpleMessage("Test Result:"),
    "theAddressAlreadyExist" : MessageLookupByLibrary.simpleMessage("The Address already Exist"),
    "thisNameAlreadyExist" : MessageLookupByLibrary.simpleMessage("This Name already Exist"),
    "title_confirm_unlock_stake" : MessageLookupByLibrary.simpleMessage("Unlock Stake"),
    "title_new_stake" : MessageLookupByLibrary.simpleMessage("New Stake"),
    "title_stakes" : MessageLookupByLibrary.simpleMessage("Stakes"),
    "today" : MessageLookupByLibrary.simpleMessage("Today"),
    "touchTheFingerprintSensor" : MessageLookupByLibrary.simpleMessage("Touch the Fingerprint sensor"),
    "transactionInitiatedSuccessfully" : MessageLookupByLibrary.simpleMessage("Transaction initiated successfully"),
    "transaction_details_amount" : MessageLookupByLibrary.simpleMessage("Amount"),
    "transaction_details_copied" : m15,
    "transaction_details_date" : MessageLookupByLibrary.simpleMessage("Date"),
    "transaction_details_height" : MessageLookupByLibrary.simpleMessage("Height"),
    "transaction_details_recipient_address" : MessageLookupByLibrary.simpleMessage("Recipient Address"),
    "transaction_details_title" : MessageLookupByLibrary.simpleMessage("Transaction Details"),
    "transaction_details_transaction_id" : MessageLookupByLibrary.simpleMessage("Transaction ID"),
    "transaction_priority_blink" : MessageLookupByLibrary.simpleMessage("Flash"),
    "transaction_priority_slow" : MessageLookupByLibrary.simpleMessage("Slow"),
    "transaction_sent" : MessageLookupByLibrary.simpleMessage("Transaction sent!"),
    "transactions" : MessageLookupByLibrary.simpleMessage("Transactions"),
    "transactions_by_date" : MessageLookupByLibrary.simpleMessage("Transactions by Date"),
    "transferYourBdxMoreFasternWithFlashTransaction" : MessageLookupByLibrary.simpleMessage("Transfer your BDX more faster\n with Flash Transaction!"),
    "twoDecimals" : MessageLookupByLibrary.simpleMessage("2 - Two (0.00)"),
    "unable_unlock_stake" : MessageLookupByLibrary.simpleMessage("Unable to unlock stake"),
    "unlockBeldexWallet" : MessageLookupByLibrary.simpleMessage("Unlock Beldex Wallet"),
    "unlock_stake_requested" : MessageLookupByLibrary.simpleMessage("Stake unlock requested"),
    "use" : MessageLookupByLibrary.simpleMessage("Switch to "),
    "usePattern" : MessageLookupByLibrary.simpleMessage("USE PATTERN"),
    "userNameOptional" : MessageLookupByLibrary.simpleMessage("User Name (optional)"),
    "version" : m16,
    "view_key_private" : MessageLookupByLibrary.simpleMessage("View key (private)"),
    "view_key_public" : MessageLookupByLibrary.simpleMessage("View key (public)"),
    "wallet" : MessageLookupByLibrary.simpleMessage("Wallet"),
    "walletAddress" : MessageLookupByLibrary.simpleMessage("Wallet Address"),
    "walletRestore" : MessageLookupByLibrary.simpleMessage("Wallet Restore"),
    "walletSettings" : MessageLookupByLibrary.simpleMessage("Wallet Settings"),
    "wallet_keys" : MessageLookupByLibrary.simpleMessage("Wallet keys"),
    "wallet_list_create_new_wallet" : MessageLookupByLibrary.simpleMessage("Create New Wallet"),
    "wallet_list_failed_to_load" : m17,
    "wallet_list_failed_to_remove" : m18,
    "wallet_list_load_wallet" : MessageLookupByLibrary.simpleMessage("Load wallet"),
    "wallet_list_loading_wallet" : m19,
    "wallet_list_removing_wallet" : m20,
    "wallet_list_restore_wallet" : MessageLookupByLibrary.simpleMessage("Use Existing Wallet"),
    "wallet_list_title" : MessageLookupByLibrary.simpleMessage("Beldex Wallet"),
    "wallet_menu" : MessageLookupByLibrary.simpleMessage("Menu"),
    "wallet_name" : MessageLookupByLibrary.simpleMessage("Wallet Name"),
    "wallet_restoration_store_incorrect_seed_length" : MessageLookupByLibrary.simpleMessage("Incorrect seed length"),
    "wallets" : MessageLookupByLibrary.simpleMessage("Wallets"),
    "welcome" : MessageLookupByLibrary.simpleMessage("Welcome to\nBeldex Wallet"),
    "welcomeToBeldexWallet" : MessageLookupByLibrary.simpleMessage("Welcome to Beldex Wallet :)"),
    "widgets_address" : MessageLookupByLibrary.simpleMessage("Address"),
    "widgets_or" : MessageLookupByLibrary.simpleMessage("OR"),
    "widgets_restore_from_blockheight" : MessageLookupByLibrary.simpleMessage("Restore from Blockheight"),
    "widgets_restore_from_date" : MessageLookupByLibrary.simpleMessage("Restore from Date"),
    "widgets_seed" : MessageLookupByLibrary.simpleMessage("Seed"),
    "yes" : MessageLookupByLibrary.simpleMessage("Yes"),
    "yes_im_sure" : MessageLookupByLibrary.simpleMessage("Yes, I\'m sure!"),
    "yesterday" : MessageLookupByLibrary.simpleMessage("Yesterday"),
    "youAreAboutToDeletenYourWallet" : MessageLookupByLibrary.simpleMessage("You are about to delete\n your wallet!"),
    "youCantViewTheSeedBecauseYouveRestoredUsingKeys" : MessageLookupByLibrary.simpleMessage("You can\'t view the seed because you\'ve restored using keys"),
    "youDontHaveEnoughUnlockedBalance" : MessageLookupByLibrary.simpleMessage("You don\'t have enough unlocked balance"),
    "youHaveScannedFromTheBlockHeight" : MessageLookupByLibrary.simpleMessage("You have scanned from the block height"),
    "your_contributions" : MessageLookupByLibrary.simpleMessage("Your Contributions"),
    "zeroDecimal" : MessageLookupByLibrary.simpleMessage("0 - Zero (000)")
  };
}
