// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get welcome => '';

  @override
  String get first_wallet_text => '';

  @override
  String get please_make_selection => '';

  @override
  String get create_new => 'إنشاء محفظة جديدة';

  @override
  String get restore_wallet => 'استخدام محفظة موجودة';

  @override
  String get accounts => 'الحسابات';

  @override
  String get edit => 'تعديل';

  @override
  String get account => 'الحساب';

  @override
  String get add => 'إضافة';

  @override
  String get address_book => 'دفتر العناوين';

  @override
  String get contact => '';

  @override
  String get please_select => '';

  @override
  String get cancel => 'إلغاء';

  @override
  String get ok => 'موافق';

  @override
  String get contact_name => '';

  @override
  String get reset => 'عادة تعيين';

  @override
  String get save => 'حفظ';

  @override
  String get authenticated => '';

  @override
  String get authentication => '';

  @override
  String failed_authentication(Object state_error) {
    return 'فشل المصادقة. $state_error';
  }

  @override
  String get wallet_menu => '';

  @override
  String blocksRemaining(Object status) {
    return 'متبقي $status كتلة';
  }

  @override
  String get please_try_to_connect_to_another_node => 'يرجى محاولة الاتصال بعقدة أخرى';

  @override
  String get beldex_hidden => '';

  @override
  String get beldex_available_balance => '';

  @override
  String get beldex_full_balance => '';

  @override
  String get send => 'إرسال';

  @override
  String get receive => 'استلام';

  @override
  String get transactions => 'المعاملات';

  @override
  String get incoming => 'الواردة';

  @override
  String get outgoing => 'الصادرة';

  @override
  String get transactions_by_date => 'المعاملات حسب التاريخ';

  @override
  String get filters => 'تصفية حسب';

  @override
  String get today => '';

  @override
  String get yesterday => '';

  @override
  String get received => '';

  @override
  String get sent => 'تم الإرسال';

  @override
  String get pending => '';

  @override
  String get rescan => 'إعادة الفحص';

  @override
  String get reconnect => 'إعادة الاتصال';

  @override
  String get wallets => 'المحافظ';

  @override
  String get show_seed => 'عرض البذرة';

  @override
  String get show_keys => 'عرض المفاتيح';

  @override
  String get reconnection => '';

  @override
  String get reconnect_alert_text => '';

  @override
  String get reload_fiat => '';

  @override
  String get clear => 'مسح';

  @override
  String get error => '';

  @override
  String get copied_to_clipboard => '';

  @override
  String get fetching => '';

  @override
  String get id => '';

  @override
  String get amount => 'المبلغ';

  @override
  String get status => 'الحالة';

  @override
  String get confirm => '';

  @override
  String get confirm_sending => 'تأكيد الإرسال';

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
  String get faq => 'الأسئلة الشائعة';

  @override
  String get changelog => 'سجل التغييرات';

  @override
  String get loading_your_wallet => '';

  @override
  String get new_wallet => 'محفظة جديدة';

  @override
  String get wallet_name => 'اسم المحفظة';

  @override
  String get continue_text => 'متابعة';

  @override
  String get node_new => '';

  @override
  String get node_address => 'عنوان العقدة';

  @override
  String get node_port => 'منفذ العقدة';

  @override
  String get login => '';

  @override
  String get password => '';

  @override
  String get nodes => 'العقد';

  @override
  String get node_reset_settings_title => 'إعادة ضبط الإعدادات';

  @override
  String get nodes_list_reset_to_default_message => 'هل أنت متأكد أنك تريد إعادة ضبط الإعدادات إلى الوضع الافتراضي؟';

  @override
  String change_current_node(Object node) {
    return 'هل أنت متأكد من أنك تريد تغيير العقدة الحالية إلى $node؟';
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
  String get delete => 'حذف';

  @override
  String get use => '';

  @override
  String get digit_pin => '';

  @override
  String get share_address => '';

  @override
  String get subaddresses => '';

  @override
  String get restore_restore_wallet => 'استعادة المحفظة';

  @override
  String get restore_title_from_seed_keys => ' استعادة من العبارة السرية/المفاتيح';

  @override
  String get restore_description_from_seed_keys => 'استرجع محفظتك باستخدام العبارة السرية/المفاتيح التي قمت بحفظها في مكان آمن';

  @override
  String get restore_next => 'التالي';

  @override
  String get restore_title_from_backup => '';

  @override
  String get restore_description_from_backup => '';

  @override
  String get restore_seed_keys_restore => '';

  @override
  String get restore_title_from_seed => ' استعادة من العبارة السرية';

  @override
  String get restore_description_from_seed => ' استخدم المفتاح التذكّري المكوّن من 25 كلمة أو عبارة الاسترداد لاستعادة محفظتك';

  @override
  String get restore_title_from_keys => 'استعادة من المفاتيح';

  @override
  String get restore_description_from_keys => ' استخدم ضغطات المفاتيح المُولّدة والمحفوظة من المفاتيح الخاصة لاستعادة محفظتك';

  @override
  String get restore_address => ' العنوان';

  @override
  String get restore_recover => 'استعادة';

  @override
  String get restore_wallet_restore_description => '';

  @override
  String get seed_title => 'العبارة الأولية';

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
  String get send_beldex_address => 'عنوان Beldex أو اسم BNS';

  @override
  String get all => '';

  @override
  String get send_error_currency => '';

  @override
  String get send_estimated_fee => 'الرسوم المقدّرة';

  @override
  String send_priority(Object transactionPriority) {
    return 'تم تعيين أولوية $transactionPriority كرسوم افتراضية. انتقل إلى الإعدادات لتغيير أولوية المعاملة.';
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
  String get settings_title => 'الإعدادات';

  @override
  String get settings_current_node => 'العقد الحالي';

  @override
  String get settings_display_balance_as => 'عرض الرصيد ك';

  @override
  String get settings_balance_detail => 'بحث عن العملة';

  @override
  String get settings_currency => 'بحث عن العملة';

  @override
  String get settings_fee_priority => 'أولوية الرسوم';

  @override
  String get settings_save_recipient_address => 'حفظ عنوان المستلم';

  @override
  String get settings_personal => 'الشخصية';

  @override
  String get settings_change_pin => ' تغيير الرقم السري';

  @override
  String get settings_allow_biometric_authentication => 'السماح بالمصادقة البيومترية';

  @override
  String get settings_dark_mode => 'الوضع الليلي';

  @override
  String get settings_display_on_dashboard_list => '';

  @override
  String get settings_none => '';

  @override
  String get settings_support => 'الوضع الليلي';

  @override
  String get settings_terms_and_conditions => 'الشروط والأحكام';

  @override
  String get settings_enable_fiat_currency => 'عرض الرصيد ك';

  @override
  String get pin_is_incorrect => ' رمز PIN غير صحيح';

  @override
  String get amount_detail_ultra => '';

  @override
  String get amount_detail_none => '';

  @override
  String get amount_detail_detailed => '';

  @override
  String get amount_detail_normal => '';

  @override
  String get setup_pin => 'إعداد رمز PIN';

  @override
  String get re_enter_your_pin => 'أعد إدخال رمز PIN الخاص بك';

  @override
  String get setup_successful => 'تم إعداد رمز PIN الخاص بك بنجاح!';

  @override
  String get wallet_keys => 'مفاتيح المحفظة';

  @override
  String get view_key_private => ' مفتاح العرض (خاص)';

  @override
  String get view_key_public => 'عرض المفتاح (عام):';

  @override
  String get spend_key_private => ' مفتاح الإنفاق (خاص)';

  @override
  String get spend_key_public => ' مفتاح الإنفاق (عام):';

  @override
  String copied_key_to_clipboard(Object key) {
    return '';
  }

  @override
  String get new_subaddress_title => '';

  @override
  String get new_subaddress_create => 'إنشاء';

  @override
  String get subaddress_title => '';

  @override
  String get transaction_details_title => '';

  @override
  String get transaction_details_transaction_id => 'معرّف المعاملة';

  @override
  String get transaction_details_height => 'الارتفاع';

  @override
  String get transaction_details_amount => 'تم الإرسال';

  @override
  String get transaction_details_payment_id => '';

  @override
  String transaction_details_copied(Object title) {
    return '';
  }

  @override
  String get transaction_details_recipient_address => 'عنوان المستلم';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return 'يرجى التأكد من إدخال العنوان الصحيح للسلسلة المحددة - $blockchain. وإلا ستفقد أموالك.';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return 'أدخل عنوان المستلم لـ $currency';
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
  String get swap_transaction_preview => 'معاينة المعاملة';

  @override
  String get swap_exchange_rate => 'سعر الصرف';

  @override
  String get swap_service_fee => 'رسوم الخدمة 0.25%';

  @override
  String get service_fee => 'رسوم الخدمة 0.25%';

  @override
  String get network_fee => 'رسوم الشبكة';

  @override
  String get swap_refund_address => '';

  @override
  String get swap_network_fee => 'رسوم الشبكة';

  @override
  String get swap_you_get => 'أنت تحصل على';

  @override
  String get swap_checkout => 'إتمام الدفع';

  @override
  String get swap_network_label => 'الشبكة: ';

  @override
  String get swap_estimated_time => '';

  @override
  String get swap_estimated_time_value => '';

  @override
  String get swap_confirm_and_make_payment => 'تأكيد وإجراء الدفع';

  @override
  String get swap_send_funds_to_address_below => 'أرسل الأموال إلى العنوان أدناه';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return 'الوقت المتبقي لإرسال $amount $currency';
  }

  @override
  String swap_time_remaining(Object value) {
    return 'الوقت المتبقي: $value';
  }

  @override
  String get swap_send_funds_notice => 'لديك 3 ساعات لإرسال الأموال\nوإلا سيتم إلغاء المعاملة تلقائيًا.\nسيتم بدء عملية التبادل بمجرد\nاستلام الأموال.';

  @override
  String get swap_confirmations => '';

  @override
  String get swap_completed => 'مكتمل';

  @override
  String get swap_amount_from => 'المبلغ المُرسل';

  @override
  String get swap_amount_to => 'المبلغ المستلم';

  @override
  String get swap_received_time => 'وقت الاستلام';

  @override
  String get swap_amount_sent => 'المبلغ المرسل';

  @override
  String get swap_input_output_hash => 'هاش الإدخال/الإخراج';

  @override
  String get swap_input_hash => 'هاش الإدخال';

  @override
  String get swap_output_hash => 'هاش الإخراج';

  @override
  String get swap_failed => 'فشل';

  @override
  String get swap_expired => '';

  @override
  String get swap_overdue => '';

  @override
  String get swap_funds_not_received => 'لم يتم استلام الأموال خلال 3\nساعات. يرجى التحقق من الأسعار وإنشاء\nمعاملة جديدة';

  @override
  String get swap_start_over => 'ابدأ من جديد';

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
  String get swap_open_history => 'عرض السجل';

  @override
  String get swap_new_transaction => 'معاملة جديدة';

  @override
  String get swap_i_agree_with => 'أوافق على';

  @override
  String get swap_terms_of_use => 'شروط الاستخدام';

  @override
  String get swap_and => 'و';

  @override
  String get swap_privacy_policy => 'سياسة الخصوصية';

  @override
  String get wallet_list_title => ' محفظة Beldex';

  @override
  String get wallet_list_load_wallet => 'تحميل المحفظة';

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
  String get widgets_restore_from_blockheight => 'الاستعادة من رقم الكتلة ';

  @override
  String get widgets_restore_from_date => 'الاستعادة من التاريخ';

  @override
  String get widgets_or => '';

  @override
  String router_no_route(Object name) {
    return '';
  }

  @override
  String get error_text_account_name => '';

  @override
  String get error_text_contact_name => 'لا يجوز أن يحتوي اسم جهة الاتصال على الرموز \' و \"\nويجب أن يتراوح طوله بين 1 و 32\nحرفاً';

  @override
  String get error_text_address => ' عنوان BDX غير صالح';

  @override
  String get error_text_node_address => ' الرجاء إدخال عنوان IPv4 صالح';

  @override
  String get error_text_node_port => 'لا يمكن أن يحتوي منفذ العقدة إلا على أرقام بين 0 و65535';

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
  String get error_text_keys => ' يجب أن تحتوي مفاتيح المحفظة على 64 حرفًا سداسيًا فقط';

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
  String get full_balance => 'الرصيد الكامل';

  @override
  String get available_balance => 'الرصيد المتاح';

  @override
  String get hidden_balance => 'الرصيد المخفي';

  @override
  String get sync_status_synchronizing => 'جارٍ المزامنة';

  @override
  String get sync_status_synchronized => 'تمت المزامنة';

  @override
  String get sync_status_not_connected => '';

  @override
  String get sync_status_starting_sync => 'بدء المزامنة';

  @override
  String get sync_status_failed_connect => 'فشل الاتصال بالعقدة';

  @override
  String get sync_status_connecting => 'جارٍ الاتصال';

  @override
  String get sync_status_connected => '';

  @override
  String get transaction_priority_slow => 'بطيء';

  @override
  String get transaction_priority_blink => 'فلاش';

  @override
  String get change_language => 'تغيير اللغة';

  @override
  String change_language_to(Object language) {
    return '';
  }

  @override
  String get paste => 'لصق';

  @override
  String get restore_from_seed_placeholder => 'يرجى إدخال أو لصق العبارة السرية هنا';

  @override
  String get add_new_word => '';

  @override
  String get incorrect_seed => '';

  @override
  String get biometric_auth_reason => '';

  @override
  String version(Object currentVersion) {
    return 'الإصدار $currentVersion';
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
  String get yes_im_sure => 'نعم، أنا متأكد!';

  @override
  String never_give_your(Object item) {
    return 'لا تعطِ $item الخاص بمحفظة Beldex لأي شخص أبدًا!';
  }

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'لا تُدخل أبدًا $item الخاص بمحفظة Beldex في أي برنامج أو موقع إلكتروني باستثناء محافظ Beldex الرسمية التي يتم تنزيلها مباشرةً من $app_store أو موقع Beldex أو GitHub الخاص بـ Beldex. هل أنت متأكد من أنك تريد الوصول إلى محفظتك $item؟';
  }

  @override
  String get keys_title => '';

  @override
  String get are_you_sure => 'هل أنت متأكد؟';

  @override
  String get do_you_want_to_exit_an_app => '';

  @override
  String get no => 'لا';

  @override
  String get yes => 'نعم';

  @override
  String get byUsingThisAppYouAgreeToTheTermsOf => '';

  @override
  String get iAgreeToTermsOfUse => '';

  @override
  String get accept => '';

  @override
  String get pleaseEnterAValidAmount => 'يرجى إدخال مبلغ صالح';

  @override
  String get pleaseEnterAValidSeed => 'يرجى إدخال عبارة سرية صالحة';

  @override
  String get changeWallet => 'تغيير المحفظة';

  @override
  String get removeWallet => 'إزالة المحفظة';

  @override
  String get reconnectWallet => 'عادة الاتصال بالمحفظة';

  @override
  String get rescanWallet => 'إعادة فحص المحفظة';

  @override
  String get enterWalletName => 'أدخل اسم المحفظة';

  @override
  String get noTransactionsYet => 'لا توجد معاملات حتى الآن!';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'عد إتمام معاملتك الأولى، ستتمكن\nمن عرضها هنا.';

  @override
  String get copied => 'تم النسخ';

  @override
  String get addAddress => 'إضافة عنوان';

  @override
  String get important => '';

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'لا تُدخل $item الخاص بمحفظة Beldex في أي برنامج أو موقع إلكتروني باستثناء محافظ Beldex الرسمية التي يتم تنزيلها مباشرةً من $appStore أو موقع Beldex الإلكتروني أو GitHub الخاص بـ Beldex.';
  }

  @override
  String get enterWalletName_ => 'أدخل اسم المحفظة';

  @override
  String get chooseSeedLanguage => 'اختر لغة العبارة السرية';

  @override
  String get wallet => 'المحفظة';

  @override
  String get seedKeys => 'البذرة والمفاتيح';

  @override
  String get walletAddress => 'عنوان المحفظة';

  @override
  String get recoverySeedkey => 'عبارة الاسترداد/مفتاح الاسترداد';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get welcomeToBeldexWallet => 'مرحبًا بك في محفظة Beldex :)';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'اختر خيارًا لإنشاء أو استعادة\n محفظة موجودة';

  @override
  String get enterAValidNameUpto15Characters => 'أدخل اسمًا صالحًا حتى 15 حرفًا';

  @override
  String get enterAValidNameUpto20Characters => 'أدخل اسمًا صالحًا بحد أقصى 20 حرفًا';

  @override
  String get fiveDecimals => '5 - خمسة (0.00000)';

  @override
  String get fourDecimals => ' 4 - أربعة (0.0000)';

  @override
  String get twoDecimals => '2 - اثنان (0.00)';

  @override
  String get zeroDecimal => ' 0 - صفر (000)';

  @override
  String get doYouWantToExitTheWallet => 'هل تريد الخروج من المحفظة؟';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => ' تأكد من أخذ نسخة احتياطية من بذرة الاسترداد، عنوان المحفظة، والمفاتيح الخاصة.';

  @override
  String blockRemaining(Object status) {
    return '';
  }

  @override
  String get flashTransaction => 'معاملة سريعة';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => ' قم بتحويل BDX الخاص بك بشكل أسرع باستخدام المعاملة السريعة!';

  @override
  String get enterYourPin => 'أدخل رمز PIN الخاص بك';

  @override
  String get walletSettings => 'إعدادات المحفظة';

  @override
  String get recoverySeed => 'الـ Seed للاستعادة';

  @override
  String get youDontHaveEnoughUnlockedBalance => '';

  @override
  String get alert => 'تنبيه';

  @override
  String get touchTheFingerprintSensor => '';

  @override
  String get usePattern => '';

  @override
  String get enterBdxToSend => 'أدخل BDX للإرسال';

  @override
  String get enterAmount => ' أدخل المبلغ';

  @override
  String get pleaseEnterAAmount => 'يرجى إدخال مبلغ';

  @override
  String get committingTheTransaction => '';

  @override
  String get availableBdx => 'BDX المتاح:';

  @override
  String get pleaseEnterABdxAddress => ' يرجى إدخال عنوان BDX';

  @override
  String get enterAValidAddress => '';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'ميزة القياسات الحيوية معطّلة حاليًا.\n يرجى تمكين ميزة المصادقة البيومترية\n من داخل إعدادات التطبيق';

  @override
  String get unlockBeldexWallet => '';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => '';

  @override
  String get doYouWantToChangeYournPrimaryAccount => ' هل تريد تغيير الحساب الأساسي؟';

  @override
  String get rename => '';

  @override
  String get addAccount => 'إضافة حساب';

  @override
  String get noAddressesInBook => 'لا توجد عناوين في الدفتر';

  @override
  String get bdx => '';

  @override
  String get howeverWeRecommendToScanTheBlockchainFromTheBlock => '';

  @override
  String get youHaveScannedFromTheBlockHeight => '';

  @override
  String get syncInfo => '';

  @override
  String get doYouWantToReconnectnTheWallet => 'هل تريد إعادة الاتصال بالمحفظة؟';

  @override
  String get enterValidNameUpto15Characters => 'أدخل اسمًا صالحًا بحد أقصى 15 حرفًا';

  @override
  String get checkingNodeConnection => '';

  @override
  String get enterBdxToReceive => 'أدخل BDX للاستلام';

  @override
  String get addSubAddress => 'إضافة عنوان فرعي';

  @override
  String get shareQr => 'مشاركة ';

  @override
  String get name => 'الاسم';

  @override
  String get enterValidHeightWithoutSpace => 'أدخل رقم كتلة صالح بدون مسافات';

  @override
  String get dateShouldNotBeEmpty => ' يجب ألا يكون التاريخ فارغً';

  @override
  String get walletRestore => 'استعادة المحفظة';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => '';

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'لا تشارك العبارة السرية مع أي شخص!\nتأكد من محيطك لضمان عدم وجود\nمن يراقبك';

  @override
  String get note => 'ملاحظة:';

  @override
  String get copySeed => 'نسخ العبارة السرية';

  @override
  String get accountAlreadyExist => 'الحساب موجود بالفعل';

  @override
  String get transactionInitiatedSuccessfully => 'تم بدء المعاملة بنجاح';

  @override
  String get enterAValidSubAddress => 'أدخل عنوانًا فرعيًا صالحًا';

  @override
  String get subaddressAlreadyExist => 'العنوان الفرعي موجود بالفعل';

  @override
  String get labelName => 'اسم التسمية';

  @override
  String get subAddress => 'العنوان الفرعي';

  @override
  String get loadingTheWallet => 'جارٍ تحميل المحفظة…';

  @override
  String get youAreAboutToDeletenYourWallet => 'أنت على وشك حذف محفظتك!';

  @override
  String get creatingTheTransaction => '';

  @override
  String get copyAndSaveTheSeedToContinue => 'قم بنسخ وحفظ العبارة السرية للمتابعة';

  @override
  String get enterPin => 'أدخل الرقم السري';

  @override
  String get test => 'اختبار';

  @override
  String get success => '';

  @override
  String get connectionFailed => '';

  @override
  String get checking => '';

  @override
  String get testResult => 'نتيجة الاختبار:';

  @override
  String get passwordOptional => ' كلمة المرور (اختياري)';

  @override
  String get userNameOptional => 'اسم المستخدم (اختياري)';

  @override
  String get nodeNameOptional => ' اسم العقدة (اختياري)';

  @override
  String get addNode => 'إضافة عقدة';

  @override
  String get legalDisclaimer => '';

  @override
  String get howCanWenhelpYou => 'كيف يمكننا مساعدتك؟';

  @override
  String get removeContact => 'إزالة جهة اتصال';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => 'هل أنت متأكد من رغبتك في إزالة جهة\nالاتصال المحددة؟';

  @override
  String get theAddressAlreadyExist => 'العنوان موجود بالفعل';

  @override
  String get thisNameAlreadyExist => 'هذا الاسم موجود بالفعل';

  @override
  String get enterAValidName => 'أدخل اسماً صالحاً';

  @override
  String get addressShouldNotBeEmpty => 'يجب ألا يكون حقل العنوان فارغاً';

  @override
  String get nameShouldNotBeEmpty => 'يجب ألا يكون حقل الاسم فارغاً';

  @override
  String get enterName => 'أدخل اسماً صالحاً';

  @override
  String get accountName => 'اسم الحساب';

  @override
  String get playStore => '';

  @override
  String get appstore => '';

  @override
  String get allowFaceIdAuthentication => '';

  @override
  String get enterAddress => 'أدخل العنوان';

  @override
  String get pleaseAddAMainnetNode => '';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return '';
  }

  @override
  String get initiatingTransactionTitle => 'جارٍ بدء المعاملة..';

  @override
  String get initiatingTransactionDescription => ' يرجى عدم إغلاق هذه النافذة أو الانتقال\n إلى تطبيق آخر حتى يتم بدء المعاملة';

  @override
  String get subAddresses => '';

  @override
  String get loadingTheWalletDescription => ' يرجى عدم إغلاق هذه النافذة أو الانتقال إلى تطبيق آخر حتى يتم تحميل المحفظة';

  @override
  String get buyBns => ' شراء BNS';

  @override
  String get myBns => '';

  @override
  String get addBns => 'إضافة BNSجارٍ جلب سجل BNS من الشبكة\n';

  @override
  String get bns => '';

  @override
  String get bnsPurchaseDescription => 'شراء أو تحديث سجل BNS.\n إذا قمت بشراء اسم، قد يستغرق الأمر دقيقة أو دقيقتين حتى يظهر في القائمة.';

  @override
  String get bnsPrice => 'سعر';

  @override
  String get bnsYearOneShort => '1 سنة';

  @override
  String get bnsYearTwoShort => ' 2 سنة';

  @override
  String get bnsYearFiveShort => '5 سنوات';

  @override
  String get bnsYearTenShort => '10 سنوات';

  @override
  String get bnsYearOne => '';

  @override
  String get bnsYearTwo => '';

  @override
  String get bnsYearFive => '';

  @override
  String get bnsYearTen => '';

  @override
  String get bnsYouSave => 'أنت أحفظ';

  @override
  String get bnsNameHint => ' الاسم الذي تريد شراؤه عبر خدمة Beldex Name Service';

  @override
  String get bnsOwnerOptional => 'المالك (اختياري)';

  @override
  String get bnsOwnerHint => 'عنوان المحفظة للمالك';

  @override
  String get bnsBchatId => ' معرّف BChat';

  @override
  String get bnsBelnetId => 'معرّف Belnet';

  @override
  String get bnsEthAddress => 'عنوان ETH';

  @override
  String get bnsUpdateOwner => 'تحديث المالك';

  @override
  String get bnsUpdateValues => 'تحديث القيم';

  @override
  String get bnsNewOwnerHint => 'أدخل عنوان المحفظة للمالك الجديد';

  @override
  String get bnsUpdateNote => 'يمكنك تحديث عنوان المالك أو القيم مرة واحدة فقط. إذا أردت تحديث كلاهما، يمكنك تحديث القيم قبل نقل الملكية أو بعد نقل الملكية.';

  @override
  String get bnsAddRecord => 'إضافة سجل';

  @override
  String get bnsRecordsDescription => 'هنا يمكنك العثور على جميع أسماء BNS التي تمتلكها هذه المحفظة.\n فك تشفير سجل تمتلكه سيعيد الاسم والقيمة في سجل BNS.';

  @override
  String get bnsRecordNameHint => ' اسم BNS يخصك';

  @override
  String get bnsFetchingRecords => 'جارٍ جلب سجل BNS من الشبكة';

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return 'تم فك تشفير سجل BNS لـ $bnsName بنجاح';
  }

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return 'فشل فك تشفير سجل BNS لـ $bnsName';
  }

  @override
  String get bnsRecordNotFound => '';

  @override
  String get bnsWaitForFetch => '';

  @override
  String get bnsRecords => 'سجلات BNS';

  @override
  String get bnsExpirationHeight => 'ارتفاع انتهاء الصلاحية';

  @override
  String get bnsUpdateHeight => 'ارتفاع التحديث';

  @override
  String get bnsBackupOwner => 'المالك الاحتياطي';

  @override
  String get bnsEncryptedWalletValue => 'قيمة المحفظة المشفرة';

  @override
  String get bnsEncryptedBchatValue => ' القيمة المشفرة لـ BChat';

  @override
  String get bnsEncryptedBelnetValue => ' القيمة المشفرة لـ Belnet';

  @override
  String get bnsEncryptedEthValue => ' القيمة المشفرة لـ ETH';

  @override
  String get bnsUpdateAction => 'تحديث';

  @override
  String get bnsRenewAction => 'تجديد';

  @override
  String get bnsNoteLabel => 'ملاحظة: ';

  @override
  String get bnsEthAddressDescription => 'عنوان ETH الخاص بنا متوافق عبر جميع شبكات EVM';

  @override
  String get bnsPurchase => 'شراء';

  @override
  String get bnsPleaseFillField => 'يرجى تعبئة هذا الحقل';

  @override
  String get bnsInvalidName => '';

  @override
  String get bnsInvalidBchatId => ' معرّف BChat غير صالح';

  @override
  String get bnsInvalidBelnetId => ' معرّف Belnet غير صالح';

  @override
  String get bnsInvalidEthAddress => ' عنوان ETH غير صالح';

  @override
  String get bnsEnterValidWalletAddress => 'أدخل عنوان محفظة صالح.';

  @override
  String get bnsConfirmPurchase => 'تأكيد الشراء';

  @override
  String get bnsYearLabel => 'السنة';

  @override
  String get bnsOwnerLabel => 'المالك';

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
  String get bnsUpdate => 'تحديث BNS';

  @override
  String get bnsRenewal => 'تجديد BNS';

  @override
  String get swap => ' تبديل';

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
  String get restoredViaKeys => 'لقد قمت بالاستعادة باستخدام المفاتيح';

  @override
  String walletAlreadyExists(Object name) {
    return 'توجد محفظة بالاسم $name بالفعل!';
  }

  @override
  String get nodeAlreadyExists => 'هذه العقدة موجودة بالفعل';

  @override
  String get fee => 'الرسوم';

  @override
  String get noInternet => 'لا يوجد اتصال بالإنترنت!';

  @override
  String get noInternetMessage => 'يرجى التحقق من اتصالك بالإنترنت\nوالمحاولة مرة أخرى';

  @override
  String get swapNotAvailable => 'تبديل BDX غير متاح في الوقت الحالي';

  @override
  String get tryAgain => 'يرجى المحاولة مرة أخرى لاحقًا';

  @override
  String get exchange => 'تبادل';

  @override
  String get youSend => 'أنت ترسل';

  @override
  String get youGet => 'تحصل على';

  @override
  String get floatingExchangeRate => 'سعر صرف عائم';

  @override
  String get floatingRateDescription => 'يمكن أن يتغير السعر العائم في أي وقت\nبسبب ظروف السوق، لذلك قد\nتتلقى عملات رقمية أكثر أو أقل من المتوقع';

  @override
  String get searchCoins => 'ابحث عن العملات';

  @override
  String get minimumAmount => 'الحد الأدنى للمبلغ هو';

  @override
  String get maximumAmount => 'الحد الأقصى للمبلغ هو';

  @override
  String get exchangeAmount => '';

  @override
  String get exchangeRate => 'سعر الصرف';

  @override
  String get receiver => 'المستلم';

  @override
  String get amountReceived => 'المبلغ المستلم';

  @override
  String get date => 'التاريخ';

  @override
  String get expandDetails => 'عرض التفاصيل';

  @override
  String get view => 'عرض';

  @override
  String get noTransactionsMessage => 'لا توجد معاملات أو عمليات تبادل\nلعرضها..';

  @override
  String get networkErrorCheckConnection => 'خطأ في الشبكة! يرجى التحقق من اتصال الإنترنت';

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
  String get searchCurrency => 'بحث عن العملة';

  @override
  String changePinLength(Object value) {
    return 'التبديل إلى رمز PIN مكوّن من $value أرقام';
  }

  @override
  String get pleaseEnterAValidHeight => 'يرجى إدخال رقم كتلة صالح';

  @override
  String get invalidAddress => 'عنوان غير صالح';

  @override
  String get exchangePair => 'زوج التبادل';

  @override
  String get payment => 'الدفع';

  @override
  String get bnsConfirmUpdate => 'تأكيد التحديث';
}
