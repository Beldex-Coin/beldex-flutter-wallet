// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get unsupportedExchangePair => 'Cặp trao đổi không được hỗ trợ';

  @override
  String get account => 'Tài khoản';

  @override
  String get accountAlreadyExist => 'Tài khoản đã tồn tại';

  @override
  String get accountName => 'Tên tài khoản';

  @override
  String get accounts => 'Các tài khoản';

  @override
  String get add => 'Thêm';

  @override
  String get addAccount => 'Thêm tài khoản';

  @override
  String get addAddress => 'Thêm địa chỉ';

  @override
  String get addBns => 'Thêm BNS';

  @override
  String get addNode => 'Thêm Node';

  @override
  String get address_book => 'Danh bạ địa chỉ';

  @override
  String get addressShouldNotBeEmpty => 'Địa chỉ không được để trống';

  @override
  String get addSubAddress => 'Thêm địa chỉ phụ';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'Sau giao dịch đầu tiên, bạn sẽ có thể xem tại đây.';

  @override
  String get alert => 'Cảnh báo';

  @override
  String get allowFaceIdAuthentication => 'Cho phép xác thực bằng Face ID';

  @override
  String get amount => 'Số lượng';

  @override
  String get amountReceived => 'Số tiền nhận';

  @override
  String get appstore => 'AppStore';

  @override
  String get are_you_sure => 'Xác nhận?';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => 'Bạn có chắc chắn muốn xóa liên hệ đã chọn không?';

  @override
  String get auth_store_banned_for => 'Bị cấm vì';

  @override
  String get auth_store_banned_minutes => 'phút';

  @override
  String get auth_store_incorrect_password => 'Mã PIN không đúng';

  @override
  String get authenticated => 'Đã xác thực';

  @override
  String get available_balance => 'Số dư khả dụng';

  @override
  String get availableBdx => 'BDX khả dụng :';

  @override
  String get bdx => 'BDX';

  @override
  String get biometric_auth_reason => 'Quét dấu vân tay để xác thực';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'Tính năng sinh trắc học hiện đang bị tắt.\n Vui lòng bật tính năng xác thực sinh trắc học trong phần cài đặt của ứng dụng.';

  @override
  String blockConfirmed(Object count) {
    return '$count khối';
  }

  @override
  String blockRemaining(Object status) {
    return 'Còn $status khối';
  }

  @override
  String blocksConfirmed(Object count) {
    return '$count khối';
  }

  @override
  String blocksRemaining(Object status) {
    return 'Còn $status khối';
  }

  @override
  String get bns => 'BNS';

  @override
  String get bnsAddRecord => 'Thêm bản ghi';

  @override
  String get bnsBackupOwner => 'Chủ sở hữu dự phòng';

  @override
  String get bnsBchatId => 'ID BChat';

  @override
  String get bnsBelnetId => 'ID Belnet';

  @override
  String get bnsConfirmPurchase => 'Xác nhận mua';

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return 'Không thể giải mã bản ghi BNS cho $bnsName';
  }

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return 'Đã giải mã thành công bản ghi BNS cho $bnsName';
  }

  @override
  String get bnsEncryptedBchatValue => 'Giá trị BChat được mã hóa';

  @override
  String get bnsEncryptedBelnetValue => 'Giá trị Belnet được mã hóa';

  @override
  String get bnsEncryptedEthValue => 'Giá trị ETH được mã hóa';

  @override
  String get bnsEncryptedWalletValue => 'Giá trị ví được mã hóa';

  @override
  String get bnsEnterValidWalletAddress => 'Nhập địa chỉ ví hợp lệ';

  @override
  String get bnsEthAddress => 'Địa chỉ ETH';

  @override
  String get bnsEthAddressDescription => 'Địa chỉ ETH của chúng tôi tương thích với tất cả các chuỗi EVM';

  @override
  String get bnsExpirationHeight => 'Chiều cao hết hạn';

  @override
  String get bnsFetchingRecords => 'Đang lấy bản ghi BNS từ mạng';

  @override
  String get bnsInvalidBchatId => 'BChat ID không hợp lệ';

  @override
  String get bnsInvalidBelnetId => 'Belnet ID không hợp lệ';

  @override
  String get bnsInvalidEthAddress => 'Địa chỉ ETH không hợp lệ';

  @override
  String get bnsInvalidName => 'Tên BNS không hợp lệ';

  @override
  String get bnsInvalidOwnerAddress => 'Địa chỉ chủ sở hữu không hợp lệ.';

  @override
  String get bnsInvalidWalletAddress => 'Địa chỉ ví không hợp lệ. Để trống nếu bạn muốn sử dụng ví hiện tại làm chủ sở hữu BNS.';

  @override
  String get bnsNameHint => 'Tên cần mua thông qua Dịch vụ Tên Beldex';

  @override
  String get bnsNameIsTaken => 'Tên BNS đã được sử dụng. Hãy chọn tên khác.';

  @override
  String get bnsNewOwnerHint => 'Nhập địa chỉ ví của chủ sở hữu mới';

  @override
  String get bnsNoteLabel => 'Ghi chú:';

  @override
  String get bnsOwnerAndBackupDifferent => 'Địa chỉ chủ sở hữu và địa chỉ dự phòng phải khác nhau.';

  @override
  String get bnsOwnerHint => 'Địa chỉ ví của chủ sở hữu';

  @override
  String get bnsOwnerLabel => 'Chủ sở hữu';

  @override
  String get bnsOwnerOptional => 'Chủ sở hữu (Owner – Tùy chọn)';

  @override
  String get bnsPleaseFillField => 'Vui lòng điền vào trường này';

  @override
  String get bnsPrice => 'Giá';

  @override
  String get bnsPurchase => 'Mua';

  @override
  String get bnsPurchaseDescription => 'Mua hoặc cập nhật một bản ghi BNS.\n Nếu bạn mua một tên, có thể mất một hoặc hai phút để hiển thị trong danh sách.';

  @override
  String get bnsPurchasedSuccessfully => 'Đã mua BNS thành công';

  @override
  String get bnsRecordNameHint => 'Một tên BNS thuộc về bạn';

  @override
  String get bnsRecordNotFound => 'Bản ghi BNS được cung cấp không tồn tại hoặc không thuộc về ví này.';

  @override
  String get bnsRecords => 'Bản ghi BNS';

  @override
  String get bnsRecordsDescription => 'Tại đây bạn có thể tìm thấy tất cả các tên BNS thuộc sở hữu của ví này. Khi giải mã một bản ghi mà bạn sở hữu, hệ thống sẽ trả về tên và giá trị trong bản ghi BNS.';

  @override
  String get bnsRenewAction => 'Gia hạn';

  @override
  String get bnsRenewal => 'Gia hạn BNS';

  @override
  String get bnsUpdate => 'Cập nhật BNS';

  @override
  String get bnsUpdateAction => 'Cập nhật';

  @override
  String get bnsUpdateHeight => 'Chiều cao cập nhật';

  @override
  String get bnsUpdateNote => 'Bạn chỉ có thể cập nhật địa chỉ chủ sở hữu hoặc các giá trị tại một thời điểm.\n Nếu bạn muốn cập nhật cả hai, bạn có thể cập nhật giá trị trước khi chuyển quyền sở hữu hoặc sau khi chuyển quyền sở hữu.';

  @override
  String get bnsUpdateOwner => 'Cập nhật chủ sở hữu';

  @override
  String get bnsUpdateValues => 'Cập nhật giá trị';

  @override
  String get bnsYearFiveShort => '5 năm';

  @override
  String get bnsYearLabel => 'Năm';

  @override
  String get bnsYearOneShort => '1 năm';

  @override
  String get bnsYearTenShort => '10 năm';

  @override
  String get bnsYearTwoShort => '2 năm';

  @override
  String get bnsYouSave => 'Bạn tiết kiệm';

  @override
  String get buyBns => 'Mua BNS';

  @override
  String get cancel => 'Hủy';

  @override
  String change_current_node(Object node) {
    return 'Bạn có chắc chắn muốn thay đổi node hiện tại thành $node không?';
  }

  @override
  String get change_language => 'Đổi ngôn ngữ';

  @override
  String get changelog => 'Lịch sử cập nhật';

  @override
  String get changeWallet => 'Chuyển ví';

  @override
  String get chooseLanguage => 'Chọn ngôn ngữ';

  @override
  String get chooseSeedLanguage => 'Chọn ngôn ngữ Seed';

  @override
  String get clear => 'Xóa';

  @override
  String get confirm_sending => 'Xác nhận gửi';

  @override
  String get continue_text => 'Tiếp tục';

  @override
  String get copied => 'Đã sao chép';

  @override
  String get copyAndSaveTheSeedToContinue => 'Hãy sao chép và lưu seed để tiếp tục';

  @override
  String get copySeed => 'Sao chép Seed';

  @override
  String get create_new => 'Tạo ví mới';

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'KHÔNG BAO GIỜ nhập $item trong ví Beldex của bạn vào bất kỳ phần mềm hoặc trang web nào khác ngoài các ví Beldex CHÍNH THỨC được tải trực tiếp từ $app_store, trang web Beldex hoặc GitHub của Beldex. Bạn có chắc chắn muốn truy cập vào $item trong ví của mình không?';
  }

  @override
  String get date => 'Ngày';

  @override
  String get dateShouldNotBeEmpty => 'Ngày không được để trống';

  @override
  String get delete => 'Xóa';

  @override
  String get doYouWantToChangeYournPrimaryAccount => 'Bạn có muốn thay đổi tài khoản chính không?';

  @override
  String get doYouWantToExitTheWallet => 'Bạn có muốn thoát khỏi ví không?';

  @override
  String get doYouWantToReconnectnTheWallet => 'Bạn có muốn kết nối lại ví không?';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get enterAddress => 'Nhập địa chỉ';

  @override
  String get enterAmount => 'Nhập số lượng';

  @override
  String get enterAValidName => 'Nhập tên hợp lệ';

  @override
  String get enterAValidNameUpto15Characters => 'Nhập tên hợp lệ tối đa 15 ký tự';

  @override
  String get enterAValidNameUpto20Characters => 'Nhập tên hợp lệ tối đa 20 ký tự';

  @override
  String get enterAValidSubAddress => 'Nhập địa chỉ phụ hợp lệ';

  @override
  String get enterBdxToReceive => 'Nhập số BDX muốn nhận';

  @override
  String get enterBdxToSend => 'Nhập số BDX muốn gửi';

  @override
  String get enterName => 'Nhập tên';

  @override
  String get enterPin => 'Nhập mã PIN';

  @override
  String get enterValidHeightWithoutSpace => 'Nhập chiều cao block hợp lệ (không có khoảng trắng)';

  @override
  String get enterValidNameUpto15Characters => 'Nhập tên hợp lệ tối đa 15 ký tự';

  @override
  String get enterWalletName => 'Nhập tên ví';

  @override
  String get enterWalletName_ => 'Nhập tên ví';

  @override
  String get enterYourPin => 'Nhập mã PIN của bạn';

  @override
  String get error_text_address => 'Địa chỉ BDX không hợp lệ';

  @override
  String get error_text_contact_name => 'Tên liên hệ không được chứa ký tự \' , \"\n và phải có độ dài từ 1 đến 32 ký tự';

  @override
  String get error_text_keys => 'Khóa ví chỉ được chứa 64 ký tự dạng hex';

  @override
  String get error_text_node_address => 'Vui lòng nhập địa chỉ IPv4 hợp lệ';

  @override
  String get error_text_node_port => 'Cổng node chỉ có thể chứa các số từ 0 đến 65535';

  @override
  String get exchange => 'Hoán đổi';

  @override
  String get exchangeRate => 'Tỷ giá';

  @override
  String get expandDetails => 'Mở rộng chi tiết';

  @override
  String failed_authentication(Object state_error) {
    return 'Xác thực không thành công. $state_error';
  }

  @override
  String get faq => 'Câu hỏi thường gặp';

  @override
  String get fee => 'Phí';

  @override
  String get filters => 'Lọc theo';

  @override
  String get fiveDecimals => '5 - Năm (0.00000)';

  @override
  String get flashTransaction => 'Giao dịch Flash';

  @override
  String get floatingExchangeRate => 'Tỷ giá thả nổi';

  @override
  String get floatingRateDescription => 'Tỷ giá có thể thay đổi bất cứ lúc nào do điều kiện thị trường, vì vậy bạn có thể nhận được nhiều hoặc ít crypto hơn dự kiến.';

  @override
  String get fourDecimals => '4 - Bốn (0.0000)';

  @override
  String get full_balance => 'Tổng số dư';

  @override
  String get hidden_balance => 'Số dư ẩn';

  @override
  String get howCanWenhelpYou => 'Chúng tôi có thể giúp gì cho bạn?';

  @override
  String get incoming => 'Đến';

  @override
  String get initiatingTransactionDescription => 'Vui lòng không đóng cửa sổ này hoặc chuyển sang ứng dụng khác cho đến khi giao dịch được khởi tạo';

  @override
  String get initiatingTransactionTitle => 'Đang khởi tạo giao dịch...';

  @override
  String get labelName => 'Tên nhãn';

  @override
  String get legalDisclaimer => 'Tuyên bố pháp lý';

  @override
  String get loadingTheWallet => 'Đang tải ví…';

  @override
  String get loadingTheWalletDescription => 'Vui lòng không đóng cửa sổ này hoặc chuyển sang ứng dụng khác cho đến khi ví được tải xong.';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => 'Hãy đảm bảo đã sao lưu Seed khôi phục, địa chỉ ví và khóa riêng';

  @override
  String get max => 'Tối đa';

  @override
  String get maximumAmount => 'Số tiền tối đa là';

  @override
  String get minimumAmount => 'Số tiền tối thiểu là';

  @override
  String get myBns => 'BNS của tôi';

  @override
  String get name => 'Tên';

  @override
  String get nameShouldNotBeEmpty => 'Tên không được để trống';

  @override
  String get network_fee => 'Phí mạng';

  @override
  String get networkErrorCheckConnection => 'Lỗi mạng! Vui lòng kiểm tra kết nối internet.';

  @override
  String never_give_your(Object item) {
    return 'Không bao giờ cung cấp $item trong ví Beldex của bạn cho bất kỳ ai!';
  }

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Không bao giờ nhập $item trong ví Beldex của bạn vào bất kỳ phần mềm hoặc trang web nào khác ngoài các ví Beldex chính thức được tải trực tiếp từ $appStore, trang web Beldex hoặc GitHub của Beldex.';
  }

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'Không bao giờ chia sẻ seed của bạn cho bất kỳ ai! Hãy kiểm tra xung quanh để đảm bảo không có ai đang nhìn lén';

  @override
  String get new_subaddress_create => 'Tạo';

  @override
  String get new_wallet => 'Ví mới';

  @override
  String get no => 'Không';

  @override
  String get noAddressesInBook => 'Không có địa chỉ nào trong danh bạ';

  @override
  String get node_address => 'Địa chỉ Node ';

  @override
  String get node_port => 'Cổng Node';

  @override
  String get node_reset_settings_title => 'Đặt lại cài đặt ';

  @override
  String get nodeAlreadyExists => 'Node này đã tồn tại';

  @override
  String get nodeNameOptional => 'Tên Node (tùy chọn)';

  @override
  String get nodes => 'Nút';

  @override
  String get nodes_list_reset_to_default_message => 'Bạn có chắc muốn đặt lại cài đặt về mặc định không?';

  @override
  String get noInternet => 'Không có kết nối internet!';

  @override
  String get noInternetMessage => 'Vui lòng kiểm tra kết nối internet và thử lại.';

  @override
  String get note => 'Lưu ý:';

  @override
  String get noTransactionsMessage => 'Hiện chưa có giao dịch hoặc hoán đổi nào để hiển thị.';

  @override
  String get noTransactionsYet => 'Chưa có giao dịch!';

  @override
  String get ok => 'Ok';

  @override
  String get outgoing => 'Đi';

  @override
  String get passwordOptional => 'Mật khẩu (tùy chọn)';

  @override
  String get paste => 'Dán';

  @override
  String get pin_is_incorrect => 'Mã PIN không chính xác';

  @override
  String get playStore => 'Play Store';

  @override
  String get please_try_to_connect_to_another_node => 'Vui lòng thử kết nối với node khác';

  @override
  String get pleaseEnterAAmount => 'Vui lòng nhập số lượng';

  @override
  String get pleaseEnterABdxAddress => 'Vui lòng nhập địa chỉ BDX';

  @override
  String get pleaseEnterAValidAmount => 'Vui lòng nhập số lượng hợp lệ';

  @override
  String get pleaseEnterAValidSeed => 'Vui lòng nhập seed hợp lệ';

  @override
  String get re_enter_your_pin => 'Nhập lại mã PIN';

  @override
  String get receive => 'Nhận';

  @override
  String get receiver => 'Người nhận';

  @override
  String get reconnect => 'Kết nối lại';

  @override
  String get reconnectWallet => 'Kết nối lại ví';

  @override
  String get recoverySeed => 'Seed khôi phục';

  @override
  String get recoverySeedkey => 'Seed/Khóa khôi phục';

  @override
  String get removeContact => 'Xóa liên hệ';

  @override
  String get removeWallet => 'Xóa ví';

  @override
  String get rescan => 'Quét lại';

  @override
  String get rescanWallet => 'Quét lại ví ';

  @override
  String get reset => 'Đặt lại';

  @override
  String get restore_address => 'Địa chỉ';

  @override
  String get restore_description_from_keys => 'Sử dụng các khóa riêng đã lưu để khôi phục ví của bạn';

  @override
  String get restore_description_from_seed => 'Sử dụng khóa ghi nhớ 25 từ (Mnemonic) hoặc cụm seed để khôi phục ví của bạn';

  @override
  String get restore_description_from_seed_keys => 'Lấy lại ví của bạn từ seed/keys mà bạn đã lưu ở nơi an toàn';

  @override
  String get restore_from_seed_placeholder => 'Vui lòng nhập hoặc dán seed tại đây';

  @override
  String get restore_next => 'Tiếp theo';

  @override
  String get restore_recover => 'Khôi phục';

  @override
  String get restore_restore_wallet => 'Khôi phục ví';

  @override
  String get restore_title_from_keys => 'Khôi phục từ Keys';

  @override
  String get restore_title_from_seed => 'Khôi phục từ Seed';

  @override
  String get restore_title_from_seed_keys => 'Khôi phục từ seed/keys';

  @override
  String get restore_wallet => 'Sử dụng ví hiện có';

  @override
  String get restoredViaKeys => 'Bạn đã khôi phục bằng keys';

  @override
  String get save => 'Lưu';

  @override
  String get searchCoins => 'Tìm kiếm coin';

  @override
  String get searchCurrency => 'Tìm kiếm tiền tệ';

  @override
  String get seed_title => 'Seed';

  @override
  String get seedKeys => 'Seed & Khóa';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'Hãy chọn một tùy chọn để tạo hoặc khôi phục ví hiện có';

  @override
  String get selectLanguage => 'Chọn ngôn ngữ';

  @override
  String get send => 'Gửi';

  @override
  String get send_beldex_address => 'Địa chỉ Beldex hoặc tên BNS';

  @override
  String get send_estimated_fee => 'Phí ước tính:';

  @override
  String send_priority(Object transactionPriority) {
    return 'Mức ưu tiên $transactionPriority được đặt làm phí mặc định. Vào cài đặt để thay đổi mức ưu tiên giao dịch.';
  }

  @override
  String get sent => 'Đã gửi';

  @override
  String get service_fee => 'Phí dịch vụ 0.25%';

  @override
  String get settings_allow_biometric_authentication => 'Cho phép xác thực sinh trắc học';

  @override
  String get settings_balance_detail => 'Số thập phân';

  @override
  String get settings_change_pin => 'Đổi mã PIN';

  @override
  String get settings_currency => 'Tiền tệ';

  @override
  String get settings_current_node => 'Nút hiện tại';

  @override
  String get settings_dark_mode => 'Chế độ tối';

  @override
  String get settings_display_balance_as => 'Hiển thị số dư dưới dạng';

  @override
  String get settings_enable_fiat_currency => 'Bật chuyển đổi tiền tệ';

  @override
  String get settings_fee_priority => 'Mức ưu tiên phí';

  @override
  String get settings_personal => 'Cá nhân';

  @override
  String get settings_save_recipient_address => 'Lưu địa chỉ người nhận';

  @override
  String get settings_support => 'Hỗ trợ';

  @override
  String get settings_terms_and_conditions => 'Điều khoản & Điều kiện';

  @override
  String get settings_title => 'Cài đặt';

  @override
  String get setup_pin => 'Thiết lập mã PIN';

  @override
  String get setup_successful => 'Mã PIN của bạn đã được thiết lập thành công!';

  @override
  String get shareQr => 'Chia sẻ mã QR';

  @override
  String get show_keys => 'Hiển thị khóa';

  @override
  String get show_seed => 'Hiển thị Seed';

  @override
  String get spend_key_private => 'Khóa chi tiêu (riêng tư)';

  @override
  String get spend_key_public => 'Spend key (công khai)';

  @override
  String get status => 'Trạng thái:';

  @override
  String get subAddress => 'Địa chỉ phụ';

  @override
  String get subaddressAlreadyExist => 'Địa chỉ phụ đã tồn tại';

  @override
  String get swap => 'Hoán đổi';

  @override
  String get swap_amount_from => 'Số tiền gửi';

  @override
  String get swap_amount_sent => 'Số tiền đã gửi';

  @override
  String get swap_amount_to => 'Số tiền nhận';

  @override
  String get swap_and => 'và';

  @override
  String get swap_checkout => 'Thanh toán';

  @override
  String get swap_completed => 'Hoàn tất';

  @override
  String get swap_confirm_and_make_payment => 'Xác nhận & Thanh toán';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return 'Vui lòng đảm bảo nhập đúng địa chỉ cho chuỗi đã chọn - $blockchain. Nếu không, bạn sẽ mất tiền.';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return 'Nhập địa chỉ người nhận $currency của bạn';
  }

  @override
  String get swap_exchange_rate => 'Tỷ giá';

  @override
  String get swap_failed => 'Giao dịch thất bại';

  @override
  String get swap_funds_not_received => 'Không nhận được tiền trong vòng 3 giờ.\n Vui lòng kiểm tra tỷ giá và tạo giao dịch mới.';

  @override
  String get swap_i_agree_with => 'Tôi đồng ý với';

  @override
  String get swap_input_hash => 'Hash đầu vào';

  @override
  String get swap_input_output_hash => 'Hash đầu vào/đầu ra';

  @override
  String get swap_network_fee => 'Phí mạng';

  @override
  String get swap_network_label => 'MẠNG: ';

  @override
  String get swap_new_transaction => 'Giao dịch mới';

  @override
  String get swap_open_history => 'Xem lịch sử';

  @override
  String get swap_output_hash => 'Hash đầu ra';

  @override
  String get swap_privacy_policy => 'Chính sách bảo mật';

  @override
  String get swap_received_time => 'Thời gian nhận';

  @override
  String get swap_send_funds_notice => 'Bạn có 3 giờ để gửi tiền, nếu không giao dịch sẽ tự động bị hủy.\n Giao dịch sẽ được thực hiện khi tiền được nhận.';

  @override
  String get swap_send_funds_to_address_below => 'Gửi tiền đến địa chỉ bên dưới';

  @override
  String get swap_service_fee => 'Phí dịch vụ 0.25%';

  @override
  String get swap_start_over => 'Bắt đầu lại';

  @override
  String get swap_terms_of_use => 'Điều khoản sử dụng';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return 'Thời gian còn lại để gửi $amount $currency';
  }

  @override
  String swap_time_remaining(Object value) {
    return 'Thời gian còn lại: $value';
  }

  @override
  String get swap_transaction_preview => 'Xem trước giao dịch';

  @override
  String get swap_you_get => 'Bạn nhận';

  @override
  String get swapNotAvailable => 'Chức năng hoán đổi BDX hiện không khả dụng';

  @override
  String get sync_status_connecting => 'Đang kết nối';

  @override
  String get sync_status_failed_connect => 'Kết nối đến node thất bại';

  @override
  String get sync_status_starting_sync => 'Đang bắt đầu đồng bộ';

  @override
  String get sync_status_synchronized => 'Đã đồng bộ';

  @override
  String get sync_status_synchronizing => 'ĐANG ĐỒNG BỘ HÓA';

  @override
  String get test => 'Kiểm tra';

  @override
  String get testResult => 'Kết quả kiểm tra:';

  @override
  String get theAddressAlreadyExist => 'Địa chỉ đã tồn tại';

  @override
  String get thisNameAlreadyExist => 'Tên này đã tồn tại';

  @override
  String get transaction_details_amount => 'Số tiền';

  @override
  String get transaction_details_height => 'Chiều cao';

  @override
  String get transaction_details_recipient_address => 'Địa chỉ nhận';

  @override
  String get transaction_details_transaction_id => 'Mã giao dịch';

  @override
  String get transaction_priority_blink => 'Nhanh';

  @override
  String get transaction_priority_slow => 'Chậm';

  @override
  String get transactionInitiatedSuccessfully => 'Giao dịch đã được khởi tạo thành công';

  @override
  String get transactions => 'Giao dịch';

  @override
  String get transactions_by_date => 'Giao dịch theo ngày';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => 'Chuyển BDX nhanh hơn với Flash Transaction!';

  @override
  String get tryAgain => 'Vui lòng thử lại sau một thời gian';

  @override
  String get twoDecimals => '2 - Hai (0.00)';

  @override
  String get usePattern => 'SỬ DỤNG MẪU';

  @override
  String get userNameOptional => 'Tên người dùng (tùy chọn)';

  @override
  String version(Object currentVersion) {
    return 'Phiên bản $currentVersion';
  }

  @override
  String get view => 'Xem';

  @override
  String get view_key_private => 'Khóa xem (riêng tư)';

  @override
  String get view_key_public => 'Xem key (công khai)';

  @override
  String get wallet => 'Ví';

  @override
  String get wallet_keys => 'Keys của ví';

  @override
  String wallet_list_failed_to_load(Object error, Object wallet_name) {
    return 'Không thể tải ví $wallet_name. $error';
  }

  @override
  String wallet_list_failed_to_remove(Object error, Object wallet_name) {
    return 'Không thể xóa ví $wallet_name. $error';
  }

  @override
  String get wallet_list_load_wallet => 'Tải ví';

  @override
  String wallet_list_loading_wallet(Object wallet_name) {
    return 'Đang tải ví $wallet_name';
  }

  @override
  String wallet_list_removing_wallet(Object wallet_name) {
    return 'Đang xóa ví $wallet_name';
  }

  @override
  String get wallet_list_title => 'Ví Beldex';

  @override
  String get wallet_name => 'Tên ví ';

  @override
  String get wallet_restoration_store_incorrect_seed_length => 'Độ dài seed không chính xác';

  @override
  String get walletAddress => 'Địa chỉ ví';

  @override
  String walletAlreadyExists(Object name) {
    return 'Ví có tên $name đã tồn tại!';
  }

  @override
  String get walletRestore => 'Khôi phục ví';

  @override
  String get wallets => 'Các ví';

  @override
  String get walletSettings => 'Cài đặt ví';

  @override
  String get welcomeToBeldexWallet => 'Chào mừng bạn đến với Ví Beldex :)';

  @override
  String get widgets_restore_from_blockheight => 'Khôi phục từ Blockheight';

  @override
  String get widgets_restore_from_date => 'Khôi phục từ ngày ';

  @override
  String get yes => 'Có';

  @override
  String get yes_im_sure => 'Có, tôi chắc chắn!';

  @override
  String get yesterday => 'Hôm qua';

  @override
  String get youAreAboutToDeletenYourWallet => 'Bạn sắp xóa ví của mình!';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => 'Bạn không thể xem seed vì bạn đã khôi phục ví bằng khóa';

  @override
  String get youGet => 'Bạn nhận';

  @override
  String get youSend => 'Bạn gửi';

  @override
  String get zeroDecimal => '0 - Không (000)';

  @override
  String changePinLength(Object value) {
    return 'Chuyển sang PIN $value chữ số';
  }

  @override
  String get pleaseEnterAValidHeight => 'Vui lòng nhập chiều cao hợp lệ';

  @override
  String get invalidAddress => 'Địa chỉ không hợp lệ';

  @override
  String get exchangePair => 'Cặp giao dịch';

  @override
  String get payment => 'Thanh toán';

  @override
  String get bnsConfirmUpdate => 'Xác nhận cập nhật';

  @override
  String get bnsRenewedSuccessfully => 'Đã gia hạn BNS thành công';

  @override
  String get bnsSameBchatId => 'Cùng ID BChat';

  @override
  String get bnsSameBelnetId => 'Cùng ID BelNet';

  @override
  String get bnsSameEthAddress => 'Cùng địa chỉ ETH';

  @override
  String get bnsSameOwnerAddress => 'Cùng địa chỉ chủ sở hữu';

  @override
  String get bnsSameWalletAddress => 'Cùng địa chỉ ví';

  @override
  String get bnsUpdatedSuccessfully => 'Đã cập nhật BNS thành công';

  @override
  String get bnsWaitForFetch => 'Vui lòng đợi cho đến khi chúng tôi lấy bản ghi BNS từ mạng';

  @override
  String get bnsYearFive => '5 năm';

  @override
  String get bnsYearOne => '1 năm';

  @override
  String get bnsYearTen => '10 năm';

  @override
  String get bnsYearTwo => '2 năm';

  @override
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return 'Bạn có thực sự muốn mở khóa stake của mình khỏi $masterNodeKey không?';
  }

  @override
  String get checking => 'Đang kiểm tra...';

  @override
  String get checkingNodeConnection => 'Đang kiểm tra kết nối node...';

  @override
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return 'Xác nhận giao dịch\nSố tiền: $amount\nPhí: $fee';
  }

  @override
  String get committingTheTransaction => 'Đang xác nhận giao dịch';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => 'Xác nhận mã PIN, hình mở khóa hoặc mật khẩu khóa màn hình';

  @override
  String get connectionFailed => 'Kết nối thất bại';

  @override
  String get do_you_want_to_exit_an_app => 'Bạn có muốn thoát khỏi ứng dụng không?';

  @override
  String get enterAValidAddress => 'Nhập địa chỉ hợp lệ';

  @override
  String get error => 'Lỗi';

  @override
  String get error_text_beldex => 'Giá trị Beldex không thể vượt quá số dư khả dụng.\nSố chữ số thập phân phải nhỏ hơn hoặc bằng 9';

  @override
  String get error_text_fiat => 'Giá trị số tiền không thể vượt quá số dư khả dụng.\nSố chữ số thập phân phải nhỏ hơn hoặc bằng 2';

  @override
  String get error_text_service_node => 'Khóa Master Node chỉ có thể chứa 64 ký tự thập lục phân';

  @override
  String get exchangeAmount => 'Số tiền trao đổi';

  @override
  String get failedToGetOutputDistribution => 'Không thể lấy phân bổ đầu ra';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return 'Giao dịch Flash là các giao dịch tức thì.\nMức ưu tiên $transactionPriority được đặt làm phí mặc định';
  }

  @override
  String get important => 'QUAN TRỌNG';

  @override
  String get keys_title => 'Khóa';

  @override
  String get noPendingTransaction => 'Không có giao dịch đang chờ xử lý';

  @override
  String get nothing_staked => 'Chưa có gì được stake';

  @override
  String openalias_alert_content(Object recipient_name) {
    return 'Bạn sẽ gửi tiền đến\n$recipient_name';
  }

  @override
  String get openalias_alert_title => 'Đã phát hiện người nhận Beldex';

  @override
  String get pending => '(đang chờ xử lý)';

  @override
  String get please_select => 'Vui lòng chọn:';

  @override
  String get pleaseAddAMainnetNode => 'Vui lòng thêm node mainnet';

  @override
  String get received => 'Đã nhận';

  @override
  String get reconnect_alert_text => 'Bạn có chắc chắn muốn kết nối lại không?';

  @override
  String get reconnection => 'Kết nối lại';

  @override
  String get remove_node => 'Xóa node';

  @override
  String get remove_node_message => 'Bạn có chắc chắn muốn xóa node đã chọn không?';

  @override
  String get rename => 'Đổi tên';

  @override
  String router_no_route(Object name) {
    return 'Không có tuyến đường nào được xác định cho $name';
  }

  @override
  String get seed_share => 'Chia sẻ seed';

  @override
  String get send_your_wallet => 'Ví của bạn';

  @override
  String get sending => 'Đang gửi';

  @override
  String get service_node_key => 'Khóa Master Node';

  @override
  String get settings_none => 'Không có';

  @override
  String get stake_beldex => 'Stake Beldex';

  @override
  String get stake_more => 'Stake thêm';

  @override
  String get start_staking => 'Bắt đầu stake';

  @override
  String get subaddress_title => 'Danh sách địa chỉ phụ';

  @override
  String get subAddresses => 'Địa chỉ phụ';

  @override
  String get success => 'Thành công';

  @override
  String get swap_confirmations => 'Xác nhận';

  @override
  String get swap_confirmed => 'Đã xác nhận';

  @override
  String swap_confirmed_in_blockchain(Object currencyFrom, Object currencyTo) {
    return 'Sau khi $currencyFrom được xác nhận trên blockchain, chúng tôi sẽ bắt đầu đổi sang $currencyTo';
  }

  @override
  String get swap_confirming_in_progress => 'Đang xác nhận';

  @override
  String swap_done_exchanging(Object currencyFrom, Object currencyTo) {
    return 'Đã hoàn tất việc đổi $currencyFrom sang $currencyTo';
  }

  @override
  String swap_enter_extra_id(Object extraIdName) {
    return 'Nhập $extraIdName';
  }

  @override
  String swap_enter_refund_address(Object currency) {
    return 'Nhập địa chỉ hoàn tiền $currency của bạn';
  }

  @override
  String get swap_estimated_time => 'Thời gian ước tính';

  @override
  String get swap_estimated_time_value => '5–30 phút';

  @override
  String swap_exchange_address(Object currency, Object exchangeName) {
    return 'Địa chỉ $exchangeName ($currency)';
  }

  @override
  String get swap_exchanging => 'Đang trao đổi';

  @override
  String swap_exchanging_currency(Object currencyFrom, Object currencyTo) {
    return 'Đang đổi $currencyFrom sang $currencyTo';
  }

  @override
  String get swap_expired => 'Đã hết hạn';

  @override
  String swap_extra_id_info(Object currency, Object extraIdName) {
    return 'Vui lòng nhập $extraIdName cho địa chỉ nhận $currency của bạn nếu ví cung cấp thông tin này. Giao dịch sẽ không được thực hiện nếu bạn bỏ qua. Nếu ví của bạn không yêu cầu $extraIdName, hãy bỏ chọn.';
  }

  @override
  String get swap_funds_sent_to_wallet => 'Tiền đã được gửi vào ví của bạn';

  @override
  String get swap_history => 'Lịch sử';

  @override
  String get swap_maximum_amount_changed => 'Số tiền tối đa đã thay đổi. Giá trị mới là';

  @override
  String get swap_minimum_amount_changed => 'Số tiền tối thiểu đã thay đổi. Giá trị mới là';

  @override
  String swap_my_wallet_requires_extra_id(Object extraIdName) {
    return 'Ví của tôi yêu cầu $extraIdName';
  }

  @override
  String get swap_overdue => 'Quá hạn';

  @override
  String swap_please_enter_extra_id(Object extraIdName) {
    return 'Vui lòng nhập $extraIdName';
  }

  @override
  String get swap_process_wait => 'Quá trình sẽ mất vài phút. Vui lòng đợi.';

  @override
  String swap_recipient_address_with_currency(Object currency) {
    return 'Địa chỉ người nhận ($currency)';
  }

  @override
  String get swap_refund_address => 'Địa chỉ hoàn tiền';

  @override
  String get swap_refund_wallet_address => 'Địa chỉ ví hoàn tiền';

  @override
  String get swap_see_input_hash_in_explorer => 'Xem hash đầu vào trên trình khám phá';

  @override
  String get swap_sending_funds_to_wallet => 'Đang gửi tiền vào ví của bạn';

  @override
  String get swap_you_can_initiate_new_transaction => 'Bạn có thể bắt đầu một giao dịch mới. Bạn luôn có thể kiểm tra trạng thái của giao dịch này trong lịch sử giao dịch.';

  @override
  String get swap_you_dont_have_to_wait_here => 'Bạn không cần phải chờ ở đây';

  @override
  String get swap_you_sent => 'Bạn đã gửi';

  @override
  String get swapTransactionReport => 'Beldex_wallet_swap_transaction_report';

  @override
  String get sync_status_connected => 'ĐÃ KẾT NỐI';

  @override
  String get sync_status_not_connected => 'CHƯA KẾT NỐI';

  @override
  String get syncInfo => 'Thông tin đồng bộ hóa';

  @override
  String get title_confirm_unlock_stake => 'Mở khóa stake';

  @override
  String get title_new_stake => 'Stake mới';

  @override
  String get title_stakes => 'Các khoản stake';

  @override
  String get today => 'Hôm nay';

  @override
  String get touchTheFingerprintSensor => 'Chạm vào cảm biến vân tay';

  @override
  String transaction_details_copied(Object title) {
    return 'Đã sao chép $title vào bộ nhớ tạm';
  }

  @override
  String get transaction_details_payment_id => 'ID thanh toán';

  @override
  String get transaction_details_title => 'Chi tiết giao dịch';

  @override
  String get transaction_sent => 'Đã gửi giao dịch!';

  @override
  String get transactionReport => 'Báo cáo giao dịch';

  @override
  String get unable_unlock_stake => 'Không thể mở khóa stake';

  @override
  String get unlock_stake_requested => 'Đã yêu cầu mở khóa stake';

  @override
  String get unlockBeldexWallet => 'Mở khóa ví Beldex';

  @override
  String get wallet_menu => 'Menu';

  @override
  String get your_contributions => 'Đóng góp của bạn';

  @override
  String get seed_language_chinese => 'Chinese (simplified)';

  @override
  String get seed_language_dutch => 'Dutch';

  @override
  String get seed_language_english => 'English';

  @override
  String get seed_language_french => 'French';

  @override
  String get seed_language_german => 'German';

  @override
  String get seed_language_italian => 'Italian';

  @override
  String get seed_language_japanese => 'Japanese';

  @override
  String get seed_language_portuguese => 'Portuguese';

  @override
  String get seed_language_russian => 'Russian';

  @override
  String get seed_language_spanish => 'Spanish';
}
