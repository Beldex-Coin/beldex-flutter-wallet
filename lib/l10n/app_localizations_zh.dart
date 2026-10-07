// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get unsupportedExchangePair => '不支持的兑换对';

  @override
  String get account => '账户';

  @override
  String get accountAlreadyExist => ' 账户已存在';

  @override
  String get accountName => '账户名称';

  @override
  String get accounts => '账户';

  @override
  String get add => '添加';

  @override
  String get addAccount => '添加账户';

  @override
  String get addAddress => '添加地址';

  @override
  String get addBns => '添加 BNS';

  @override
  String get addNode => '添加节点';

  @override
  String get address_book => '地址簿';

  @override
  String get addressShouldNotBeEmpty => '地址不能为空';

  @override
  String get addSubAddress => '添加子地址';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => '完成首次交易后，您将在此查看';

  @override
  String get alert => '提示';

  @override
  String get allowFaceIdAuthentication => '允许使用 Face ID 进行身份验证';

  @override
  String get amount => '金额';

  @override
  String get amountReceived => '接收金额';

  @override
  String get appstore => 'AppStore';

  @override
  String get are_you_sure => '您确定吗？';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => '您确定要删除所选联系人吗？';

  @override
  String get auth_store_banned_for => '封禁原因';

  @override
  String get auth_store_banned_minutes => '分钟';

  @override
  String get auth_store_incorrect_password => 'PIN 错误';

  @override
  String get authenticated => '已通过身份验证';

  @override
  String get available_balance => '可用余额';

  @override
  String get availableBdx => '可用 BDX :';

  @override
  String get bdx => 'BDX';

  @override
  String get biometric_auth_reason => '扫描您的指纹以进行身份验证';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => '生物识别功能当前已禁用。\n 请在应用设置中启用\n 生物识别认证功能';

  @override
  String blockConfirmed(Object count) {
    return '$count 个区块';
  }

  @override
  String blockRemaining(Object status) {
    return '剩余 $status 个区块';
  }

  @override
  String blocksConfirmed(Object count) {
    return '$count 个区块';
  }

  @override
  String blocksRemaining(Object status) {
    return '剩余 $status 个区块';
  }

  @override
  String get bns => 'BNS';

  @override
  String get bnsAddRecord => '添加记录';

  @override
  String get bnsBackupOwner => '备用所有者';

  @override
  String get bnsBchatId => 'BChat ID';

  @override
  String get bnsBelnetId => 'Belnet ID';

  @override
  String get bnsConfirmPurchase => '确认购买';

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return '无法解密 $bnsName 的 BNS 记录';
  }

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return '已成功解密 $bnsName 的 BNS 记录';
  }

  @override
  String get bnsEncryptedBchatValue => '加密的 BChat 值';

  @override
  String get bnsEncryptedBelnetValue => '加密的 Belnet 值';

  @override
  String get bnsEncryptedEthValue => '加密的 ETH 值';

  @override
  String get bnsEncryptedWalletValue => '加密的钱包值';

  @override
  String get bnsEnterValidWalletAddress => '请输入有效的钱包地址';

  @override
  String get bnsEthAddress => 'ETH 地址';

  @override
  String get bnsEthAddressDescription => '我们的 ETH 地址兼容所有 EVM 链';

  @override
  String get bnsExpirationHeight => '到期高度';

  @override
  String get bnsFetchingRecords => '正在从网络获取 BNS 记录';

  @override
  String get bnsInvalidBchatId => '无效的 BChat ID';

  @override
  String get bnsInvalidBelnetId => '无效的 Belnet ID';

  @override
  String get bnsInvalidEthAddress => '无效的 ETH 地址';

  @override
  String get bnsInvalidName => 'BNS 名称无效';

  @override
  String get bnsInvalidOwnerAddress => '所有者地址无效。';

  @override
  String get bnsInvalidWalletAddress => '钱包地址无效。如果您希望使用当前钱包作为 BNS 所有者，请留空。';

  @override
  String get bnsNameHint => '通过 Beldex 名称服务购买的名称';

  @override
  String get bnsNameIsTaken => 'BNS 名称已被使用。请选择其他名称。';

  @override
  String get bnsNewOwnerHint => '输入新所有者的钱包地址';

  @override
  String get bnsNoteLabel => '注意：';

  @override
  String get bnsOwnerAndBackupDifferent => '所有者地址和备用地址必须不同。';

  @override
  String get bnsOwnerHint => '所有者的钱包地址';

  @override
  String get bnsOwnerLabel => '所有者';

  @override
  String get bnsOwnerOptional => '所有者（可选）';

  @override
  String get bnsPleaseFillField => '请填写此字段';

  @override
  String get bnsPrice => '价格';

  @override
  String get bnsPurchase => '购买';

  @override
  String get bnsPurchaseDescription => '购买或更新 BNS 记录。\n 如果您购买一个名称，可能需要\n 一两分钟才会显示在列表中';

  @override
  String get bnsPurchasedSuccessfully => 'BNS 购买成功';

  @override
  String get bnsRecordNameHint => '属于您的 BNS 名称';

  @override
  String get bnsRecordNotFound => '给定的 BNS 记录不存在或不属于此钱包。';

  @override
  String get bnsRecords => 'BNS 记录';

  @override
  String get bnsRecordsDescription => '在这里您可以查看该钱包拥有的所有 BNS 名称。解密您拥有的记录将返回该 BNS 记录中的名称和值。';

  @override
  String get bnsRenewAction => '续费';

  @override
  String get bnsRenewal => 'BNS 续期';

  @override
  String get bnsUpdate => 'BNS 更新';

  @override
  String get bnsUpdateAction => '更新';

  @override
  String get bnsUpdateHeight => '更新高度';

  @override
  String get bnsUpdateNote => '您一次只能更新所有者地址或数值。 如果您想同时更新两者，您可以在转移所有权之前或之后更新数值。';

  @override
  String get bnsUpdateOwner => '更新所有者';

  @override
  String get bnsUpdateValues => '更新数值';

  @override
  String get bnsYearFiveShort => '5 年';

  @override
  String get bnsYearLabel => '年限';

  @override
  String get bnsYearOneShort => '1 年';

  @override
  String get bnsYearTenShort => '10 年';

  @override
  String get bnsYearTwoShort => '2 年';

  @override
  String get bnsYouSave => '您节省';

  @override
  String get buyBns => '购买 BNS';

  @override
  String get cancel => '取消';

  @override
  String change_current_node(Object node) {
    return '您确定要将当前节点更改为 $node 吗？';
  }

  @override
  String get change_language => '修改语言';

  @override
  String get changelog => '更新日志';

  @override
  String get changeWallet => '切换钱包';

  @override
  String get chooseLanguage => '选择语言';

  @override
  String get chooseSeedLanguage => '选择助记词语言';

  @override
  String get clear => '清除';

  @override
  String get confirm_sending => '确认发送';

  @override
  String get continue_text => '继续';

  @override
  String get copied => '已复制';

  @override
  String get copyAndSaveTheSeedToContinue => '复制并保存助记词以继续';

  @override
  String get copySeed => '复制助记词';

  @override
  String get create_new => '创建新钱包';

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return '切勿将您的 Beldex 钱包 $item 输入到任何软件或网站中，除非是直接从 $app_store、Beldex 官方网站或 Beldex GitHub 下载的官方 Beldex 钱包。您确定要访问您的钱包 $item 吗？';
  }

  @override
  String get date => '日期';

  @override
  String get dateShouldNotBeEmpty => '日期不能为空';

  @override
  String get delete => '删除';

  @override
  String get doYouWantToChangeYournPrimaryAccount => '您是否要更改您的主账户？';

  @override
  String get doYouWantToExitTheWallet => '您是否要退出钱包？';

  @override
  String get doYouWantToReconnectnTheWallet => '您是否要重新连接钱包？';

  @override
  String get edit => '编辑';

  @override
  String get enterAddress => '输入地址';

  @override
  String get enterAmount => '输入金额';

  @override
  String get enterAValidName => '请输入有效名称';

  @override
  String get enterAValidNameUpto15Characters => '请输入最多 15 个字符的有效名称';

  @override
  String get enterAValidNameUpto20Characters => '请输入不超过 20 个字符的有效名称';

  @override
  String get enterAValidSubAddress => '请输入有效的子地址';

  @override
  String get enterBdxToReceive => '输入要接收的 BDX';

  @override
  String get enterBdxToSend => '输入要发送的 BDX';

  @override
  String get enterName => '请输入有效名称';

  @override
  String get enterPin => '输入 PIN';

  @override
  String get enterValidHeightWithoutSpace => '请输入有效的区块高度（不要包含空格）';

  @override
  String get enterValidNameUpto15Characters => '请输入不超过 15 个字符的有效名称';

  @override
  String get enterWalletName => '输入钱包名称';

  @override
  String get enterWalletName_ => '输入钱包名称';

  @override
  String get enterYourPin => '输入您的 PIN';

  @override
  String get error_text_address => '无效的 BDX 地址';

  @override
  String get error_text_contact_name => '联系人名称不能包含 \' \'、\" 符号，且长度必须在 1 到 32 个字符之间';

  @override
  String get error_text_keys => '钱包密钥只能包含 64 个十六进制字符';

  @override
  String get error_text_node_address => '请输入 IPv4 地址';

  @override
  String get error_text_node_port => '节点端口只能包含 0 到 65535 之间的数字';

  @override
  String get exchange => '兑换';

  @override
  String get exchangeRate => '汇率';

  @override
  String get expandDetails => '展开详情';

  @override
  String failed_authentication(Object state_error) {
    return '身份验证失败。$state_error';
  }

  @override
  String get faq => '常见问题';

  @override
  String get fee => '费用';

  @override
  String get filters => '按条件筛选';

  @override
  String get fiveDecimals => '5 - 五位 (0.00000)';

  @override
  String get flashTransaction => '闪电交易';

  @override
  String get floatingExchangeRate => '浮动汇率';

  @override
  String get floatingRateDescription => '由于市场情况，浮动汇率可能随时发生变化，因此您实际收到的加密货币可能多于或少于预期。';

  @override
  String get fourDecimals => '4 - 四位 (0.0000)';

  @override
  String get full_balance => '全部余额';

  @override
  String get hidden_balance => '隐藏余额';

  @override
  String get howCanWenhelpYou => '我们如何帮助您？';

  @override
  String get incoming => '收入';

  @override
  String get initiatingTransactionDescription => '请不要关闭此窗口或切换到其他应用，直到交易被发起';

  @override
  String get initiatingTransactionTitle => '正在发起交易..';

  @override
  String get labelName => '标签名称';

  @override
  String get legalDisclaimer => '法律免责声明';

  @override
  String get loadingTheWallet => '正在加载钱包…';

  @override
  String get loadingTheWalletDescription => '请勿关闭此窗口或切换到其他应用，直到钱包加载完成';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => '请确保已备份恢复助记词、钱包地址和私钥';

  @override
  String get max => '最大';

  @override
  String get maximumAmount => '最大金额为';

  @override
  String get minimumAmount => '最小金额为';

  @override
  String get myBns => '我的 BNS';

  @override
  String get name => '名称';

  @override
  String get nameShouldNotBeEmpty => '名称不能为空';

  @override
  String get network_fee => '网络费用';

  @override
  String get networkErrorCheckConnection => '网络错误！请检查网络连接。';

  @override
  String never_give_your(Object item) {
    return '切勿将您的 Beldex 钱包 $item 提供给任何人！';
  }

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return '切勿将您的 Beldex 钱包 $item 输入到任何软件或网站中，除非是直接从 $appStore、Beldex 官方网站或 Beldex GitHub 下载的官方 Beldex 钱包。';
  }

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => '切勿将您的助记词分享给任何人！请检查周围环境，确保没有人 在旁窥视';

  @override
  String get new_subaddress_create => '创建';

  @override
  String get new_wallet => '新钱包';

  @override
  String get no => '否';

  @override
  String get noAddressesInBook => '地址簿中暂无地址';

  @override
  String get node_address => '节点地址';

  @override
  String get node_port => '节点端口';

  @override
  String get node_reset_settings_title => '重置设置';

  @override
  String get nodeAlreadyExists => '该节点已存在';

  @override
  String get nodeNameOptional => '节点名称（可选）';

  @override
  String get nodes => '节点';

  @override
  String get nodes_list_reset_to_default_message => '您确定要将设置重置为默认吗？';

  @override
  String get noInternet => '无网络！';

  @override
  String get noInternetMessage => '请检查您的网络连接并重试。';

  @override
  String get note => '注意：';

  @override
  String get noTransactionsMessage => '当前没有可显示的交易或兑换记录..';

  @override
  String get noTransactionsYet => '暂无交易！';

  @override
  String get ok => '确定';

  @override
  String get outgoing => '支出';

  @override
  String get passwordOptional => '密码（可选）';

  @override
  String get paste => '粘贴';

  @override
  String get pin_is_incorrect => 'PIN 不正确';

  @override
  String get playStore => 'Play 商店';

  @override
  String get please_try_to_connect_to_another_node => '请尝试连接到其他节点';

  @override
  String get pleaseEnterAAmount => '请输入金额';

  @override
  String get pleaseEnterABdxAddress => '请输入 BDX 地址';

  @override
  String get pleaseEnterAValidAmount => '请输入有效金额';

  @override
  String get pleaseEnterAValidSeed => '请输入有效的助记词';

  @override
  String get re_enter_your_pin => '重新输入您的 PIN';

  @override
  String get receive => '接收';

  @override
  String get receiver => '接收方';

  @override
  String get reconnect => '重新连接';

  @override
  String get reconnectWallet => '重新连接钱包';

  @override
  String get recoverySeed => '恢复助记词';

  @override
  String get recoverySeedkey => '恢复助记词/密钥';

  @override
  String get removeContact => '删除联系人';

  @override
  String get removeWallet => '删除钱包';

  @override
  String get rescan => '重新扫描';

  @override
  String get rescanWallet => '重新扫描钱包';

  @override
  String get reset => '重置';

  @override
  String get restore_address => '地址';

  @override
  String get restore_description_from_keys => '使用从私钥生成并保存的密钥数据来恢复您的钱包';

  @override
  String get restore_description_from_seed => '使用 25 个单词的助记词或种子短语来恢复您的钱包。';

  @override
  String get restore_description_from_seed_keys => '通过您保存在安全位置的助记词/密钥找回您的钱包';

  @override
  String get restore_from_seed_placeholder => '请在此输入或粘贴您的助记词';

  @override
  String get restore_next => '下一步';

  @override
  String get restore_recover => '恢复';

  @override
  String get restore_restore_wallet => '恢复钱包';

  @override
  String get restore_title_from_keys => '从密钥恢复';

  @override
  String get restore_title_from_seed => '从助记词恢复';

  @override
  String get restore_title_from_seed_keys => '从助记词/密钥恢复';

  @override
  String get restore_wallet => '使用现有钱包';

  @override
  String get restoredViaKeys => '您是通过密钥恢复的钱包';

  @override
  String get save => '保存';

  @override
  String get searchCoins => '搜索币种';

  @override
  String get searchCurrency => '搜索货币';

  @override
  String get seed_title => '助记词';

  @override
  String get seedKeys => '助记词与密钥';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => '选择一个选项以创建或恢复\n 现有钱包';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get send => '发送';

  @override
  String get send_beldex_address => 'Beldex 地址或 BNS 名称';

  @override
  String get send_estimated_fee => '预计费用:';

  @override
  String send_priority(Object transactionPriority) {
    return '$transactionPriority 优先级已设置为默认费用。前往设置以更改交易优先级。';
  }

  @override
  String get sent => '已发送';

  @override
  String get service_fee => '服务费 0.25%';

  @override
  String get settings_allow_biometric_authentication => '允许生物识别认证';

  @override
  String get settings_balance_detail => '小数位数';

  @override
  String get settings_change_pin => '修改 PIN';

  @override
  String get settings_currency => '货币';

  @override
  String get settings_current_node => '当前节点';

  @override
  String get settings_dark_mode => '深色模式';

  @override
  String get settings_display_balance_as => '显示余额为';

  @override
  String get settings_enable_fiat_currency => '启用法币转换';

  @override
  String get settings_fee_priority => '手续费优先级';

  @override
  String get settings_personal => '个人';

  @override
  String get settings_save_recipient_address => '保存收款地址';

  @override
  String get settings_support => '支持';

  @override
  String get settings_terms_and_conditions => '条款与条件';

  @override
  String get settings_title => '设置';

  @override
  String get setup_pin => '设置 PIN';

  @override
  String get setup_successful => '您的 PIN 已成功设置！';

  @override
  String get shareQr => '分享二维码';

  @override
  String get show_keys => '显示密钥';

  @override
  String get show_seed => '显示助记词';

  @override
  String get spend_key_private => '花费密钥（私钥）';

  @override
  String get spend_key_public => '花费密钥（公钥）';

  @override
  String get status => '状态:';

  @override
  String get subAddress => '子地址';

  @override
  String get subaddressAlreadyExist => '子地址已存在';

  @override
  String get swap => '兑换';

  @override
  String get swap_amount_from => '发送金额';

  @override
  String get swap_amount_sent => '发送金额';

  @override
  String get swap_amount_to => '接收金额';

  @override
  String get swap_and => '和';

  @override
  String get swap_checkout => '结账';

  @override
  String get swap_completed => '已完成';

  @override
  String get swap_confirm_and_make_payment => '确认并支付';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return '请确保输入所选链（$blockchain）的正确地址。否则，您可能会损失资金。';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return '输入您的 $currency 收款地址';
  }

  @override
  String get swap_exchange_rate => '汇率';

  @override
  String get swap_failed => '失败';

  @override
  String get swap_funds_not_received => '在 3 小时内未收到资金。请检查汇率并创建新交易';

  @override
  String get swap_i_agree_with => '我同意';

  @override
  String get swap_input_hash => '输入哈希';

  @override
  String get swap_input_output_hash => '输入/输出哈希';

  @override
  String get swap_network_fee => '网络费用';

  @override
  String get swap_network_label => '网络：';

  @override
  String get swap_new_transaction => '新建交易';

  @override
  String get swap_open_history => '查看记录';

  @override
  String get swap_output_hash => '输出哈希';

  @override
  String get swap_privacy_policy => '隐私政策';

  @override
  String get swap_received_time => '接收时间';

  @override
  String get swap_send_funds_notice => '您有 3 小时发送资金，\n否则交易将自动取消。\n一旦收到资金，兑换将被发起。';

  @override
  String get swap_send_funds_to_address_below => '请将资金发送至以下地址';

  @override
  String get swap_service_fee => '服务费 0.25%';

  @override
  String get swap_start_over => '重新开始';

  @override
  String get swap_terms_of_use => '使用条款';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return '发送 $amount $currency 的剩余时间';
  }

  @override
  String swap_time_remaining(Object value) {
    return '剩余时间：$value';
  }

  @override
  String get swap_transaction_preview => '交易预览';

  @override
  String get swap_you_get => '您接收';

  @override
  String get swapNotAvailable => ' 兑换当前不可用';

  @override
  String get sync_status_connecting => '连接中';

  @override
  String get sync_status_failed_connect => '连接节点失败';

  @override
  String get sync_status_starting_sync => '开始同步';

  @override
  String get sync_status_synchronized => '已同步';

  @override
  String get sync_status_synchronizing => '正在同步';

  @override
  String get test => '测试';

  @override
  String get testResult => '测试结果：';

  @override
  String get theAddressAlreadyExist => '该地址已存在';

  @override
  String get thisNameAlreadyExist => '该名称已存在';

  @override
  String get transaction_details_amount => '金额';

  @override
  String get transaction_details_height => '区块高度';

  @override
  String get transaction_details_recipient_address => '接收地址';

  @override
  String get transaction_details_transaction_id => '交易 ID';

  @override
  String get transaction_priority_blink => '闪电';

  @override
  String get transaction_priority_slow => '慢';

  @override
  String get transactionInitiatedSuccessfully => '交易已成功发起';

  @override
  String get transactions => '交易记录';

  @override
  String get transactions_by_date => '按日期查看交易';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => '通过闪电交易更快地转移您的 BDX！';

  @override
  String get tryAgain => '请稍后再试。';

  @override
  String get twoDecimals => '2 - 两位 (0.00)';

  @override
  String get usePattern => '使用图案';

  @override
  String get userNameOptional => '用户名（可选）';

  @override
  String version(Object currentVersion) {
    return '版本 $currentVersion';
  }

  @override
  String get view => '查看';

  @override
  String get view_key_private => '查看密钥（私钥）';

  @override
  String get view_key_public => '查看密钥（公钥）';

  @override
  String get wallet => '钱包';

  @override
  String get wallet_keys => '钱包密钥';

  @override
  String wallet_list_failed_to_load(Object error, Object wallet_name) {
    return '无法加载 $wallet_name 钱包。$error';
  }

  @override
  String wallet_list_failed_to_remove(Object error, Object wallet_name) {
    return '无法移除 $wallet_name 钱包。$error';
  }

  @override
  String get wallet_list_load_wallet => '加载钱包';

  @override
  String wallet_list_loading_wallet(Object wallet_name) {
    return '正在加载 $wallet_name 钱包';
  }

  @override
  String wallet_list_removing_wallet(Object wallet_name) {
    return '正在移除 $wallet_name 钱包';
  }

  @override
  String get wallet_list_title => 'Beldex 钱包';

  @override
  String get wallet_name => '钱包名称';

  @override
  String get wallet_restoration_store_incorrect_seed_length => '助记词长度不正确';

  @override
  String get walletAddress => '钱包地址';

  @override
  String walletAlreadyExists(Object name) {
    return '名为 $name 的钱包已存在！';
  }

  @override
  String get walletRestore => '钱包恢复';

  @override
  String get wallets => '钱包列表';

  @override
  String get walletSettings => '钱包设置';

  @override
  String get welcomeToBeldexWallet => '欢迎使用 Beldex 钱包 :)';

  @override
  String get widgets_restore_from_blockheight => '从区块高度恢复';

  @override
  String get widgets_restore_from_date => '从日期恢复';

  @override
  String get yes => '是';

  @override
  String get yes_im_sure => '是的，我确定！';

  @override
  String get yesterday => '昨天';

  @override
  String get youAreAboutToDeletenYourWallet => '您即将删除钱包！';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => '由于您使用密钥恢复了钱包，因此无法查看助记词';

  @override
  String get youGet => '您接收';

  @override
  String get youSend => '您发送';

  @override
  String get zeroDecimal => '0 - 零位 (000)';

  @override
  String changePinLength(Object value) {
    return '切换到 $value 位 PIN';
  }

  @override
  String get pleaseEnterAValidHeight => '请输入有效的区块高度';

  @override
  String get invalidAddress => '地址无效';

  @override
  String get exchangePair => '交易对';

  @override
  String get payment => '支付';

  @override
  String get bnsConfirmUpdate => '确认更新';

  @override
  String get bnsRenewedSuccessfully => 'BNS 续期成功';

  @override
  String get bnsSameBchatId => '相同的 BChat ID';

  @override
  String get bnsSameBelnetId => '相同的 BelNet ID';

  @override
  String get bnsSameEthAddress => '相同的 ETH 地址';

  @override
  String get bnsSameOwnerAddress => '相同的所有者地址';

  @override
  String get bnsSameWalletAddress => '相同的钱包地址';

  @override
  String get bnsUpdatedSuccessfully => 'BNS 更新成功';

  @override
  String get bnsWaitForFetch => '请等待我们从网络获取 BNS 记录';

  @override
  String get bnsYearFive => '5 年';

  @override
  String get bnsYearOne => '1 年';

  @override
  String get bnsYearTen => '10 年';

  @override
  String get bnsYearTwo => '2 年';

  @override
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return '您确定要从 $masterNodeKey 解锁您的质押吗？';
  }

  @override
  String get checking => '正在检查...';

  @override
  String get checkingNodeConnection => '正在检查节点连接...';

  @override
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return '提交交易\n金额：$amount\n手续费：$fee';
  }

  @override
  String get committingTheTransaction => '正在提交交易';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => '确认您的屏幕锁定 PIN、图案或密码';

  @override
  String get connectionFailed => '连接失败';

  @override
  String get do_you_want_to_exit_an_app => '您要退出应用吗？';

  @override
  String get enterAValidAddress => '请输入有效的地址';

  @override
  String get error => '错误';

  @override
  String get error_text_beldex => 'Beldex 金额不能超过可用余额。\n小数位数必须小于或等于 9 位';

  @override
  String get error_text_fiat => '金额不能超过可用余额。\n小数位数必须小于或等于 2 位';

  @override
  String get error_text_service_node => 'Master Node 密钥只能包含 64 个十六进制字符';

  @override
  String get exchangeAmount => '兑换金额';

  @override
  String get failedToGetOutputDistribution => '无法获取输出分配';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return 'Flash 交易是即时交易。\n$transactionPriority 优先级已设置为默认费用';
  }

  @override
  String get important => '重要';

  @override
  String get keys_title => '密钥';

  @override
  String get noPendingTransaction => '没有待处理的交易';

  @override
  String get nothing_staked => '尚未进行任何质押';

  @override
  String openalias_alert_content(Object recipient_name) {
    return '您将向以下对象发送资金\n$recipient_name';
  }

  @override
  String get openalias_alert_title => '检测到 Beldex 收款方';

  @override
  String get pending => '(待处理)';

  @override
  String get please_select => '请选择：';

  @override
  String get pleaseAddAMainnetNode => '请添加主网节点';

  @override
  String get received => '已收到';

  @override
  String get reconnect_alert_text => '您确定要重新连接吗？';

  @override
  String get reconnection => '重新连接';

  @override
  String get remove_node => '删除节点';

  @override
  String get remove_node_message => '您确定要删除所选节点吗？';

  @override
  String get rename => '重命名';

  @override
  String router_no_route(Object name) {
    return '未为 $name 定义路由';
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
  String get seed_share => '分享助记词';

  @override
  String get send_your_wallet => '您的钱包';

  @override
  String get sending => '正在发送';

  @override
  String get service_node_key => 'Master Node 密钥';

  @override
  String get settings_none => '无';

  @override
  String get stake_beldex => '质押 Beldex';

  @override
  String get stake_more => '追加质押';

  @override
  String get start_staking => '开始质押';

  @override
  String get subaddress_title => '子地址列表';

  @override
  String get subAddresses => '子地址';

  @override
  String get success => '成功';

  @override
  String get swap_confirmations => '确认数';

  @override
  String get swap_confirmed => '已确认';

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
