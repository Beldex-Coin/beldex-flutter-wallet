// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get welcome => '';

  @override
  String get first_wallet_text => '';

  @override
  String get please_make_selection => '';

  @override
  String get create_new => 'Yeni Cüzdan Oluştur';

  @override
  String get restore_wallet => 'Mevcut Cüzdanı Kullan';

  @override
  String get accounts => 'Hesaplar';

  @override
  String get edit => 'Düzenle';

  @override
  String get account => 'Hesap';

  @override
  String get add => 'Ekle';

  @override
  String get address_book => 'Adres Defteri';

  @override
  String get contact => '';

  @override
  String get please_select => '';

  @override
  String get cancel => 'İptal';

  @override
  String get ok => 'Tamam';

  @override
  String get contact_name => '';

  @override
  String get reset => 'Sıfırla';

  @override
  String get save => 'Kaydet';

  @override
  String get authenticated => '';

  @override
  String get authentication => '';

  @override
  String failed_authentication(Object state_error) {
    return 'Kimlik doğrulama başarısız. $state_error';
  }

  @override
  String get wallet_menu => '';

  @override
  String blocksRemaining(Object status) {
    return '$status Blok Kaldı';
  }

  @override
  String get please_try_to_connect_to_another_node => 'Lütfen başka bir node’a bağlanmayı deneyin';

  @override
  String get beldex_hidden => '';

  @override
  String get beldex_available_balance => '';

  @override
  String get beldex_full_balance => '';

  @override
  String get send => 'Gönder';

  @override
  String get receive => 'Al';

  @override
  String get transactions => 'İşlemler';

  @override
  String get incoming => 'Gelen';

  @override
  String get outgoing => 'Giden';

  @override
  String get transactions_by_date => 'Tarihe Göre İşlemler';

  @override
  String get filters => 'Filtrele';

  @override
  String get today => '';

  @override
  String get yesterday => '';

  @override
  String get received => '';

  @override
  String get sent => 'Gönderildi';

  @override
  String get pending => '';

  @override
  String get rescan => 'Yeniden Tara';

  @override
  String get reconnect => 'Yeniden Bağlan';

  @override
  String get wallets => 'Cüzdanlar';

  @override
  String get show_seed => 'Seed’i Göster';

  @override
  String get show_keys => 'Anahtarları Göster';

  @override
  String get reconnection => '';

  @override
  String get reconnect_alert_text => '';

  @override
  String get reload_fiat => '';

  @override
  String get clear => 'Temizle';

  @override
  String get error => '';

  @override
  String get copied_to_clipboard => '';

  @override
  String get fetching => '';

  @override
  String get id => '';

  @override
  String get amount => 'Miktar';

  @override
  String get status => 'Durum:';

  @override
  String get confirm => '';

  @override
  String get confirm_sending => 'Gönderimi Onayla';

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
  String get faq => 'SSS';

  @override
  String get changelog => 'Değişiklik Günlüğü';

  @override
  String get loading_your_wallet => '';

  @override
  String get new_wallet => 'Yeni Cüzdan';

  @override
  String get wallet_name => 'Cüzdan Adı';

  @override
  String get continue_text => 'Devam Et';

  @override
  String get node_new => '';

  @override
  String get node_address => 'Düğüm Adresi';

  @override
  String get node_port => 'Düğüm Portu';

  @override
  String get login => '';

  @override
  String get password => '';

  @override
  String get nodes => 'Düğümler';

  @override
  String get node_reset_settings_title => 'Ayarları Sıfırla';

  @override
  String get nodes_list_reset_to_default_message => 'Ayarları varsayılanlara sıfırlamak istediğinizden emin misiniz?';

  @override
  String change_current_node(Object node) {
    return 'Mevcut düğümü $node olarak değiştirmek istediğinizden emin misiniz?';
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
  String get delete => 'Sil';

  @override
  String get use => '';

  @override
  String get digit_pin => '';

  @override
  String get share_address => '';

  @override
  String get subaddresses => '';

  @override
  String get restore_restore_wallet => 'Cüzdanı Geri Yükle';

  @override
  String get restore_title_from_seed_keys => 'Seed/anahtarlar ile geri yükle';

  @override
  String get restore_description_from_seed_keys => 'Cüzdanınızı, güvenli bir yerde sakladığınız seed/anahtarlar ile geri alın.';

  @override
  String get restore_next => 'İleri';

  @override
  String get restore_title_from_backup => '';

  @override
  String get restore_description_from_backup => '';

  @override
  String get restore_seed_keys_restore => '';

  @override
  String get restore_title_from_seed => 'Seed’den Geri Yükle';

  @override
  String get restore_description_from_seed => 'Cüzdanınızı geri yüklemek için 25 kelimelik Mnemonik anahtarınızı veya Seed ifadenizi kullanın.';

  @override
  String get restore_title_from_keys => 'Anahtarlardan Geri Yükle';

  @override
  String get restore_description_from_keys => 'Cüzdanınızı geri yüklemek için özel anahtarlardan kaydedilmiş keystroke’ları kullanın.';

  @override
  String get restore_address => 'Adres';

  @override
  String get restore_recover => 'Geri Yükle';

  @override
  String get restore_wallet_restore_description => '';

  @override
  String get seed_title => 'Seed';

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
  String get send_beldex_address => 'Beldex adresi veya BNS adı';

  @override
  String get all => '';

  @override
  String get send_error_currency => '';

  @override
  String get send_estimated_fee => 'Tahmini Ücret:';

  @override
  String send_priority(Object transactionPriority) {
    return '$transactionPriority önceliği varsayılan ücret olarak ayarlandı. İşlem önceliğini değiştirmek için ayarlara gidin.';
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
  String get settings_title => 'Ayarlar';

  @override
  String get settings_current_node => 'Mevcut düğüm';

  @override
  String get settings_display_balance_as => 'Bakiyeyi Gösterme Şekli';

  @override
  String get settings_balance_detail => 'Ondalık Basamaklar';

  @override
  String get settings_currency => 'Para Birimi';

  @override
  String get settings_fee_priority => 'Ücret Önceliği';

  @override
  String get settings_save_recipient_address => 'Alıcı adresini kaydet';

  @override
  String get settings_personal => 'Kişisel';

  @override
  String get settings_change_pin => 'PIN Değiştir';

  @override
  String get settings_allow_biometric_authentication => 'Biyometrik kimlik doğrulamaya izin ver';

  @override
  String get settings_dark_mode => 'Karanlık Mod';

  @override
  String get settings_display_on_dashboard_list => '';

  @override
  String get settings_none => '';

  @override
  String get settings_support => 'Destek';

  @override
  String get settings_terms_and_conditions => 'Şartlar ve Koşullar';

  @override
  String get settings_enable_fiat_currency => 'Düz Para Birimi Dönüşümünü Etkinleştir';

  @override
  String get pin_is_incorrect => 'PIN yanlış';

  @override
  String get amount_detail_ultra => '';

  @override
  String get amount_detail_none => '';

  @override
  String get amount_detail_detailed => '';

  @override
  String get amount_detail_normal => '';

  @override
  String get setup_pin => 'PIN Ayarla';

  @override
  String get re_enter_your_pin => 'PIN’inizi tekrar girin';

  @override
  String get setup_successful => 'PIN’iniz başarıyla ayarlandı!';

  @override
  String get wallet_keys => 'Cüzdan Anahtarları';

  @override
  String get view_key_private => 'Görüntüleme Anahtarı (özel)';

  @override
  String get view_key_public => 'Görüntüleme anahtarı (genel)';

  @override
  String get spend_key_private => 'Harcama Anahtarı (özel)';

  @override
  String get spend_key_public => 'Harcama anahtarı (genel)';

  @override
  String copied_key_to_clipboard(Object key) {
    return '';
  }

  @override
  String get new_subaddress_title => '';

  @override
  String get new_subaddress_create => 'Oluştur';

  @override
  String get subaddress_title => '';

  @override
  String get transaction_details_title => '';

  @override
  String get transaction_details_transaction_id => 'İşlem Kimliği';

  @override
  String get transaction_details_height => 'Yüksekliği';

  @override
  String get transaction_details_amount => 'Tutar';

  @override
  String get transaction_details_payment_id => '';

  @override
  String transaction_details_copied(Object title) {
    return '';
  }

  @override
  String get transaction_details_recipient_address => 'Alıcı Adresi';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return 'Seçilen zincir - $blockchain için doğru adresi girdiğinizden emin olun. Aksi takdirde varlıklarınızı kaybedebilirsiniz.';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return '$currency alıcı adresinizi girin';
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
  String get swap_exchange_rate => 'Döviz Kuru';

  @override
  String get swap_service_fee => 'Hizmet Ücreti %0,25';

  @override
  String get service_fee => 'Hizmet Ücreti %0,25';

  @override
  String get network_fee => 'Ağ Ücreti';

  @override
  String get swap_refund_address => '';

  @override
  String get swap_network_fee => 'Ağ Ücreti';

  @override
  String get swap_you_get => 'Alacağınız';

  @override
  String get swap_checkout => 'Ödeme Sayfası';

  @override
  String get swap_network_label => 'AĞ: ';

  @override
  String get swap_estimated_time => '';

  @override
  String get swap_estimated_time_value => '';

  @override
  String get swap_confirm_and_make_payment => 'Onayla ve Ödeme Yap';

  @override
  String get swap_send_funds_to_address_below => 'Aşağıdaki adrese fon gönderin';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return '$amount $currency göndermek için kalan süre';
  }

  @override
  String swap_time_remaining(Object value) {
    return 'Kalan Süre: $value';
  }

  @override
  String get swap_send_funds_notice => 'Fon göndermek için 3 saatiniz var, aksi takdirde işlem otomatik olarak iptal edilecektir.\nFonlar alındıktan sonra işlem başlatılacaktır.';

  @override
  String get swap_confirmations => '';

  @override
  String get swap_completed => 'İşlem Kimliği';

  @override
  String get swap_amount_from => 'Gönderilen Tutar';

  @override
  String get swap_amount_to => 'Alınan Tutar';

  @override
  String get swap_received_time => 'Gönderilen Tutar';

  @override
  String get swap_amount_sent => 'Döviz Kuru';

  @override
  String get swap_input_output_hash => 'Girdi/Çıktı Hash';

  @override
  String get swap_input_hash => 'Girdi Hash';

  @override
  String get swap_output_hash => 'Çıktı Hash';

  @override
  String get swap_failed => 'Başarısız';

  @override
  String get swap_expired => '';

  @override
  String get swap_overdue => '';

  @override
  String get swap_funds_not_received => 'Fonlar 3 saat içinde alınmadı. Lütfen oranları kontrol edin ve yeni bir işlem oluşturun.';

  @override
  String get swap_start_over => 'Yeniden Başlat';

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
  String get swap_open_history => 'Geçmişi Aç';

  @override
  String get swap_new_transaction => 'Yeni İşlem';

  @override
  String get swap_i_agree_with => 'Kabul ediyorum';

  @override
  String get swap_terms_of_use => 'Kullanım Koşulları';

  @override
  String get swap_and => 've';

  @override
  String get swap_privacy_policy => 'Gizlilik Politikası';

  @override
  String get wallet_list_title => 'Beldex Cüzdanı';

  @override
  String get wallet_list_load_wallet => 'Cüzdan Yükle';

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
  String get widgets_restore_from_blockheight => 'Blockheight ile Geri Yükle';

  @override
  String get widgets_restore_from_date => 'Tarih ile Geri Yükle';

  @override
  String get widgets_or => '';

  @override
  String router_no_route(Object name) {
    return '';
  }

  @override
  String get error_text_account_name => '';

  @override
  String get error_text_contact_name => 'Kişi adı \'\', \"\" sembollerini içeremez\n ve 1 ile 32 karakter arasında olmalıdır';

  @override
  String get error_text_address => 'Geçersiz BDX adresi';

  @override
  String get error_text_node_address => 'Lütfen bir IPv4 adresi girin';

  @override
  String get error_text_node_port => 'Düğüm portu yalnızca 0 ile 65535 arasındaki sayıları içerebilir';

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
  String get error_text_keys => 'Cüzdan anahtarları yalnızca 64 karakterlik hex değer içerebilir';

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
  String get full_balance => 'Toplam Bakiye';

  @override
  String get available_balance => 'Kullanılabilir Bakiye';

  @override
  String get hidden_balance => 'Gizli Bakiye';

  @override
  String get sync_status_synchronizing => 'SENKRONİZE EDİLİYOR';

  @override
  String get sync_status_synchronized => 'SENKRONIZE EDILD';

  @override
  String get sync_status_not_connected => '';

  @override
  String get sync_status_starting_sync => 'Senkronizasyon Başlatılıyor';

  @override
  String get sync_status_failed_connect => 'Node’a bağlanılamadı';

  @override
  String get sync_status_connecting => 'Bağlanıyor';

  @override
  String get sync_status_connected => '';

  @override
  String get transaction_priority_slow => 'Yavaş';

  @override
  String get transaction_priority_blink => 'Hızlı';

  @override
  String get change_language => 'Dil Değiştir';

  @override
  String change_language_to(Object language) {
    return '';
  }

  @override
  String get paste => 'Yapıştır';

  @override
  String get restore_from_seed_placeholder => 'Lütfen seed’inizi buraya girin veya yapıştırın';

  @override
  String get add_new_word => '';

  @override
  String get incorrect_seed => '';

  @override
  String get biometric_auth_reason => '';

  @override
  String version(Object currentVersion) {
    return 'Sürüm $currentVersion';
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
  String get yes_im_sure => 'Evet, eminim!';

  @override
  String never_give_your(Object item) {
    return 'Beldex cüzdanınızdaki $item bilgisini asla kimseye vermeyin!';
  }

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'Beldex cüzdanınızdaki $item bilgisini $app_store, Beldex web sitesi veya Beldex GitHub\'dan doğrudan indirilen RESMİ Beldex cüzdanları dışındaki hiçbir yazılıma veya web sitesine ASLA girmeyin. Cüzdanınızdaki $item öğesine erişmek istediğinizden emin misiniz?';
  }

  @override
  String get keys_title => '';

  @override
  String get are_you_sure => 'Emin misiniz?';

  @override
  String get do_you_want_to_exit_an_app => '';

  @override
  String get no => 'Hayı';

  @override
  String get yes => 'Evet';

  @override
  String get byUsingThisAppYouAgreeToTheTermsOf => '';

  @override
  String get iAgreeToTermsOfUse => '';

  @override
  String get accept => '';

  @override
  String get pleaseEnterAValidAmount => 'Lütfen geçerli bir miktar girin';

  @override
  String get pleaseEnterAValidSeed => 'Lütfen geçerli bir seed girin';

  @override
  String get changeWallet => 'Cüzdanı Değiştir';

  @override
  String get removeWallet => 'Cüzdanı Kaldır';

  @override
  String get reconnectWallet => 'Cüzdanı Yeniden Bağlamak İster Misiniz';

  @override
  String get rescanWallet => 'Cüzdanı Yeniden Tara';

  @override
  String get enterWalletName => 'Cüzdan Adı Girin';

  @override
  String get noTransactionsYet => 'Henüz işlem yok!';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'İlk işleminizden sonra, burada görüntüleyebilirsiniz.';

  @override
  String get copied => 'Kopyalandı';

  @override
  String get addAddress => 'Adres Ekle';

  @override
  String get important => '';

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Beldex cüzdanınızdaki $item bilgisini, $appStore, Beldex web sitesi veya Beldex GitHub\'dan doğrudan indirilen resmi Beldex cüzdanları dışındaki hiçbir yazılıma veya web sitesine asla girmeyin.';
  }

  @override
  String get enterWalletName_ => 'Cüzdan adını girin';

  @override
  String get chooseSeedLanguage => 'Seed Dilini Seçin';

  @override
  String get wallet => 'Cüzdan';

  @override
  String get seedKeys => 'Seed ve Anahtarlar';

  @override
  String get walletAddress => 'Cüzdan Adresi';

  @override
  String get recoverySeedkey => 'Kurtarma Seed\'i/Anahtarı';

  @override
  String get selectLanguage => 'Dil Seç';

  @override
  String get chooseLanguage => 'Dil Seç';

  @override
  String get welcomeToBeldexWallet => 'Beldex Cüzdanına hoş geldiniz :)';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'Mevcut cüzdanınızı oluşturmak veya geri yüklemek için bir seçenek seçin';

  @override
  String get enterAValidNameUpto15Characters => 'En fazla 15 karakterden oluşan geçerli bir isim girin';

  @override
  String get enterAValidNameUpto20Characters => 'Lütfen 20 karaktere kadar geçerli bir ad girin';

  @override
  String get fiveDecimals => '5 - Beş (0.00000)';

  @override
  String get fourDecimals => '4 - Dört (0.0000)';

  @override
  String get twoDecimals => '2 - İki (0.00)';

  @override
  String get zeroDecimal => '0 - Sıfır (000)';

  @override
  String get doYouWantToExitTheWallet => 'Cüzdanı kapatmak istiyor musunuz?';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => 'Kurtarma Seed’inizin, cüzdan adresinizin ve özel anahtarlarınızın yedeğini aldığınızdan emin olun.';

  @override
  String blockRemaining(Object status) {
    return '';
  }

  @override
  String get flashTransaction => 'Hızlı İşlem';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => 'BDX’inizi daha hızlı transfer edin!';

  @override
  String get enterYourPin => 'PIN’inizi Girin';

  @override
  String get walletSettings => 'Cüzdan Ayarları';

  @override
  String get recoverySeed => 'Kurtarma Seed’i';

  @override
  String get youDontHaveEnoughUnlockedBalance => '';

  @override
  String get alert => 'Uyarı';

  @override
  String get touchTheFingerprintSensor => '';

  @override
  String get usePattern => '';

  @override
  String get enterBdxToSend => 'Gönderilecek BDX’i Girin';

  @override
  String get enterAmount => 'Miktarı Girin';

  @override
  String get pleaseEnterAAmount => 'Lütfen bir miktar girin';

  @override
  String get committingTheTransaction => '';

  @override
  String get availableBdx => 'Mevcut BDX :';

  @override
  String get pleaseEnterABdxAddress => 'Lütfen bir BDX adresi girin';

  @override
  String get enterAValidAddress => '';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'Biyometrik özellik şu anda devre dışı.\n Lütfen uygulama ayarlarından biyometrik doğrulama özelliğini etkinleştirin.';

  @override
  String get unlockBeldexWallet => '';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => '';

  @override
  String get doYouWantToChangeYournPrimaryAccount => 'Birincil hesabınızı değiştirmek istiyor musunuz?';

  @override
  String get rename => '';

  @override
  String get addAccount => 'Hesap Ekle';

  @override
  String get noAddressesInBook => 'Adres defterinde kayıtlı adres yok';

  @override
  String get bdx => '';

  @override
  String get howeverWeRecommendToScanTheBlockchainFromTheBlock => '';

  @override
  String get youHaveScannedFromTheBlockHeight => '';

  @override
  String get syncInfo => '';

  @override
  String get doYouWantToReconnectnTheWallet => 'Cüzdanı yeniden bağlamak istiyor musunuz?';

  @override
  String get enterValidNameUpto15Characters => 'Geçerli bir ad girin (15 karaktere kadar)';

  @override
  String get checkingNodeConnection => '';

  @override
  String get enterBdxToReceive => 'BDX Almak için Girin';

  @override
  String get addSubAddress => 'Alt Adres Ekle';

  @override
  String get shareQr => 'QR Paylaş';

  @override
  String get name => 'İsim';

  @override
  String get enterValidHeightWithoutSpace => 'Boşluk olmadan geçerli bir height girin';

  @override
  String get dateShouldNotBeEmpty => 'Tarih boş olamaz';

  @override
  String get walletRestore => 'Cüzdan Geri Yükleme';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => '';

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'Seed’inizi asla kimseyle paylaşmayın! Etrafınızı kontrol edin ve kimsenin sizi izlemediğinden emin olun.';

  @override
  String get note => 'Not:';

  @override
  String get copySeed => 'Копировать seed-фразу';

  @override
  String get accountAlreadyExist => 'Hesap zaten mevcut';

  @override
  String get transactionInitiatedSuccessfully => 'İşlem başarıyla başlatıldı';

  @override
  String get enterAValidSubAddress => 'Geçerli bir alt adres girin';

  @override
  String get subaddressAlreadyExist => 'Alt adres zaten mevcut';

  @override
  String get labelName => 'Etiket Adı';

  @override
  String get subAddress => 'Alt Adres';

  @override
  String get loadingTheWallet => 'Cüzdan yükleniyor…';

  @override
  String get youAreAboutToDeletenYourWallet => 'Cüzdanınızı silmek üzeresiniz!';

  @override
  String get creatingTheTransaction => '';

  @override
  String get copyAndSaveTheSeedToContinue => 'Seed’i kopyalayın ve kaydedin, devam etmek için';

  @override
  String get enterPin => 'PIN Gir';

  @override
  String get test => 'Test';

  @override
  String get success => '';

  @override
  String get connectionFailed => '';

  @override
  String get checking => '';

  @override
  String get testResult => 'Test Sonucu:';

  @override
  String get passwordOptional => 'Şifre (isteğe bağlı)';

  @override
  String get userNameOptional => 'Kullanıcı Adı (isteğe bağlı)';

  @override
  String get nodeNameOptional => 'Düğüm Adı (isteğe bağlı)';

  @override
  String get addNode => 'Düğüm Ekle';

  @override
  String get legalDisclaimer => '';

  @override
  String get howCanWenhelpYou => 'Size nasıl yardımcı olabiliriz?';

  @override
  String get removeContact => 'Kişiyi Kaldır';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => 'Seçili kişiyi kaldırmak istediğinize emin misiniz?';

  @override
  String get theAddressAlreadyExist => 'Bu adres zaten mevcut';

  @override
  String get thisNameAlreadyExist => 'Bu isim zaten mevcut';

  @override
  String get enterAValidName => 'Geçerli bir isim girin';

  @override
  String get addressShouldNotBeEmpty => 'Adres boş bırakılamaz';

  @override
  String get nameShouldNotBeEmpty => 'İsim boş bırakılamaz';

  @override
  String get enterName => 'Ad Girin';

  @override
  String get accountName => 'Hesap Adı';

  @override
  String get playStore => '';

  @override
  String get appstore => '';

  @override
  String get allowFaceIdAuthentication => '';

  @override
  String get enterAddress => 'Adres Girin';

  @override
  String get pleaseAddAMainnetNode => '';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return '';
  }

  @override
  String get initiatingTransactionTitle => 'İşlem Başlatılıyor…';

  @override
  String get initiatingTransactionDescription => 'Lütfen işlem başlatılana kadar bu pencereyi kapatmayın veya başka bir uygulamaya geçmeyin.';

  @override
  String get subAddresses => '';

  @override
  String get loadingTheWalletDescription => 'Lütfen bu pencereyi kapatmayın veya cüzdan yüklenene kadar başka bir uygulamaya geçmeyin';

  @override
  String get buyBns => 'BNS Satın Al';

  @override
  String get myBns => '';

  @override
  String get addBns => 'BNS Ekle';

  @override
  String get bns => '';

  @override
  String get bnsPurchaseDescription => 'Bir BNS kaydı satın alın veya güncelleyin.\n Bir isim satın alırsanız, listede görünmesi bir veya iki dakika sürebilir.';

  @override
  String get bnsPrice => 'Fiyatı';

  @override
  String get bnsYearOneShort => '1 Yı';

  @override
  String get bnsYearTwoShort => '2 Yı';

  @override
  String get bnsYearFiveShort => '5 Yı';

  @override
  String get bnsYearTenShort => '10 Yı';

  @override
  String get bnsYearOne => '';

  @override
  String get bnsYearTwo => '';

  @override
  String get bnsYearFive => '';

  @override
  String get bnsYearTen => '';

  @override
  String get bnsYouSave => 'Tasarruf Edersiniz';

  @override
  String get bnsNameHint => 'Beldex Name Service üzerinden satın alınacak isim';

  @override
  String get bnsOwnerOptional => 'Sahip (İsteğe Bağlı)';

  @override
  String get bnsOwnerHint => 'Sahibin cüzdan adresi';

  @override
  String get bnsBchatId => 'BChat ID';

  @override
  String get bnsBelnetId => 'Belnet ID';

  @override
  String get bnsEthAddress => 'ETH Adresi';

  @override
  String get bnsUpdateOwner => 'Sahibi Güncelle';

  @override
  String get bnsUpdateValues => 'Değerleri Güncelle';

  @override
  String get bnsNewOwnerHint => 'Yeni sahibin cüzdan adresini girin';

  @override
  String get bnsUpdateNote => 'Aynı anda yalnızca sahip adresini veya değerleri güncelleyebilirsiniz.\n Her ikisini de güncellemek istiyorsanız, sahipliği devretmeden önce veya devrettikten sonra değerleri güncelleyebilirsiniz.';

  @override
  String get bnsAddRecord => 'Kayıt Ekle';

  @override
  String get bnsRecordsDescription => 'Burada bu cüzdana ait tüm BNS isimlerini bulabilirsiniz.Sahip olduğunuz bir kaydı çözdüğünüzde, BNS kaydındaki isim ve değer görüntülenir.';

  @override
  String get bnsRecordNameHint => 'Size ait bir BNS adı';

  @override
  String get bnsFetchingRecords => 'Ağdan BNS kaydı alınıyor';

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return '$bnsName için BNS kaydı başarıyla çözüldü';
  }

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return '$bnsName için BNS kaydı çözülemedi';
  }

  @override
  String get bnsRecordNotFound => '';

  @override
  String get bnsWaitForFetch => '';

  @override
  String get bnsRecords => 'BNS Kayıtları';

  @override
  String get bnsExpirationHeight => 'Bitiş Yüksekliği';

  @override
  String get bnsUpdateHeight => 'Güncelleme Yüksekliği';

  @override
  String get bnsBackupOwner => 'Yedek Sahip';

  @override
  String get bnsEncryptedWalletValue => 'Şifrelenmiş Cüzdan Değeri';

  @override
  String get bnsEncryptedBchatValue => 'Şifrelenmiş BChat Değeri';

  @override
  String get bnsEncryptedBelnetValue => 'Şifrelenmiş Belnet Değeri';

  @override
  String get bnsEncryptedEthValue => 'Şifrelenmiş ETH Değeri';

  @override
  String get bnsUpdateAction => 'Güncelle';

  @override
  String get bnsRenewAction => 'Yenile';

  @override
  String get bnsNoteLabel => 'Not: ';

  @override
  String get bnsEthAddressDescription => 'ETH adresimiz tüm EVM zincirleriyle uyumludur';

  @override
  String get bnsPurchase => 'Satın Al';

  @override
  String get bnsPleaseFillField => 'Lütfen bu alanı doldurun';

  @override
  String get bnsInvalidName => '';

  @override
  String get bnsInvalidBchatId => 'Geçersiz BChat ID';

  @override
  String get bnsInvalidBelnetId => 'Geçersiz Belnet ID';

  @override
  String get bnsInvalidEthAddress => 'Geçersiz ETH Adresi';

  @override
  String get bnsEnterValidWalletAddress => 'Geçerli bir cüzdan adresi girin';

  @override
  String get bnsConfirmPurchase => 'Satın Alma Onayı';

  @override
  String get bnsYearLabel => 'Yıl';

  @override
  String get bnsOwnerLabel => 'Sahip';

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
  String get bnsUpdate => 'BNS Güncelleme';

  @override
  String get bnsRenewal => 'BNS Yenileme';

  @override
  String get swap => 'Takas';

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
  String get restoredViaKeys => 'Cüzdanı anahtarlar ile geri yüklediniz';

  @override
  String walletAlreadyExists(Object name) {
    return '$name adlı bir cüzdan zaten mevcut!';
  }

  @override
  String get nodeAlreadyExists => 'Bu düğüm zaten mevcut ';

  @override
  String get fee => 'Ücret';

  @override
  String get noInternet => 'İnternet bağlantısı yok!';

  @override
  String get noInternetMessage => 'Lütfen internet bağlantınızı kontrol edin ve tekrar deneyin.';

  @override
  String get swapNotAvailable => ' Swap şu anda kullanılamıyor';

  @override
  String get tryAgain => 'Lütfen daha sonra tekrar deneyin.';

  @override
  String get exchange => 'Değişim';

  @override
  String get youSend => 'Gönderdiğiniz';

  @override
  String get youGet => 'Alacağınız';

  @override
  String get floatingExchangeRate => 'Değişken Kur Oranı';

  @override
  String get floatingRateDescription => 'Değişken oran, piyasa koşullarına bağlı olarak herhangi bir anda değişebilir, bu nedenle beklediğinizden daha fazla veya daha az kripto alabilirsiniz.';

  @override
  String get searchCoins => 'Coin Ara';

  @override
  String get minimumAmount => 'Minimum tutar';

  @override
  String get maximumAmount => 'Maksimum tutar';

  @override
  String get exchangeAmount => '';

  @override
  String get exchangeRate => 'Döviz Kuru';

  @override
  String get receiver => 'Alıcı';

  @override
  String get amountReceived => 'Alınan Tutar';

  @override
  String get date => 'Tarih';

  @override
  String get expandDetails => 'Detayları Genişlet';

  @override
  String get view => 'Görüntüle';

  @override
  String get noTransactionsMessage => 'Gösterilecek herhangi bir işlem veya değişim bulunmamaktadır.';

  @override
  String get networkErrorCheckConnection => 'Ağ hatası! Lütfen internet bağlantınızı kontrol edin.';

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
  String get searchCurrency => 'Para Birimi Ara';

  @override
  String changePinLength(Object value) {
    return '$value haneli PİN’e geç';
  }

  @override
  String get pleaseEnterAValidHeight => 'Lütfen geçerli bir height girin';

  @override
  String get invalidAddress => '';

  @override
  String get exchangePair => 'İşlem Çifti';

  @override
  String get payment => 'Ödeme';

  @override
  String get bnsConfirmUpdate => 'Güncelleme Onayı';
}
