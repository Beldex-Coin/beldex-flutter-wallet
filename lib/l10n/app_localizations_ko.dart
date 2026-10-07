// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get unsupportedExchangePair => '지원되지 않는 교환 쌍';

  @override
  String get account => '계정';

  @override
  String get accountAlreadyExist => '이미 존재하는 계정입니다';

  @override
  String get accountName => '계정 이름';

  @override
  String get accounts => '계정 목록';

  @override
  String get add => '추가';

  @override
  String get addAccount => '계정 추가';

  @override
  String get addAddress => '주소 추가';

  @override
  String get addBns => 'BNS 추가';

  @override
  String get addNode => '노드 추가';

  @override
  String get address_book => '주소록';

  @override
  String get addressShouldNotBeEmpty => '주소를 입력해야 합니다';

  @override
  String get addSubAddress => '서브 주소 추가';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => ' 첫 거래 이후 여기에서 확인할 수 있습니다.';

  @override
  String get alert => '알림';

  @override
  String get allowFaceIdAuthentication => 'Face ID 인증 허용';

  @override
  String get amount => '금액';

  @override
  String get amountReceived => '수신 금액';

  @override
  String get appstore => 'AppStore';

  @override
  String get are_you_sure => '정말로 종료하시겠습니까?';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => '선택한 연락처를 삭제하시겠습니까?';

  @override
  String get auth_store_banned_for => '금지 사유';

  @override
  String get auth_store_banned_minutes => '분';

  @override
  String get auth_store_incorrect_password => '잘못된 PIN';

  @override
  String get authenticated => '인증됨';

  @override
  String get available_balance => '사용 가능 잔액';

  @override
  String get availableBdx => '사용 가능한 BDX :';

  @override
  String get bdx => 'BDX';

  @override
  String get biometric_auth_reason => '인증하려면 지문을 스캔하세요';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => '생체 인증 기능이 현재 비활성화되어 있습니다.\n앱 설정에서 생체 인증 허용 기능을 활성화해 주세요.';

  @override
  String blockConfirmed(Object count) {
    return '$count 블록';
  }

  @override
  String blockRemaining(Object status) {
    return '$status 블록 남음';
  }

  @override
  String blocksConfirmed(Object count) {
    return '$count 블록';
  }

  @override
  String blocksRemaining(Object status) {
    return '$status 블록 남음';
  }

  @override
  String get bns => 'BNS';

  @override
  String get bnsAddRecord => '레코드 추가';

  @override
  String get bnsBackupOwner => '백업 소유자';

  @override
  String get bnsBchatId => 'BChat ID';

  @override
  String get bnsBelnetId => 'Belnet ID';

  @override
  String get bnsConfirmPurchase => '구매 확인';

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return '$bnsName의 BNS 레코드를 복호화하지 못했습니다';
  }

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return '$bnsName의 BNS 레코드가 성공적으로 복호화되었습니다';
  }

  @override
  String get bnsEncryptedBchatValue => '암호화된 BChat 값';

  @override
  String get bnsEncryptedBelnetValue => '암호화된 Belnet 값';

  @override
  String get bnsEncryptedEthValue => '암호화된 ETH 값';

  @override
  String get bnsEncryptedWalletValue => '암호화된 지갑 값';

  @override
  String get bnsEnterValidWalletAddress => '유효한 지갑 주소를 입력하세요.';

  @override
  String get bnsEthAddress => 'ETH 주소';

  @override
  String get bnsEthAddressDescription => '당사의 ETH 주소는 모든 EVM 체인에서 호환됩니다.';

  @override
  String get bnsExpirationHeight => '만료 높이';

  @override
  String get bnsFetchingRecords => '네트워크에서 BNS 레코드를 가져오는 중...';

  @override
  String get bnsInvalidBchatId => '유효하지 않은 BChat ID';

  @override
  String get bnsInvalidBelnetId => '유효하지 않은 Belnet ID';

  @override
  String get bnsInvalidEthAddress => '유효하지 않은 ETH 주소';

  @override
  String get bnsInvalidName => '잘못된 BNS 이름';

  @override
  String get bnsInvalidOwnerAddress => '소유자 주소가 잘못되었습니다.';

  @override
  String get bnsInvalidWalletAddress => '잘못된 지갑 주소입니다. 현재 지갑을 BNS 소유자로 사용하려면 비워 두세요.';

  @override
  String get bnsNameHint => 'Beldex Name Service를 통해 구매할 이름';

  @override
  String get bnsNameIsTaken => 'BNS 이름이 이미 사용 중입니다. 다른 이름을 선택하세요.';

  @override
  String get bnsNewOwnerHint => '새 소유자의 지갑 주소를 입력하세요';

  @override
  String get bnsNoteLabel => '참고: ';

  @override
  String get bnsOwnerAndBackupDifferent => '소유자 주소와 백업 주소는 서로 달라야 합니다.';

  @override
  String get bnsOwnerHint => '소유자의 지갑 주소';

  @override
  String get bnsOwnerLabel => '소유자';

  @override
  String get bnsOwnerOptional => '소유자 (선택 사항)';

  @override
  String get bnsPleaseFillField => '이 필드를 입력해 주세요';

  @override
  String get bnsPrice => '가격';

  @override
  String get bnsPurchase => '구매';

  @override
  String get bnsPurchaseDescription => 'BNS 레코드를 구매하거나 당신은 절약합니다업데이트할 수 있습니다.\n 이름을 구매한 경우, 목록에 표시되기까지 1~2분 정도 소요될 수 있습니다.';

  @override
  String get bnsPurchasedSuccessfully => 'BNS를 성공적으로 구매했습니다';

  @override
  String get bnsRecordNameHint => '귀하가 소유한 BNS 이름';

  @override
  String get bnsRecordNotFound => '지정된 BNS 레코드가 존재하지 않거나 이 지갑에 속하지 않습니다.';

  @override
  String get bnsRecords => 'BNS 레코드';

  @override
  String get bnsRecordsDescription => '이 지갑이 소유한 모든 BNS 이름을 확인할 수 있습니다.\n 소유한 레코드를 복호화하면 해당 BNS 레코드의 이름과 값이 반환됩니다.';

  @override
  String get bnsRenewAction => '갱신';

  @override
  String get bnsRenewal => 'BNS 갱신';

  @override
  String get bnsUpdate => 'BNS 업데이트';

  @override
  String get bnsUpdateAction => '업데이트';

  @override
  String get bnsUpdateHeight => '업데이트 높이';

  @override
  String get bnsUpdateNote => '한 번에 소유자 주소 또는 값 중 하나만 업데이트할 수 있습니다.\n 둘 다 업데이트하려면, 소유권 이전 전에 값을 먼저 업데이트하거나\n 소유권 이전 후에 값을 업데이트해야 합니다.';

  @override
  String get bnsUpdateOwner => '소유자 업데이트';

  @override
  String get bnsUpdateValues => '값 업데이트';

  @override
  String get bnsYearFiveShort => '5년';

  @override
  String get bnsYearLabel => '기간';

  @override
  String get bnsYearOneShort => '1년';

  @override
  String get bnsYearTenShort => '10년';

  @override
  String get bnsYearTwoShort => '2년';

  @override
  String get bnsYouSave => '당신은 절약합니다';

  @override
  String get buyBns => 'BNS 구매';

  @override
  String get cancel => '취소';

  @override
  String change_current_node(Object node) {
    return '현재 노드를 $node(으)로 변경하시겠습니까?';
  }

  @override
  String get change_language => '언어 변경';

  @override
  String get changelog => '변경 로그';

  @override
  String get changeWallet => '지갑 변경';

  @override
  String get chooseLanguage => '언어 선택';

  @override
  String get chooseSeedLanguage => '시드 언어 선택';

  @override
  String get clear => '지우기';

  @override
  String get confirm_sending => '전송 확인';

  @override
  String get continue_text => '계속';

  @override
  String get copied => '복사됨';

  @override
  String get copyAndSaveTheSeedToContinue => '시드를 복사하고 저장한 후 계속하세요';

  @override
  String get copySeed => '시드 복사';

  @override
  String get create_new => '새 지갑 생성';

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'Beldex 지갑의 $item을(를) $app_store, Beldex 웹사이트 또는 Beldex GitHub에서 직접 다운로드한 공식 Beldex 지갑 이외의 소프트웨어나 웹사이트에 절대로 입력하지 마세요. 지갑 $item에 액세스하시겠습니까?';
  }

  @override
  String get date => '날짜';

  @override
  String get dateShouldNotBeEmpty => '날짜를 입력해야 합니다';

  @override
  String get delete => '삭제';

  @override
  String get doYouWantToChangeYournPrimaryAccount => '기본 계정을 변경하시겠습니까?';

  @override
  String get doYouWantToExitTheWallet => '지갑을 종료하시겠습니까?';

  @override
  String get doYouWantToReconnectnTheWallet => '지갑을 재연결하시겠습니까?';

  @override
  String get edit => '수정';

  @override
  String get enterAddress => '주소 입력';

  @override
  String get enterAmount => '금액 입력';

  @override
  String get enterAValidName => '유효한 이름을 입력하세요';

  @override
  String get enterAValidNameUpto15Characters => '최대 15자 이내의 유효한 이름을 입력하세요';

  @override
  String get enterAValidNameUpto20Characters => '20자 이내의 유효한 이름을 입력하세요';

  @override
  String get enterAValidSubAddress => '유효한 하위 주소를 입력하세요';

  @override
  String get enterBdxToReceive => '수신할 BDX 입력';

  @override
  String get enterBdxToSend => '전송할 BDX 입력';

  @override
  String get enterName => '이름 입력';

  @override
  String get enterPin => 'PIN 입력';

  @override
  String get enterValidHeightWithoutSpace => '공백 없이 유효한 블록 높이를 입력하세요';

  @override
  String get enterValidNameUpto15Characters => '유효한 이름을 입력하세요 (최대 15자)';

  @override
  String get enterWalletName => '지갑 이름 입력';

  @override
  String get enterWalletName_ => '지갑 이름 입력';

  @override
  String get enterYourPin => 'PIN을 입력하세요';

  @override
  String get error_text_address => '유효하지 않은 BDX 주소입니다';

  @override
  String get error_text_contact_name => '연락처 이름에는 \' , \" 기호를 포함할 수 없으며\n 1자 이상 32자 이하이어야 합니다';

  @override
  String get error_text_keys => '지갑 키는 16진수 64자만 포함할 수 있습니다';

  @override
  String get error_text_node_address => 'IPv4 주소를 입력하세요';

  @override
  String get error_text_node_port => '노드 포트에는 0에서 65535 사이의 숫자만 입력할 수 있습니다';

  @override
  String get exchange => '환전';

  @override
  String get exchangeRate => '환율';

  @override
  String get expandDetails => '세부 정보 펼치기';

  @override
  String failed_authentication(Object state_error) {
    return '인증에 실패했습니다. $state_error';
  }

  @override
  String get faq => 'FAQ';

  @override
  String get fee => '수수료';

  @override
  String get filters => '필터';

  @override
  String get fiveDecimals => '5자리 (0.00000)';

  @override
  String get flashTransaction => '플래시 트랜잭션';

  @override
  String get floatingExchangeRate => '변동 환율';

  @override
  String get floatingRateDescription => '변동 환율은 시장 상황에 따라 언제든지 변경될 수 있으며,예상보다 더 많거나 적은 암호화폐를 받을 수 있습니다.';

  @override
  String get fourDecimals => '4자리 (0.0000)';

  @override
  String get full_balance => '전체 잔액';

  @override
  String get hidden_balance => '숨김 잔액';

  @override
  String get howCanWenhelpYou => '어떻게 도와드릴까요?';

  @override
  String get incoming => '입금';

  @override
  String get initiatingTransactionDescription => '거래가 시작될 때까지 이 창을 닫거나\n 다른 앱으로 이동하지 마세요';

  @override
  String get initiatingTransactionTitle => '거래 시작 중..';

  @override
  String get labelName => '라벨 이름';

  @override
  String get legalDisclaimer => '법적 고지';

  @override
  String get loadingTheWallet => '지갑 로딩 중…';

  @override
  String get loadingTheWalletDescription => '지갑을 불러오는 동안 이 창을 닫거나 다른 앱으로 이동하지 마십시오';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => '복구 시드, 지갑 주소 및 개인 키를 반드시 백업하세요';

  @override
  String get max => '최대';

  @override
  String get maximumAmount => '최대 금액은';

  @override
  String get minimumAmount => '최소 금액은';

  @override
  String get myBns => '내 BNS';

  @override
  String get name => '이름';

  @override
  String get nameShouldNotBeEmpty => '이름은 비워둘 수 없습니다';

  @override
  String get network_fee => '네트워크 수수료';

  @override
  String get networkErrorCheckConnection => '네트워크 오류! 인터넷 연결을 확인하세요.';

  @override
  String never_give_your(Object item) {
    return 'Beldex 지갑의 $item을(를) 절대로 다른 사람에게 제공하지 마세요!';
  }

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Beldex 지갑의 $item을(를) $appStore, Beldex 웹사이트 또는 Beldex GitHub에서 직접 다운로드한 공식 Beldex 지갑 이외의 소프트웨어나 웹사이트에 절대 입력하지 마세요.';
  }

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => '시드를 절대 다른 사람과 공유하지 마세요! 주변을 확인하여 다른 사람이 보고 있지 않은지 확인하세요';

  @override
  String get new_subaddress_create => '생성';

  @override
  String get new_wallet => '새 지갑';

  @override
  String get no => '아니요';

  @override
  String get noAddressesInBook => '주소록에 저장된 주소가 없습니다';

  @override
  String get node_address => '노드 주소';

  @override
  String get node_port => '노드 포트';

  @override
  String get node_reset_settings_title => '설정 초기화 ';

  @override
  String get nodeAlreadyExists => '이미 존재하는 노드입니다';

  @override
  String get nodeNameOptional => '노드 이름 (선택 사항)';

  @override
  String get nodes => '노드';

  @override
  String get nodes_list_reset_to_default_message => '설정을 기본값으로 초기화하시겠습니까? ';

  @override
  String get noInternet => '인터넷 연결 없음!';

  @override
  String get noInternetMessage => '인터넷 연결을 확인한 후 다시 시도하세요.';

  @override
  String get note => '주의:';

  @override
  String get noTransactionsMessage => '표시할 거래 또는 환전 내역이 없습니다.';

  @override
  String get noTransactionsYet => '아직 거래가 없습니다!';

  @override
  String get ok => '확인';

  @override
  String get outgoing => '출금';

  @override
  String get passwordOptional => '비밀번호 (선택 사항)';

  @override
  String get paste => '붙여넣기';

  @override
  String get pin_is_incorrect => 'PIN이 올바르지 않습니다';

  @override
  String get playStore => 'Play 스토어';

  @override
  String get please_try_to_connect_to_another_node => '다른 노드에 연결을 시도해주세요';

  @override
  String get pleaseEnterAAmount => '금액을 입력하세요';

  @override
  String get pleaseEnterABdxAddress => 'BDX 주소를 입력하세요';

  @override
  String get pleaseEnterAValidAmount => '유효한 금액을 입력하세요';

  @override
  String get pleaseEnterAValidSeed => '유효한 시드를 입력하세요';

  @override
  String get re_enter_your_pin => 'PIN을 다시 입력하세요';

  @override
  String get receive => '받기';

  @override
  String get receiver => '수신자';

  @override
  String get reconnect => '재연결';

  @override
  String get reconnectWallet => '지갑을 다시 연결하시겠습니까';

  @override
  String get recoverySeed => '복구 시드';

  @override
  String get recoverySeedkey => '복구 시드/키';

  @override
  String get removeContact => '연락처 삭제';

  @override
  String get removeWallet => '지갑 삭제';

  @override
  String get rescan => '재스캔';

  @override
  String get rescanWallet => '지갑 재스캔';

  @override
  String get reset => '초기화';

  @override
  String get restore_address => '주소';

  @override
  String get restore_description_from_keys => '개인 키에서 생성된 키 입력값을 사용하여 지갑을 복원하세요.';

  @override
  String get restore_description_from_seed => '25단어 니모닉 키 또는 시드 구문을 사용하여 지갑을 복원하세요.';

  @override
  String get restore_description_from_seed_keys => '안전한 장소에 저장해둔 시드/키를 사용하여 지갑을 복구하세요';

  @override
  String get restore_from_seed_placeholder => '시드를 입력하거나 붙여넣으세요';

  @override
  String get restore_next => '다음';

  @override
  String get restore_recover => '복원';

  @override
  String get restore_restore_wallet => '지갑 복원';

  @override
  String get restore_title_from_keys => '키로 복원';

  @override
  String get restore_title_from_seed => '시드로 복원';

  @override
  String get restore_title_from_seed_keys => '시드/키로 복원';

  @override
  String get restore_wallet => '기존 지갑 사용';

  @override
  String get restoredViaKeys => '키를 통해 복원되었습니다';

  @override
  String get save => '저장';

  @override
  String get searchCoins => '코인 검색';

  @override
  String get searchCurrency => '통화 검색';

  @override
  String get seed_title => '시드';

  @override
  String get seedKeys => '시드 및 키';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => '기존 지갑을 복구하거나 새로 생성할 옵션을 선택하세요';

  @override
  String get selectLanguage => '언어 선택';

  @override
  String get send => '보내기';

  @override
  String get send_beldex_address => '벨덱스 주소 또는 BNS 이름';

  @override
  String get send_estimated_fee => '예상 수수료:';

  @override
  String send_priority(Object transactionPriority) {
    return '$transactionPriority 우선순위가 기본 수수료로 설정되어 있습니다. 거래 우선순위를 변경하려면 설정으로 이동하세요.';
  }

  @override
  String get sent => '보냄';

  @override
  String get service_fee => '서비스 수수료: 0.25%';

  @override
  String get settings_allow_biometric_authentication => '생체 인증 허용';

  @override
  String get settings_balance_detail => '소수점';

  @override
  String get settings_change_pin => 'PIN 변경';

  @override
  String get settings_currency => '통화 선택';

  @override
  String get settings_current_node => '현재 노드';

  @override
  String get settings_dark_mode => '다크 모드';

  @override
  String get settings_display_balance_as => '잔액 표시 방식';

  @override
  String get settings_enable_fiat_currency => '법정화폐 환산 활성화';

  @override
  String get settings_fee_priority => '수수료 우선순위';

  @override
  String get settings_personal => '개인 설정';

  @override
  String get settings_save_recipient_address => '수신 주소 저장';

  @override
  String get settings_support => '지원';

  @override
  String get settings_terms_and_conditions => '이용 약관';

  @override
  String get settings_title => '설정';

  @override
  String get setup_pin => 'PIN 설정';

  @override
  String get setup_successful => 'PIN이 성공적으로 설정되었습니다!';

  @override
  String get shareQr => 'QR 코드 공유';

  @override
  String get show_keys => '키 보기';

  @override
  String get show_seed => '시드 보기';

  @override
  String get spend_key_private => '사용 키 (개인 키)';

  @override
  String get spend_key_public => '지출 키 (공개)';

  @override
  String get status => '상태:';

  @override
  String get subAddress => '서브 주소';

  @override
  String get subaddressAlreadyExist => '하위 주소가 이미 존재합니다';

  @override
  String get swap => '스왑';

  @override
  String get swap_amount_from => '보낸 금액';

  @override
  String get swap_amount_sent => '전송된 금액';

  @override
  String get swap_amount_to => '받는 금액';

  @override
  String get swap_and => '및';

  @override
  String get swap_checkout => '체크아웃';

  @override
  String get swap_completed => '완료됨';

  @override
  String get swap_confirm_and_make_payment => '확인 및 결제 진행';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return '선택한 체인($blockchain)에 맞는 올바른 주소를 입력했는지 확인하세요. 그렇지 않으면 자금을 잃을 수 있습니다.';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return '$currency 수신자 주소를 입력하세요';
  }

  @override
  String get swap_exchange_rate => '환율';

  @override
  String get swap_failed => '실패';

  @override
  String get swap_funds_not_received => '자금이 3시간 이내에 수신되지 않았습니다.\n 환율을 확인하고 새 거래를 생성해 주세요.';

  @override
  String get swap_i_agree_with => '동의합니다';

  @override
  String get swap_input_hash => '입력 해시';

  @override
  String get swap_input_output_hash => '입력/출력 해시';

  @override
  String get swap_network_fee => '네트워크 수수료';

  @override
  String get swap_network_label => '네트워크: ';

  @override
  String get swap_new_transaction => '새 거래';

  @override
  String get swap_open_history => '내역 열기';

  @override
  String get swap_output_hash => '출력 해시';

  @override
  String get swap_privacy_policy => '개인정보 보호정책';

  @override
  String get swap_received_time => '수신 시간 ';

  @override
  String get swap_send_funds_notice => '자금을 전송할 수 있는 시간은 3시간이며, 이를 초과할 경우 거래는 자동으로 취소됩니다.\n 자금이 수신되면 교환이 시작됩니다.';

  @override
  String get swap_send_funds_to_address_below => '아래 주소로 자금을 보내세요';

  @override
  String get swap_service_fee => '서비스 수수료: 0.25%';

  @override
  String get swap_start_over => '다시 시작';

  @override
  String get swap_terms_of_use => '이용 약관';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return '$amount $currency을(를) 보낼 수 있는 남은 시간';
  }

  @override
  String swap_time_remaining(Object value) {
    return '남은 시간: $value';
  }

  @override
  String get swap_transaction_preview => '거래 미리보기';

  @override
  String get swap_you_get => '받는 자산';

  @override
  String get swapNotAvailable => ' 현재 BDX 스왑을 사용할 수 없습니다.';

  @override
  String get sync_status_connecting => '연결 중';

  @override
  String get sync_status_failed_connect => '노드에 연결하지 못했습니다';

  @override
  String get sync_status_starting_sync => '동기화 시작 중';

  @override
  String get sync_status_synchronized => '동기화됨';

  @override
  String get sync_status_synchronizing => '동기화 중';

  @override
  String get test => '테스트';

  @override
  String get testResult => '테스트 결과:';

  @override
  String get theAddressAlreadyExist => '이미 존재하는 주소입니다';

  @override
  String get thisNameAlreadyExist => '이미 존재하는 이름입니다';

  @override
  String get transaction_details_amount => '금액';

  @override
  String get transaction_details_height => '키가';

  @override
  String get transaction_details_recipient_address => '수신 주소';

  @override
  String get transaction_details_transaction_id => '거래 ID';

  @override
  String get transaction_priority_blink => '플래시';

  @override
  String get transaction_priority_slow => '느림';

  @override
  String get transactionInitiatedSuccessfully => '거래가 성공적으로 시작되었습니다';

  @override
  String get transactions => '거래 내역';

  @override
  String get transactions_by_date => '날짜별 거래';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => '플래시 트랜잭션으로 BDX를 더 빠르게 전송하세요!';

  @override
  String get tryAgain => '잠시 후 다시 시도해 주세요.';

  @override
  String get twoDecimals => '2자리 (0.00)';

  @override
  String get usePattern => '패턴 사용';

  @override
  String get userNameOptional => '사용자 이름 (선택 사항)';

  @override
  String version(Object currentVersion) {
    return '버전 $currentVersion';
  }

  @override
  String get view => '보기';

  @override
  String get view_key_private => '조회 키 (개인 키)';

  @override
  String get view_key_public => '조회 키 (공개)';

  @override
  String get wallet => '지갑';

  @override
  String get wallet_keys => '지갑 키';

  @override
  String wallet_list_failed_to_load(Object error, Object wallet_name) {
    return '$wallet_name 지갑을 불러오지 못했습니다. $error';
  }

  @override
  String wallet_list_failed_to_remove(Object error, Object wallet_name) {
    return '$wallet_name 지갑을 삭제하지 못했습니다. $error';
  }

  @override
  String get wallet_list_load_wallet => '지갑 불러오기';

  @override
  String wallet_list_loading_wallet(Object wallet_name) {
    return '$wallet_name 지갑을 불러오는 중';
  }

  @override
  String wallet_list_removing_wallet(Object wallet_name) {
    return '$wallet_name 지갑을 삭제하는 중';
  }

  @override
  String get wallet_list_title => '벨덱스 지갑';

  @override
  String get wallet_name => '지갑 이름';

  @override
  String get wallet_restoration_store_incorrect_seed_length => '시드 길이가 잘못되었습니다';

  @override
  String get walletAddress => '지갑 주소';

  @override
  String walletAlreadyExists(Object name) {
    return '$name 이름의 지갑이 이미 존재합니다!';
  }

  @override
  String get walletRestore => '지갑 복원';

  @override
  String get wallets => '지갑 목록';

  @override
  String get walletSettings => '지갑 설정';

  @override
  String get welcomeToBeldexWallet => '벨덱스 지갑에 오신 것을 환영합니다 :)';

  @override
  String get widgets_restore_from_blockheight => '블록 높이로 복원';

  @override
  String get widgets_restore_from_date => '날짜로 복원';

  @override
  String get yes => '예';

  @override
  String get yes_im_sure => '예, 확인했습니다!';

  @override
  String get yesterday => '어제';

  @override
  String get youAreAboutToDeletenYourWallet => '지갑을 삭제하려고 합니다!';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => '키를 사용하여 지갑을 복원했기 때문에 시드를 볼 수 없습니다';

  @override
  String get youGet => '받는 금액';

  @override
  String get youSend => '보내는 금액';

  @override
  String get zeroDecimal => '0자리 (000)';

  @override
  String changePinLength(Object value) {
    return '$value자리 PIN으로 전환';
  }

  @override
  String get pleaseEnterAValidHeight => '유효한 높이를 입력하세요';

  @override
  String get invalidAddress => '잘못된 주소';

  @override
  String get exchangePair => '환전 쌍';

  @override
  String get payment => '결제';

  @override
  String get bnsConfirmUpdate => '업데이트 확인';

  @override
  String get bnsRenewedSuccessfully => 'BNS가 성공적으로 갱신되었습니다';

  @override
  String get bnsSameBchatId => '동일한 BChat ID';

  @override
  String get bnsSameBelnetId => '동일한 BelNet ID';

  @override
  String get bnsSameEthAddress => '동일한 ETH 주소';

  @override
  String get bnsSameOwnerAddress => '동일한 소유자 주소';

  @override
  String get bnsSameWalletAddress => '동일한 지갑 주소';

  @override
  String get bnsUpdatedSuccessfully => 'BNS가 성공적으로 업데이트되었습니다';

  @override
  String get bnsWaitForFetch => '네트워크에서 BNS 레코드를 가져올 때까지 기다려 주세요';

  @override
  String get bnsYearFive => '5년';

  @override
  String get bnsYearOne => '1년';

  @override
  String get bnsYearTen => '10년';

  @override
  String get bnsYearTwo => '2년';

  @override
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return '정말로 $masterNodeKey에서 스테이크를 잠금 해제하시겠습니까?';
  }

  @override
  String get checking => '확인 중...';

  @override
  String get checkingNodeConnection => '노드 연결 확인 중...';

  @override
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return '거래 확정\n금액: $amount\n수수료: $fee';
  }

  @override
  String get committingTheTransaction => '거래를 확정하는 중';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => '화면 잠금 PIN, 패턴 또는 비밀번호를 확인하세요';

  @override
  String get connectionFailed => '연결 실패';

  @override
  String get do_you_want_to_exit_an_app => '앱을 종료하시겠습니까?';

  @override
  String get enterAValidAddress => '유효한 주소를 입력하세요';

  @override
  String get error => '오류';

  @override
  String get error_text_beldex => 'Beldex 금액은 사용 가능한 잔액을 초과할 수 없습니다.\n소수점 이하 자릿수는 9자리 이하여야 합니다';

  @override
  String get error_text_fiat => '금액은 사용 가능한 잔액을 초과할 수 없습니다.\n소수점 이하 자릿수는 2자리 이하여야 합니다';

  @override
  String get error_text_service_node => '마스터 노드 키는 64개의 16진수 문자만 포함할 수 있습니다';

  @override
  String get exchangeAmount => '교환 금액';

  @override
  String get failedToGetOutputDistribution => '출력 분배를 가져오지 못했습니다';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return 'Flash 거래는 즉시 처리되는 거래입니다.\n$transactionPriority 우선순위가 기본 수수료로 설정되어 있습니다';
  }

  @override
  String get important => '중요';

  @override
  String get keys_title => '키';

  @override
  String get noPendingTransaction => '대기 중인 거래가 없습니다';

  @override
  String get nothing_staked => '아직 스테이킹된 항목이 없습니다';

  @override
  String openalias_alert_content(Object recipient_name) {
    return '다음 수신자에게 자금을 보냅니다\n$recipient_name';
  }

  @override
  String get openalias_alert_title => 'Beldex 수신자가 감지되었습니다';

  @override
  String get pending => '(대기 중)';

  @override
  String get please_select => '선택하세요:';

  @override
  String get pleaseAddAMainnetNode => '메인넷 노드를 추가하세요';

  @override
  String get received => '수신됨';

  @override
  String get reconnect_alert_text => '다시 연결하시겠습니까?';

  @override
  String get reconnection => '재연결';

  @override
  String get remove_node => '노드 삭제';

  @override
  String get remove_node_message => '선택한 노드를 삭제하시겠습니까?';

  @override
  String get rename => '이름 변경';

  @override
  String router_no_route(Object name) {
    return '$name에 대해 정의된 경로가 없습니다';
  }

  @override
  String get seed_language_chinese => 'Chinese';

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

  @override
  String get seed_share => '시드 공유';

  @override
  String get send_your_wallet => '내 지갑';

  @override
  String get sending => '전송 중';

  @override
  String get service_node_key => '마스터 노드 키';

  @override
  String get settings_none => '없음';

  @override
  String get stake_beldex => 'Beldex 스테이킹';

  @override
  String get stake_more => '더 스테이킹하기';

  @override
  String get start_staking => '스테이킹 시작';

  @override
  String get subaddress_title => '하위 주소 목록';

  @override
  String get subAddresses => '하위 주소';

  @override
  String get success => '성공';

  @override
  String get swap_confirmations => '확인 수';

  @override
  String get swap_confirmed => '확인됨';

  @override
  String swap_confirmed_in_blockchain(Object currencyFrom, Object currencyTo) {
    return 'Once $currencyFrom is confirmed in the blockchain, we\'ll start exchanging it to $currencyTo';
  }

  @override
  String get swap_confirming_in_progress => 'Confirming in progress';

  @override
  String swap_done_exchanging(Object currencyFrom, Object currencyTo) {
    return 'Done Exchanging $currencyFrom to $currencyTo';
  }

  @override
  String swap_enter_extra_id(Object extraIdName) {
    return 'Enter $extraIdName';
  }

  @override
  String swap_enter_refund_address(Object currency) {
    return 'Enter your $currency refund address';
  }

  @override
  String get swap_estimated_time => 'Estimated Time';

  @override
  String get swap_estimated_time_value => '5-30 mins';

  @override
  String swap_exchange_address(Object currency, Object exchangeName) {
    return '$exchangeName address ($currency)';
  }

  @override
  String get swap_exchanging => 'Exchanging';

  @override
  String swap_exchanging_currency(Object currencyFrom, Object currencyTo) {
    return 'Exchanging $currencyFrom to $currencyTo';
  }

  @override
  String get swap_expired => 'Expired';

  @override
  String swap_extra_id_info(Object currency, Object extraIdName) {
    return 'Please specify the $extraIdName for your $currency receiving address if your wallet provides it. Your transaction will not go through if you omit it. If your wallet doesn’t require a $extraIdName, remove the tick.';
  }

  @override
  String get swap_funds_sent_to_wallet => 'Funds send to your wallet';

  @override
  String get swap_history => 'history';

  @override
  String get swap_maximum_amount_changed => 'The maximum amount value has changed, The new value is ';

  @override
  String get swap_minimum_amount_changed => 'The minimum amount value has changed, The new value is ';

  @override
  String swap_my_wallet_requires_extra_id(Object extraIdName) {
    return 'My wallet requires $extraIdName';
  }

  @override
  String get swap_overdue => 'Overdue';

  @override
  String swap_please_enter_extra_id(Object extraIdName) {
    return 'Please enter $extraIdName';
  }

  @override
  String get swap_process_wait => 'The process will take a few minutes. please wait.';

  @override
  String swap_recipient_address_with_currency(Object currency) {
    return 'Recipient address ($currency)';
  }

  @override
  String get swap_refund_address => 'Refund Address';

  @override
  String get swap_refund_wallet_address => 'Refund wallet Address';

  @override
  String get swap_see_input_hash_in_explorer => 'See input hash in explorer';

  @override
  String get swap_sending_funds_to_wallet => 'Sending funds to your wallet';

  @override
  String get swap_you_can_initiate_new_transaction => 'You can initiate a new transaction. You can always check the status of this transaction in transaction ';

  @override
  String get swap_you_dont_have_to_wait_here => 'You don’t have to wait here';

  @override
  String get swap_you_sent => 'You sent';

  @override
  String get swapTransactionReport => 'Beldex_wallet_swap_transaction_report';

  @override
  String get sync_status_connected => 'CONNECTED';

  @override
  String get sync_status_not_connected => 'NOT CONNECTED';

  @override
  String get syncInfo => 'Sync info';

  @override
  String get title_confirm_unlock_stake => 'Unlock Stake';

  @override
  String get title_new_stake => 'New Stake';

  @override
  String get title_stakes => 'Stakes';

  @override
  String get today => 'Today';

  @override
  String get touchTheFingerprintSensor => 'Touch the Fingerprint sensor';

  @override
  String transaction_details_copied(Object title) {
    return '$title copied to Clipboard';
  }

  @override
  String get transaction_details_payment_id => 'Payment ID';

  @override
  String get transaction_details_title => 'Transaction Details';

  @override
  String get transaction_sent => 'Transaction sent!';

  @override
  String get transactionReport => 'Transaction Report';

  @override
  String get unable_unlock_stake => 'Unable to unlock stake';

  @override
  String get unlock_stake_requested => 'Stake unlock requested';

  @override
  String get unlockBeldexWallet => 'Unlock Beldex Wallet';

  @override
  String get wallet_menu => 'Menu';

  @override
  String get your_contributions => 'Your Contributions';
}
