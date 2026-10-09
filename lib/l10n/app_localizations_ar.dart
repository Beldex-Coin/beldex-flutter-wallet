// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get unsupportedExchangePair => 'زوج التبادل غير مدعوم';

  @override
  String get account => 'الحساب';

  @override
  String get accountAlreadyExist => 'الحساب موجود بالفعل';

  @override
  String get accountName => 'اسم الحساب';

  @override
  String get accounts => 'الحسابات';

  @override
  String get add => 'إضافة';

  @override
  String get addAccount => 'إضافة حساب';

  @override
  String get addAddress => 'إضافة عنوان';

  @override
  String get addBns => 'إضافة BNSجارٍ جلب سجل BNS من الشبكة\n';

  @override
  String get addNode => 'إضافة عقدة';

  @override
  String get address_book => 'دفتر العناوين';

  @override
  String get addressShouldNotBeEmpty => 'يجب ألا يكون حقل العنوان فارغاً';

  @override
  String get addSubAddress => 'إضافة عنوان فرعي';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'عد إتمام معاملتك الأولى، ستتمكن\nمن عرضها هنا.';

  @override
  String get alert => 'تنبيه';

  @override
  String get allowFaceIdAuthentication => 'السماح بالمصادقة باستخدام Face ID';

  @override
  String get amount => 'المبلغ';

  @override
  String get amountReceived => 'المبلغ المستلم';

  @override
  String get appstore => 'AppStore';

  @override
  String get are_you_sure => 'هل أنت متأكد؟';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => 'هل أنت متأكد من رغبتك في إزالة جهة\nالاتصال المحددة؟';

  @override
  String get auth_store_banned_for => 'محظور بسبب';

  @override
  String get auth_store_banned_minutes => 'دقائق';

  @override
  String get auth_store_incorrect_password => 'رمز PIN غير صحيح';

  @override
  String get authenticated => 'تمت المصادقة';

  @override
  String get available_balance => 'الرصيد المتاح';

  @override
  String get availableBdx => 'BDX المتاح:';

  @override
  String get bdx => 'BDX';

  @override
  String get biometric_auth_reason => 'امسح بصمة إصبعك للمصادقة';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'ميزة القياسات الحيوية معطّلة حاليًا.\n يرجى تمكين ميزة المصادقة البيومترية\n من داخل إعدادات التطبيق';

  @override
  String blockConfirmed(Object count) {
    return '$count كتلة';
  }

  @override
  String blockRemaining(Object status) {
    return 'متبقي $status كتلة';
  }

  @override
  String blocksConfirmed(Object count) {
    return '$count كتلة';
  }

  @override
  String blocksRemaining(Object status) {
    return 'متبقي $status كتلة';
  }

  @override
  String get bns => 'BNS';

  @override
  String get bnsAddRecord => 'إضافة سجل';

  @override
  String get bnsBackupOwner => 'المالك الاحتياطي';

  @override
  String get bnsBchatId => ' معرّف BChat';

  @override
  String get bnsBelnetId => 'معرّف Belnet';

  @override
  String get bnsConfirmPurchase => 'تأكيد الشراء';

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return 'فشل فك تشفير سجل BNS لـ $bnsName';
  }

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return 'تم فك تشفير سجل BNS لـ $bnsName بنجاح';
  }

  @override
  String get bnsEncryptedBchatValue => ' القيمة المشفرة لـ BChat';

  @override
  String get bnsEncryptedBelnetValue => ' القيمة المشفرة لـ Belnet';

  @override
  String get bnsEncryptedEthValue => ' القيمة المشفرة لـ ETH';

  @override
  String get bnsEncryptedWalletValue => 'قيمة المحفظة المشفرة';

  @override
  String get bnsEnterValidWalletAddress => 'أدخل عنوان محفظة صالح.';

  @override
  String get bnsEthAddress => 'عنوان ETH';

  @override
  String get bnsEthAddressDescription => 'عنوان ETH الخاص بنا متوافق عبر جميع شبكات EVM';

  @override
  String get bnsExpirationHeight => 'ارتفاع انتهاء الصلاحية';

  @override
  String get bnsFetchingRecords => 'جارٍ جلب سجل BNS من الشبكة';

  @override
  String get bnsInvalidBchatId => ' معرّف BChat غير صالح';

  @override
  String get bnsInvalidBelnetId => ' معرّف Belnet غير صالح';

  @override
  String get bnsInvalidEthAddress => ' عنوان ETH غير صالح';

  @override
  String get bnsInvalidName => 'اسم BNS غير صالح';

  @override
  String get bnsInvalidOwnerAddress => 'عنوان المالك غير صالح.';

  @override
  String get bnsInvalidWalletAddress => 'عنوان المحفظة غير صالح. اتركه فارغًا إذا كنت تريد استخدام المحفظة الحالية كمالك لـ BNS.';

  @override
  String get bnsNameHint => ' الاسم الذي تريد شراؤه عبر خدمة Beldex Name Service';

  @override
  String get bnsNameIsTaken => 'اسم BNS مستخدم بالفعل. اختر اسمًا مختلفًا.';

  @override
  String get bnsNewOwnerHint => 'أدخل عنوان المحفظة للمالك الجديد';

  @override
  String get bnsNoteLabel => 'ملاحظة: ';

  @override
  String get bnsOwnerAndBackupDifferent => 'يجب أن يكون عنوان المالك وعنوان النسخة الاحتياطية مختلفين.';

  @override
  String get bnsOwnerHint => 'عنوان المحفظة للمالك';

  @override
  String get bnsOwnerLabel => 'المالك';

  @override
  String get bnsOwnerOptional => 'المالك (اختياري)';

  @override
  String get bnsPleaseFillField => 'يرجى تعبئة هذا الحقل';

  @override
  String get bnsPrice => 'سعر';

  @override
  String get bnsPurchase => 'شراء';

  @override
  String get bnsPurchaseDescription => 'شراء أو تحديث سجل BNS.\n إذا قمت بشراء اسم، قد يستغرق الأمر دقيقة أو دقيقتين حتى يظهر في القائمة.';

  @override
  String get bnsPurchasedSuccessfully => 'تم شراء BNS بنجاح';

  @override
  String get bnsRecordNameHint => ' اسم BNS يخصك';

  @override
  String get bnsRecordNotFound => 'سجل BNS المحدد غير موجود أو لا ينتمي إلى هذه المحفظة.';

  @override
  String get bnsRecords => 'سجلات BNS';

  @override
  String get bnsRecordsDescription => 'هنا يمكنك العثور على جميع أسماء BNS التي تمتلكها هذه المحفظة.\n فك تشفير سجل تمتلكه سيعيد الاسم والقيمة في سجل BNS.';

  @override
  String get bnsRenewAction => 'تجديد';

  @override
  String get bnsRenewal => 'تجديد BNS';

  @override
  String get bnsUpdate => 'تحديث BNS';

  @override
  String get bnsUpdateAction => 'تحديث';

  @override
  String get bnsUpdateHeight => 'ارتفاع التحديث';

  @override
  String get bnsUpdateNote => 'يمكنك تحديث عنوان المالك أو القيم مرة واحدة فقط. إذا أردت تحديث كلاهما، يمكنك تحديث القيم قبل نقل الملكية أو بعد نقل الملكية.';

  @override
  String get bnsUpdateOwner => 'تحديث المالك';

  @override
  String get bnsUpdateValues => 'تحديث القيم';

  @override
  String get bnsYearFiveShort => '5 سنوات';

  @override
  String get bnsYearLabel => 'السنة';

  @override
  String get bnsYearOneShort => '1 سنة';

  @override
  String get bnsYearTenShort => '10 سنوات';

  @override
  String get bnsYearTwoShort => ' 2 سنة';

  @override
  String get bnsYouSave => 'أنت أحفظ';

  @override
  String get buyBns => ' شراء BNS';

  @override
  String get cancel => 'إلغاء';

  @override
  String change_current_node(Object node) {
    return 'هل أنت متأكد من أنك تريد تغيير العقدة الحالية إلى $node؟';
  }

  @override
  String get change_language => 'تغيير اللغة';

  @override
  String get changelog => 'سجل التغييرات';

  @override
  String get changeWallet => 'تغيير المحفظة';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get chooseSeedLanguage => 'اختر لغة العبارة السرية';

  @override
  String get clear => 'مسح';

  @override
  String get confirm_sending => 'تأكيد الإرسال';

  @override
  String get continue_text => 'متابعة';

  @override
  String get copied => 'تم النسخ';

  @override
  String get copyAndSaveTheSeedToContinue => 'قم بنسخ وحفظ العبارة السرية للمتابعة';

  @override
  String get copySeed => 'نسخ العبارة السرية';

  @override
  String get create_new => 'إنشاء محفظة جديدة';

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'لا تُدخل أبدًا $item الخاص بمحفظة Beldex في أي برنامج أو موقع إلكتروني باستثناء محافظ Beldex الرسمية التي يتم تنزيلها مباشرةً من $app_store أو موقع Beldex أو GitHub الخاص بـ Beldex. هل أنت متأكد من أنك تريد الوصول إلى محفظتك $item؟';
  }

  @override
  String get date => 'التاريخ';

  @override
  String get dateShouldNotBeEmpty => ' يجب ألا يكون التاريخ فارغً';

  @override
  String get delete => 'حذف';

  @override
  String get doYouWantToChangeYournPrimaryAccount => ' هل تريد تغيير الحساب الأساسي؟';

  @override
  String get doYouWantToExitTheWallet => 'هل تريد الخروج من المحفظة؟';

  @override
  String get doYouWantToReconnectnTheWallet => 'هل تريد إعادة الاتصال بالمحفظة؟';

  @override
  String get edit => 'تعديل';

  @override
  String get enterAddress => 'أدخل العنوان';

  @override
  String get enterAmount => ' أدخل المبلغ';

  @override
  String get enterAValidName => 'أدخل اسماً صالحاً';

  @override
  String get enterAValidNameUpto15Characters => 'أدخل اسمًا صالحًا حتى 15 حرفًا';

  @override
  String get enterAValidNameUpto20Characters => 'أدخل اسمًا صالحًا بحد أقصى 20 حرفًا';

  @override
  String get enterAValidSubAddress => 'أدخل عنوانًا فرعيًا صالحًا';

  @override
  String get enterBdxToReceive => 'أدخل BDX للاستلام';

  @override
  String get enterBdxToSend => 'أدخل BDX للإرسال';

  @override
  String get enterName => 'أدخل اسماً صالحاً';

  @override
  String get enterPin => 'أدخل الرقم السري';

  @override
  String get enterValidHeightWithoutSpace => 'أدخل رقم كتلة صالح بدون مسافات';

  @override
  String get enterValidNameUpto15Characters => 'أدخل اسمًا صالحًا بحد أقصى 15 حرفًا';

  @override
  String get enterWalletName => 'أدخل اسم المحفظة';

  @override
  String get enterWalletName_ => 'أدخل اسم المحفظة';

  @override
  String get enterYourPin => 'أدخل رمز PIN الخاص بك';

  @override
  String get error_text_address => ' عنوان BDX غير صالح';

  @override
  String get error_text_contact_name => 'لا يجوز أن يحتوي اسم جهة الاتصال على الرموز \' و \"\nويجب أن يتراوح طوله بين 1 و 32\nحرفاً';

  @override
  String get error_text_keys => ' يجب أن تحتوي مفاتيح المحفظة على 64 حرفًا سداسيًا فقط';

  @override
  String get error_text_node_address => ' الرجاء إدخال عنوان IPv4 صالح';

  @override
  String get error_text_node_port => 'لا يمكن أن يحتوي منفذ العقدة إلا على أرقام بين 0 و65535';

  @override
  String get exchange => 'تبادل';

  @override
  String get exchangeRate => 'سعر الصرف';

  @override
  String get expandDetails => 'عرض التفاصيل';

  @override
  String failed_authentication(Object state_error) {
    return 'فشل المصادقة. $state_error';
  }

  @override
  String get faq => 'الأسئلة الشائعة';

  @override
  String get fee => 'الرسوم';

  @override
  String get filters => 'تصفية حسب';

  @override
  String get fiveDecimals => '5 - خمسة (0.00000)';

  @override
  String get flashTransaction => 'معاملة سريعة';

  @override
  String get floatingExchangeRate => 'سعر صرف عائم';

  @override
  String get floatingRateDescription => 'يمكن أن يتغير السعر العائم في أي وقت\nبسبب ظروف السوق، لذلك قد\nتتلقى عملات رقمية أكثر أو أقل من المتوقع';

  @override
  String get fourDecimals => ' 4 - أربعة (0.0000)';

  @override
  String get full_balance => 'الرصيد الكامل';

  @override
  String get hidden_balance => 'الرصيد المخفي';

  @override
  String get howCanWenhelpYou => 'كيف يمكننا مساعدتك؟';

  @override
  String get incoming => 'الواردة';

  @override
  String get initiatingTransactionDescription => ' يرجى عدم إغلاق هذه النافذة أو الانتقال\n إلى تطبيق آخر حتى يتم بدء المعاملة';

  @override
  String get initiatingTransactionTitle => 'جارٍ بدء المعاملة..';

  @override
  String get labelName => 'اسم التسمية';

  @override
  String get legalDisclaimer => 'إخلاء المسؤولية القانونية';

  @override
  String get loadingTheWallet => 'جارٍ تحميل المحفظة…';

  @override
  String get loadingTheWalletDescription => ' يرجى عدم إغلاق هذه النافذة أو الانتقال إلى تطبيق آخر حتى يتم تحميل المحفظة';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => ' تأكد من أخذ نسخة احتياطية من بذرة الاسترداد، عنوان المحفظة، والمفاتيح الخاصة.';

  @override
  String get max => 'الحد الأقصى';

  @override
  String get maximumAmount => 'الحد الأقصى للمبلغ هو';

  @override
  String get minimumAmount => 'الحد الأدنى للمبلغ هو';

  @override
  String get myBns => 'BNS الخاص بي';

  @override
  String get name => 'الاسم';

  @override
  String get nameShouldNotBeEmpty => 'يجب ألا يكون حقل الاسم فارغاً';

  @override
  String get network_fee => 'رسوم الشبكة';

  @override
  String get networkErrorCheckConnection => 'خطأ في الشبكة! يرجى التحقق من اتصال الإنترنت';

  @override
  String never_give_your(Object item) {
    return 'لا تعطِ $item الخاص بمحفظة Beldex لأي شخص أبدًا!';
  }

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'لا تُدخل $item الخاص بمحفظة Beldex في أي برنامج أو موقع إلكتروني باستثناء محافظ Beldex الرسمية التي يتم تنزيلها مباشرةً من $appStore أو موقع Beldex الإلكتروني أو GitHub الخاص بـ Beldex.';
  }

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'لا تشارك العبارة السرية مع أي شخص!\nتأكد من محيطك لضمان عدم وجود\nمن يراقبك';

  @override
  String get new_subaddress_create => 'إنشاء';

  @override
  String get new_wallet => 'محفظة جديدة';

  @override
  String get no => 'لا';

  @override
  String get noAddressesInBook => 'لا توجد عناوين في الدفتر';

  @override
  String get node_address => 'عنوان العقدة';

  @override
  String get node_port => 'منفذ العقدة';

  @override
  String get node_reset_settings_title => 'إعادة ضبط الإعدادات';

  @override
  String get nodeAlreadyExists => 'هذه العقدة موجودة بالفعل';

  @override
  String get nodeNameOptional => ' اسم العقدة (اختياري)';

  @override
  String get nodes => 'العقد';

  @override
  String get nodes_list_reset_to_default_message => 'هل أنت متأكد أنك تريد إعادة ضبط الإعدادات إلى الوضع الافتراضي؟';

  @override
  String get noInternet => 'لا يوجد اتصال بالإنترنت!';

  @override
  String get noInternetMessage => 'يرجى التحقق من اتصالك بالإنترنت\nوالمحاولة مرة أخرى';

  @override
  String get note => 'ملاحظة:';

  @override
  String get noTransactionsMessage => 'لا توجد معاملات أو عمليات تبادل\nلعرضها..';

  @override
  String get noTransactionsYet => 'لا توجد معاملات حتى الآن!';

  @override
  String get ok => 'موافق';

  @override
  String get outgoing => 'الصادرة';

  @override
  String get passwordOptional => ' كلمة المرور (اختياري)';

  @override
  String get paste => 'لصق';

  @override
  String get pin_is_incorrect => ' رمز PIN غير صحيح';

  @override
  String get playStore => 'متجر Play';

  @override
  String get please_try_to_connect_to_another_node => 'يرجى محاولة الاتصال بعقدة أخرى';

  @override
  String get pleaseEnterAAmount => 'يرجى إدخال مبلغ';

  @override
  String get pleaseEnterABdxAddress => ' يرجى إدخال عنوان BDX';

  @override
  String get pleaseEnterAValidAmount => 'يرجى إدخال مبلغ صالح';

  @override
  String get pleaseEnterAValidSeed => 'يرجى إدخال عبارة سرية صالحة';

  @override
  String get re_enter_your_pin => 'أعد إدخال رمز PIN الخاص بك';

  @override
  String get receive => 'استلام';

  @override
  String get receiver => 'المستلم';

  @override
  String get reconnect => 'إعادة الاتصال';

  @override
  String get reconnectWallet => 'عادة الاتصال بالمحفظة';

  @override
  String get recoverySeed => 'الـ Seed للاستعادة';

  @override
  String get recoverySeedkey => 'عبارة الاسترداد/مفتاح الاسترداد';

  @override
  String get removeContact => 'إزالة جهة اتصال';

  @override
  String get removeWallet => 'إزالة المحفظة';

  @override
  String get rescan => 'إعادة الفحص';

  @override
  String get rescanWallet => 'إعادة فحص المحفظة';

  @override
  String get reset => 'عادة تعيين';

  @override
  String get restore_address => ' العنوان';

  @override
  String get restore_description_from_keys => ' استخدم ضغطات المفاتيح المُولّدة والمحفوظة من المفاتيح الخاصة لاستعادة محفظتك';

  @override
  String get restore_description_from_seed => ' استخدم المفتاح التذكّري المكوّن من 25 كلمة أو عبارة الاسترداد لاستعادة محفظتك';

  @override
  String get restore_description_from_seed_keys => 'استرجع محفظتك باستخدام العبارة السرية/المفاتيح التي قمت بحفظها في مكان آمن';

  @override
  String get restore_from_seed_placeholder => 'يرجى إدخال أو لصق العبارة السرية هنا';

  @override
  String get restore_next => 'التالي';

  @override
  String get restore_recover => 'استعادة';

  @override
  String get restore_restore_wallet => 'استعادة المحفظة';

  @override
  String get restore_title_from_keys => 'استعادة من المفاتيح';

  @override
  String get restore_title_from_seed => ' استعادة من العبارة السرية';

  @override
  String get restore_title_from_seed_keys => ' استعادة من العبارة السرية/المفاتيح';

  @override
  String get restore_wallet => 'استخدام محفظة موجودة';

  @override
  String get restoredViaKeys => 'لقد قمت بالاستعادة باستخدام المفاتيح';

  @override
  String get save => 'حفظ';

  @override
  String get searchCoins => 'ابحث عن العملات';

  @override
  String get searchCurrency => 'بحث عن العملة';

  @override
  String get seed_title => 'العبارة الأولية';

  @override
  String get seedKeys => 'البذرة والمفاتيح';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'اختر خيارًا لإنشاء أو استعادة\n محفظة موجودة';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get send => 'إرسال';

  @override
  String get send_beldex_address => 'عنوان Beldex أو اسم BNS';

  @override
  String get send_estimated_fee => 'الرسوم المقدّرة';

  @override
  String send_priority(Object transactionPriority) {
    return 'تم تعيين أولوية $transactionPriority كرسوم افتراضية. انتقل إلى الإعدادات لتغيير أولوية المعاملة.';
  }

  @override
  String get sent => 'تم الإرسال';

  @override
  String get service_fee => 'رسوم الخدمة 0.25%';

  @override
  String get settings_allow_biometric_authentication => 'السماح بالمصادقة البيومترية';

  @override
  String get settings_balance_detail => 'بحث عن العملة';

  @override
  String get settings_change_pin => ' تغيير الرقم السري';

  @override
  String get settings_currency => 'بحث عن العملة';

  @override
  String get settings_current_node => 'العقد الحالي';

  @override
  String get settings_dark_mode => 'الوضع الليلي';

  @override
  String get settings_display_balance_as => 'عرض الرصيد ك';

  @override
  String get settings_enable_fiat_currency => 'عرض الرصيد ك';

  @override
  String get settings_fee_priority => 'أولوية الرسوم';

  @override
  String get settings_personal => 'الشخصية';

  @override
  String get settings_save_recipient_address => 'حفظ عنوان المستلم';

  @override
  String get settings_support => 'الوضع الليلي';

  @override
  String get settings_terms_and_conditions => 'الشروط والأحكام';

  @override
  String get settings_title => 'الإعدادات';

  @override
  String get setup_pin => 'إعداد رمز PIN';

  @override
  String get setup_successful => 'تم إعداد رمز PIN الخاص بك بنجاح!';

  @override
  String get shareQr => 'مشاركة ';

  @override
  String get show_keys => 'عرض المفاتيح';

  @override
  String get show_seed => 'عرض البذرة';

  @override
  String get spend_key_private => ' مفتاح الإنفاق (خاص)';

  @override
  String get spend_key_public => ' مفتاح الإنفاق (عام):';

  @override
  String get status => 'الحالة';

  @override
  String get subAddress => 'العنوان الفرعي';

  @override
  String get subaddressAlreadyExist => 'العنوان الفرعي موجود بالفعل';

  @override
  String get swap => ' تبديل';

  @override
  String get swap_amount_from => 'المبلغ المُرسل';

  @override
  String get swap_amount_sent => 'المبلغ المرسل';

  @override
  String get swap_amount_to => 'المبلغ المستلم';

  @override
  String get swap_and => 'و';

  @override
  String get swap_checkout => 'إتمام الدفع';

  @override
  String get swap_completed => 'مكتمل';

  @override
  String get swap_confirm_and_make_payment => 'تأكيد وإجراء الدفع';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return 'يرجى التأكد من إدخال العنوان الصحيح للسلسلة المحددة - $blockchain. وإلا ستفقد أموالك.';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return 'أدخل عنوان المستلم لـ $currency';
  }

  @override
  String get swap_exchange_rate => 'سعر الصرف';

  @override
  String get swap_failed => 'فشل';

  @override
  String get swap_funds_not_received => 'لم يتم استلام الأموال خلال 3\nساعات. يرجى التحقق من الأسعار وإنشاء\nمعاملة جديدة';

  @override
  String get swap_i_agree_with => 'أوافق على';

  @override
  String get swap_input_hash => 'هاش الإدخال';

  @override
  String get swap_input_output_hash => 'هاش الإدخال/الإخراج';

  @override
  String get swap_network_fee => 'رسوم الشبكة';

  @override
  String get swap_network_label => 'الشبكة: ';

  @override
  String get swap_new_transaction => 'معاملة جديدة';

  @override
  String get swap_open_history => 'عرض السجل';

  @override
  String get swap_output_hash => 'هاش الإخراج';

  @override
  String get swap_privacy_policy => 'سياسة الخصوصية';

  @override
  String get swap_received_time => 'وقت الاستلام';

  @override
  String get swap_send_funds_notice => 'لديك 3 ساعات لإرسال الأموال\nوإلا سيتم إلغاء المعاملة تلقائيًا.\nسيتم بدء عملية التبادل بمجرد\nاستلام الأموال.';

  @override
  String get swap_send_funds_to_address_below => 'أرسل الأموال إلى العنوان أدناه';

  @override
  String get swap_service_fee => 'رسوم الخدمة 0.25%';

  @override
  String get swap_start_over => 'ابدأ من جديد';

  @override
  String get swap_terms_of_use => 'شروط الاستخدام';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return 'الوقت المتبقي لإرسال $amount $currency';
  }

  @override
  String swap_time_remaining(Object value) {
    return 'الوقت المتبقي: $value';
  }

  @override
  String get swap_transaction_preview => 'معاينة المعاملة';

  @override
  String get swap_you_get => 'أنت تحصل على';

  @override
  String get swapNotAvailable => 'تبديل BDX غير متاح في الوقت الحالي';

  @override
  String get sync_status_connecting => 'جارٍ الاتصال';

  @override
  String get sync_status_failed_connect => 'فشل الاتصال بالعقدة';

  @override
  String get sync_status_starting_sync => 'بدء المزامنة';

  @override
  String get sync_status_synchronized => 'تمت المزامنة';

  @override
  String get sync_status_synchronizing => 'جارٍ المزامنة';

  @override
  String get test => 'اختبار';

  @override
  String get testResult => 'نتيجة الاختبار:';

  @override
  String get theAddressAlreadyExist => 'العنوان موجود بالفعل';

  @override
  String get thisNameAlreadyExist => 'هذا الاسم موجود بالفعل';

  @override
  String get transaction_details_amount => 'تم الإرسال';

  @override
  String get transaction_details_height => 'الارتفاع';

  @override
  String get transaction_details_recipient_address => 'عنوان المستلم';

  @override
  String get transaction_details_transaction_id => 'معرّف المعاملة';

  @override
  String get transaction_priority_blink => 'فلاش';

  @override
  String get transaction_priority_slow => 'بطيء';

  @override
  String get transactionInitiatedSuccessfully => 'تم بدء المعاملة بنجاح';

  @override
  String get transactions => 'المعاملات';

  @override
  String get transactions_by_date => 'المعاملات حسب التاريخ';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => ' قم بتحويل BDX الخاص بك بشكل أسرع باستخدام المعاملة السريعة!';

  @override
  String get tryAgain => 'يرجى المحاولة مرة أخرى لاحقًا';

  @override
  String get twoDecimals => '2 - اثنان (0.00)';

  @override
  String get usePattern => 'استخدام النمط';

  @override
  String get userNameOptional => 'اسم المستخدم (اختياري)';

  @override
  String version(Object currentVersion) {
    return 'الإصدار $currentVersion';
  }

  @override
  String get view => 'عرض';

  @override
  String get view_key_private => ' مفتاح العرض (خاص)';

  @override
  String get view_key_public => 'عرض المفتاح (عام):';

  @override
  String get wallet => 'المحفظة';

  @override
  String get wallet_keys => 'مفاتيح المحفظة';

  @override
  String wallet_list_failed_to_load(Object error, Object wallet_name) {
    return 'فشل في تحميل محفظة $wallet_name. $error';
  }

  @override
  String wallet_list_failed_to_remove(Object error, Object wallet_name) {
    return 'فشل في إزالة محفظة $wallet_name. $error';
  }

  @override
  String get wallet_list_load_wallet => 'تحميل المحفظة';

  @override
  String wallet_list_loading_wallet(Object wallet_name) {
    return 'جارٍ تحميل محفظة $wallet_name';
  }

  @override
  String wallet_list_removing_wallet(Object wallet_name) {
    return 'جارٍ إزالة محفظة $wallet_name';
  }

  @override
  String get wallet_list_title => ' محفظة Beldex';

  @override
  String get wallet_name => 'اسم المحفظة';

  @override
  String get wallet_restoration_store_incorrect_seed_length => 'طول العبارة الأولية غير صحيح';

  @override
  String get walletAddress => 'عنوان المحفظة';

  @override
  String walletAlreadyExists(Object name) {
    return 'توجد محفظة بالاسم $name بالفعل!';
  }

  @override
  String get walletRestore => 'استعادة المحفظة';

  @override
  String get wallets => 'المحافظ';

  @override
  String get walletSettings => 'إعدادات المحفظة';

  @override
  String get welcomeToBeldexWallet => 'مرحبًا بك في محفظة Beldex :)';

  @override
  String get widgets_restore_from_blockheight => 'الاستعادة من رقم الكتلة ';

  @override
  String get widgets_restore_from_date => 'الاستعادة من التاريخ';

  @override
  String get yes => 'نعم';

  @override
  String get yes_im_sure => 'نعم، أنا متأكد!';

  @override
  String get yesterday => 'أمس';

  @override
  String get youAreAboutToDeletenYourWallet => 'أنت على وشك حذف محفظتك!';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => 'لا يمكنك عرض العبارة الأولية لأنك استعدت المحفظة باستخدام المفاتيح';

  @override
  String get youGet => 'تحصل على';

  @override
  String get youSend => 'أنت ترسل';

  @override
  String get zeroDecimal => ' 0 - صفر (000)';

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

  @override
  String get bnsRenewedSuccessfully => 'تم تجديد BNS بنجاح';

  @override
  String get bnsSameBchatId => 'نفس معرّف BChat';

  @override
  String get bnsSameBelnetId => 'نفس معرّف BelNet';

  @override
  String get bnsSameEthAddress => 'نفس عنوان ETH';

  @override
  String get bnsSameOwnerAddress => 'نفس عنوان المالك';

  @override
  String get bnsSameWalletAddress => 'نفس عنوان المحفظة';

  @override
  String get bnsUpdatedSuccessfully => 'تم تحديث BNS بنجاح';

  @override
  String get bnsWaitForFetch => 'يرجى الانتظار حتى نجلب سجل BNS من الشبكة';

  @override
  String get bnsYearFive => '5 سنوات';

  @override
  String get bnsYearOne => 'سنة واحدة';

  @override
  String get bnsYearTen => '10 سنوات';

  @override
  String get bnsYearTwo => 'سنتان';

  @override
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return 'هل تريد حقًا إلغاء قفل حصتك من $masterNodeKey؟';
  }

  @override
  String get checking => 'جارٍ التحقق...';

  @override
  String get checkingNodeConnection => 'جارٍ التحقق من اتصال العقدة...';

  @override
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return 'تأكيد المعاملة\nالمبلغ: $amount\nالرسوم: $fee';
  }

  @override
  String get committingTheTransaction => 'جارٍ تأكيد المعاملة';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => 'أكد رمز PIN أو النمط أو كلمة مرور قفل الشاشة';

  @override
  String get connectionFailed => 'فشل الاتصال';

  @override
  String get do_you_want_to_exit_an_app => 'هل تريد الخروج من التطبيق؟';

  @override
  String get enterAValidAddress => 'أدخل عنوانًا صالحًا';

  @override
  String get error => 'خطأ';

  @override
  String get error_text_beldex => 'لا يمكن أن تتجاوز قيمة Beldex الرصيد المتاح.\nيجب ألا يتجاوز عدد الأرقام العشرية 9 أرقام.';

  @override
  String get error_text_fiat => 'لا يمكن أن تتجاوز قيمة المبلغ الرصيد المتاح.\nيجب ألا يتجاوز عدد الأرقام العشرية رقمين';

  @override
  String get error_text_service_node => 'لا يمكن أن يحتوي مفتاح العقدة الرئيسية إلا على 64 حرفًا بالنظام السداسي عشري.';

  @override
  String get exchangeAmount => 'مبلغ التبادل';

  @override
  String get failedToGetOutputDistribution => 'تعذر الحصول على توزيع المخرجات';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return 'معاملات Flash هي معاملات فورية.\nتم تعيين أولوية $transactionPriority كرسوم افتراضية';
  }

  @override
  String get important => 'مهم';

  @override
  String get keys_title => 'المفاتيح';

  @override
  String get noPendingTransaction => 'لا توجد معاملة معلقة';

  @override
  String get nothing_staked => 'لم يتم تخزين أي حصة بعد';

  @override
  String openalias_alert_content(Object recipient_name) {
    return 'سترسل الأموال إلى\n$recipient_name';
  }

  @override
  String get openalias_alert_title => 'تم اكتشاف مستلم Beldex';

  @override
  String get pending => '(قيد الانتظار)';

  @override
  String get please_select => 'يرجى الاختيار:';

  @override
  String get pleaseAddAMainnetNode => 'يرجى إضافة عقدة للشبكة الرئيسية';

  @override
  String get received => 'تم الاستلام';

  @override
  String get reconnect_alert_text => 'هل أنت متأكد من أنك تريد إعادة الاتصال؟';

  @override
  String get reconnection => 'إعادة الاتصال';

  @override
  String get remove_node => 'إزالة العقدة';

  @override
  String get remove_node_message => 'هل أنت متأكد من أنك تريد إزالة العقدة المحددة؟';

  @override
  String get rename => 'إعادة التسمية';

  @override
  String router_no_route(Object name) {
    return 'لم يتم تحديد مسار لـ $name';
  }

  @override
  String get seed_share => 'مشاركة العبارة الأولية';

  @override
  String get send_your_wallet => 'محفظتك';

  @override
  String get sending => 'جارٍ الإرسال';

  @override
  String get service_node_key => 'مفتاح العقدة الرئيسية';

  @override
  String get settings_none => 'لا شيء';

  @override
  String get stake_beldex => 'تخزين Beldex';

  @override
  String get stake_more => 'إضافة المزيد من الحصة';

  @override
  String get start_staking => 'بدء التخزين';

  @override
  String get subaddress_title => 'قائمة العناوين الفرعية';

  @override
  String get subAddresses => 'العناوين الفرعية';

  @override
  String get success => 'نجح';

  @override
  String get swap_confirmations => 'التأكيدات';

  @override
  String get swap_confirmed => 'تم التأكيد';

  @override
  String swap_confirmed_in_blockchain(Object currencyFrom, Object currencyTo) {
    return 'بمجرد تأكيد $currencyFrom على البلوكشين، سنبدأ في استبداله بـ $currencyTo';
  }

  @override
  String get swap_confirming_in_progress => 'جارٍ التأكيد';

  @override
  String swap_done_exchanging(Object currencyFrom, Object currencyTo) {
    return 'تم استبدال $currencyFrom بـ $currencyTo';
  }

  @override
  String swap_enter_extra_id(Object extraIdName) {
    return 'أدخل $extraIdName';
  }

  @override
  String swap_enter_refund_address(Object currency) {
    return 'أدخل عنوان استرداد $currency الخاص بك';
  }

  @override
  String get swap_estimated_time => 'الوقت المقدر';

  @override
  String get swap_estimated_time_value => '5–30 دقيقة';

  @override
  String swap_exchange_address(Object currency, Object exchangeName) {
    return 'عنوان $exchangeName ($currency)';
  }

  @override
  String get swap_exchanging => 'جارٍ التبادل';

  @override
  String swap_exchanging_currency(Object currencyFrom, Object currencyTo) {
    return 'جارٍ استبدال $currencyFrom بـ $currencyTo';
  }

  @override
  String get swap_expired => 'منتهي الصلاحية';

  @override
  String swap_extra_id_info(Object currency, Object extraIdName) {
    return 'يرجى إدخال $extraIdName لعنوان استلام $currency إذا كانت محفظتك توفره. لن تتم معاملتك إذا تركته فارغًا. إذا كانت محفظتك لا تتطلب $extraIdName، فأزل علامة الاختيار.';
  }

  @override
  String get swap_funds_sent_to_wallet => 'تم إرسال الأموال إلى محفظتك';

  @override
  String get swap_history => 'السجل';

  @override
  String get swap_maximum_amount_changed => 'لقد تغيّرت قيمة الحد الأقصى للمبلغ. القيمة الجديدة هي';

  @override
  String get swap_minimum_amount_changed => 'لقد تغيّرت قيمة الحد الأدنى للمبلغ. القيمة الجديدة هي';

  @override
  String swap_my_wallet_requires_extra_id(Object extraIdName) {
    return 'محفظتي تتطلب $extraIdName';
  }

  @override
  String get swap_overdue => 'متأخر';

  @override
  String swap_please_enter_extra_id(Object extraIdName) {
    return 'يرجى إدخال $extraIdName';
  }

  @override
  String get swap_process_wait => 'ستستغرق العملية بضع دقائق. يرجى الانتظار.';

  @override
  String swap_recipient_address_with_currency(Object currency) {
    return 'عنوان المستلم ($currency)';
  }

  @override
  String get swap_refund_address => 'عنوان استرداد الأموال';

  @override
  String get swap_refund_wallet_address => 'عنوان محفظة استرداد الأموال';

  @override
  String get swap_see_input_hash_in_explorer => 'عرض تجزئة الإدخال في المستكشف';

  @override
  String get swap_sending_funds_to_wallet => 'جارٍ إرسال الأموال إلى محفظتك';

  @override
  String get swap_you_can_initiate_new_transaction => 'يمكنك بدء معاملة جديدة. يمكنك دائمًا التحقق من حالة هذه المعاملة في سجل المعاملات.';

  @override
  String get swap_you_dont_have_to_wait_here => 'لا يتعين عليك الانتظار هنا';

  @override
  String get swap_you_sent => 'لقد أرسلت';

  @override
  String get swapTransactionReport => 'Beldex_wallet_swap_transaction_report';

  @override
  String get sync_status_connected => 'متصل';

  @override
  String get sync_status_not_connected => 'غير متصل';

  @override
  String get syncInfo => 'معلومات المزامنة';

  @override
  String get title_confirm_unlock_stake => 'إلغاء قفل الحصة';

  @override
  String get title_new_stake => 'حصة جديدة';

  @override
  String get title_stakes => 'الحصص';

  @override
  String get today => 'اليوم';

  @override
  String get touchTheFingerprintSensor => 'المس مستشعر بصمة الإصبع';

  @override
  String transaction_details_copied(Object title) {
    return 'تم نسخ $title إلى الحافظة';
  }

  @override
  String get transaction_details_payment_id => 'معرّف الدفع';

  @override
  String get transaction_details_title => 'تفاصيل المعاملة';

  @override
  String get transaction_sent => 'تم إرسال المعاملة!';

  @override
  String get transactionReport => 'تقرير المعاملة';

  @override
  String get unable_unlock_stake => 'تعذر إلغاء قفل الحصة';

  @override
  String get unlock_stake_requested => 'تم طلب إلغاء قفل الحصة';

  @override
  String get unlockBeldexWallet => 'إلغاء قفل محفظة Beldex';

  @override
  String get wallet_menu => 'القائمة';

  @override
  String get your_contributions => 'مساهماتك';

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
