// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get welcome => '';

  @override
  String get first_wallet_text => '';

  @override
  String get please_make_selection => '';

  @override
  String get create_new => 'Tạo ví mới';

  @override
  String get restore_wallet => 'Sử dụng ví hiện có';

  @override
  String get accounts => 'Các tài khoản';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get account => 'Tài khoản';

  @override
  String get add => 'Thêm';

  @override
  String get address_book => 'Danh bạ địa chỉ';

  @override
  String get contact => '';

  @override
  String get please_select => '';

  @override
  String get cancel => 'Hủy';

  @override
  String get ok => 'Ok';

  @override
  String get contact_name => '';

  @override
  String get reset => 'Đặt lại';

  @override
  String get save => 'Lưu';

  @override
  String get authenticated => '';

  @override
  String get authentication => '';

  @override
  String failed_authentication(Object state_error) {
    return 'Xác thực không thành công. $state_error';
  }

  @override
  String get wallet_menu => '';

  @override
  String blocksRemaining(Object status) {
    return 'Còn $status khối';
  }

  @override
  String get please_try_to_connect_to_another_node => 'Vui lòng thử kết nối với node khác';

  @override
  String get beldex_hidden => '';

  @override
  String get beldex_available_balance => '';

  @override
  String get beldex_full_balance => '';

  @override
  String get send => 'Gửi';

  @override
  String get receive => 'Nhận';

  @override
  String get transactions => 'Giao dịch';

  @override
  String get incoming => 'Đến';

  @override
  String get outgoing => 'Đi';

  @override
  String get transactions_by_date => 'Giao dịch theo ngày';

  @override
  String get filters => 'Lọc theo';

  @override
  String get today => '';

  @override
  String get yesterday => '';

  @override
  String get received => '';

  @override
  String get sent => 'Đã gửi';

  @override
  String get pending => '';

  @override
  String get rescan => 'Quét lại';

  @override
  String get reconnect => 'Kết nối lại';

  @override
  String get wallets => 'Các ví';

  @override
  String get show_seed => 'Hiển thị Seed';

  @override
  String get show_keys => 'Hiển thị khóa';

  @override
  String get reconnection => '';

  @override
  String get reconnect_alert_text => '';

  @override
  String get reload_fiat => '';

  @override
  String get clear => 'Xóa';

  @override
  String get error => '';

  @override
  String get copied_to_clipboard => '';

  @override
  String get fetching => '';

  @override
  String get id => '';

  @override
  String get amount => 'Số lượng';

  @override
  String get status => 'Trạng thái:';

  @override
  String get confirm => '';

  @override
  String get confirm_sending => 'Xác nhận gửi';

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
  String get faq => 'Câu hỏi thường gặp';

  @override
  String get changelog => 'Lịch sử cập nhật';

  @override
  String get loading_your_wallet => '';

  @override
  String get new_wallet => 'Ví mới';

  @override
  String get wallet_name => 'Tên ví ';

  @override
  String get continue_text => 'Tiếp tục';

  @override
  String get node_new => '';

  @override
  String get node_address => 'Địa chỉ Node ';

  @override
  String get node_port => 'Cổng Node';

  @override
  String get login => '';

  @override
  String get password => '';

  @override
  String get nodes => 'Nút';

  @override
  String get node_reset_settings_title => 'Đặt lại cài đặt ';

  @override
  String get nodes_list_reset_to_default_message => 'Bạn có chắc muốn đặt lại cài đặt về mặc định không?';

  @override
  String change_current_node(Object node) {
    return 'Bạn có chắc chắn muốn thay đổi node hiện tại thành $node không?';
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
  String get delete => 'Xóa';

  @override
  String get use => '';

  @override
  String get digit_pin => '';

  @override
  String get share_address => '';

  @override
  String get subaddresses => '';

  @override
  String get restore_restore_wallet => 'Khôi phục ví';

  @override
  String get restore_title_from_seed_keys => 'Khôi phục từ seed/keys';

  @override
  String get restore_description_from_seed_keys => 'Lấy lại ví của bạn từ seed/keys mà bạn đã lưu ở nơi an toàn';

  @override
  String get restore_next => 'Tiếp theo';

  @override
  String get restore_title_from_backup => '';

  @override
  String get restore_description_from_backup => '';

  @override
  String get restore_seed_keys_restore => '';

  @override
  String get restore_title_from_seed => 'Khôi phục từ Seed';

  @override
  String get restore_description_from_seed => 'Sử dụng khóa ghi nhớ 25 từ (Mnemonic) hoặc cụm seed để khôi phục ví của bạn';

  @override
  String get restore_title_from_keys => 'Khôi phục từ Keys';

  @override
  String get restore_description_from_keys => 'Sử dụng các khóa riêng đã lưu để khôi phục ví của bạn';

  @override
  String get restore_address => 'Địa chỉ';

  @override
  String get restore_recover => 'Khôi phục';

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
  String get send_beldex_address => 'Địa chỉ Beldex hoặc tên BNS';

  @override
  String get all => '';

  @override
  String get send_error_currency => '';

  @override
  String get send_estimated_fee => 'Phí ước tính:';

  @override
  String send_priority(Object transactionPriority) {
    return 'Mức ưu tiên $transactionPriority được đặt làm phí mặc định. Vào cài đặt để thay đổi mức ưu tiên giao dịch.';
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
  String get settings_title => 'Cài đặt';

  @override
  String get settings_current_node => 'Nút hiện tại';

  @override
  String get settings_display_balance_as => 'Hiển thị số dư dưới dạng';

  @override
  String get settings_balance_detail => 'Số thập phân';

  @override
  String get settings_currency => 'Tiền tệ';

  @override
  String get settings_fee_priority => 'Mức ưu tiên phí';

  @override
  String get settings_save_recipient_address => 'Lưu địa chỉ người nhận';

  @override
  String get settings_personal => 'Cá nhân';

  @override
  String get settings_change_pin => 'Đổi mã PIN';

  @override
  String get settings_allow_biometric_authentication => 'Cho phép xác thực sinh trắc học';

  @override
  String get settings_dark_mode => 'Chế độ tối';

  @override
  String get settings_display_on_dashboard_list => '';

  @override
  String get settings_none => '';

  @override
  String get settings_support => 'Hỗ trợ';

  @override
  String get settings_terms_and_conditions => 'Điều khoản & Điều kiện';

  @override
  String get settings_enable_fiat_currency => 'Bật chuyển đổi tiền tệ';

  @override
  String get pin_is_incorrect => 'Mã PIN không chính xác';

  @override
  String get amount_detail_ultra => '';

  @override
  String get amount_detail_none => '';

  @override
  String get amount_detail_detailed => '';

  @override
  String get amount_detail_normal => '';

  @override
  String get setup_pin => 'Thiết lập mã PIN';

  @override
  String get re_enter_your_pin => 'Nhập lại mã PIN';

  @override
  String get setup_successful => 'Mã PIN của bạn đã được thiết lập thành công!';

  @override
  String get wallet_keys => 'Keys của ví';

  @override
  String get view_key_private => 'Khóa xem (riêng tư)';

  @override
  String get view_key_public => 'Xem key (công khai)';

  @override
  String get spend_key_private => 'Khóa chi tiêu (riêng tư)';

  @override
  String get spend_key_public => 'Spend key (công khai)';

  @override
  String copied_key_to_clipboard(Object key) {
    return '';
  }

  @override
  String get new_subaddress_title => '';

  @override
  String get new_subaddress_create => 'Tạo';

  @override
  String get subaddress_title => '';

  @override
  String get transaction_details_title => '';

  @override
  String get transaction_details_transaction_id => 'Mã giao dịch';

  @override
  String get transaction_details_height => 'Chiều cao';

  @override
  String get transaction_details_amount => 'Số tiền';

  @override
  String get transaction_details_payment_id => '';

  @override
  String transaction_details_copied(Object title) {
    return '';
  }

  @override
  String get transaction_details_recipient_address => 'Địa chỉ nhận';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return 'Vui lòng đảm bảo nhập đúng địa chỉ cho chuỗi đã chọn - $blockchain. Nếu không, bạn sẽ mất tiền.';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return 'Nhập địa chỉ người nhận $currency của bạn';
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
  String get swap_exchange_rate => 'Tỷ giá';

  @override
  String get swap_service_fee => 'Phí dịch vụ 0.25%';

  @override
  String get service_fee => 'Phí dịch vụ 0.25%';

  @override
  String get network_fee => 'Phí mạng';

  @override
  String get swap_refund_address => '';

  @override
  String get swap_network_fee => 'Phí mạng';

  @override
  String get swap_you_get => 'Bạn nhận';

  @override
  String get swap_checkout => 'Thanh toán';

  @override
  String get swap_network_label => 'MẠNG: ';

  @override
  String get swap_estimated_time => '';

  @override
  String get swap_estimated_time_value => '';

  @override
  String get swap_confirm_and_make_payment => 'Xác nhận & Thanh toán';

  @override
  String get swap_send_funds_to_address_below => 'Gửi tiền đến địa chỉ bên dưới';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return 'Thời gian còn lại để gửi $amount $currency';
  }

  @override
  String swap_time_remaining(Object value) {
    return 'Thời gian còn lại: $value';
  }

  @override
  String get swap_send_funds_notice => 'Bạn có 3 giờ để gửi tiền, nếu không giao dịch sẽ tự động bị hủy.\n Giao dịch sẽ được thực hiện khi tiền được nhận.';

  @override
  String get swap_confirmations => '';

  @override
  String get swap_completed => 'Hoàn tất';

  @override
  String get swap_amount_from => 'Số tiền gửi';

  @override
  String get swap_amount_to => 'Số tiền nhận';

  @override
  String get swap_received_time => 'Thời gian nhận';

  @override
  String get swap_amount_sent => 'Số tiền đã gửi';

  @override
  String get swap_input_output_hash => 'Hash đầu vào/đầu ra';

  @override
  String get swap_input_hash => 'Hash đầu vào';

  @override
  String get swap_output_hash => 'Hash đầu ra';

  @override
  String get swap_failed => 'Giao dịch thất bại';

  @override
  String get swap_expired => '';

  @override
  String get swap_overdue => '';

  @override
  String get swap_funds_not_received => 'Không nhận được tiền trong vòng 3 giờ.\n Vui lòng kiểm tra tỷ giá và tạo giao dịch mới.';

  @override
  String get swap_start_over => 'Bắt đầu lại';

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
  String get swap_open_history => 'Xem lịch sử';

  @override
  String get swap_new_transaction => 'Giao dịch mới';

  @override
  String get swap_i_agree_with => 'Tôi đồng ý với';

  @override
  String get swap_terms_of_use => 'Điều khoản sử dụng';

  @override
  String get swap_and => 'và';

  @override
  String get swap_privacy_policy => 'Chính sách bảo mật';

  @override
  String get wallet_list_title => 'Ví Beldex';

  @override
  String get wallet_list_load_wallet => 'Tải ví';

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
  String get widgets_restore_from_blockheight => 'Khôi phục từ Blockheight';

  @override
  String get widgets_restore_from_date => 'Khôi phục từ ngày ';

  @override
  String get widgets_or => '';

  @override
  String router_no_route(Object name) {
    return '';
  }

  @override
  String get error_text_account_name => '';

  @override
  String get error_text_contact_name => 'Tên liên hệ không được chứa ký tự \' , \"\n và phải có độ dài từ 1 đến 32 ký tự';

  @override
  String get error_text_address => 'Địa chỉ BDX không hợp lệ';

  @override
  String get error_text_node_address => 'Vui lòng nhập địa chỉ IPv4 hợp lệ';

  @override
  String get error_text_node_port => 'Cổng node chỉ có thể chứa các số từ 0 đến 65535';

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
  String get error_text_keys => 'Khóa ví chỉ được chứa 64 ký tự dạng hex';

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
  String get full_balance => 'Tổng số dư';

  @override
  String get available_balance => 'Số dư khả dụng';

  @override
  String get hidden_balance => 'Số dư ẩn';

  @override
  String get sync_status_synchronizing => 'ĐANG ĐỒNG BỘ HÓA';

  @override
  String get sync_status_synchronized => 'Đã đồng bộ';

  @override
  String get sync_status_not_connected => '';

  @override
  String get sync_status_starting_sync => 'Đang bắt đầu đồng bộ';

  @override
  String get sync_status_failed_connect => 'Kết nối đến node thất bại';

  @override
  String get sync_status_connecting => 'Đang kết nối';

  @override
  String get sync_status_connected => '';

  @override
  String get transaction_priority_slow => 'Chậm';

  @override
  String get transaction_priority_blink => 'Nhanh';

  @override
  String get change_language => 'Đổi ngôn ngữ';

  @override
  String change_language_to(Object language) {
    return '';
  }

  @override
  String get paste => 'Dán';

  @override
  String get restore_from_seed_placeholder => 'Vui lòng nhập hoặc dán seed tại đây';

  @override
  String get add_new_word => '';

  @override
  String get incorrect_seed => '';

  @override
  String get biometric_auth_reason => '';

  @override
  String version(Object currentVersion) {
    return 'Phiên bản $currentVersion';
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
  String get yes_im_sure => 'Có, tôi chắc chắn!';

  @override
  String never_give_your(Object item) {
    return 'Không bao giờ cung cấp $item trong ví Beldex của bạn cho bất kỳ ai!';
  }

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'KHÔNG BAO GIỜ nhập $item trong ví Beldex của bạn vào bất kỳ phần mềm hoặc trang web nào khác ngoài các ví Beldex CHÍNH THỨC được tải trực tiếp từ $app_store, trang web Beldex hoặc GitHub của Beldex. Bạn có chắc chắn muốn truy cập vào $item trong ví của mình không?';
  }

  @override
  String get keys_title => '';

  @override
  String get are_you_sure => 'Xác nhận?';

  @override
  String get do_you_want_to_exit_an_app => '';

  @override
  String get no => 'Không';

  @override
  String get yes => 'Có';

  @override
  String get byUsingThisAppYouAgreeToTheTermsOf => '';

  @override
  String get iAgreeToTermsOfUse => '';

  @override
  String get accept => '';

  @override
  String get pleaseEnterAValidAmount => 'Vui lòng nhập số lượng hợp lệ';

  @override
  String get pleaseEnterAValidSeed => 'Vui lòng nhập seed hợp lệ';

  @override
  String get changeWallet => 'Chuyển ví';

  @override
  String get removeWallet => 'Xóa ví';

  @override
  String get reconnectWallet => 'Kết nối lại ví';

  @override
  String get rescanWallet => 'Quét lại ví ';

  @override
  String get enterWalletName => 'Nhập tên ví';

  @override
  String get noTransactionsYet => 'Chưa có giao dịch!';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'Sau giao dịch đầu tiên, bạn sẽ có thể xem tại đây.';

  @override
  String get copied => 'Đã sao chép';

  @override
  String get addAddress => 'Thêm địa chỉ';

  @override
  String get important => '';

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Không bao giờ nhập $item trong ví Beldex của bạn vào bất kỳ phần mềm hoặc trang web nào khác ngoài các ví Beldex chính thức được tải trực tiếp từ $appStore, trang web Beldex hoặc GitHub của Beldex.';
  }

  @override
  String get enterWalletName_ => 'Nhập tên ví';

  @override
  String get chooseSeedLanguage => 'Chọn ngôn ngữ Seed';

  @override
  String get wallet => 'Ví';

  @override
  String get seedKeys => 'Seed & Khóa';

  @override
  String get walletAddress => 'Địa chỉ ví';

  @override
  String get recoverySeedkey => 'Seed/Khóa khôi phục';

  @override
  String get selectLanguage => 'Chọn ngôn ngữ';

  @override
  String get chooseLanguage => 'Chọn ngôn ngữ';

  @override
  String get welcomeToBeldexWallet => 'Chào mừng bạn đến với Ví Beldex :)';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'Hãy chọn một tùy chọn để tạo hoặc khôi phục ví hiện có';

  @override
  String get enterAValidNameUpto15Characters => 'Nhập tên hợp lệ tối đa 15 ký tự';

  @override
  String get enterAValidNameUpto20Characters => 'Nhập tên hợp lệ tối đa 20 ký tự';

  @override
  String get fiveDecimals => '5 - Năm (0.00000)';

  @override
  String get fourDecimals => '4 - Bốn (0.0000)';

  @override
  String get twoDecimals => '2 - Hai (0.00)';

  @override
  String get zeroDecimal => '0 - Không (000)';

  @override
  String get doYouWantToExitTheWallet => 'Bạn có muốn thoát khỏi ví không?';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => 'Hãy đảm bảo đã sao lưu Seed khôi phục, địa chỉ ví và khóa riêng';

  @override
  String blockRemaining(Object status) {
    return '';
  }

  @override
  String get flashTransaction => 'Giao dịch Flash';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => 'Chuyển BDX nhanh hơn với Flash Transaction!';

  @override
  String get enterYourPin => 'Nhập mã PIN của bạn';

  @override
  String get walletSettings => 'Cài đặt ví';

  @override
  String get recoverySeed => 'Seed khôi phục';

  @override
  String get youDontHaveEnoughUnlockedBalance => '';

  @override
  String get alert => 'Cảnh báo';

  @override
  String get touchTheFingerprintSensor => '';

  @override
  String get usePattern => '';

  @override
  String get enterBdxToSend => 'Nhập số BDX muốn gửi';

  @override
  String get enterAmount => 'Nhập số lượng';

  @override
  String get pleaseEnterAAmount => 'Vui lòng nhập số lượng';

  @override
  String get committingTheTransaction => '';

  @override
  String get availableBdx => 'BDX khả dụng :';

  @override
  String get pleaseEnterABdxAddress => 'Vui lòng nhập địa chỉ BDX';

  @override
  String get enterAValidAddress => '';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'Tính năng sinh trắc học hiện đang bị tắt.\n Vui lòng bật tính năng xác thực sinh trắc học trong phần cài đặt của ứng dụng.';

  @override
  String get unlockBeldexWallet => '';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => '';

  @override
  String get doYouWantToChangeYournPrimaryAccount => 'Bạn có muốn thay đổi tài khoản chính không?';

  @override
  String get rename => '';

  @override
  String get addAccount => 'Thêm tài khoản';

  @override
  String get noAddressesInBook => 'Không có địa chỉ nào trong danh bạ';

  @override
  String get bdx => '';

  @override
  String get howeverWeRecommendToScanTheBlockchainFromTheBlock => '';

  @override
  String get youHaveScannedFromTheBlockHeight => '';

  @override
  String get syncInfo => '';

  @override
  String get doYouWantToReconnectnTheWallet => 'Bạn có muốn kết nối lại ví không?';

  @override
  String get enterValidNameUpto15Characters => 'Nhập tên hợp lệ tối đa 15 ký tự';

  @override
  String get checkingNodeConnection => '';

  @override
  String get enterBdxToReceive => 'Nhập số BDX muốn nhận';

  @override
  String get addSubAddress => 'Thêm địa chỉ phụ';

  @override
  String get shareQr => 'Chia sẻ mã QR';

  @override
  String get name => 'Tên';

  @override
  String get enterValidHeightWithoutSpace => 'Nhập chiều cao block hợp lệ (không có khoảng trắng)';

  @override
  String get dateShouldNotBeEmpty => 'Ngày không được để trống';

  @override
  String get walletRestore => 'Khôi phục ví';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => '';

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'Không bao giờ chia sẻ seed của bạn cho bất kỳ ai! Hãy kiểm tra xung quanh để đảm bảo không có ai đang nhìn lén';

  @override
  String get note => 'Lưu ý:';

  @override
  String get copySeed => 'Sao chép Seed';

  @override
  String get accountAlreadyExist => 'Tài khoản đã tồn tại';

  @override
  String get transactionInitiatedSuccessfully => 'Giao dịch đã được khởi tạo thành công';

  @override
  String get enterAValidSubAddress => 'Nhập địa chỉ phụ hợp lệ';

  @override
  String get subaddressAlreadyExist => 'Địa chỉ phụ đã tồn tại';

  @override
  String get labelName => 'Tên nhãn';

  @override
  String get subAddress => 'Địa chỉ phụ';

  @override
  String get loadingTheWallet => 'Đang tải ví…';

  @override
  String get youAreAboutToDeletenYourWallet => 'Bạn sắp xóa ví của mình!';

  @override
  String get creatingTheTransaction => '';

  @override
  String get copyAndSaveTheSeedToContinue => 'Hãy sao chép và lưu seed để tiếp tục';

  @override
  String get enterPin => 'Nhập mã PIN';

  @override
  String get test => 'Kiểm tra';

  @override
  String get success => '';

  @override
  String get connectionFailed => '';

  @override
  String get checking => '';

  @override
  String get testResult => 'Kết quả kiểm tra:';

  @override
  String get passwordOptional => 'Mật khẩu (tùy chọn)';

  @override
  String get userNameOptional => 'Tên người dùng (tùy chọn)';

  @override
  String get nodeNameOptional => 'Tên Node (tùy chọn)';

  @override
  String get addNode => 'Thêm Node';

  @override
  String get legalDisclaimer => '';

  @override
  String get howCanWenhelpYou => 'Chúng tôi có thể giúp gì cho bạn?';

  @override
  String get removeContact => 'Xóa liên hệ';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => 'Bạn có chắc chắn muốn xóa liên hệ đã chọn không?';

  @override
  String get theAddressAlreadyExist => 'Địa chỉ đã tồn tại';

  @override
  String get thisNameAlreadyExist => 'Tên này đã tồn tại';

  @override
  String get enterAValidName => 'Nhập tên hợp lệ';

  @override
  String get addressShouldNotBeEmpty => 'Địa chỉ không được để trống';

  @override
  String get nameShouldNotBeEmpty => 'Tên không được để trống';

  @override
  String get enterName => 'Nhập tên';

  @override
  String get accountName => 'Tên tài khoản';

  @override
  String get playStore => '';

  @override
  String get appstore => '';

  @override
  String get allowFaceIdAuthentication => '';

  @override
  String get enterAddress => 'Nhập địa chỉ';

  @override
  String get pleaseAddAMainnetNode => '';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return '';
  }

  @override
  String get initiatingTransactionTitle => 'Đang khởi tạo giao dịch...';

  @override
  String get initiatingTransactionDescription => 'Vui lòng không đóng cửa sổ này hoặc chuyển sang ứng dụng khác cho đến khi giao dịch được khởi tạo';

  @override
  String get subAddresses => '';

  @override
  String get loadingTheWalletDescription => 'Vui lòng không đóng cửa sổ này hoặc chuyển sang ứng dụng khác cho đến khi ví được tải xong.';

  @override
  String get buyBns => 'Mua BNS';

  @override
  String get myBns => '';

  @override
  String get addBns => 'Thêm BNS';

  @override
  String get bns => '';

  @override
  String get bnsPurchaseDescription => 'Mua hoặc cập nhật một bản ghi BNS.\n Nếu bạn mua một tên, có thể mất một hoặc hai phút để hiển thị trong danh sách.';

  @override
  String get bnsPrice => 'Giá';

  @override
  String get bnsYearOneShort => '1 năm';

  @override
  String get bnsYearTwoShort => '2 năm';

  @override
  String get bnsYearFiveShort => '5 năm';

  @override
  String get bnsYearTenShort => '10 năm';

  @override
  String get bnsYearOne => '';

  @override
  String get bnsYearTwo => '';

  @override
  String get bnsYearFive => '';

  @override
  String get bnsYearTen => '';

  @override
  String get bnsYouSave => 'Bạn tiết kiệm';

  @override
  String get bnsNameHint => 'Tên cần mua thông qua Dịch vụ Tên Beldex';

  @override
  String get bnsOwnerOptional => 'Chủ sở hữu (Owner – Tùy chọn)';

  @override
  String get bnsOwnerHint => 'Địa chỉ ví của chủ sở hữu';

  @override
  String get bnsBchatId => 'ID BChat';

  @override
  String get bnsBelnetId => 'ID Belnet';

  @override
  String get bnsEthAddress => 'Địa chỉ ETH';

  @override
  String get bnsUpdateOwner => 'Cập nhật chủ sở hữu';

  @override
  String get bnsUpdateValues => 'Cập nhật giá trị';

  @override
  String get bnsNewOwnerHint => 'Nhập địa chỉ ví của chủ sở hữu mới';

  @override
  String get bnsUpdateNote => 'Bạn chỉ có thể cập nhật địa chỉ chủ sở hữu hoặc các giá trị tại một thời điểm.\n Nếu bạn muốn cập nhật cả hai, bạn có thể cập nhật giá trị trước khi chuyển quyền sở hữu hoặc sau khi chuyển quyền sở hữu.';

  @override
  String get bnsAddRecord => 'Thêm bản ghi';

  @override
  String get bnsRecordsDescription => 'Tại đây bạn có thể tìm thấy tất cả các tên BNS thuộc sở hữu của ví này. Khi giải mã một bản ghi mà bạn sở hữu, hệ thống sẽ trả về tên và giá trị trong bản ghi BNS.';

  @override
  String get bnsRecordNameHint => 'Một tên BNS thuộc về bạn';

  @override
  String get bnsFetchingRecords => 'Đang lấy bản ghi BNS từ mạng';

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return 'Đã giải mã thành công bản ghi BNS cho $bnsName';
  }

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return 'Không thể giải mã bản ghi BNS cho $bnsName';
  }

  @override
  String get bnsRecordNotFound => '';

  @override
  String get bnsWaitForFetch => '';

  @override
  String get bnsRecords => 'Bản ghi BNS';

  @override
  String get bnsExpirationHeight => 'Chiều cao hết hạn';

  @override
  String get bnsUpdateHeight => 'Chiều cao cập nhật';

  @override
  String get bnsBackupOwner => 'Chủ sở hữu dự phòng';

  @override
  String get bnsEncryptedWalletValue => 'Giá trị ví được mã hóa';

  @override
  String get bnsEncryptedBchatValue => 'Giá trị BChat được mã hóa';

  @override
  String get bnsEncryptedBelnetValue => 'Giá trị Belnet được mã hóa';

  @override
  String get bnsEncryptedEthValue => 'Giá trị ETH được mã hóa';

  @override
  String get bnsUpdateAction => 'Cập nhật';

  @override
  String get bnsRenewAction => 'Gia hạn';

  @override
  String get bnsNoteLabel => 'Ghi chú:';

  @override
  String get bnsEthAddressDescription => 'Địa chỉ ETH của chúng tôi tương thích với tất cả các chuỗi EVM';

  @override
  String get bnsPurchase => 'Mua';

  @override
  String get bnsPleaseFillField => 'Vui lòng điền vào trường này';

  @override
  String get bnsInvalidName => '';

  @override
  String get bnsInvalidBchatId => 'BChat ID không hợp lệ';

  @override
  String get bnsInvalidBelnetId => 'Belnet ID không hợp lệ';

  @override
  String get bnsInvalidEthAddress => 'Địa chỉ ETH không hợp lệ';

  @override
  String get bnsEnterValidWalletAddress => 'Nhập địa chỉ ví hợp lệ';

  @override
  String get bnsConfirmPurchase => 'Xác nhận mua';

  @override
  String get bnsYearLabel => 'Năm';

  @override
  String get bnsOwnerLabel => 'Chủ sở hữu';

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
  String get bnsUpdate => 'Cập nhật BNS';

  @override
  String get bnsRenewal => 'Gia hạn BNS';

  @override
  String get swap => 'Hoán đổi';

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
  String get restoredViaKeys => 'Bạn đã khôi phục bằng keys';

  @override
  String walletAlreadyExists(Object name) {
    return 'Ví có tên $name đã tồn tại!';
  }

  @override
  String get nodeAlreadyExists => 'Node này đã tồn tại';

  @override
  String get fee => 'Phí';

  @override
  String get noInternet => 'Không có kết nối internet!';

  @override
  String get noInternetMessage => 'Vui lòng kiểm tra kết nối internet và thử lại.';

  @override
  String get swapNotAvailable => 'Chức năng hoán đổi BDX hiện không khả dụng';

  @override
  String get tryAgain => 'Vui lòng thử lại sau một thời gian';

  @override
  String get exchange => 'Hoán đổi';

  @override
  String get youSend => 'Bạn gửi';

  @override
  String get youGet => 'Bạn nhận';

  @override
  String get floatingExchangeRate => 'Tỷ giá thả nổi';

  @override
  String get floatingRateDescription => 'Tỷ giá có thể thay đổi bất cứ lúc nào do điều kiện thị trường, vì vậy bạn có thể nhận được nhiều hoặc ít crypto hơn dự kiến.';

  @override
  String get searchCoins => 'Tìm kiếm coin';

  @override
  String get minimumAmount => 'Số tiền tối thiểu là';

  @override
  String get maximumAmount => 'Số tiền tối đa là';

  @override
  String get exchangeAmount => '';

  @override
  String get exchangeRate => 'Tỷ giá';

  @override
  String get receiver => 'Người nhận';

  @override
  String get amountReceived => 'Số tiền nhận';

  @override
  String get date => 'Ngày';

  @override
  String get expandDetails => 'Mở rộng chi tiết';

  @override
  String get view => 'Xem';

  @override
  String get noTransactionsMessage => 'Hiện chưa có giao dịch hoặc hoán đổi nào để hiển thị.';

  @override
  String get networkErrorCheckConnection => 'Lỗi mạng! Vui lòng kiểm tra kết nối internet.';

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
  String get searchCurrency => 'Tìm kiếm tiền tệ';

  @override
  String changePinLength(Object value) {
    return 'Chuyển sang PIN $value chữ số';
  }

  @override
  String get pleaseEnterAValidHeight => 'Vui lòng nhập chiều cao hợp lệ';

  @override
  String get invalidAddress => '';

  @override
  String get exchangePair => 'Cặp giao dịch';

  @override
  String get payment => 'Thanh toán';

  @override
  String get bnsConfirmUpdate => 'Xác nhận cập nhật';
}
