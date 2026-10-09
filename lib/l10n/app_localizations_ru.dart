// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get unsupportedExchangePair => 'Неподдерживаемая пара обмена';

  @override
  String get account => 'Аккаунт';

  @override
  String get accountAlreadyExist => 'Аккаунт уже существует';

  @override
  String get accountName => 'Имя аккаунта';

  @override
  String get accounts => 'Аккаунты';

  @override
  String get add => 'Добавить';

  @override
  String get addAccount => 'Добавить аккаунт';

  @override
  String get addAddress => 'Добавить адрес';

  @override
  String get addBns => 'Добавить BNS';

  @override
  String get addNode => 'Добавить ноду';

  @override
  String get address_book => 'Адресная книга';

  @override
  String get addressShouldNotBeEmpty => 'Адрес не должен быть пустым';

  @override
  String get addSubAddress => 'Добавить субадрес';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'После вашей первой транзакции\n она появится здесь.';

  @override
  String get alert => 'Предупреждение';

  @override
  String get allowFaceIdAuthentication => 'Разрешить аутентификацию с помощью Face ID';

  @override
  String get amount => 'Сумма';

  @override
  String get amountReceived => 'Полученная сумма';

  @override
  String get appstore => 'AppStore';

  @override
  String get are_you_sure => 'Вы уверены?';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => 'Вы уверены, что хотите удалить выбранный\n контакт?';

  @override
  String get auth_store_banned_for => 'Заблокирован за';

  @override
  String get auth_store_banned_minutes => 'минут';

  @override
  String get auth_store_incorrect_password => 'Неверный PIN-код';

  @override
  String get authenticated => 'Аутентифицировано';

  @override
  String get available_balance => 'Доступный баланс';

  @override
  String get availableBdx => 'Доступный баланс BDX :';

  @override
  String get bdx => 'BDX';

  @override
  String get biometric_auth_reason => 'Отсканируйте отпечаток пальца для аутентификации';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'Биометрическая функция в настоящее время отключена.\n Пожалуйста, включите биометрическую аутентификацию\n в настройках приложения';

  @override
  String blockConfirmed(Object count) {
    return '$count блок';
  }

  @override
  String blockRemaining(Object status) {
    return 'Остался $status блок';
  }

  @override
  String blocksConfirmed(Object count) {
    return '$count блоков';
  }

  @override
  String blocksRemaining(Object status) {
    return 'Осталось блоков: $status';
  }

  @override
  String get bns => 'BNS';

  @override
  String get bnsAddRecord => 'Добавить запись';

  @override
  String get bnsBackupOwner => 'Резервный владелец';

  @override
  String get bnsBchatId => 'BChat ID';

  @override
  String get bnsBelnetId => 'Belnet ID';

  @override
  String get bnsConfirmPurchase => 'Подтверждение покупки';

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return 'Не удалось расшифровать запись BNS для $bnsName';
  }

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return 'Запись BNS для $bnsName успешно расшифрована';
  }

  @override
  String get bnsEncryptedBchatValue => 'Зашифрованное значение BChat';

  @override
  String get bnsEncryptedBelnetValue => 'Зашифрованное значение Belnet';

  @override
  String get bnsEncryptedEthValue => 'Зашифрованное значение ETH';

  @override
  String get bnsEncryptedWalletValue => 'Зашифрованное значение кошелька';

  @override
  String get bnsEnterValidWalletAddress => 'Введите корректный адрес кошелька';

  @override
  String get bnsEthAddress => 'ETH-адрес';

  @override
  String get bnsEthAddressDescription => 'наш ETH-адрес совместим\n со всеми EVM-сетями';

  @override
  String get bnsExpirationHeight => 'Высота истечения';

  @override
  String get bnsFetchingRecords => 'Получение записи BNS из сети';

  @override
  String get bnsInvalidBchatId => 'Неверный BChat ID';

  @override
  String get bnsInvalidBelnetId => 'Неверный Belnet ID';

  @override
  String get bnsInvalidEthAddress => 'Неверный ETH-адрес';

  @override
  String get bnsInvalidName => 'Недопустимое имя BNS';

  @override
  String get bnsInvalidOwnerAddress => 'Недопустимый адрес владельца.';

  @override
  String get bnsInvalidWalletAddress => 'Недопустимый адрес кошелька. Оставьте поле пустым, если хотите использовать текущий кошелёк в качестве владельца BNS.';

  @override
  String get bnsNameHint => 'Имя для покупки через сервис\n Beldex Name Service';

  @override
  String get bnsNameIsTaken => 'Имя BNS уже занято. Выберите другое.';

  @override
  String get bnsNewOwnerHint => 'Введите адрес кошелька нового владельца';

  @override
  String get bnsNoteLabel => 'Примечание: ';

  @override
  String get bnsOwnerAndBackupDifferent => 'Адрес владельца и резервный адрес должны отличаться.';

  @override
  String get bnsOwnerHint => 'Адрес кошелька владельца';

  @override
  String get bnsOwnerLabel => 'Владелец';

  @override
  String get bnsOwnerOptional => 'Владелец (необязательно)';

  @override
  String get bnsPleaseFillField => 'Пожалуйста, заполните это поле';

  @override
  String get bnsPrice => 'Цена';

  @override
  String get bnsPurchase => 'Купить';

  @override
  String get bnsPurchaseDescription => 'Приобретите или обновите запись BNS.\n Если вы покупаете имя, может потребоваться\n минута или две, чтобы оно появилось в списке';

  @override
  String get bnsPurchasedSuccessfully => 'BNS успешно приобретён';

  @override
  String get bnsRecordNameHint => 'BNS-имя, принадлежащее вам';

  @override
  String get bnsRecordNotFound => 'Указанная запись BNS не существует или не принадлежит этому кошельку.';

  @override
  String get bnsRecords => 'Записи BNS';

  @override
  String get bnsRecordsDescription => 'Здесь вы можете найти все BNS-имена,принадлежащие этому кошельку.Расшифровка принадлежащей вам записи вернёт имя и значение записи BNS.';

  @override
  String get bnsRenewAction => 'Продлить';

  @override
  String get bnsRenewal => 'Продление BNS';

  @override
  String get bnsUpdate => 'Обновление BNS';

  @override
  String get bnsUpdateAction => 'Обновить';

  @override
  String get bnsUpdateHeight => 'Высота обновления';

  @override
  String get bnsUpdateNote => 'вы можете обновить либо адрес владельца, либо значения за один раз.\n Если вы хотите обновить и то, и другое, вы можете сначала обновить значения,\n а затем передать право владения, либо сделать это после передачи владения.';

  @override
  String get bnsUpdateOwner => 'Обновить владельца';

  @override
  String get bnsUpdateValues => 'Обновить значения';

  @override
  String get bnsYearFiveShort => '5 лет';

  @override
  String get bnsYearLabel => 'год';

  @override
  String get bnsYearOneShort => '1 год';

  @override
  String get bnsYearTenShort => '10 лет';

  @override
  String get bnsYearTwoShort => '2 года';

  @override
  String get bnsYouSave => 'Вы экономите';

  @override
  String get buyBns => 'Купить BNS';

  @override
  String get cancel => 'Отмена';

  @override
  String change_current_node(Object node) {
    return 'Вы уверены, что хотите изменить текущий узел на $node?';
  }

  @override
  String get change_language => 'Изменить язык';

  @override
  String get changelog => 'Список изменений';

  @override
  String get changeWallet => 'Сменить кошелёк';

  @override
  String get chooseLanguage => 'Выберите язык';

  @override
  String get chooseSeedLanguage => 'Выберите язык seed-фразы';

  @override
  String get clear => 'Очистить';

  @override
  String get confirm_sending => 'Подтверждение отправки';

  @override
  String get continue_text => 'Продолжить';

  @override
  String get copied => 'Скопировано';

  @override
  String get copyAndSaveTheSeedToContinue => 'Скопируйте и сохраните seed-фразу, чтобы продолжить';

  @override
  String get copySeed => 'Копировать seed-фразу';

  @override
  String get create_new => 'Создать новый кошелёк';

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'НИКОГДА не вводите $item своего кошелька Beldex в какое-либо программное обеспечение или на веб-сайт, кроме ОФИЦИАЛЬНЫХ кошельков Beldex, загруженных непосредственно из $app_store, с сайта Beldex или из GitHub Beldex. Вы уверены, что хотите получить доступ к своему кошельку $item?';
  }

  @override
  String get date => 'Дата';

  @override
  String get dateShouldNotBeEmpty => 'Дата не должна быть пустой';

  @override
  String get delete => 'Удалить';

  @override
  String get doYouWantToChangeYournPrimaryAccount => 'Вы хотите изменить основной аккаунт?';

  @override
  String get doYouWantToExitTheWallet => 'Вы хотите выйти из кошелька?';

  @override
  String get doYouWantToReconnectnTheWallet => 'Вы хотите переподключить кошелёк?';

  @override
  String get edit => 'Редактировать';

  @override
  String get enterAddress => 'Введите адрес';

  @override
  String get enterAmount => 'Введите сумму';

  @override
  String get enterAValidName => 'Введите корректное имя';

  @override
  String get enterAValidNameUpto15Characters => 'Введите корректное имя (до 15 символов)';

  @override
  String get enterAValidNameUpto20Characters => 'Введите корректное имя (до 20 символов)';

  @override
  String get enterAValidSubAddress => 'Введите корректный субадрес';

  @override
  String get enterBdxToReceive => 'Введите количество BDX для получения';

  @override
  String get enterBdxToSend => 'Введите количество BDX для отправки';

  @override
  String get enterName => 'Введите имя';

  @override
  String get enterPin => 'Введите PIN';

  @override
  String get enterValidHeightWithoutSpace => 'Введите корректную высоту блока без пробелов';

  @override
  String get enterValidNameUpto15Characters => 'Введите корректное имя (до 15 символов)';

  @override
  String get enterWalletName => 'Введите название кошелька';

  @override
  String get enterWalletName_ => 'Введите название кошелька';

  @override
  String get enterYourPin => 'Введите ваш PIN-код';

  @override
  String get error_text_address => 'Недействительный адрес BDX';

  @override
  String get error_text_contact_name => 'Имя контакта не может содержать символы «\'» или «\"»\n и должно быть длиной от 1 до 32 символов';

  @override
  String get error_text_keys => 'Ключи кошелька должны содержать 64 символа в шестнадцатеричном формате';

  @override
  String get error_text_node_address => 'Пожалуйста, введите IPv4-адрес ';

  @override
  String get error_text_node_port => 'Порт узла может содержать только числа от 0 до 65535';

  @override
  String get exchange => 'Обмен';

  @override
  String get exchangeRate => 'Курс обмена';

  @override
  String get expandDetails => 'Развернуть детали';

  @override
  String failed_authentication(Object state_error) {
    return 'Не удалось выполнить аутентификацию. $state_error';
  }

  @override
  String get faq => 'FAQ';

  @override
  String get fee => 'Комиссия';

  @override
  String get filters => 'Фильтр по';

  @override
  String get fiveDecimals => '5 — Пять (0.00000)';

  @override
  String get flashTransaction => 'Флеш-транзакция';

  @override
  String get floatingExchangeRate => 'Плавающий курс обмена';

  @override
  String get floatingRateDescription => 'Плавающий курс может измениться в любой момент в зависимости от рыночных условий, поэтому вы можете получить больше или меньше криптовалюты, чем ожидалось.';

  @override
  String get fourDecimals => '4 — Четыре (0.0000)';

  @override
  String get full_balance => 'Полный баланс';

  @override
  String get hidden_balance => 'Скрытый баланс';

  @override
  String get howCanWenhelpYou => 'Как мы можем вам помочь?';

  @override
  String get incoming => 'Входящие';

  @override
  String get initiatingTransactionDescription => 'Пожалуйста, не закрывайте это окно и не переходите в другие приложения, пока транзакция не будет инициирована';

  @override
  String get initiatingTransactionTitle => 'Инициализация транзакции...';

  @override
  String get labelName => 'Название метки';

  @override
  String get legalDisclaimer => 'Юридическое уведомление';

  @override
  String get loadingTheWallet => 'Загрузка кошелька…';

  @override
  String get loadingTheWalletDescription => 'Пожалуйста, не закрывайте это окно\nи не переходите в другие приложения,\nпока кошелёк загружается';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => 'Обязательно сделайте резервную копию\nвашей seed-фразы, адреса кошелька\nи приватных ключей';

  @override
  String get max => 'Макс.';

  @override
  String get maximumAmount => 'Максимальная сумма';

  @override
  String get minimumAmount => 'Минимальная сумма';

  @override
  String get myBns => 'Мой BNS';

  @override
  String get name => 'Имя';

  @override
  String get nameShouldNotBeEmpty => 'Имя не должно быть пустым';

  @override
  String get network_fee => 'Сетевая комиссия';

  @override
  String get networkErrorCheckConnection => 'Ошибка сети! Пожалуйста, проверьте подключение к интернету.';

  @override
  String never_give_your(Object item) {
    return 'Никогда не передавайте $item своего кошелька Beldex кому-либо!';
  }

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Никогда не вводите $item своего кошелька Beldex в какое-либо программное обеспечение или на веб-сайт, кроме официальных кошельков Beldex, загруженных непосредственно из $appStore, с сайта Beldex или из GitHub Beldex.';
  }

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'Никогда не делитесь своей seed-фразой ни с кем! Убедитесь, что рядом нет никого, кто может подсмотреть';

  @override
  String get new_subaddress_create => 'Создать';

  @override
  String get new_wallet => 'Новый кошелёк';

  @override
  String get no => 'Нет';

  @override
  String get noAddressesInBook => 'Нет адресов в книге';

  @override
  String get node_address => 'Адрес ноды';

  @override
  String get node_port => 'Порт ноды';

  @override
  String get node_reset_settings_title => 'Сброс настроек';

  @override
  String get nodeAlreadyExists => 'Такая нода уже существует';

  @override
  String get nodeNameOptional => 'Название ноды (необязательно)';

  @override
  String get nodes => 'Ноды';

  @override
  String get nodes_list_reset_to_default_message => 'Вы уверены, что хотите сбросить настройки\n до значений по умолчанию?';

  @override
  String get noInternet => 'Нет подключения к интернету!';

  @override
  String get noInternetMessage => 'Пожалуйста, проверьте подключение к интернету и попробуйте снова.';

  @override
  String get note => 'Примечание:';

  @override
  String get noTransactionsMessage => 'Нет транзакций или обменов для отображения.';

  @override
  String get noTransactionsYet => 'Транзакций пока нет!';

  @override
  String get ok => 'Ок';

  @override
  String get outgoing => 'Исходящие';

  @override
  String get passwordOptional => 'Пароль (необязательно)';

  @override
  String get paste => 'Вставить';

  @override
  String get pin_is_incorrect => 'PIN-код неверный';

  @override
  String get playStore => 'Play Маркет';

  @override
  String get please_try_to_connect_to_another_node => 'Пожалуйста, попробуйте подключиться к другому узлу';

  @override
  String get pleaseEnterAAmount => 'Пожалуйста, введите сумму';

  @override
  String get pleaseEnterABdxAddress => 'Пожалуйста, введите адрес BDX';

  @override
  String get pleaseEnterAValidAmount => 'Пожалуйста, введите корректную сумму';

  @override
  String get pleaseEnterAValidSeed => 'Пожалуйста, введите корректную seed-фразу';

  @override
  String get re_enter_your_pin => 'Повторно введите ваш PIN-код';

  @override
  String get receive => 'Получить';

  @override
  String get receiver => 'Получатель';

  @override
  String get reconnect => 'Переподключиться';

  @override
  String get reconnectWallet => 'Переподключить кошелёк';

  @override
  String get recoverySeed => 'Восстановительная seed-фраза';

  @override
  String get recoverySeedkey => 'Фраза восстановления/ключ';

  @override
  String get removeContact => 'Удаление контакта';

  @override
  String get removeWallet => 'Удалить кошелёк';

  @override
  String get rescan => 'Повторное сканирование';

  @override
  String get rescanWallet => 'Повторное сканирование кошелька';

  @override
  String get reset => 'Сброс';

  @override
  String get restore_address => 'Адрес';

  @override
  String get restore_description_from_keys => 'Используйте сохранённые ключи (private keys) для восстановления кошелька';

  @override
  String get restore_description_from_seed => 'Используйте 25-словную мнемоническую фразу или seed-фразу для восстановления кошелька.';

  @override
  String get restore_description_from_seed_keys => 'Восстановите свой кошелёк с помощью seed-фразы или ключей, которые вы сохранили в безопасном месте';

  @override
  String get restore_from_seed_placeholder => 'Пожалуйста, введите или вставьте вашу seed-фразу здесь';

  @override
  String get restore_next => 'Далее';

  @override
  String get restore_recover => 'Восстановить';

  @override
  String get restore_restore_wallet => 'Восстановить кошелёк';

  @override
  String get restore_title_from_keys => 'Восстановить с помощью ключей';

  @override
  String get restore_title_from_seed => 'Восстановить из seed-фразы';

  @override
  String get restore_title_from_seed_keys => 'Восстановить из seed-фразы/ключей';

  @override
  String get restore_wallet => 'Использовать существующий кошелёк';

  @override
  String get restoredViaKeys => 'Вы восстановили кошелёк с помощью ключей';

  @override
  String get save => 'Сохранить';

  @override
  String get searchCoins => 'Поиск монет';

  @override
  String get searchCurrency => 'Поиск валюты';

  @override
  String get seed_title => 'Сид-фраза';

  @override
  String get seedKeys => 'Seed и ключи';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'Выберите опцию, чтобы создать новый кошелёк\n или восстановить существующий';

  @override
  String get selectLanguage => 'Выбрать язык';

  @override
  String get send => 'Отправить';

  @override
  String get send_beldex_address => 'Адрес Beldex или имя BNS';

  @override
  String get send_estimated_fee => 'Ожидаемая комиссия:';

  @override
  String send_priority(Object transactionPriority) {
    return 'Приоритет $transactionPriority установлен в качестве комиссии по умолчанию. Перейдите в настройки, чтобы изменить приоритет транзакции.';
  }

  @override
  String get sent => 'Отправлено';

  @override
  String get service_fee => 'Комиссия сервиса 0.25%';

  @override
  String get settings_allow_biometric_authentication => 'Разрешить биометрическую аутентификацию';

  @override
  String get settings_balance_detail => 'Десятичные знаки';

  @override
  String get settings_change_pin => 'Изменить PIN';

  @override
  String get settings_currency => 'Валюта';

  @override
  String get settings_current_node => 'Текущая нода';

  @override
  String get settings_dark_mode => 'Тёмный режим';

  @override
  String get settings_display_balance_as => 'Отображать баланс как';

  @override
  String get settings_enable_fiat_currency => 'Включить конвертацию в фиатную валюту';

  @override
  String get settings_fee_priority => 'Приоритет комиссии';

  @override
  String get settings_personal => 'Личное';

  @override
  String get settings_save_recipient_address => 'Сохранять адрес получателя';

  @override
  String get settings_support => 'Поддержка';

  @override
  String get settings_terms_and_conditions => 'Условия использования';

  @override
  String get settings_title => 'Настройки';

  @override
  String get setup_pin => 'Настроить PIN-код';

  @override
  String get setup_successful => 'Ваш PIN-код успешно установлен!';

  @override
  String get shareQr => 'Поделиться QR-кодом';

  @override
  String get show_keys => 'Показать ключи';

  @override
  String get show_seed => 'Показать seed-фразу';

  @override
  String get spend_key_private => 'Ключ расходования';

  @override
  String get spend_key_public => 'Spend key (публичный)';

  @override
  String get status => 'Статус:';

  @override
  String get subAddress => 'Субадрес';

  @override
  String get subaddressAlreadyExist => 'Субадрес уже существует';

  @override
  String get swap => 'Обмен';

  @override
  String get swap_amount_from => 'Сумма отправки';

  @override
  String get swap_amount_sent => 'Отправленная сумма';

  @override
  String get swap_amount_to => 'Сумма получения';

  @override
  String get swap_and => 'и';

  @override
  String get swap_checkout => 'Оформление заказа';

  @override
  String get swap_completed => 'Завершено';

  @override
  String get swap_confirm_and_make_payment => 'Подтвердить и оплатить';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return 'Убедитесь, что вы ввели правильный адрес для выбранной сети — $blockchain. В противном случае вы потеряете свои средства.';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return 'Введите адрес получателя $currency';
  }

  @override
  String get swap_exchange_rate => 'Курс обмена';

  @override
  String get swap_failed => 'Ошибка';

  @override
  String get swap_funds_not_received => 'Средства не были получены в течение 3 часов.\nПожалуйста, проверьте курс и создайте\nновую транзакцию';

  @override
  String get swap_i_agree_with => 'Я согласен с';

  @override
  String get swap_input_hash => 'Хэш входа';

  @override
  String get swap_input_output_hash => 'Хэш входа/выхода';

  @override
  String get swap_network_fee => 'Сетевая комиссия';

  @override
  String get swap_network_label => 'СЕТЬ: ';

  @override
  String get swap_new_transaction => 'Новая транзакция';

  @override
  String get swap_open_history => 'Открыть историю';

  @override
  String get swap_output_hash => 'Хэш выхода';

  @override
  String get swap_privacy_policy => 'Политика конфиденциальности';

  @override
  String get swap_received_time => 'Время получения';

  @override
  String get swap_send_funds_notice => 'У вас есть 3 часа, чтобы отправить средства,\nв противном случае транзакция будет\nавтоматически отменена.\nОбмен будет инициирован после получения средств.';

  @override
  String get swap_send_funds_to_address_below => 'Отправьте средства на указанный ниже адрес';

  @override
  String get swap_service_fee => 'Комиссия сервиса 0.25%';

  @override
  String get swap_start_over => 'Начать заново';

  @override
  String get swap_terms_of_use => 'Условия использования';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return 'Оставшееся время для отправки $amount $currency';
  }

  @override
  String swap_time_remaining(Object value) {
    return 'Оставшееся время: $value';
  }

  @override
  String get swap_transaction_preview => 'Предварительный просмотр транзакции';

  @override
  String get swap_you_get => 'Вы получаете';

  @override
  String get swapNotAvailable => 'Обмен BDX в данный момент недоступен.';

  @override
  String get sync_status_connecting => 'Подключение';

  @override
  String get sync_status_failed_connect => 'Не удалось подключиться к узлу';

  @override
  String get sync_status_starting_sync => 'Начало синхронизации';

  @override
  String get sync_status_synchronized => 'Синхронизировано';

  @override
  String get sync_status_synchronizing => 'СИНХРОНИЗАЦИЯ';

  @override
  String get test => 'Проверить';

  @override
  String get testResult => 'Результат проверки:';

  @override
  String get theAddressAlreadyExist => 'Адрес уже существует';

  @override
  String get thisNameAlreadyExist => 'Такое имя уже существует';

  @override
  String get transaction_details_amount => 'Сумма';

  @override
  String get transaction_details_height => 'Высота';

  @override
  String get transaction_details_recipient_address => 'Адрес получателя';

  @override
  String get transaction_details_transaction_id => 'ID транзакции';

  @override
  String get transaction_priority_blink => 'Flash';

  @override
  String get transaction_priority_slow => 'Низкий';

  @override
  String get transactionInitiatedSuccessfully => 'Транзакция успешно инициирована';

  @override
  String get transactions => 'Транзакции';

  @override
  String get transactions_by_date => 'Транзакции по дате';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => 'Переводите BDX быстрее с помощью флеш-транзакций!';

  @override
  String get tryAgain => 'Пожалуйста, попробуйте позже.';

  @override
  String get twoDecimals => '2 — Два (0.00)';

  @override
  String get usePattern => 'ИСПОЛЬЗОВАТЬ ГРАФИЧЕСКИЙ КЛЮЧ';

  @override
  String get userNameOptional => 'Имя пользователя (необязательно)';

  @override
  String version(Object currentVersion) {
    return 'Версия $currentVersion';
  }

  @override
  String get view => 'Просмотр';

  @override
  String get view_key_private => 'Ключ просмотра (приватный)';

  @override
  String get view_key_public => 'View key (публичный)';

  @override
  String get wallet => 'Кошелёк';

  @override
  String get wallet_keys => 'Ключи кошелька';

  @override
  String wallet_list_failed_to_load(Object error, Object wallet_name) {
    return 'Не удалось загрузить кошелёк $wallet_name. $error';
  }

  @override
  String wallet_list_failed_to_remove(Object error, Object wallet_name) {
    return 'Не удалось удалить кошелёк $wallet_name. $error';
  }

  @override
  String get wallet_list_load_wallet => 'Загрузить кошелёк';

  @override
  String wallet_list_loading_wallet(Object wallet_name) {
    return 'Загрузка кошелька $wallet_name';
  }

  @override
  String wallet_list_removing_wallet(Object wallet_name) {
    return 'Удаление кошелька $wallet_name';
  }

  @override
  String get wallet_list_title => 'Кошелёк Beldex';

  @override
  String get wallet_name => 'Название кошелька';

  @override
  String get wallet_restoration_store_incorrect_seed_length => 'Неверная длина сид-фразы';

  @override
  String get walletAddress => 'Адрес кошелька';

  @override
  String walletAlreadyExists(Object name) {
    return 'Кошелёк с именем $name уже существует!';
  }

  @override
  String get walletRestore => 'Восстановление кошелька';

  @override
  String get wallets => 'Кошельки';

  @override
  String get walletSettings => 'Настройки кошелька';

  @override
  String get welcomeToBeldexWallet => 'Добро пожаловать в кошелёк Beldex :)';

  @override
  String get widgets_restore_from_blockheight => 'Восстановить с высоты блока';

  @override
  String get widgets_restore_from_date => 'Восстановить по дате';

  @override
  String get yes => 'Да';

  @override
  String get yes_im_sure => 'Да, я уверен(а)!';

  @override
  String get yesterday => 'Вчера';

  @override
  String get youAreAboutToDeletenYourWallet => 'Вы собираетесь удалить свой кошелёк!';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => 'Вы не можете просмотреть сид-фразу, поскольку восстановили кошелёк с помощью ключей';

  @override
  String get youGet => 'Вы получаете';

  @override
  String get youSend => 'Вы отправляете';

  @override
  String get zeroDecimal => '0 — Ноль (000)';

  @override
  String changePinLength(Object value) {
    return 'Переключиться на $value-значный PIN-код';
  }

  @override
  String get pleaseEnterAValidHeight => 'Пожалуйста, введите корректную высоту блока';

  @override
  String get invalidAddress => 'Недопустимый адрес';

  @override
  String get exchangePair => 'Торговая пара';

  @override
  String get payment => 'Оплата';

  @override
  String get bnsConfirmUpdate => 'Подтверждение обновления';

  @override
  String get bnsRenewedSuccessfully => 'BNS успешно продлён';

  @override
  String get bnsSameBchatId => 'Тот же BChat ID';

  @override
  String get bnsSameBelnetId => 'Тот же BelNet ID';

  @override
  String get bnsSameEthAddress => 'Тот же ETH-адрес';

  @override
  String get bnsSameOwnerAddress => 'Тот же адрес владельца';

  @override
  String get bnsSameWalletAddress => 'Тот же адрес кошелька';

  @override
  String get bnsUpdatedSuccessfully => 'BNS успешно обновлён';

  @override
  String get bnsWaitForFetch => 'Пожалуйста, подождите, пока мы получим запись BNS из сети';

  @override
  String get bnsYearFive => '5 лет';

  @override
  String get bnsYearOne => '1 год';

  @override
  String get bnsYearTen => '10 лет';

  @override
  String get bnsYearTwo => '2 года';

  @override
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return 'Вы действительно хотите разблокировать свой стейк из $masterNodeKey?';
  }

  @override
  String get checking => 'Проверка...';

  @override
  String get checkingNodeConnection => 'Проверка подключения к узлу...';

  @override
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return 'Подтвердить транзакцию\nСумма: $amount\nКомиссия: $fee';
  }

  @override
  String get committingTheTransaction => 'Подтверждение транзакции';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => 'Подтвердите PIN-код, графический ключ или пароль блокировки экрана';

  @override
  String get connectionFailed => 'Не удалось подключиться';

  @override
  String get do_you_want_to_exit_an_app => 'Вы хотите выйти из приложения?';

  @override
  String get enterAValidAddress => 'Введите допустимый адрес';

  @override
  String get error => 'Ошибка';

  @override
  String get error_text_beldex => 'Сумма Beldex не может превышать доступный баланс.\nКоличество знаков после запятой не должно превышать 9';

  @override
  String get error_text_fiat => 'Сумма не может превышать доступный баланс.\nКоличество знаков после запятой не должно превышать 2';

  @override
  String get error_text_service_node => 'Ключ Master Node может содержать только 64 шестнадцатеричных символа';

  @override
  String get exchangeAmount => 'Сумма обмена';

  @override
  String get failedToGetOutputDistribution => 'Не удалось получить распределение выходных данных';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return 'Flash-транзакции являются мгновенными транзакциями.\nПриоритет $transactionPriority установлен в качестве комиссии по умолчанию';
  }

  @override
  String get important => 'ВАЖНО';

  @override
  String get keys_title => 'Ключи';

  @override
  String get noPendingTransaction => 'Нет ожидающих транзакций';

  @override
  String get nothing_staked => 'Пока ничего не застейкано';

  @override
  String openalias_alert_content(Object recipient_name) {
    return 'Вы отправите средства на адрес\n$recipient_name';
  }

  @override
  String get openalias_alert_title => 'Обнаружен получатель Beldex';

  @override
  String get pending => '(в ожидании)';

  @override
  String get please_select => 'Выберите:';

  @override
  String get pleaseAddAMainnetNode => 'Добавьте узел основной сети';

  @override
  String get received => 'Получено';

  @override
  String get reconnect_alert_text => 'Вы уверены, что хотите переподключиться?';

  @override
  String get reconnection => 'Повторное подключение';

  @override
  String get remove_node => 'Удалить узел';

  @override
  String get remove_node_message => 'Вы уверены, что хотите удалить выбранный узел?';

  @override
  String get rename => 'Переименовать';

  @override
  String router_no_route(Object name) {
    return 'Для $name не определён маршрут';
  }

  @override
  String get seed_share => 'Поделиться сид-фразой';

  @override
  String get send_your_wallet => 'Ваш кошелёк';

  @override
  String get sending => 'Отправка';

  @override
  String get service_node_key => 'Ключ Master Node';

  @override
  String get settings_none => 'Нет';

  @override
  String get stake_beldex => 'Стейкинг Beldex';

  @override
  String get stake_more => 'Увеличить стейкинг';

  @override
  String get start_staking => 'Начать стейкинг';

  @override
  String get subaddress_title => 'Список подадресов';

  @override
  String get subAddresses => 'Подадреса';

  @override
  String get success => 'Успешно';

  @override
  String get swap_confirmations => 'Подтверждения';

  @override
  String get swap_confirmed => 'Подтверждено';

  @override
  String swap_confirmed_in_blockchain(Object currencyFrom, Object currencyTo) {
    return 'После подтверждения $currencyFrom в блокчейне мы начнём обмен на $currencyTo';
  }

  @override
  String get swap_confirming_in_progress => 'Выполняется подтверждение';

  @override
  String swap_done_exchanging(Object currencyFrom, Object currencyTo) {
    return 'Обмен $currencyFrom на $currencyTo завершён';
  }

  @override
  String swap_enter_extra_id(Object extraIdName) {
    return 'Введите $extraIdName';
  }

  @override
  String swap_enter_refund_address(Object currency) {
    return 'Введите адрес возврата $currency';
  }

  @override
  String get swap_estimated_time => 'Расчётное время';

  @override
  String get swap_estimated_time_value => '5–30 мин';

  @override
  String swap_exchange_address(Object currency, Object exchangeName) {
    return 'Адрес $exchangeName ($currency)';
  }

  @override
  String get swap_exchanging => 'Обмен';

  @override
  String swap_exchanging_currency(Object currencyFrom, Object currencyTo) {
    return 'Обмен $currencyFrom на $currencyTo';
  }

  @override
  String get swap_expired => 'Истёк';

  @override
  String swap_extra_id_info(Object currency, Object extraIdName) {
    return 'Укажите $extraIdName для вашего адреса получения $currency, если ваш кошелёк его предоставляет. Транзакция не будет выполнена, если вы его не укажете. Если вашему кошельку не требуется $extraIdName, снимите отметку.';
  }

  @override
  String get swap_funds_sent_to_wallet => 'Средства отправлены на ваш кошелёк';

  @override
  String get swap_history => 'История';

  @override
  String get swap_maximum_amount_changed => 'Максимальная сумма изменилась. Новое значение:';

  @override
  String get swap_minimum_amount_changed => 'Минимальная сумма изменилась. Новое значение:';

  @override
  String swap_my_wallet_requires_extra_id(Object extraIdName) {
    return 'Моему кошельку требуется $extraIdName';
  }

  @override
  String get swap_overdue => 'Просрочено';

  @override
  String swap_please_enter_extra_id(Object extraIdName) {
    return 'Введите $extraIdName';
  }

  @override
  String get swap_process_wait => 'Процесс займёт несколько минут. Пожалуйста, подождите.';

  @override
  String swap_recipient_address_with_currency(Object currency) {
    return 'Адрес получателя ($currency)';
  }

  @override
  String get swap_refund_address => 'Адрес возврата';

  @override
  String get swap_refund_wallet_address => 'Адрес кошелька для возврата';

  @override
  String get swap_see_input_hash_in_explorer => 'Посмотреть хеш входа в обозревателе';

  @override
  String get swap_sending_funds_to_wallet => 'Отправка средств на ваш кошелёк';

  @override
  String get swap_you_can_initiate_new_transaction => 'Вы можете начать новую транзакцию. Вы всегда можете проверить статус этой транзакции в истории транзакций.';

  @override
  String get swap_you_dont_have_to_wait_here => 'Вам не нужно ждать здесь';

  @override
  String get swap_you_sent => 'Вы отправили';

  @override
  String get swapTransactionReport => 'Beldex_wallet_swap_transaction_report';

  @override
  String get sync_status_connected => 'ПОДКЛЮЧЕНО';

  @override
  String get sync_status_not_connected => 'НЕ ПОДКЛЮЧЕНО';

  @override
  String get syncInfo => 'Информация о синхронизации';

  @override
  String get title_confirm_unlock_stake => 'Разблокировать стейк';

  @override
  String get title_new_stake => 'Новый стейк';

  @override
  String get title_stakes => 'Стейки';

  @override
  String get today => 'Сегодня';

  @override
  String get touchTheFingerprintSensor => 'Коснитесь датчика отпечатков пальцев';

  @override
  String transaction_details_copied(Object title) {
    return '$title скопировано в буфер обмена';
  }

  @override
  String get transaction_details_payment_id => 'ID платежа';

  @override
  String get transaction_details_title => 'Детали транзакции';

  @override
  String get transaction_sent => 'Транзакция отправлена!';

  @override
  String get transactionReport => 'Отчёт о транзакции';

  @override
  String get unable_unlock_stake => 'Не удалось разблокировать стейк';

  @override
  String get unlock_stake_requested => 'Запрошена разблокировка стейка';

  @override
  String get unlockBeldexWallet => 'Разблокировать кошелёк Beldex';

  @override
  String get wallet_menu => 'Меню';

  @override
  String get your_contributions => 'Ваш вклад';

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
