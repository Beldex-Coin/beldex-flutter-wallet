// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome to\nBeldex Wallet';

  @override
  String get first_wallet_text => 'Awesome wallet\nfor Beldex';

  @override
  String get please_make_selection => 'Select from the options below to\neither create or recover your wallet.';

  @override
  String get create_new => 'Create New Wallet';

  @override
  String get restore_wallet => 'Use Existing Wallet';

  @override
  String get accounts => 'Accounts';

  @override
  String get edit => 'Edit';

  @override
  String get account => 'Account';

  @override
  String get add => 'Add';

  @override
  String get address_book => 'Address Book';

  @override
  String get contact => 'Contact';

  @override
  String get please_select => 'Please select:';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'Ok';

  @override
  String get contact_name => 'Contact Name';

  @override
  String get reset => 'Reset';

  @override
  String get save => 'Save';

  @override
  String get authenticated => 'Authenticated';

  @override
  String get authentication => 'Authentication';

  @override
  String failed_authentication(Object state_error) {
    return 'Failed authentication. $state_error';
  }

  @override
  String get wallet_menu => 'Menu';

  @override
  String blocksRemaining(Object status) {
    return '$status Blocks Remaining';
  }

  @override
  String get please_try_to_connect_to_another_node => 'Please try to connect to another node';

  @override
  String get beldex_hidden => 'Beldex Hidden';

  @override
  String get beldex_available_balance => 'Beldex Available Balance';

  @override
  String get beldex_full_balance => 'Beldex Full Balance';

  @override
  String get send => 'Send';

  @override
  String get receive => 'Receive';

  @override
  String get transactions => 'Transactions';

  @override
  String get incoming => 'Incoming';

  @override
  String get outgoing => 'Outgoing';

  @override
  String get transactions_by_date => 'Transactions by Date';

  @override
  String get filters => 'Filters';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get received => 'Received';

  @override
  String get sent => 'Sent';

  @override
  String get pending => ' (pending)';

  @override
  String get rescan => 'Rescan';

  @override
  String get reconnect => 'Reconnect';

  @override
  String get wallets => 'Wallets';

  @override
  String get show_seed => 'Show Seed';

  @override
  String get show_keys => 'Show keys';

  @override
  String get reconnection => 'Reconnection';

  @override
  String get reconnect_alert_text => 'Are you sure to reconnect?';

  @override
  String get reload_fiat => 'Reload Fiat data';

  @override
  String get clear => 'Clear';

  @override
  String get error => 'Error';

  @override
  String get copied_to_clipboard => 'Copied to clipboard!';

  @override
  String get fetching => 'Fetching';

  @override
  String get id => 'ID: ';

  @override
  String get amount => 'Amount ';

  @override
  String get status => 'Status: ';

  @override
  String get confirm => 'Confirm';

  @override
  String get confirm_sending => 'Confirm sending';

  @override
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return 'Commit transaction\nAmount: $amount\nFee: $fee';
  }

  @override
  String get sending => 'Sending';

  @override
  String get transaction_sent => 'Transaction sent!';

  @override
  String get send_beldex => 'Send Beldex';

  @override
  String get faq => 'FAQ';

  @override
  String get changelog => 'Changelog';

  @override
  String get loading_your_wallet => 'Loading your wallet';

  @override
  String get new_wallet => 'New Wallet';

  @override
  String get wallet_name => 'Wallet Name';

  @override
  String get continue_text => 'Continue';

  @override
  String get node_new => 'New Node';

  @override
  String get node_address => 'Node Address';

  @override
  String get node_port => 'Node Port';

  @override
  String get login => 'Login';

  @override
  String get password => 'Password';

  @override
  String get nodes => 'Nodes';

  @override
  String get node_reset_settings_title => 'Reset settings';

  @override
  String get nodes_list_reset_to_default_message => 'Are you sure that you want to reset settings to default?';

  @override
  String change_current_node(Object node) {
    return 'Are you sure to change current node to $node?';
  }

  @override
  String get change => 'Change';

  @override
  String get remove_node => 'Remove node';

  @override
  String get remove_node_message => 'Are you sure that you want to remove selected node?';

  @override
  String get remove => 'Remove';

  @override
  String get delete => 'Delete';

  @override
  String get use => 'Switch to ';

  @override
  String get digit_pin => '-digit PIN';

  @override
  String get share_address => 'Share address';

  @override
  String get receive_amount => 'Amount';

  @override
  String get subaddresses => 'Subaddresses';

  @override
  String get restore_restore_wallet => 'Restore Wallet';

  @override
  String get restore_title_from_seed_keys => 'Restore from seed/keys';

  @override
  String get restore_description_from_seed_keys => 'Get back your wallet from seed/keys that you\'ve saved to secure place';

  @override
  String get restore_next => 'Next';

  @override
  String get restore_title_from_backup => 'Restore from a back-up file';

  @override
  String get restore_description_from_backup => 'You can restore the whole Beldex Wallet app from your back-up file';

  @override
  String get restore_seed_keys_restore => 'Seed/Keys Restore';

  @override
  String get restore_title_from_seed => 'Restore from Seed';

  @override
  String get restore_description_from_seed => 'Use the 25-word Mnemonic Key or Seed Phrase to Restore your Wallet.';

  @override
  String get restore_title_from_keys => 'Restore from Keys';

  @override
  String get restore_description_from_keys => 'Use the generated keystrokes saved from private keys to Restore your Wallet ';

  @override
  String get restore_wallet_name => 'Wallet Name';

  @override
  String get restore_address => 'Address';

  @override
  String get restore_view_key_private => 'View key (private)';

  @override
  String get restore_spend_key_private => 'Spend key (private)';

  @override
  String get restore_recover => 'Restore';

  @override
  String get restore_wallet_restore_description => 'Wallet restore description';

  @override
  String get seed_title => 'Seed';

  @override
  String get seed_share => 'Share seed';

  @override
  String get copy => 'Copy';

  @override
  String get seed_language_choose => 'Please choose a seed language';

  @override
  String get seed_language_next => 'Next';

  @override
  String get seed_language_english => 'English';

  @override
  String get seed_language_chinese => 'Chinese';

  @override
  String get seed_language_dutch => 'Dutch';

  @override
  String get seed_language_german => 'German';

  @override
  String get seed_language_japanese => 'Japanese';

  @override
  String get seed_language_portuguese => 'Portuguese';

  @override
  String get seed_language_russian => 'Russian';

  @override
  String get seed_language_spanish => 'Spanish';

  @override
  String get seed_language_french => 'French';

  @override
  String get seed_language_italian => 'Italian';

  @override
  String get send_title => 'Send';

  @override
  String get send_your_wallet => 'Your wallet';

  @override
  String get send_beldex_address => 'Beldex address or BNS name';

  @override
  String get all => 'ALL';

  @override
  String get send_error_currency => 'Currency can only contain numbers';

  @override
  String get send_estimated_fee => 'Estimated Fee:';

  @override
  String send_priority(Object transactionPriority) {
    return '$transactionPriority priority is set as the default fee.\nGo to setting to change the transaction priority.';
  }

  @override
  String get send_creating_transaction => 'Creating transaction';

  @override
  String get title_stakes => 'Stakes';

  @override
  String get title_new_stake => 'New Stake';

  @override
  String get your_contributions => 'Your Contributions';

  @override
  String get start_staking => 'Start staking';

  @override
  String get stake_more => 'Stake more';

  @override
  String get nothing_staked => 'Nothing staked yet';

  @override
  String get service_node_key => 'Master Node Key';

  @override
  String get stake_beldex => 'Stake Beldex';

  @override
  String get title_confirm_unlock_stake => 'Unlock Stake';

  @override
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return 'Do you really want to unlock your stake from $masterNodeKey?';
  }

  @override
  String get unlock_stake_requested => 'Stake unlock requested';

  @override
  String get unable_unlock_stake => 'Unable to unlock stake';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_nodes => 'Nodes';

  @override
  String get settings_current_node => 'Current node';

  @override
  String get settings_wallets => 'Wallets';

  @override
  String get settings_display_balance_as => 'Display Balance As';

  @override
  String get settings_balance_detail => 'Decimals';

  @override
  String get settings_currency => 'Currency';

  @override
  String get settings_fee_priority => 'Fee Priority';

  @override
  String get settings_save_recipient_address => 'Save recipient address';

  @override
  String get settings_personal => 'Personal';

  @override
  String get settings_change_pin => 'Change PIN';

  @override
  String get settings_change_language => 'Select Language';

  @override
  String get settings_allow_biometric_authentication => 'Allow biometric authentication';

  @override
  String get settings_dark_mode => 'Dark mode';

  @override
  String get settings_transactions => 'Transactions';

  @override
  String get settings_display_on_dashboard_list => 'Display on dashboard list';

  @override
  String get settings_all => 'ALL';

  @override
  String get settings_none => 'None';

  @override
  String get settings_support => 'Support';

  @override
  String get settings_terms_and_conditions => 'Terms & Conditions';

  @override
  String get settings_enable_fiat_currency => 'Enable Fiat Currency conversion';

  @override
  String get pin_is_incorrect => 'PIN is incorrect';

  @override
  String get amount_detail_ultra => '9 - Ultra';

  @override
  String get amount_detail_none => '0 - None';

  @override
  String get amount_detail_detailed => '4 - Detailed';

  @override
  String get amount_detail_normal => '2 - Normal';

  @override
  String get setup_pin => 'Setup PIN';

  @override
  String get re_enter_your_pin => 'Re-Enter your PIN';

  @override
  String get setup_successful => 'Your PIN has been set up \nsuccessfully!';

  @override
  String get wallet_keys => 'Wallet keys';

  @override
  String get view_key_private => 'View key (private)';

  @override
  String get view_key_public => 'View key (public)';

  @override
  String get spend_key_private => 'Spend key (private)';

  @override
  String get spend_key_public => 'Spend key (public)';

  @override
  String copied_key_to_clipboard(Object key) {
    return 'Copied $key to Clipboard';
  }

  @override
  String get new_subaddress_title => 'New subaddress';

  @override
  String get new_subaddress_label_name => 'Label name';

  @override
  String get new_subaddress_create => 'Create';

  @override
  String get subaddress_title => 'Subaddress list';

  @override
  String get transaction_details_title => 'Transaction Details';

  @override
  String get transaction_details_transaction_id => 'Transaction ID';

  @override
  String get transaction_details_date => 'Date';

  @override
  String get transaction_details_height => 'Height';

  @override
  String get transaction_details_amount => 'Amount';

  @override
  String transaction_details_copied(Object title) {
    return '$title copied to Clipboard';
  }

  @override
  String get transaction_details_recipient_address => 'Recipient Address';

  @override
  String get wallet_list_title => 'Beldex Wallet';

  @override
  String get wallet_list_create_new_wallet => 'Create New Wallet';

  @override
  String get wallet_list_restore_wallet => 'Use Existing Wallet';

  @override
  String get wallet_list_load_wallet => 'Load wallet';

  @override
  String wallet_list_loading_wallet(Object wallet_name) {
    return 'Loading $wallet_name wallet';
  }

  @override
  String wallet_list_failed_to_load(Object error, Object wallet_name) {
    return 'Failed to load $wallet_name wallet. $error';
  }

  @override
  String wallet_list_removing_wallet(Object wallet_name) {
    return 'Removing $wallet_name wallet';
  }

  @override
  String wallet_list_failed_to_remove(Object error, Object wallet_name) {
    return 'Failed to remove $wallet_name wallet. $error';
  }

  @override
  String get widgets_address => 'Address';

  @override
  String get widgets_restore_from_blockheight => 'Restore from Blockheight';

  @override
  String get widgets_restore_from_date => 'Restore from Date';

  @override
  String get widgets_or => 'OR';

  @override
  String get widgets_seed => 'Seed';

  @override
  String router_no_route(Object name) {
    return 'No route defined for $name';
  }

  @override
  String get error_text_account_name => 'Account name can only contain letters, numbers\nand must be between 1 and 15 characters long';

  @override
  String get error_text_contact_name => 'Contact name can\'t contain ` , \' \" symbols\nand must be between 1 and 32 characters long';

  @override
  String get error_text_address => 'Invalid BDX address';

  @override
  String get error_text_node_address => 'Please enter a iPv4 address';

  @override
  String get error_text_node_port => 'Node port can only contain numbers between 0 and 65535';

  @override
  String get error_text_payment_id => 'Payment ID can only contain from 16 to 64 chars in hex';

  @override
  String get error_text_beldex => 'Beldex value can\'t exceed available balance.\nThe number of fraction digits must be less or equal to 9';

  @override
  String get error_text_fiat => 'Value of amount can\'t exceed available balance.\nThe number of fraction digits must be less or equal to 2';

  @override
  String get error_text_subaddress_name => 'Subaddress name can\'t contain ` , \' \" symbols\nand must be between 1 and 20 characters long';

  @override
  String get error_text_amount => 'Amount can only contain numbers';

  @override
  String get error_text_wallet_name => 'Wallet name can only contain letters, numbers\nand must be between 1 and 15 characters long';

  @override
  String get error_text_keys => 'Wallet keys can only contain 64 chars in hex';

  @override
  String get error_text_crypto_currency => 'The number of fraction digits\nmust be less or equal to 12';

  @override
  String get error_text_service_node => 'A Master Node key can only contain 64 chars in hex';

  @override
  String get auth_store_ban_timeout => 'ban_timeout';

  @override
  String get auth_store_banned_for => 'Banned for ';

  @override
  String get auth_store_banned_minutes => ' minutes';

  @override
  String get auth_store_incorrect_password => 'Wrong PIN';

  @override
  String get wallet_restoration_store_incorrect_seed_length => 'Incorrect seed length';

  @override
  String get full_balance => 'Full Balance';

  @override
  String get available_balance => 'Available Balance';

  @override
  String get hidden_balance => 'Hidden Balance';

  @override
  String get sync_status_synchronizing => 'SYNCHRONIZING';

  @override
  String get sync_status_synchronized => 'SYNCHRONIZED';

  @override
  String get sync_status_not_connected => 'NOT CONNECTED';

  @override
  String get sync_status_starting_sync => 'STARTING SYNC';

  @override
  String get sync_status_failed_connect => 'FAILED CONNECT TO THE NODE';

  @override
  String get sync_status_connecting => 'CONNECTING';

  @override
  String get sync_status_connected => 'CONNECTED';

  @override
  String get transaction_priority_slow => 'Slow';

  @override
  String get transaction_priority_blink => 'Flash';

  @override
  String get change_language => 'Change Language';

  @override
  String change_language_to(Object language) {
    return 'Change language to $language?';
  }

  @override
  String get paste => 'Paste';

  @override
  String get restore_from_seed_placeholder => 'Please enter or paste your seed here';

  @override
  String get add_new_word => 'Add new word';

  @override
  String get incorrect_seed => 'The text entered is not valid.';

  @override
  String get biometric_auth_reason => 'Scan your fingerprint to authenticate';

  @override
  String version(Object currentVersion) {
    return 'Version $currentVersion';
  }

  @override
  String get openalias_alert_title => 'Beldex Recipient Detected';

  @override
  String openalias_alert_content(Object recipient_name) {
    return 'You will be sending funds to\n$recipient_name';
  }

  @override
  String get dangerzone => 'Dangerzone';

  @override
  String get yes_im_sure => 'Yes, I\'m sure!';

  @override
  String never_give_your(Object item) {
    return 'Never Give your Beldex Wallet $item to Anyone!';
  }

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'NEVER input your Beldex wallet $item into any software or website other than the OFFICIAL Beldex wallets downloaded directly from the $app_store, the Beldex website, or the Beldex GitHub.\nAre you sure you want to access your wallet $item?';
  }

  @override
  String get keys_title => 'Keys';

  @override
  String get are_you_sure => 'Are you sure?';

  @override
  String get do_you_want_to_exit_an_app => 'Do you want to exit an App';

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get byUsingThisAppYouAgreeToTheTermsOf => 'By using this app, you agree to the Terms of Agreement set forth to below';

  @override
  String get iAgreeToTermsOfUse => 'I agree to Terms of Use';

  @override
  String get accept => 'Accept';

  @override
  String get pleaseEnterAValidAmount => 'Please enter a valid amount';

  @override
  String get pleaseEnterAValidSeed => 'Please enter a valid seed';

  @override
  String get changeWallet => 'Change Wallet';

  @override
  String get removeWallet => 'Remove Wallet';

  @override
  String get reconnectWallet => 'Reconnect Wallet';

  @override
  String get rescanWallet => 'Rescan Wallet';

  @override
  String get enterWalletName => 'Enter Wallet Name';

  @override
  String get noTransactionsYet => 'No transactions yet!';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'After your first transaction,\n you will be able to view it here.';

  @override
  String get copied => 'Copied';

  @override
  String get addAddress => 'Add Address';

  @override
  String get important => 'IMPORTANT';

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Never input your Beldex wallet $item into any software or website other than the official Beldex wallets downloaded directly from the $appStore,the beldex website, or the beldex GitHub.';
  }

  @override
  String get enterWalletName_ => 'Enter wallet name';

  @override
  String get chooseSeedLanguage => 'Choose Seed Language';

  @override
  String get wallet => 'Wallet';

  @override
  String get seedKeys => 'Seed & Keys';

  @override
  String get walletAddress => 'Wallet Address';

  @override
  String get recoverySeedkey => 'Recovery Seed/Key';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get chooseLanguage => 'Choose Language';

  @override
  String get welcomeToBeldexWallet => 'Welcome to Beldex Wallet :)';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'Select an option below to create or\n recover existing wallet';

  @override
  String get enterAValidNameUpto15Characters => 'Enter a valid name upto 15 characters';

  @override
  String get fiveDecimals => '5 - Five (0.00000)';

  @override
  String get fourDecimals => '4 - Four (0.0000)';

  @override
  String get twoDecimals => '2 - Two (0.00)';

  @override
  String get zeroDecimal => '0 - Zero (000)';

  @override
  String get doYouWantToExitTheWallet => 'Do you want to exit the wallet?';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => 'Make sure to take backup of your\nrecovery Seed, wallet address\nand private keys';

  @override
  String blockRemaining(Object status) {
    return '$status Block Remaining';
  }

  @override
  String get flashTransaction => 'Flash Transaction';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => 'Transfer your BDX more faster with\n Flash Transaction!';

  @override
  String get enterYourPin => 'Enter Your PIN';

  @override
  String get walletSettings => 'Wallet Settings';

  @override
  String get recoverySeed => 'Recovery Seed';

  @override
  String get youDontHaveEnoughUnlockedBalance => 'You don\'t have enough unlocked balance';

  @override
  String get alert => 'Alert';

  @override
  String get touchTheFingerprintSensor => 'Touch the Fingerprint sensor';

  @override
  String get usePattern => 'USE PATTERN';

  @override
  String get enterBdxToSend => 'Enter BDX to send';

  @override
  String get enterAmount => 'Enter Amount';

  @override
  String get pleaseEnterAAmount => 'Please enter a amount';

  @override
  String get committingTheTransaction => 'Committing the Transaction';

  @override
  String get availableBdx => 'Available BDX : ';

  @override
  String get pleaseEnterABdxAddress => 'Please enter a bdx address';

  @override
  String get enterAValidAddress => 'Enter a valid address';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'Biometric feature currenly disabled.Kindly enable allow biometric authentication feature inside the app settings';

  @override
  String get unlockBeldexWallet => 'Unlock Beldex Wallet';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => 'Confirm your screen lock PIN,Pattern and password';

  @override
  String get doYouWantToChangeYournPrimaryAccount => 'Do you want to change your\n primary account?';

  @override
  String get rename => 'Rename';

  @override
  String get addAccount => 'Add Account';

  @override
  String get noAddressesInBook => 'No addresses in book';

  @override
  String get bdx => 'BDX';

  @override
  String get howeverWeRecommendToScanTheBlockchainFromTheBlock => 'However we recommend to scan the blockchain from the block height at which you created the wallet to get all transactions and correct balance';

  @override
  String get youHaveScannedFromTheBlockHeight => 'You have scanned from the block height';

  @override
  String get syncInfo => 'Sync info';

  @override
  String get doYouWantToReconnectnTheWallet => 'Do you want to reconnect\n the wallet?';

  @override
  String get enterValidNameUpto15Characters => 'Enter valid name upto 15 characters';

  @override
  String get checkingNodeConnection => 'Checking node connection...';

  @override
  String get enterBdxToReceive => 'Enter BDX to Receive';

  @override
  String get addSubAddress => 'Add Sub Address';

  @override
  String get shareQr => 'Share QR';

  @override
  String get name => 'Name';

  @override
  String get enterValidHeightWithoutSpace => 'Enter valid height without space';

  @override
  String get dateShouldNotBeEmpty => 'Date should not be empty';

  @override
  String get walletRestore => 'Wallet Restore';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => 'You can\'t view the seed because you\'ve restored using keys';

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'Never share your seed to anyone! Check your surroundings to ensure no one is overlooking';

  @override
  String get note => 'Note :';

  @override
  String get copySeed => 'Copy Seed';

  @override
  String get accountAlreadyExist => 'Account already exist';

  @override
  String get transactionInitiatedSuccessfully => 'Transaction initiated successfully';

  @override
  String get enterAValidSubAddress => 'Enter a valid sub address';

  @override
  String get subaddressAlreadyExist => 'Subaddress already exist';

  @override
  String get labelName => 'Label name';

  @override
  String get subAddress => 'Sub Address';

  @override
  String get loadingTheWallet => 'Loading the wallet...';

  @override
  String get youAreAboutToDeletenYourWallet => 'You are about to delete\n your wallet!';

  @override
  String get creatingTheTransaction => 'Creating the Transaction';

  @override
  String get copyAndSaveTheSeedToContinue => 'Copy and save the seed to continue';

  @override
  String get enterPin => 'Enter PIN';

  @override
  String get test => 'Test';

  @override
  String get success => 'Success';

  @override
  String get connectionFailed => 'Connection Failed';

  @override
  String get checking => 'Checking...';

  @override
  String get testResult => 'Test Result:';

  @override
  String get passwordOptional => 'Password (optional)';

  @override
  String get userNameOptional => 'User Name (optional)';

  @override
  String get nodeNameOptional => 'Node Name (optional)';

  @override
  String get addNode => 'Add Node';

  @override
  String get legalDisclaimer => 'Legal Disclaimer';

  @override
  String get howCanWenhelpYou => 'How can we\nhelp you?';

  @override
  String get removeContact => 'Remove Contact';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => 'Are you sure you want to remove selected contact?';

  @override
  String get theAddressAlreadyExist => 'The Address already Exist';

  @override
  String get thisNameAlreadyExist => 'This Name already Exist';

  @override
  String get enterAValidName => 'Enter a valid name';

  @override
  String get nameShouldNotBeEmpty => 'Name should not be empty';

  @override
  String get enterName => 'Enter Name';

  @override
  String get accountName => 'Account Name';

  @override
  String get playStore => 'Play Store';

  @override
  String get appstore => 'AppStore';

  @override
  String get allowFaceIdAuthentication => 'Allow face id authentication';

  @override
  String get enterAddress => 'Enter Address';

  @override
  String get pleaseAddAMainnetNode => 'Please add a mainnet node';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return 'Flash transaction are instant transactions.\n$transactionPriority priority is set as a default fee.';
  }

  @override
  String get initiatingTransactionTitle => 'Initiating Transaction..';

  @override
  String get initiatingTransactionDescription => 'Please don\'t close this window or navigate to another app until the transaction gets initiated';

  @override
  String get subAddresses => 'Sub Addresses';

  @override
  String get loadingTheWalletDescription => 'Please don\'t close this window or navigate to another app until we load the wallet';

  @override
  String get buyBns => 'Buy BNS';

  @override
  String get bns => 'BNS';

  @override
  String get bnsUpdate => 'BNS Update';

  @override
  String get bnsRenewal => 'BNS Renewal';

  @override
  String get swap => 'Swap';

  @override
  String get nodeAlreadyExists => 'This node already exists';

  @override
  String get networkErrorCheckConnection => 'Network Error! Please check internet connection.';
}
