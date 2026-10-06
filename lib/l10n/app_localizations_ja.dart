// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get welcome => '';

  @override
  String get first_wallet_text => '';

  @override
  String get please_make_selection => '';

  @override
  String get create_new => '新しいウォレットを作成';

  @override
  String get restore_wallet => '既存のウォレットを使用';

  @override
  String get accounts => 'アカウント';

  @override
  String get edit => '編集';

  @override
  String get account => 'アカウント';

  @override
  String get add => '追加';

  @override
  String get address_book => 'アドレス帳';

  @override
  String get contact => '';

  @override
  String get please_select => '';

  @override
  String get cancel => 'キャンセル';

  @override
  String get ok => 'OK';

  @override
  String get contact_name => '';

  @override
  String get reset => 'リセット';

  @override
  String get save => '保存';

  @override
  String get authenticated => '';

  @override
  String get authentication => '';

  @override
  String failed_authentication(Object state_error) {
    return '認証に失敗しました。$state_error';
  }

  @override
  String get wallet_menu => '';

  @override
  String blocksRemaining(Object status) {
    return '残り$statusブロック';
  }

  @override
  String get please_try_to_connect_to_another_node => '別のノードへの接続を試してください';

  @override
  String get beldex_hidden => '';

  @override
  String get beldex_available_balance => '';

  @override
  String get beldex_full_balance => '';

  @override
  String get send => '送金';

  @override
  String get receive => '受取';

  @override
  String get transactions => '取引履歴';

  @override
  String get incoming => '受信';

  @override
  String get outgoing => '送信';

  @override
  String get transactions_by_date => '日付別';

  @override
  String get filters => 'フィルター';

  @override
  String get today => '';

  @override
  String get yesterday => '';

  @override
  String get received => '';

  @override
  String get sent => '送信';

  @override
  String get pending => '';

  @override
  String get rescan => '再スキャン';

  @override
  String get reconnect => '再接続';

  @override
  String get wallets => 'ウォレット';

  @override
  String get show_seed => 'シード表示';

  @override
  String get show_keys => 'キー表示';

  @override
  String get reconnection => '';

  @override
  String get reconnect_alert_text => '';

  @override
  String get reload_fiat => '';

  @override
  String get clear => 'クリア';

  @override
  String get error => '';

  @override
  String get copied_to_clipboard => '';

  @override
  String get fetching => '';

  @override
  String get id => '';

  @override
  String get amount => '金額';

  @override
  String get status => 'ステータス:';

  @override
  String get confirm => '';

  @override
  String get confirm_sending => '送金確認';

  @override
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return '';
  }

  @override
  String get sending => '';

  @override
  String get transaction_sent => '';

  @override
  String get send_beldex => '';

  @override
  String get faq => 'FAQ';

  @override
  String get changelog => '変更履歴';

  @override
  String get loading_your_wallet => '';

  @override
  String get new_wallet => '新しいウォレット';

  @override
  String get wallet_name => 'ウォレット名';

  @override
  String get continue_text => '続行';

  @override
  String get node_new => '';

  @override
  String get node_address => 'ノードアドレス';

  @override
  String get node_port => 'ノードポート';

  @override
  String get login => '';

  @override
  String get password => '';

  @override
  String get nodes => 'ノード';

  @override
  String get node_reset_settings_title => '設定をリセット';

  @override
  String get nodes_list_reset_to_default_message => '設定をデフォルトにリセットしてもよろしいですか？\n キャンセル';

  @override
  String change_current_node(Object node) {
    return '現在のノードを$nodeに変更してもよろしいですか？';
  }

  @override
  String get change => '';

  @override
  String get remove_node => '';

  @override
  String get remove_node_message => '';

  @override
  String get remove => '';

  @override
  String get delete => '削除';

  @override
  String get use => '';

  @override
  String get digit_pin => '';

  @override
  String get share_address => '';

  @override
  String get subaddresses => '';

  @override
  String get restore_restore_wallet => 'ウォレットを復元';

  @override
  String get restore_title_from_seed_keys => 'シード／キーから復元';

  @override
  String get restore_description_from_seed_keys => '安全な場所に保存したシード／キーを使用してウォレットを復元します';

  @override
  String get restore_next => '次へ';

  @override
  String get restore_title_from_backup => '';

  @override
  String get restore_description_from_backup => '';

  @override
  String get restore_seed_keys_restore => '';

  @override
  String get restore_title_from_seed => ' シードから復元';

  @override
  String get restore_description_from_seed => 'ウォレットを復元するには、25語のニーモニックキーまたはシードフレーズを使用します。';

  @override
  String get restore_title_from_keys => 'キーから復元';

  @override
  String get restore_description_from_keys => 'ウォレットを復元するには、秘密鍵から保存されたキーストロークを使用します';

  @override
  String get restore_address => 'アドレス';

  @override
  String get restore_recover => '復元';

  @override
  String get restore_wallet_restore_description => '';

  @override
  String get seed_title => 'シード';

  @override
  String get seed_share => '';

  @override
  String get copy => '';

  @override
  String get seed_language_choose => '';

  @override
  String get seed_language_english => '';

  @override
  String get seed_language_chinese => '';

  @override
  String get seed_language_dutch => '';

  @override
  String get seed_language_german => '';

  @override
  String get seed_language_japanese => '';

  @override
  String get seed_language_portuguese => '';

  @override
  String get seed_language_russian => '';

  @override
  String get seed_language_spanish => '';

  @override
  String get seed_language_french => '';

  @override
  String get seed_language_italian => '';

  @override
  String get send_your_wallet => '';

  @override
  String get send_beldex_address => 'BeldexアドレスまたはBNS名';

  @override
  String get all => '';

  @override
  String get send_error_currency => '';

  @override
  String get send_estimated_fee => '推定手数料:';

  @override
  String send_priority(Object transactionPriority) {
    return '$transactionPriorityの優先度がデフォルトの手数料として設定されています。取引の優先度を変更するには、設定に移動してください。';
  }

  @override
  String get send_creating_transaction => '';

  @override
  String get title_stakes => '';

  @override
  String get title_new_stake => '';

  @override
  String get your_contributions => '';

  @override
  String get start_staking => '';

  @override
  String get stake_more => '';

  @override
  String get nothing_staked => '';

  @override
  String get service_node_key => '';

  @override
  String get stake_beldex => '';

  @override
  String get title_confirm_unlock_stake => '';

  @override
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return '';
  }

  @override
  String get unlock_stake_requested => '';

  @override
  String get unable_unlock_stake => '';

  @override
  String get settings_title => '設定';

  @override
  String get settings_current_node => '現在のノード';

  @override
  String get settings_display_balance_as => '残高表示';

  @override
  String get settings_balance_detail => '小数点表示';

  @override
  String get settings_currency => '通貨';

  @override
  String get settings_fee_priority => '手数料優先';

  @override
  String get settings_save_recipient_address => '受取人アドレスを保存';

  @override
  String get settings_personal => '個人';

  @override
  String get settings_change_pin => 'PINを変更';

  @override
  String get settings_allow_biometric_authentication => '生体認証を許可';

  @override
  String get settings_dark_mode => 'ダークモード';

  @override
  String get settings_display_on_dashboard_list => '';

  @override
  String get settings_none => '';

  @override
  String get settings_support => 'サポート';

  @override
  String get settings_terms_and_conditions => '利用規約';

  @override
  String get settings_enable_fiat_currency => 'フラット通貨換算を有効にする';

  @override
  String get pin_is_incorrect => 'PINが正しくありません';

  @override
  String get amount_detail_ultra => '';

  @override
  String get amount_detail_none => '';

  @override
  String get amount_detail_detailed => '';

  @override
  String get amount_detail_normal => '';

  @override
  String get setup_pin => 'PINを設定';

  @override
  String get re_enter_your_pin => 'PINを再入力してください';

  @override
  String get setup_successful => 'PINの設定が正常に完了しました！';

  @override
  String get wallet_keys => 'ウォレットキー';

  @override
  String get view_key_private => 'ビューキー（秘密）';

  @override
  String get view_key_public => ' 公開キーを見る';

  @override
  String get spend_key_private => 'スペンドキー（秘密）';

  @override
  String get spend_key_public => '支出キー（公開）';

  @override
  String copied_key_to_clipboard(Object key) {
    return '';
  }

  @override
  String get new_subaddress_title => '';

  @override
  String get new_subaddress_create => '作成';

  @override
  String get subaddress_title => '';

  @override
  String get transaction_details_title => '';

  @override
  String get transaction_details_transaction_id => 'トランザクションID';

  @override
  String get transaction_details_height => '身長';

  @override
  String get transaction_details_amount => '金額';

  @override
  String get transaction_details_payment_id => '';

  @override
  String transaction_details_copied(Object title) {
    return '';
  }

  @override
  String get transaction_details_recipient_address => '受取アドレス';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return '選択したチェーン（$blockchain）の正しいアドレスを入力してください。正しく入力しないと、資金を失う可能性があります。';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return '$currencyの受取人アドレスを入力してください';
  }

  @override
  String get swap_refund_wallet_address => '';

  @override
  String swap_enter_refund_address(Object currency) {
    return '';
  }

  @override
  String swap_extra_id_info(Object currency, Object extraIdName) {
    return '';
  }

  @override
  String swap_my_wallet_requires_extra_id(Object extraIdName) {
    return '';
  }

  @override
  String swap_enter_extra_id(Object extraIdName) {
    return '';
  }

  @override
  String swap_please_enter_extra_id(Object extraIdName) {
    return '';
  }

  @override
  String get swap_minimum_amount_changed => '';

  @override
  String get swap_maximum_amount_changed => '';

  @override
  String get swap_transaction_preview => '';

  @override
  String get swap_exchange_rate => '為替レート';

  @override
  String get swap_service_fee => 'サービス手数料 0.25%';

  @override
  String get service_fee => 'サービス手数料 0.25%';

  @override
  String get network_fee => 'ネットワーク手数料';

  @override
  String get swap_refund_address => '';

  @override
  String get swap_network_fee => 'ネットワーク手数料';

  @override
  String get swap_you_get => '受取額';

  @override
  String get swap_checkout => 'チェックアウト';

  @override
  String get swap_network_label => 'ネットワーク：';

  @override
  String get swap_estimated_time => '';

  @override
  String get swap_estimated_time_value => '';

  @override
  String get swap_confirm_and_make_payment => '確認して支払い';

  @override
  String get swap_send_funds_to_address_below => '以下のアドレスに資金を送金してください';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return '$amount $currencyを送信するまでの残り時間';
  }

  @override
  String swap_time_remaining(Object value) {
    return '残り時間：$value';
  }

  @override
  String get swap_send_funds_notice => '資金を送金するまで3時間あります。\nそれ以降は取引が自動的にキャンセルされます。\n資金が受信されると交換が開始されます。';

  @override
  String get swap_confirmations => '';

  @override
  String get swap_completed => '完了';

  @override
  String get swap_amount_from => '送金額';

  @override
  String get swap_amount_to => '受取額';

  @override
  String get swap_received_time => '受信時間';

  @override
  String get swap_amount_sent => '送金額';

  @override
  String get swap_input_output_hash => '入出力ハッシュ';

  @override
  String get swap_input_hash => '入力ハッシュ';

  @override
  String get swap_output_hash => '出力ハッシュ';

  @override
  String get swap_failed => '失敗';

  @override
  String get swap_expired => '';

  @override
  String get swap_overdue => '';

  @override
  String get swap_funds_not_received => '資金が3時間以内に受信されませんでした。レートを確認し、新しい取引を作成してください';

  @override
  String get swap_start_over => 'やり直す';

  @override
  String get swap_exchanging => '';

  @override
  String get swap_confirming_in_progress => '';

  @override
  String get swap_confirmed => '';

  @override
  String swap_confirmed_in_blockchain(Object currencyFrom, Object currencyTo) {
    return '';
  }

  @override
  String get swap_see_input_hash_in_explorer => '';

  @override
  String swap_done_exchanging(Object currencyFrom, Object currencyTo) {
    return '';
  }

  @override
  String swap_exchanging_currency(Object currencyFrom, Object currencyTo) {
    return '';
  }

  @override
  String get swap_process_wait => '';

  @override
  String get swap_sending_funds_to_wallet => '';

  @override
  String get swap_funds_sent_to_wallet => '';

  @override
  String get swap_you_dont_have_to_wait_here => '';

  @override
  String get swap_you_can_initiate_new_transaction => '';

  @override
  String get swap_history => '';

  @override
  String get swap_you_sent => '';

  @override
  String swap_exchange_address(Object currency, Object exchangeName) {
    return '';
  }

  @override
  String swap_recipient_address_with_currency(Object currency) {
    return '';
  }

  @override
  String get swap_open_history => '履歴を開く';

  @override
  String get swap_new_transaction => '新しい取引';

  @override
  String get swap_i_agree_with => '同意します';

  @override
  String get swap_terms_of_use => '利用規約';

  @override
  String get swap_and => 'と';

  @override
  String get swap_privacy_policy => 'プライバシーポリシー';

  @override
  String get wallet_list_title => 'Beldexウォレット';

  @override
  String get wallet_list_load_wallet => 'ウォレットを読み込む';

  @override
  String wallet_list_loading_wallet(Object wallet_name) {
    return '';
  }

  @override
  String wallet_list_failed_to_load(Object error, Object wallet_name) {
    return '';
  }

  @override
  String wallet_list_removing_wallet(Object wallet_name) {
    return '';
  }

  @override
  String wallet_list_failed_to_remove(Object error, Object wallet_name) {
    return '';
  }

  @override
  String get widgets_restore_from_blockheight => 'ブロック高から復元';

  @override
  String get widgets_restore_from_date => '日付から復元';

  @override
  String get widgets_or => '';

  @override
  String router_no_route(Object name) {
    return '';
  }

  @override
  String get error_text_account_name => '';

  @override
  String get error_text_contact_name => '連絡先名には \' \" 記号を含めることはできません\n 1～32文字で入力してください';

  @override
  String get error_text_address => '無効なBDXアドレスです';

  @override
  String get error_text_node_address => 'IPv4アドレスを入力してください';

  @override
  String get error_text_node_port => 'ノードポートには0から65535までの数字のみ入力できます';

  @override
  String get error_text_payment_id => '';

  @override
  String get error_text_beldex => '';

  @override
  String get error_text_fiat => '';

  @override
  String get error_text_subaddress_name => '';

  @override
  String get error_text_amount => '';

  @override
  String get error_text_wallet_name => '';

  @override
  String get error_text_keys => 'ウォレットキーは16進数で64文字のみ使用できます';

  @override
  String get error_text_crypto_currency => '';

  @override
  String get error_text_service_node => '';

  @override
  String get auth_store_ban_timeout => '';

  @override
  String get auth_store_banned_for => '';

  @override
  String get auth_store_banned_minutes => '';

  @override
  String get auth_store_incorrect_password => '';

  @override
  String get wallet_restoration_store_incorrect_seed_length => '';

  @override
  String get full_balance => '総残高';

  @override
  String get available_balance => '利用可能残高';

  @override
  String get hidden_balance => '非表示残高';

  @override
  String get sync_status_synchronizing => '同期中';

  @override
  String get sync_status_synchronized => '同期済み';

  @override
  String get sync_status_not_connected => '';

  @override
  String get sync_status_starting_sync => '同期開始中';

  @override
  String get sync_status_failed_connect => 'ノードへの接続に失敗しました';

  @override
  String get sync_status_connecting => '接続中';

  @override
  String get sync_status_connected => '';

  @override
  String get transaction_priority_slow => '低速';

  @override
  String get transaction_priority_blink => '高速';

  @override
  String get change_language => '言語を変更';

  @override
  String change_language_to(Object language) {
    return '';
  }

  @override
  String get paste => '貼り付け';

  @override
  String get restore_from_seed_placeholder => 'ここにシードを入力または貼り付けてください';

  @override
  String get add_new_word => '';

  @override
  String get incorrect_seed => '';

  @override
  String get biometric_auth_reason => '';

  @override
  String version(Object currentVersion) {
    return 'バージョン $currentVersion';
  }

  @override
  String get openalias_alert_title => '';

  @override
  String openalias_alert_content(Object recipient_name) {
    return '';
  }

  @override
  String get dangerzone => '';

  @override
  String get yes_im_sure => 'はい、確かです！';

  @override
  String never_give_your(Object item) {
    return 'Beldexウォレットの$itemを決して誰にも渡さないでください！';
  }

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'Beldexウォレットの$itemを、$app_store、Beldex公式ウェブサイト、またはBeldex GitHubから直接ダウンロードした公式Beldexウォレット以外のソフトウェアやウェブサイトには絶対に入力しないでください。ウォレットの$itemにアクセスしてもよろしいですか？';
  }

  @override
  String get keys_title => '';

  @override
  String get are_you_sure => 'よろしいですか？';

  @override
  String get do_you_want_to_exit_an_app => '';

  @override
  String get no => 'いいえ';

  @override
  String get yes => 'はい';

  @override
  String get byUsingThisAppYouAgreeToTheTermsOf => '';

  @override
  String get iAgreeToTermsOfUse => '';

  @override
  String get accept => '';

  @override
  String get pleaseEnterAValidAmount => '有効な金額を入力してください';

  @override
  String get pleaseEnterAValidSeed => '有効なシードを入力してください';

  @override
  String get changeWallet => 'ウォレットを変更';

  @override
  String get removeWallet => 'ウォレットを削除';

  @override
  String get reconnectWallet => 'ウォレットを再接続しますか';

  @override
  String get rescanWallet => 'ウォレットを再スキャン';

  @override
  String get enterWalletName => 'ウォレット名を入力';

  @override
  String get noTransactionsYet => 'まだ取引はありません！';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => '最初の取引後、ここで確認できます。';

  @override
  String get copied => 'コピーしました';

  @override
  String get addAddress => 'アドレス追加';

  @override
  String get important => '';

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Beldexウォレットの$itemを、$appStore、Beldex公式ウェブサイト、またはBeldex GitHubから直接ダウンロードした公式Beldexウォレット以外のソフトウェアやウェブサイトには絶対に入力しないでください。';
  }

  @override
  String get enterWalletName_ => 'ウォレット名を入力';

  @override
  String get chooseSeedLanguage => 'シード言語を選択';

  @override
  String get wallet => 'ウォレット';

  @override
  String get seedKeys => 'シード & キー';

  @override
  String get walletAddress => 'ウォレットアドレス';

  @override
  String get recoverySeedkey => 'リカバリーシード/キー';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get chooseLanguage => '言語選択';

  @override
  String get welcomeToBeldexWallet => 'Beldexウォレットへようこそ :)';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => '既存のウォレットを復元するか、新しく作成するオプションを選択してください';

  @override
  String get enterAValidNameUpto15Characters => '15文字以内で有効な名前を入力してください';

  @override
  String get enterAValidNameUpto20Characters => '20文字以内の有効な名前を入力してください';

  @override
  String get fiveDecimals => '5桁 - 0.00000';

  @override
  String get fourDecimals => '4桁 - 0.0000';

  @override
  String get twoDecimals => '2桁 - 0.00';

  @override
  String get zeroDecimal => '0桁 - 000';

  @override
  String get doYouWantToExitTheWallet => 'ウォレットを終了しますか？';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => '必ずリカバリーシード、ウォレットアドレス、プライベートキーのバックアップを取ってください';

  @override
  String blockRemaining(Object status) {
    return '';
  }

  @override
  String get flashTransaction => 'フラッシュトランザクション';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => 'フラッシュトランザクションでBDXをより速く送金！';

  @override
  String get enterYourPin => 'PINを入力してください';

  @override
  String get walletSettings => 'ウォレット設定';

  @override
  String get recoverySeed => 'リカバリーシード';

  @override
  String get youDontHaveEnoughUnlockedBalance => '';

  @override
  String get alert => 'アラート';

  @override
  String get touchTheFingerprintSensor => '';

  @override
  String get usePattern => '';

  @override
  String get enterBdxToSend => '送金するBDXを入力';

  @override
  String get enterAmount => '金額を入力';

  @override
  String get pleaseEnterAAmount => '金額を入力してください';

  @override
  String get committingTheTransaction => '';

  @override
  String get availableBdx => '利用可能BDX :';

  @override
  String get pleaseEnterABdxAddress => 'BDXアドレスを入力してください';

  @override
  String get enterAValidAddress => '';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => '現在、生体認証機能は無効になっています。\n 　　　　　　アプリの設定で生体認証機能を\n 　　　　　　有効にしてください';

  @override
  String get unlockBeldexWallet => '';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => '';

  @override
  String get doYouWantToChangeYournPrimaryAccount => 'プライマリアカウントを変更しますか？';

  @override
  String get rename => '';

  @override
  String get addAccount => 'アカウントを追加';

  @override
  String get noAddressesInBook => 'アドレスは登録されていません';

  @override
  String get bdx => '';

  @override
  String get howeverWeRecommendToScanTheBlockchainFromTheBlock => '';

  @override
  String get youHaveScannedFromTheBlockHeight => '';

  @override
  String get syncInfo => '';

  @override
  String get doYouWantToReconnectnTheWallet => 'ウォレットを再接続しますか？';

  @override
  String get enterValidNameUpto15Characters => '15文字以内の有効な名前を入力してください';

  @override
  String get checkingNodeConnection => '';

  @override
  String get enterBdxToReceive => '受け取るBDXを入力';

  @override
  String get addSubAddress => 'サブアドレスを追加';

  @override
  String get shareQr => 'QRを共有';

  @override
  String get name => '名前';

  @override
  String get enterValidHeightWithoutSpace => 'スペースなしで有効なブロック高を入力してください';

  @override
  String get dateShouldNotBeEmpty => '日付は空にできません';

  @override
  String get walletRestore => 'ウォレットの復元';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => '';

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'シードは絶対に他人と共有しないでください！周囲を確認し、誰にも見られていないことを確認してください';

  @override
  String get note => '注意：';

  @override
  String get copySeed => 'シードをコピー';

  @override
  String get accountAlreadyExist => 'アカウントは既に存在します';

  @override
  String get transactionInitiatedSuccessfully => 'トランザクションが正常に開始されました';

  @override
  String get enterAValidSubAddress => '有効なサブアドレスを入力してください';

  @override
  String get subaddressAlreadyExist => 'サブアドレスは既に存在します';

  @override
  String get labelName => 'ラベル名';

  @override
  String get subAddress => 'サブアドレス';

  @override
  String get loadingTheWallet => 'ウォレットを読み込み中…';

  @override
  String get youAreAboutToDeletenYourWallet => 'ウォレットを削除しようとしています！';

  @override
  String get creatingTheTransaction => '';

  @override
  String get copyAndSaveTheSeedToContinue => '続行するにはシードをコピーして保存してください';

  @override
  String get enterPin => 'PIN入力';

  @override
  String get test => 'テスト';

  @override
  String get success => '';

  @override
  String get connectionFailed => '';

  @override
  String get checking => '';

  @override
  String get testResult => 'テスト結果:';

  @override
  String get passwordOptional => 'パスワード（任意）';

  @override
  String get userNameOptional => 'ユーザー名（任意）';

  @override
  String get nodeNameOptional => 'ノード名（任意）';

  @override
  String get addNode => 'ノード追加';

  @override
  String get legalDisclaimer => '';

  @override
  String get howCanWenhelpYou => 'どのようにお手伝いできますか？';

  @override
  String get removeContact => '連絡先の削除';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => '選択した連絡先を削除してもよろしいですか？';

  @override
  String get theAddressAlreadyExist => 'このアドレスは既に存在します';

  @override
  String get thisNameAlreadyExist => 'この名前は既に存在します';

  @override
  String get enterAValidName => '有効な名前を入力してください';

  @override
  String get addressShouldNotBeEmpty => 'アドレスを空にすることはできません';

  @override
  String get nameShouldNotBeEmpty => '名前を空にすることはできません';

  @override
  String get enterName => '名前を入力';

  @override
  String get accountName => 'アカウント名';

  @override
  String get playStore => '';

  @override
  String get appstore => '';

  @override
  String get allowFaceIdAuthentication => '';

  @override
  String get enterAddress => 'アドレスを入力';

  @override
  String get pleaseAddAMainnetNode => '';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return '';
  }

  @override
  String get initiatingTransactionTitle => 'トランザクション開始中…';

  @override
  String get initiatingTransactionDescription => 'トランザクションが開始されるまで、このウィンドウを閉じたり、他のアプリに移動しないでください';

  @override
  String get subAddresses => '';

  @override
  String get loadingTheWalletDescription => 'このウィンドウを閉じたり、他のアプリに移動しないでください';

  @override
  String get buyBns => 'BNS購入';

  @override
  String get myBns => '';

  @override
  String get addBns => 'BNSを追加';

  @override
  String get bns => '';

  @override
  String get bnsPurchaseDescription => 'BNSレコードを購入または更新します。\n 名前を購入した場合、一覧に表示されるまでに1～2分かかることがあります。';

  @override
  String get bnsPrice => '価格';

  @override
  String get bnsYearOneShort => '1年';

  @override
  String get bnsYearTwoShort => '2年';

  @override
  String get bnsYearFiveShort => '5年';

  @override
  String get bnsYearTenShort => '10年';

  @override
  String get bnsYearOne => '';

  @override
  String get bnsYearTwo => '';

  @override
  String get bnsYearFive => '';

  @override
  String get bnsYearTen => '';

  @override
  String get bnsYouSave => '保存します';

  @override
  String get bnsNameHint => 'Beldex Name Serviceを通じて購入する名前';

  @override
  String get bnsOwnerOptional => '所有者（任意）';

  @override
  String get bnsOwnerHint => '所有者のウォレットアドレス';

  @override
  String get bnsBchatId => 'BChat ID';

  @override
  String get bnsBelnetId => 'Belnet ID';

  @override
  String get bnsEthAddress => 'ETHアドレス';

  @override
  String get bnsUpdateOwner => '所有者の更新';

  @override
  String get bnsUpdateValues => '値の更新';

  @override
  String get bnsNewOwnerHint => '新しい所有者のウォレットアドレスを入力';

  @override
  String get bnsUpdateNote => '所有者アドレスまたは値は一度にどちらか一方のみ更新できます。両方更新する場合は、所有権移転の前または後に値を更新してください。';

  @override
  String get bnsAddRecord => 'レコード追加';

  @override
  String get bnsRecordsDescription => 'このウォレットが所有するすべてのBNS名を確認できます。\n 所有しているレコードを復号すると、BNSレコード内の名前と値が表示されます。';

  @override
  String get bnsRecordNameHint => 'あなたが所有するBNS名';

  @override
  String get bnsFetchingRecords => 'ネットワークからBNSレコードを取得中';

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return '$bnsName のBNSレコードの復号に成功しました';
  }

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return '$bnsName のBNSレコードの復号に失敗しました';
  }

  @override
  String get bnsRecordNotFound => '';

  @override
  String get bnsWaitForFetch => '';

  @override
  String get bnsRecords => 'BNSレコード';

  @override
  String get bnsExpirationHeight => '有効期限ブロック高';

  @override
  String get bnsUpdateHeight => '更新ブロック高';

  @override
  String get bnsBackupOwner => 'バックアップ所有者';

  @override
  String get bnsEncryptedWalletValue => '暗号化されたウォレット値';

  @override
  String get bnsEncryptedBchatValue => '暗号化されたBChat値';

  @override
  String get bnsEncryptedBelnetValue => '暗号化されたBelnet値';

  @override
  String get bnsEncryptedEthValue => '暗号化されたETH値';

  @override
  String get bnsUpdateAction => '更新';

  @override
  String get bnsRenewAction => '更新';

  @override
  String get bnsNoteLabel => '注意：';

  @override
  String get bnsEthAddressDescription => '当社のETHアドレスはすべてのEVMチェーンに対応しています';

  @override
  String get bnsPurchase => '購入';

  @override
  String get bnsPleaseFillField => 'このフィールドを入力してください';

  @override
  String get bnsInvalidName => '';

  @override
  String get bnsInvalidBchatId => '無効なBChat ID';

  @override
  String get bnsInvalidBelnetId => '無効なBelnet ID';

  @override
  String get bnsInvalidEthAddress => '無効なETHアドレス';

  @override
  String get bnsEnterValidWalletAddress => '有効なウォレットアドレスを入力してください';

  @override
  String get bnsConfirmPurchase => '購入の確認';

  @override
  String get bnsYearLabel => '年数';

  @override
  String get bnsOwnerLabel => '所有者';

  @override
  String get bnsSameOwnerAddress => '';

  @override
  String get bnsSameWalletAddress => '';

  @override
  String get bnsSameBchatId => '';

  @override
  String get bnsSameBelnetId => '';

  @override
  String get bnsSameEthAddress => '';

  @override
  String get bnsInvalidOwnerAddress => '';

  @override
  String get bnsNameIsTaken => '';

  @override
  String get bnsInvalidWalletAddress => '';

  @override
  String get bnsOwnerAndBackupDifferent => '';

  @override
  String get bnsPurchasedSuccessfully => '';

  @override
  String get bnsUpdatedSuccessfully => '';

  @override
  String get bnsRenewedSuccessfully => '';

  @override
  String get bnsUpdate => 'BNS更新';

  @override
  String get bnsRenewal => 'BNSの更新';

  @override
  String get swap => 'スワップ';

  @override
  String get unsupportedExchangePair => '';

  @override
  String blockConfirmed(Object count) {
    return '';
  }

  @override
  String blocksConfirmed(Object count) {
    return '';
  }

  @override
  String get restoredViaKeys => 'キーから復元しました';

  @override
  String walletAlreadyExists(Object name) {
    return '$nameという名前のウォレットはすでに存在します！';
  }

  @override
  String get nodeAlreadyExists => 'このノードは既に存在します';

  @override
  String get fee => '手数料';

  @override
  String get noInternet => 'インターネット接続がありません！';

  @override
  String get noInternetMessage => 'インターネット接続を確認して再試行してください。';

  @override
  String get swapNotAvailable => '現在、BDXスワップは利用できません';

  @override
  String get tryAgain => 'しばらくしてから再度お試しください。';

  @override
  String get exchange => '交換';

  @override
  String get youSend => '送信する';

  @override
  String get youGet => '受け取る';

  @override
  String get floatingExchangeRate => '変動為替レート';

  @override
  String get floatingRateDescription => '変動レートは市場状況によりいつでも変動する可能性があり、予想より多くまたは少ない暗号資産を受け取る場合があります。';

  @override
  String get searchCoins => 'コインを検索';

  @override
  String get minimumAmount => '最小金額は';

  @override
  String get maximumAmount => '最大金額は';

  @override
  String get exchangeAmount => '';

  @override
  String get exchangeRate => '為替レート';

  @override
  String get receiver => '受取先';

  @override
  String get amountReceived => '受取金額';

  @override
  String get date => '日付';

  @override
  String get expandDetails => '詳細を展開';

  @override
  String get view => '表示';

  @override
  String get noTransactionsMessage => '表示する取引や交換はありません。';

  @override
  String get networkErrorCheckConnection => 'ネットワークエラー！インターネット接続を確認してください。';

  @override
  String get swapTransactionReport => '';

  @override
  String get transactionReport => '';

  @override
  String get failedToGetOutputDistribution => '';

  @override
  String get noPendingTransaction => '';

  @override
  String get max => '';

  @override
  String get addressCopied => '';

  @override
  String get searchCurrency => '通貨検索';

  @override
  String changePinLength(Object value) {
    return '$value桁のPINに切り替え';
  }

  @override
  String get pleaseEnterAValidHeight => '有効なブロック高を入力してください';

  @override
  String get invalidAddress => '';

  @override
  String get exchangePair => '取引ペア';

  @override
  String get payment => '支払い';

  @override
  String get bnsConfirmUpdate => '更新の確認';
}
