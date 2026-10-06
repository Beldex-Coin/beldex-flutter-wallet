// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcome => '';

  @override
  String get first_wallet_text => '';

  @override
  String get please_make_selection => '';

  @override
  String get create_new => 'Crear nueva billetera';

  @override
  String get restore_wallet => 'Usar billetera existente';

  @override
  String get accounts => 'Cuentas';

  @override
  String get edit => 'Editar';

  @override
  String get account => 'Cuenta';

  @override
  String get add => 'Agregar';

  @override
  String get address_book => 'Libreta de direcciones';

  @override
  String get contact => '';

  @override
  String get please_select => '';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'Ok';

  @override
  String get contact_name => '';

  @override
  String get reset => 'Restablecer';

  @override
  String get save => 'Guardar';

  @override
  String get authenticated => '';

  @override
  String get authentication => '';

  @override
  String failed_authentication(Object state_error) {
    return 'Error de autenticación. $state_error';
  }

  @override
  String get wallet_menu => '';

  @override
  String blocksRemaining(Object status) {
    return 'Quedan $status bloques';
  }

  @override
  String get please_try_to_connect_to_another_node => 'Por favor intenta conectarte a otro nodo';

  @override
  String get beldex_hidden => '';

  @override
  String get beldex_available_balance => '';

  @override
  String get beldex_full_balance => '';

  @override
  String get send => 'Enviar';

  @override
  String get receive => 'Recibir';

  @override
  String get transactions => 'Transacciones';

  @override
  String get incoming => 'Entrantes';

  @override
  String get outgoing => 'Salientes';

  @override
  String get transactions_by_date => 'Transacciones por fecha';

  @override
  String get filters => 'Filtrar por';

  @override
  String get today => '';

  @override
  String get yesterday => '';

  @override
  String get received => '';

  @override
  String get sent => 'Enviado';

  @override
  String get pending => '';

  @override
  String get rescan => 'Reescanear';

  @override
  String get reconnect => 'Reconectar';

  @override
  String get wallets => 'Billeteras';

  @override
  String get show_seed => 'Mostrar semilla';

  @override
  String get show_keys => 'Mostrar claves';

  @override
  String get reconnection => '';

  @override
  String get reconnect_alert_text => '';

  @override
  String get reload_fiat => '';

  @override
  String get clear => 'Borrar';

  @override
  String get error => '';

  @override
  String get copied_to_clipboard => '';

  @override
  String get fetching => '';

  @override
  String get id => '';

  @override
  String get amount => 'Cantidad';

  @override
  String get status => 'Estado:';

  @override
  String get confirm => '';

  @override
  String get confirm_sending => 'Confirmar envío';

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
  String get changelog => 'Registro de cambios';

  @override
  String get loading_your_wallet => '';

  @override
  String get new_wallet => 'Nueva cartera';

  @override
  String get wallet_name => 'Nombre de la billetera';

  @override
  String get continue_text => 'Continuar';

  @override
  String get node_new => '';

  @override
  String get node_address => 'Dirección del nodo';

  @override
  String get node_port => 'Puerto del nodo';

  @override
  String get login => '';

  @override
  String get password => '';

  @override
  String get nodes => 'Nodos';

  @override
  String get node_reset_settings_title => 'Restablecer ajustes';

  @override
  String get nodes_list_reset_to_default_message => '¿Estás seguro de que quieres restablecer los ajustes a los valores predeterminados?';

  @override
  String change_current_node(Object node) {
    return '¿Estás seguro de que quieres cambiar el nodo actual a $node?';
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
  String get delete => 'Eliminar';

  @override
  String get use => '';

  @override
  String get digit_pin => '';

  @override
  String get share_address => '';

  @override
  String get subaddresses => '';

  @override
  String get restore_restore_wallet => 'Restaurar cartera';

  @override
  String get restore_title_from_seed_keys => 'Restaurar desde semilla/claves';

  @override
  String get restore_description_from_seed_keys => 'Recupera tu billetera desde la semilla/claves que has guardado en un lugar seguro';

  @override
  String get restore_next => 'Siguiente';

  @override
  String get restore_title_from_backup => '';

  @override
  String get restore_description_from_backup => '';

  @override
  String get restore_seed_keys_restore => '';

  @override
  String get restore_title_from_seed => 'Restaurar desde semilla';

  @override
  String get restore_description_from_seed => 'Usa la clave mnemónica de 25 palabras o frase semilla para restaurar tu billetera.';

  @override
  String get restore_title_from_keys => 'Restaurar desde claves';

  @override
  String get restore_description_from_keys => 'Usa las claves generadas guardadas desde las claves privadas para restaurar tu billetera';

  @override
  String get restore_address => 'Dirección';

  @override
  String get restore_recover => 'Restaurar';

  @override
  String get restore_wallet_restore_description => '';

  @override
  String get seed_title => 'Semilla';

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
  String get send_beldex_address => 'Dirección Beldex o nombre BNS';

  @override
  String get all => '';

  @override
  String get send_error_currency => '';

  @override
  String get send_estimated_fee => 'Tarifa estimada:';

  @override
  String send_priority(Object transactionPriority) {
    return 'La prioridad $transactionPriority está establecida como tarifa predeterminada. Ve a Ajustes para cambiar la prioridad de la transacción.';
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
  String get settings_title => 'Ajustes';

  @override
  String get settings_current_node => 'Nodo actual';

  @override
  String get settings_display_balance_as => 'Mostrar saldo como';

  @override
  String get settings_balance_detail => 'Decimales';

  @override
  String get settings_currency => 'Moneda';

  @override
  String get settings_fee_priority => 'Prioridad de comisión';

  @override
  String get settings_save_recipient_address => 'Guardar dirección del destinatario';

  @override
  String get settings_personal => 'Personal';

  @override
  String get settings_change_pin => 'Cambiar PIN';

  @override
  String get settings_allow_biometric_authentication => 'Permitir autenticación biométrica';

  @override
  String get settings_dark_mode => 'Modo oscuro';

  @override
  String get settings_display_on_dashboard_list => '';

  @override
  String get settings_none => '';

  @override
  String get settings_support => 'Soporte';

  @override
  String get settings_terms_and_conditions => 'Términos y condiciones';

  @override
  String get settings_enable_fiat_currency => 'Habilitar conversión a moneda fiat';

  @override
  String get pin_is_incorrect => 'El PIN es incorrecto';

  @override
  String get amount_detail_ultra => '';

  @override
  String get amount_detail_none => '';

  @override
  String get amount_detail_detailed => '';

  @override
  String get amount_detail_normal => '';

  @override
  String get setup_pin => 'Configurar PIN';

  @override
  String get re_enter_your_pin => 'Vuelve a ingresar tu PIN';

  @override
  String get setup_successful => '¡Tu PIN se ha configurado correctamente!';

  @override
  String get wallet_keys => 'Sí, estoy seguro';

  @override
  String get view_key_private => 'Clave de visualización (privada)';

  @override
  String get view_key_public => 'Ver clave (pública)';

  @override
  String get spend_key_private => 'Clave de gasto (privada)';

  @override
  String get spend_key_public => 'Clave de gasto (pública)';

  @override
  String copied_key_to_clipboard(Object key) {
    return '';
  }

  @override
  String get new_subaddress_title => '';

  @override
  String get new_subaddress_create => 'Crear';

  @override
  String get subaddress_title => '';

  @override
  String get transaction_details_title => '';

  @override
  String get transaction_details_transaction_id => 'ID de transacción';

  @override
  String get transaction_details_height => 'Altura';

  @override
  String get transaction_details_amount => 'Monto';

  @override
  String get transaction_details_payment_id => '';

  @override
  String transaction_details_copied(Object title) {
    return '';
  }

  @override
  String get transaction_details_recipient_address => 'Dirección del destinatario';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return 'Asegúrate de introducir la dirección correcta para la cadena seleccionada - $blockchain. De lo contrario, perderás tus fondos.';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return 'Introduce la dirección del destinatario de $currency';
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
  String get swap_exchange_rate => 'Tipo de cambio';

  @override
  String get swap_service_fee => 'Tarifa de servicio: 0.25%';

  @override
  String get service_fee => 'Tarifa de servicio: 0.25%';

  @override
  String get network_fee => 'Tarifa de red';

  @override
  String get swap_refund_address => '';

  @override
  String get swap_network_fee => 'Tarifa de red';

  @override
  String get swap_you_get => 'Recibes';

  @override
  String get swap_checkout => 'Checkout';

  @override
  String get swap_network_label => 'RED: ';

  @override
  String get swap_estimated_time => '';

  @override
  String get swap_estimated_time_value => '';

  @override
  String get swap_confirm_and_make_payment => 'Confirmar y realizar pago';

  @override
  String get swap_send_funds_to_address_below => 'Envía los fondos a la siguiente dirección';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return 'Tiempo restante para enviar $amount $currency';
  }

  @override
  String swap_time_remaining(Object value) {
    return 'Tiempo restante: $value';
  }

  @override
  String get swap_send_funds_notice => 'Tienes 3 horas para enviar los fondos; de lo contrario, la transacción se cancelará automáticamente.\nEl intercambio se iniciará una vez que se reciban los fondos.';

  @override
  String get swap_confirmations => '';

  @override
  String get swap_completed => 'completado';

  @override
  String get swap_amount_from => 'Monto desde';

  @override
  String get swap_amount_to => 'Monto a';

  @override
  String get swap_received_time => 'Hora de recepción';

  @override
  String get swap_amount_sent => 'Monto enviado';

  @override
  String get swap_input_output_hash => 'Hash de entrada/salida';

  @override
  String get swap_input_hash => 'Hash de entrada';

  @override
  String get swap_output_hash => 'Hash de salida';

  @override
  String get swap_failed => 'Fallido';

  @override
  String get swap_expired => '';

  @override
  String get swap_overdue => '';

  @override
  String get swap_funds_not_received => 'Los fondos no fueron recibidos dentro de 3 horas. Por favor, revisa las tasas y crea una nueva transacción.';

  @override
  String get swap_start_over => 'Empezar de nuevo';

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
  String get swap_open_history => 'Abrir historial';

  @override
  String get swap_new_transaction => 'Nueva transacción';

  @override
  String get swap_i_agree_with => 'Estoy de acuerdo con';

  @override
  String get swap_terms_of_use => 'Términos de uso';

  @override
  String get swap_and => 'y';

  @override
  String get swap_privacy_policy => 'Política de privacidad';

  @override
  String get wallet_list_title => 'Beldex Wallet';

  @override
  String get wallet_list_load_wallet => 'Cargar billetera';

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
  String get widgets_restore_from_blockheight => 'Restaurar desde altura de bloque';

  @override
  String get widgets_restore_from_date => 'Restaurar desde fecha';

  @override
  String get widgets_or => '';

  @override
  String router_no_route(Object name) {
    return '';
  }

  @override
  String get error_text_account_name => '';

  @override
  String get error_text_contact_name => 'El nombre del contacto no puede contener símbolos ‘ ’ , “ ” y debe tener entre 1 y 32 caracteres';

  @override
  String get error_text_address => 'Dirección BDX inválida';

  @override
  String get error_text_node_address => 'Introduce una dirección IPv4.';

  @override
  String get error_text_node_port => 'El puerto del nodo solo puede contener números entre 0 y 65535';

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
  String get error_text_keys => 'Las claves de la billetera solo pueden contener 64 caracteres en hexadecimal ';

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
  String get full_balance => 'Saldo total';

  @override
  String get available_balance => 'Saldo disponible';

  @override
  String get hidden_balance => 'Saldo oculto';

  @override
  String get sync_status_synchronizing => 'SINCRONIZANDO';

  @override
  String get sync_status_synchronized => 'SINCRONIZADO';

  @override
  String get sync_status_not_connected => '';

  @override
  String get sync_status_starting_sync => 'Iniciando sincronización';

  @override
  String get sync_status_failed_connect => 'Error al conectar con el nodo';

  @override
  String get sync_status_connecting => 'Conectando';

  @override
  String get sync_status_connected => '';

  @override
  String get transaction_priority_slow => 'Lenta';

  @override
  String get transaction_priority_blink => 'Flash';

  @override
  String get change_language => 'Cambiar idioma';

  @override
  String change_language_to(Object language) {
    return '';
  }

  @override
  String get paste => 'Pegar';

  @override
  String get restore_from_seed_placeholder => 'Por favor ingresa o pega tu semilla aquí';

  @override
  String get add_new_word => '';

  @override
  String get incorrect_seed => '';

  @override
  String get biometric_auth_reason => '';

  @override
  String version(Object currentVersion) {
    return 'Versión $currentVersion';
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
  String get yes_im_sure => 'Sí, estoy seguro';

  @override
  String never_give_your(Object item) {
    return '¡Nunca des a nadie el $item de tu cartera Beldex!';
  }

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'NUNCA introduzcas el $item de tu cartera Beldex en ningún software o sitio web que no sean las carteras Beldex OFICIALES descargadas directamente desde $app_store, el sitio web de Beldex o el GitHub de Beldex. ¿Estás seguro de que quieres acceder a tu cartera $item?';
  }

  @override
  String get keys_title => '';

  @override
  String get are_you_sure => '¿Estás seguro?';

  @override
  String get do_you_want_to_exit_an_app => '';

  @override
  String get no => 'No';

  @override
  String get yes => 'Sí';

  @override
  String get byUsingThisAppYouAgreeToTheTermsOf => '';

  @override
  String get iAgreeToTermsOfUse => '';

  @override
  String get accept => '';

  @override
  String get pleaseEnterAValidAmount => 'Por favor ingresa una cantidad válida';

  @override
  String get pleaseEnterAValidSeed => 'Por favor ingresa una semilla válida';

  @override
  String get changeWallet => 'Cambiar billetera';

  @override
  String get removeWallet => 'Eliminar billetera';

  @override
  String get reconnectWallet => 'Reconectar billetera';

  @override
  String get rescanWallet => 'Reescanear billetera';

  @override
  String get enterWalletName => 'Ingresa el nombre de la billetera';

  @override
  String get noTransactionsYet => '¡No hay transacciones aún!';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'Después de tu primera transacción, podrás verla aquí.';

  @override
  String get copied => 'Copiado';

  @override
  String get addAddress => 'Agregar dirección';

  @override
  String get important => '';

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Nunca introduzcas el $item de tu cartera Beldex en ningún software o sitio web que no sean las carteras oficiales de Beldex descargadas directamente desde $appStore, el sitio web de Beldex o el GitHub de Beldex.';
  }

  @override
  String get enterWalletName_ => 'Ingresa el nombre de la billetera';

  @override
  String get chooseSeedLanguage => 'Elegir idioma de la semilla';

  @override
  String get wallet => 'Billetera';

  @override
  String get seedKeys => 'Semilla y Claves';

  @override
  String get walletAddress => 'Dirección de la billetera';

  @override
  String get recoverySeedkey => 'Semilla/clave de recuperación';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get chooseLanguage => 'Elegir idioma';

  @override
  String get welcomeToBeldexWallet => 'Bienvenido a Beldex Wallet :)';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'Selecciona una opción para crear o recuperar\n una billetera existente';

  @override
  String get enterAValidNameUpto15Characters => 'Introduzca un nombre válido de hasta 15 caracteres';

  @override
  String get enterAValidNameUpto20Characters => 'Ingresa un nombre válido de hasta 20 caracteres';

  @override
  String get fiveDecimals => '5 - Cinco (0.00000)';

  @override
  String get fourDecimals => '4 - Cuatro (0.0000)';

  @override
  String get twoDecimals => '2 - Dos (0.00)';

  @override
  String get zeroDecimal => '0 - Cero (000)';

  @override
  String get doYouWantToExitTheWallet => '¿Deseas salir de la billetera?';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => 'Asegúrate de hacer una copia de seguridad de tu semilla de recuperación, dirección de billetera y claves privadas';

  @override
  String blockRemaining(Object status) {
    return '';
  }

  @override
  String get flashTransaction => 'Transacción Flash';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => '¡Transfiere tu BDX más rápido con Transacción Flash!';

  @override
  String get enterYourPin => 'Ingresa tu PIN';

  @override
  String get walletSettings => 'Configuración de billetera';

  @override
  String get recoverySeed => 'Seed de recuperación';

  @override
  String get youDontHaveEnoughUnlockedBalance => '';

  @override
  String get alert => 'Alerta';

  @override
  String get touchTheFingerprintSensor => '';

  @override
  String get usePattern => '';

  @override
  String get enterBdxToSend => 'Ingresa BDX a enviar';

  @override
  String get enterAmount => 'Ingresa cantidad';

  @override
  String get pleaseEnterAAmount => 'Por favor ingresa una cantidad';

  @override
  String get committingTheTransaction => '';

  @override
  String get availableBdx => 'BDX disponible :';

  @override
  String get pleaseEnterABdxAddress => 'Por favor ingresa una dirección BDX';

  @override
  String get enterAValidAddress => '';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'La función biométrica está actualmente deshabilitada. Por favor, habilita la autenticación biométrica en la configuración de la aplicación';

  @override
  String get unlockBeldexWallet => '';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => '';

  @override
  String get doYouWantToChangeYournPrimaryAccount => '¿Desea cambiar su cuenta principal?';

  @override
  String get rename => '';

  @override
  String get addAccount => 'Añadir cuenta';

  @override
  String get noAddressesInBook => 'No hay direcciones en la libreta';

  @override
  String get bdx => '';

  @override
  String get howeverWeRecommendToScanTheBlockchainFromTheBlock => '';

  @override
  String get youHaveScannedFromTheBlockHeight => '';

  @override
  String get syncInfo => '';

  @override
  String get doYouWantToReconnectnTheWallet => '¿Deseas reconectar la billetera?';

  @override
  String get enterValidNameUpto15Characters => 'Ingresa un nombre válido de hasta 15 caracteres';

  @override
  String get checkingNodeConnection => '';

  @override
  String get enterBdxToReceive => 'Ingresa BDX a recibir';

  @override
  String get addSubAddress => 'Agregar subdirección';

  @override
  String get shareQr => 'Compartir QR';

  @override
  String get name => 'Nombre';

  @override
  String get enterValidHeightWithoutSpace => 'Ingresa una altura válida sin espacios';

  @override
  String get dateShouldNotBeEmpty => 'La fecha no debe estar vacía';

  @override
  String get walletRestore => 'Restauración de cartera';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => '';

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => '¡Nunca compartas tu semilla con nadie! Verifica tu entorno para asegurarte de que nadie esté mirando';

  @override
  String get note => 'Nota:';

  @override
  String get copySeed => 'Copiar semilla';

  @override
  String get accountAlreadyExist => 'La cuenta ya existe';

  @override
  String get transactionInitiatedSuccessfully => 'Transacción iniciada correctamente';

  @override
  String get enterAValidSubAddress => 'Ingresa una subdirección válida';

  @override
  String get subaddressAlreadyExist => 'La subdirección ya existe';

  @override
  String get labelName => 'Nombre de etiqueta';

  @override
  String get subAddress => 'Subdirección';

  @override
  String get loadingTheWallet => 'Cargando la billetera…';

  @override
  String get youAreAboutToDeletenYourWallet => 'Estás a punto de eliminar tu billetera';

  @override
  String get creatingTheTransaction => '';

  @override
  String get copyAndSaveTheSeedToContinue => 'Copia y guarda la semilla para continuar';

  @override
  String get enterPin => 'Ingresar PIN';

  @override
  String get test => 'Prueba';

  @override
  String get success => '';

  @override
  String get connectionFailed => '';

  @override
  String get checking => '';

  @override
  String get testResult => 'Resultado de la prueba:';

  @override
  String get passwordOptional => 'Contraseña (opcional)';

  @override
  String get userNameOptional => 'Nombre de usuario (opcional)';

  @override
  String get nodeNameOptional => 'Nombre del nodo (opcional)';

  @override
  String get addNode => 'Añadir nodo';

  @override
  String get legalDisclaimer => '';

  @override
  String get howCanWenhelpYou => '¿Cómo podemos ayudarte?';

  @override
  String get removeContact => 'Eliminar contacto';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => '¿Estás seguro de que deseas eliminar el contacto seleccionado?';

  @override
  String get theAddressAlreadyExist => 'La dirección ya existe';

  @override
  String get thisNameAlreadyExist => 'Este nombre ya existe';

  @override
  String get enterAValidName => 'Ingresa un nombre válid';

  @override
  String get addressShouldNotBeEmpty => 'La dirección no debe estar vacía';

  @override
  String get nameShouldNotBeEmpty => 'El nombre no debe estar vacío';

  @override
  String get enterName => 'Ingresar nombre';

  @override
  String get accountName => 'Nombre de la cuenta';

  @override
  String get playStore => '';

  @override
  String get appstore => '';

  @override
  String get allowFaceIdAuthentication => '';

  @override
  String get enterAddress => 'Ingresar dirección';

  @override
  String get pleaseAddAMainnetNode => '';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return '';
  }

  @override
  String get initiatingTransactionTitle => 'Iniciando transacción..';

  @override
  String get initiatingTransactionDescription => 'Por favor, no cierres esta ventana ni navegues a otra aplicación hasta que la transacción se inicie';

  @override
  String get subAddresses => '';

  @override
  String get loadingTheWalletDescription => 'Por favor, no cierres esta ventana ni navegues a otra aplicación hasta que la billetera se haya cargado.';

  @override
  String get buyBns => 'Comprar BNS';

  @override
  String get myBns => '';

  @override
  String get addBns => 'Agregar BNS';

  @override
  String get bns => '';

  @override
  String get bnsPurchaseDescription => 'Compra o actualiza un registro BNS. Si compras un nombre, puede tardar uno o dos minutos en aparecer en la lista.';

  @override
  String get bnsPrice => 'Precio';

  @override
  String get bnsYearOneShort => '1 Año';

  @override
  String get bnsYearTwoShort => '2 Años';

  @override
  String get bnsYearFiveShort => '5 Años';

  @override
  String get bnsYearTenShort => '10 Años';

  @override
  String get bnsYearOne => '';

  @override
  String get bnsYearTwo => '';

  @override
  String get bnsYearFive => '';

  @override
  String get bnsYearTen => '';

  @override
  String get bnsYouSave => 'Ahorras';

  @override
  String get bnsNameHint => 'El nombre a comprar a través del Beldex Name Service';

  @override
  String get bnsOwnerOptional => 'Propietario (Opcional';

  @override
  String get bnsOwnerHint => 'La dirección de billetera del propietario';

  @override
  String get bnsBchatId => 'ID de BChat';

  @override
  String get bnsBelnetId => 'ID de Belnet';

  @override
  String get bnsEthAddress => 'Dirección ETH';

  @override
  String get bnsUpdateOwner => 'Actualizar propietario';

  @override
  String get bnsUpdateValues => 'Actualizar valores';

  @override
  String get bnsNewOwnerHint => 'Introduce la dirección de billetera del nuevo propietario';

  @override
  String get bnsUpdateNote => 'Solo puedes actualizar la dirección del propietario o los valores a la vez.\n Si deseas actualizar ambos, puedes actualizar los valores antes o después de transferir la propiedad.';

  @override
  String get bnsAddRecord => 'Agregar registro';

  @override
  String get bnsRecordsDescription => 'Aquí puedes encontrar todos los nombres BNS propiedad de esta billetera. Al descifrar un registro que te pertenece, se mostrará el nombre y el valor del registro BNS.';

  @override
  String get bnsRecordNameHint => 'Un nombre BNS que te pertenece';

  @override
  String get bnsFetchingRecords => 'Obteniendo registro BNS de la red...';

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return 'Registro BNS de $bnsName descifrado correctamente';
  }

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return 'No se pudo descifrar el registro BNS de $bnsName';
  }

  @override
  String get bnsRecordNotFound => '';

  @override
  String get bnsWaitForFetch => '';

  @override
  String get bnsRecords => 'Registros BNS';

  @override
  String get bnsExpirationHeight => 'Altura de expiración';

  @override
  String get bnsUpdateHeight => 'Altura de actualización';

  @override
  String get bnsBackupOwner => 'Propietario de respaldo';

  @override
  String get bnsEncryptedWalletValue => 'Valor de billetera encriptado';

  @override
  String get bnsEncryptedBchatValue => 'Valor de BChat encriptado';

  @override
  String get bnsEncryptedBelnetValue => 'Valor de Belnet encriptado';

  @override
  String get bnsEncryptedEthValue => 'Valor de ETH encriptado';

  @override
  String get bnsUpdateAction => 'Actualiza';

  @override
  String get bnsRenewAction => 'Renovar';

  @override
  String get bnsNoteLabel => 'Nota: ';

  @override
  String get bnsEthAddressDescription => 'Nuestra dirección ETH es compatible con todas las cadenas EVM';

  @override
  String get bnsPurchase => 'Comprar';

  @override
  String get bnsPleaseFillField => 'Por favor completa este campo';

  @override
  String get bnsInvalidName => '';

  @override
  String get bnsInvalidBchatId => 'ID de BChat inválido';

  @override
  String get bnsInvalidBelnetId => 'ID de Belnet inválido';

  @override
  String get bnsInvalidEthAddress => 'Dirección ETH inválida';

  @override
  String get bnsEnterValidWalletAddress => 'Introduce una dirección de billetera válida';

  @override
  String get bnsConfirmPurchase => 'Confirmar compra';

  @override
  String get bnsYearLabel => 'Año';

  @override
  String get bnsOwnerLabel => 'Propietario';

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
  String get bnsUpdate => 'Actualización BNS';

  @override
  String get bnsRenewal => 'Renovación de BNS';

  @override
  String get swap => 'Intercambiar';

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
  String get restoredViaKeys => 'Has restaurado mediante claves';

  @override
  String walletAlreadyExists(Object name) {
    return '¡Ya existe una cartera con el nombre $name!';
  }

  @override
  String get nodeAlreadyExists => 'Este nodo ya existe';

  @override
  String get fee => 'Tarifa';

  @override
  String get noInternet => '¡Sin internet!';

  @override
  String get noInternetMessage => 'Por favor, revisa tu conexión a internet e\n inténtalo de nuevo.';

  @override
  String get swapNotAvailable => ' El intercambio BDX no está disponible por el momento';

  @override
  String get tryAgain => 'Por favor, inténtalo nuevamente después de un tiempo.';

  @override
  String get exchange => 'Intercambiar';

  @override
  String get youSend => 'Envías';

  @override
  String get youGet => 'Recibes';

  @override
  String get floatingExchangeRate => 'Tasa de cambio flotante';

  @override
  String get floatingRateDescription => 'La tasa flotante puede cambiar en cualquier momento debido a las condiciones del mercado, por lo que podrías recibir más o menos cripto de lo esperado.';

  @override
  String get searchCoins => 'Buscar monedas';

  @override
  String get minimumAmount => 'La cantidad mínima es';

  @override
  String get maximumAmount => 'La cantidad máxima es';

  @override
  String get exchangeAmount => '';

  @override
  String get exchangeRate => 'Tipo de cambio';

  @override
  String get receiver => 'Receptor';

  @override
  String get amountReceived => 'Cantidad recibida';

  @override
  String get date => 'Fecha';

  @override
  String get expandDetails => 'Expandir detalles';

  @override
  String get view => 'Ver';

  @override
  String get noTransactionsMessage => 'No hay transacciones o intercambios para mostrar.';

  @override
  String get networkErrorCheckConnection => '¡Error de red! Por favor, revisa la conexión a internet.';

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
  String get searchCurrency => 'Buscar moneda';

  @override
  String changePinLength(Object value) {
    return 'Cambiar a PIN de $value dígitos';
  }

  @override
  String get pleaseEnterAValidHeight => 'Por favor ingresa una altura válida';

  @override
  String get invalidAddress => '';

  @override
  String get exchangePair => 'Par de intercambio';

  @override
  String get payment => 'Pago';

  @override
  String get bnsConfirmUpdate => 'Confirmar actualización';
}
