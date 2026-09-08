// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get welcome => 'Willkommen\nim Beldex WALLET';

  @override
  String get first_wallet_text => 'Das tolle Wallet\nfür Beldex';

  @override
  String get please_make_selection => 'Bitte treffen Sie unten eine Auswahl zu\nErstellen oder Wiederherstellen Ihres Wallets.';

  @override
  String get create_new => 'Neu erstellen';

  @override
  String get restore_wallet => 'Wallet wiederherstellen';

  @override
  String get accounts => 'Konten';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get account => 'Konto';

  @override
  String get add => 'Hinzufügen';

  @override
  String get address_book => 'Adressbuch';

  @override
  String get contact => 'Kontakt';

  @override
  String get please_select => 'Bitte auswählen:';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get ok => 'Ok';

  @override
  String get contact_name => 'Name des Ansprechpartners';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get save => 'Speichern';

  @override
  String get authenticated => 'Authentifiziert';

  @override
  String get authentication => 'Authentifizierung';

  @override
  String failed_authentication(Object state_error) {
    return 'Authentifizierung fehlgeschlagen. $state_error';
  }

  @override
  String get wallet_menu => 'Wallet-Menü';

  @override
  String blocksRemaining(Object status) {
    return '$status verbleibende Blöcke';
  }

  @override
  String get please_try_to_connect_to_another_node => 'Bitte versuchen Sie, eine Verbindung zu einem anderen Knoten herzustellen';

  @override
  String get beldex_hidden => 'Beldex versteckt';

  @override
  String get beldex_available_balance => 'Beldex verfügbares Guthaben';

  @override
  String get beldex_full_balance => 'Beldex volles Guthaben';

  @override
  String get send => 'Senden';

  @override
  String get receive => 'Erhalten';

  @override
  String get transactions => 'Transaktionen';

  @override
  String get incoming => 'Eingehend';

  @override
  String get outgoing => 'Ausgehend';

  @override
  String get transactions_by_date => 'Transaktionen nach Datum';

  @override
  String get filters => 'Filter';

  @override
  String get today => 'Heute';

  @override
  String get yesterday => 'Gestern';

  @override
  String get received => 'Empfangen';

  @override
  String get sent => 'Geschickt';

  @override
  String get pending => ' (steht aus)';

  @override
  String get rescan => 'Erneut scannen';

  @override
  String get reconnect => 'Erneut verbinden';

  @override
  String get wallets => 'Wallets';

  @override
  String get show_seed => 'Seed zeigen';

  @override
  String get show_keys => 'Schlüssel anzeigen';

  @override
  String get reconnection => 'Wiederverbindung';

  @override
  String get reconnect_alert_text => 'Sind Sie sicher, dass Sie die Verbindung wiederherstellen möchten?';

  @override
  String get reload_fiat => 'Fiat-Kurs neuladen';

  @override
  String get clear => 'Löschen';

  @override
  String get error => 'Error';

  @override
  String get copied_to_clipboard => 'In die Zwischenablage kopiert';

  @override
  String get fetching => 'aktualisieren';

  @override
  String get id => 'ID: ';

  @override
  String get amount => 'Menge ';

  @override
  String get status => 'Status: ';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get confirm_sending => 'Bestätigen Sie das Senden';

  @override
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return 'Transaktion festschreiben\nMenge: $amount\nGebühr: $fee';
  }

  @override
  String get sending => 'Senden';

  @override
  String get transaction_sent => 'Transaktion gesendet!';

  @override
  String get send_beldex => 'Beldex Senden';

  @override
  String get faq => 'FAQ';

  @override
  String get changelog => 'Änderungsprotokoll';

  @override
  String get loading_your_wallet => 'Wallet wird geladen';

  @override
  String get new_wallet => 'Neues wallet';

  @override
  String get wallet_name => 'Walletname';

  @override
  String get continue_text => 'Fortsetzen';

  @override
  String get node_new => 'Neuer Knoten';

  @override
  String get node_address => 'Knotenadresse';

  @override
  String get node_port => 'Knotenport';

  @override
  String get login => 'Einloggen';

  @override
  String get password => 'Passwort';

  @override
  String get nodes => 'Knoten';

  @override
  String get node_reset_settings_title => 'Einstellungen zurücksetzen';

  @override
  String get nodes_list_reset_to_default_message => 'Möchten Sie die Einstellungen wirklich auf die Standardeinstellungen zurücksetzen?';

  @override
  String change_current_node(Object node) {
    return 'Möchten Sie den aktuellen Knoten wirklich auf ändern? $node?';
  }

  @override
  String get change => 'Veränderung';

  @override
  String get remove_node => 'Knoten entfernen';

  @override
  String get remove_node_message => 'Möchten Sie den ausgewählten Knoten wirklich entfernen?';

  @override
  String get remove => 'Löschen';

  @override
  String get delete => 'Löschen';

  @override
  String get use => 'Wechseln zu ';

  @override
  String get digit_pin => '-stelliger PIN';

  @override
  String get share_address => 'Adresse teilen ';

  @override
  String get receive_amount => 'Menge';

  @override
  String get subaddresses => 'Unteradressen';

  @override
  String get restore_restore_wallet => 'Wallet wiederherstellen';

  @override
  String get restore_title_from_seed_keys => 'Vom Seed / Schlüssel wiederherstellen';

  @override
  String get restore_description_from_seed_keys => 'Stellen sie Ihr Wallet mit Seed / Schlüsseln, welche Sie an einem sicheren Ort aufbewahrt haben, wieder her';

  @override
  String get restore_next => 'Weiter';

  @override
  String get restore_title_from_backup => 'Aus einer Sicherungsdatei wiederherstellen';

  @override
  String get restore_description_from_backup => 'Sie können die gesamte Beldex Wallet-App aus ihrer Sicherungsdatei wiederherstellen.';

  @override
  String get restore_seed_keys_restore => 'Seed / Schlüssel wiederherstellen';

  @override
  String get restore_title_from_seed => 'Aus Seed wiederherstellen';

  @override
  String get restore_description_from_seed => 'Verwenden Sie den 25-Wörter-Mnemonikschlüssel oder die Seed-Phrase, um Ihre Brieftasche wiederherzustellen.';

  @override
  String get restore_title_from_keys => 'Wiederherstellen von Schlüsseln';

  @override
  String get restore_description_from_keys => 'Verwenden Sie die generierten Tastenanschläge, die von privaten Schlüsseln gespeichert wurden, um Ihre Brieftasche wiederherzustellen';

  @override
  String get restore_wallet_name => 'Walletname';

  @override
  String get restore_address => 'Adresse';

  @override
  String get restore_view_key_private => 'Anzeige-Schlüssel (geheim)';

  @override
  String get restore_spend_key_private => 'Ausgabe-Schlüssel (geheim)';

  @override
  String get restore_recover => 'Wiederherstellen';

  @override
  String get restore_wallet_restore_description => 'Beschreibung zur Wiederherstellung des Wallets';

  @override
  String get seed_title => 'Seed';

  @override
  String get seed_share => 'Teilen Sie Seed';

  @override
  String get copy => 'Kopieren';

  @override
  String get seed_language_choose => 'Bitte wählen Sie die Ausgangssprache';

  @override
  String get seed_language_next => 'Weiter';

  @override
  String get seed_language_english => 'Englisch';

  @override
  String get seed_language_chinese => 'Chinesisch';

  @override
  String get seed_language_dutch => 'Niederländisch';

  @override
  String get seed_language_german => 'Deutsch';

  @override
  String get seed_language_japanese => 'Japanisch';

  @override
  String get seed_language_portuguese => 'Portugiesisch';

  @override
  String get seed_language_russian => 'Russisch';

  @override
  String get seed_language_spanish => 'Spanisch';

  @override
  String get seed_language_french => 'Französisch';

  @override
  String get seed_language_italian => 'Italienisch';

  @override
  String get send_title => 'Senden Sie';

  @override
  String get send_your_wallet => 'Dein Wallet';

  @override
  String get send_beldex_address => 'Beldex-Adresse oder BNS-Name';

  @override
  String get all => 'ALLE';

  @override
  String get send_error_currency => 'Die Währung kann nur Zahlen enthalten';

  @override
  String get send_estimated_fee => 'Geschätzte Gebühr:';

  @override
  String send_priority(Object transactionPriority) {
    return '$transactionPriority Priorität ist als Standardgebühr festgelegt.\nGehen Sie zu Einstellung, um die Transaktionspriorität zu ändern.';
  }

  @override
  String get send_creating_transaction => 'Transaktion erstellen';

  @override
  String get title_stakes => 'Stakes';

  @override
  String get title_new_stake => 'Neuer Stake';

  @override
  String get your_contributions => 'Deine Anteile';

  @override
  String get start_staking => 'Starte zu staken';

  @override
  String get stake_more => 'Mehr staken';

  @override
  String get nothing_staked => 'Noch nichts gestaked';

  @override
  String get service_node_key => 'Master Node Schlüssel';

  @override
  String get stake_beldex => 'Beldex staken';

  @override
  String get title_confirm_unlock_stake => 'Stake entsperren';

  @override
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return 'Möchtest du wirkklich dein Stake von $masterNodeKey entsperren?';
  }

  @override
  String get unlock_stake_requested => 'Stake Entsperrung angefragt';

  @override
  String get unable_unlock_stake => 'Stake Entsperrung nicht möglich';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get settings_nodes => 'Knoten';

  @override
  String get settings_current_node => 'Aktueller Knoten';

  @override
  String get settings_wallets => 'Wallets';

  @override
  String get settings_display_balance_as => 'Kontostand anzeigen als';

  @override
  String get settings_balance_detail => 'Dezimalstellen';

  @override
  String get settings_currency => 'Währung';

  @override
  String get settings_fee_priority => 'Gebührenpriorität';

  @override
  String get settings_save_recipient_address => 'Empfängeradresse speichern';

  @override
  String get settings_personal => 'Persönlich';

  @override
  String get settings_change_pin => 'PIN ändern';

  @override
  String get settings_change_language => 'Sprache ändern';

  @override
  String get settings_allow_biometric_authentication => 'Biometrische Authentifizierung';

  @override
  String get settings_dark_mode => 'Dunkler Modus';

  @override
  String get settings_transactions => 'Transaktionen';

  @override
  String get settings_display_on_dashboard_list => 'Anzeige in der Dashboard-Liste';

  @override
  String get settings_all => 'ALLE';

  @override
  String get settings_none => 'Keiner';

  @override
  String get settings_support => 'Unterstützung';

  @override
  String get settings_terms_and_conditions => 'Geschäftsbedingungen';

  @override
  String get settings_enable_fiat_currency => 'In Fiat Währung umrechnen';

  @override
  String get pin_is_incorrect => 'PIN ist falsch';

  @override
  String get amount_detail_ultra => '9 - Ultra';

  @override
  String get amount_detail_none => '0 - Keine';

  @override
  String get amount_detail_detailed => '4 - Detailliert';

  @override
  String get amount_detail_normal => '2 - Normal';

  @override
  String get setup_pin => 'PIN einrichten';

  @override
  String get re_enter_your_pin => 'Geben Sie Ihre PIN erneut ein';

  @override
  String get setup_successful => 'Ihre PIN wurde erfolgreich eingerichtet!';

  @override
  String get wallet_keys => 'Wallet Schlüssel';

  @override
  String get view_key_private => 'Anzeige-Schlüssel (geheim)';

  @override
  String get view_key_public => 'Anzeige-Schlüssel (öffentlich)';

  @override
  String get spend_key_private => 'Ausgabe-Schlüssel (geheim)';

  @override
  String get spend_key_public => 'Ausgabe-Schlüssel (öffentlich)';

  @override
  String copied_key_to_clipboard(Object key) {
    return 'Kopiert $key in die Zwischenablage';
  }

  @override
  String get new_subaddress_title => 'Neue Unteradresse';

  @override
  String get new_subaddress_label_name => 'Name';

  @override
  String get new_subaddress_create => 'Erstellen';

  @override
  String get subaddress_title => 'Unteradressenliste';

  @override
  String get transaction_details_title => 'Transaktionsdetails';

  @override
  String get transaction_details_transaction_id => 'Transaktions-ID';

  @override
  String get transaction_details_date => 'Datum';

  @override
  String get transaction_details_height => 'Höhe';

  @override
  String get transaction_details_amount => 'Betrag';

  @override
  String transaction_details_copied(Object title) {
    return '$title in die Zwischenablage kopiert';
  }

  @override
  String get transaction_details_recipient_address => 'Empfängeradresse';

  @override
  String get wallet_list_title => 'Beldex Wallet';

  @override
  String get wallet_list_create_new_wallet => 'Neues wallet erstellen';

  @override
  String get wallet_list_restore_wallet => 'Wallet wiederherstellen';

  @override
  String get wallet_list_load_wallet => 'Wallet laden';

  @override
  String wallet_list_loading_wallet(Object wallet_name) {
    return 'Wallet $wallet_name wird geladen';
  }

  @override
  String wallet_list_failed_to_load(Object error, Object wallet_name) {
    return 'Laden fehlgeschlagen $wallet_name Wallet. $error';
  }

  @override
  String wallet_list_removing_wallet(Object wallet_name) {
    return 'Wallet $wallet_name entfernen';
  }

  @override
  String wallet_list_failed_to_remove(Object error, Object wallet_name) {
    return 'Fehler beim Entfernen $wallet_name Wallet. $error';
  }

  @override
  String get widgets_address => 'Adresse';

  @override
  String get widgets_restore_from_blockheight => 'Aus Blockhöhe wiederherstellen';

  @override
  String get widgets_restore_from_date => 'Vom Datum wiederherstellen';

  @override
  String get widgets_or => 'oder';

  @override
  String get widgets_seed => 'Seed';

  @override
  String router_no_route(Object name) {
    return 'Keine Route definiert für $name';
  }

  @override
  String get error_text_account_name => 'Der Kontoname darf nur Buchstaben und Zahlen enthalten\nund muss zwischen 1 und 15 Zeichen lang sein';

  @override
  String get error_text_contact_name => 'Im Kontaktname könne die Symbole ` , \' \" nicht enthalten sein\nund muss zwischen 1 und 32 Zeichen lang sein';

  @override
  String get error_text_address => 'Invalid BDX address';

  @override
  String get error_text_node_address => 'Bitte geben Sie eine iPv4-Adresse ein';

  @override
  String get error_text_node_port => 'Der Knotenport kann nur Nummern zwischen 0 und 65535 enthalten';

  @override
  String get error_text_payment_id => 'Die Zahlungs-ID kann nur 16 bis 64 hexadezimale Zeichen enthalten';

  @override
  String get error_text_beldex => 'Der Beldex-Wert kann das verfügbare Guthaben nicht überschreiten.\nDie Anzahl der Nachkommastellen muss kleiner oder gleich 9 sein';

  @override
  String get error_text_fiat => 'Der Wert des Betrags darf den verfügbaren Kontostand nicht überschreiten.\nDie Anzahl der Nachkommastellen muss kleiner oder gleich 2 sein';

  @override
  String get error_text_subaddress_name => 'Im Namen der Unteradresse könne die Symbole ` , \' \" nicht enthalten sein\nund muss zwischen 1 und 20 Zeichen lang sein';

  @override
  String get error_text_amount => 'Betrag kann nur Zahlen enthalten';

  @override
  String get error_text_wallet_name => 'Der Walletname darf nur Buchstaben und Zahlen enthalten\nund muss zwischen 1 und 15 Zeichen lang sein';

  @override
  String get error_text_keys => 'Walletschlüssel können nur 64 hexadezimale Zeichen enthalten';

  @override
  String get error_text_crypto_currency => 'Die Anzahl der Nachkommastellen\nmuss kleiner oder gleich 12 sein.';

  @override
  String get error_text_service_node => 'Master Node Schlüssel können nur 64 hexadezimale Zeichen enthalten';

  @override
  String get auth_store_ban_timeout => 'Auszeit verbieten';

  @override
  String get auth_store_banned_for => 'Gebannt für ';

  @override
  String get auth_store_banned_minutes => ' Protokoll';

  @override
  String get auth_store_incorrect_password => 'Falsches PIN';

  @override
  String get wallet_restoration_store_incorrect_seed_length => 'Falsche Seed-länge';

  @override
  String get full_balance => 'Volles Guthaben';

  @override
  String get available_balance => 'Verfügbares Guthaben';

  @override
  String get hidden_balance => 'Verstecktes Guthaben';

  @override
  String get sync_status_synchronizing => 'SYNCHRONISIERUNG';

  @override
  String get sync_status_synchronized => 'SYNCHRONISIERT';

  @override
  String get sync_status_not_connected => 'NICHT VERBUNDEN';

  @override
  String get sync_status_starting_sync => 'STARTEN DER SYNCHRONISIERUNG';

  @override
  String get sync_status_failed_connect => 'Verbindung zum Knoten fehlgeschlagen';

  @override
  String get sync_status_connecting => 'ANSCHLUSS';

  @override
  String get sync_status_connected => 'IN VERBINDUNG GEBRACHT';

  @override
  String get transaction_priority_slow => 'Langsam';

  @override
  String get transaction_priority_blink => 'Flash';

  @override
  String get change_language => 'Sprache ändern';

  @override
  String change_language_to(Object language) {
    return 'Ändern Sie die Sprache zu $language?';
  }

  @override
  String get paste => 'Einfügen';

  @override
  String get restore_from_seed_placeholder => 'Bitte geben Sie hier Ihren Code ein';

  @override
  String get add_new_word => 'Neues Wort hinzufügen';

  @override
  String get incorrect_seed => 'Der eingegebene Text ist ungültig.';

  @override
  String get biometric_auth_reason => 'Scannen Sie Ihren Fingerabdruck zur Authentifizierung';

  @override
  String version(Object currentVersion) {
    return 'Ausführung $currentVersion';
  }

  @override
  String get openalias_alert_title => 'Beldex-Empfänger erkannt';

  @override
  String openalias_alert_content(Object recipient_name) {
    return 'Sie senden Geld an\n$recipient_name';
  }

  @override
  String get dangerzone => 'Gefahrenzone';

  @override
  String get yes_im_sure => 'Ja, Ich bin mir sicher!';

  @override
  String never_give_your(Object item) {
    return 'Geben sie NIEMALS ihren Beldex wallet $item weiter!';
  }

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'Geben sie NIEMALS ihren Beldex wallet $item in einer andere software oder website außer den OFFIZIELLEN Beldex wallets aus dem $app_store, der Beldex website, der dem Beldex GitHub.\nMöchtest du wirklich fortfahren?';
  }

  @override
  String get keys_title => 'Schlüssel';

  @override
  String get are_you_sure => 'Bist du sicher?';

  @override
  String get do_you_want_to_exit_an_app => 'Möchten Sie eine App beenden?';

  @override
  String get no => 'NEIN';

  @override
  String get yes => 'Ja';

  @override
  String get byUsingThisAppYouAgreeToTheTermsOf => 'Durch die Nutzung dieser App stimmen Sie den unten aufgeführten Vertragsbedingungen zu';

  @override
  String get iAgreeToTermsOfUse => 'Ich stimme den Nutzungsbedingungen zu';

  @override
  String get accept => 'Akzeptieren';

  @override
  String get pleaseEnterAValidAmount => 'Bitte geben Sie einen gültigen Betrag ein';

  @override
  String get pleaseEnterAValidSeed => 'Bitte geben Sie einen gültigen Seed ein';

  @override
  String get changeWallet => 'Geldbörse wechseln';

  @override
  String get removeWallet => 'Wallet entfernen';

  @override
  String get reconnectWallet => 'Wallet erneut verbinden';

  @override
  String get rescanWallet => 'Wallet erneut scannen';

  @override
  String get enterWalletName => 'Geben Sie den Wallet-Namen ein';

  @override
  String get noTransactionsYet => 'Noch keine Transaktionen!';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'Nach Ihrer ersten Transaktion\n Sie können es hier ansehen.';

  @override
  String get copied => 'Kopiert';

  @override
  String get addAddress => 'Adresse hinzufügen';

  @override
  String get important => 'WICHTIG';

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Geben Sie Ihr Beldex-Wallet $item niemals in eine andere Software oder Website ein als die offiziellen Beldex-Wallets, die Sie direkt aus dem $appStore,\n der Beldex-Website oder dem Beldex GitHub heruntergeladen haben.';
  }

  @override
  String get enterWalletName_ => 'Geben Sie den Wallet-Namen ein';

  @override
  String get chooseSeedLanguage => 'Wählen Sie die Seed-Sprache';

  @override
  String get wallet => 'Geldbörse';

  @override
  String get seedKeys => 'Samen & Schlüssel';

  @override
  String get walletAddress => 'Wallet-Adresse';

  @override
  String get recoverySeedkey => 'Wiederherstellungssamen/-schlüssel';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get chooseLanguage => 'Sprache wählen';

  @override
  String get welcomeToBeldexWallet => 'Willkommen bei Beldex Wallet :)';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'Wählen Sie unten eine Option zum Erstellen oder aus\n  Vorhandene Wallet wiederherstellen';

  @override
  String get enterAValidNameUpto15Characters => 'Geben Sie einen gültigen Namen mit bis zu 15 Zeichen ein';

  @override
  String get fiveDecimals => '5 - Five (0.00000)';

  @override
  String get fourDecimals => '4 - Four (0.0000)';

  @override
  String get twoDecimals => '2 - Two (0.00)';

  @override
  String get zeroDecimal => '0 - Zero (000)';

  @override
  String get doYouWantToExitTheWallet => 'Möchten Sie das Wallet verlassen?';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => 'Stellen Sie sicher, dass Sie Ihre Daten wieder aufnehmen\nWiederherstellungs-Seed, Wallet-Adresse\nund private Schlüssel';

  @override
  String blockRemaining(Object status) {
    return '$status Verbleibende Blockierung';
  }

  @override
  String get flashTransaction => 'Flash-Transaktion';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => 'Übertrage deine BDX schneller mit\n Flash-Transaktion!';

  @override
  String get enterYourPin => 'PIN eingeben';

  @override
  String get walletSettings => 'Wallet-Einstellungen';

  @override
  String get recoverySeed => 'Erholungssamen';

  @override
  String get youDontHaveEnoughUnlockedBalance => 'Ihr Guthaben reicht nicht aus';

  @override
  String get alert => 'Alarm';

  @override
  String get touchTheFingerprintSensor => 'Berühren Sie den Fingerabdrucksensor';

  @override
  String get usePattern => 'VERWENDEN SIE MUSTER';

  @override
  String get enterBdxToSend => 'Geben Sie BDX zum Senden ein';

  @override
  String get enterAmount => 'Menge eingeben';

  @override
  String get pleaseEnterAAmount => 'Bitte geben Sie einen Betrag ein';

  @override
  String get committingTheTransaction => 'Festschreiben der Transaktion';

  @override
  String get availableBdx => 'Verfügbares BDX : ';

  @override
  String get pleaseEnterABdxAddress => 'Bitte geben Sie eine BDX-Adresse ein';

  @override
  String get enterAValidAddress => 'Geben Sie eine gültige Adresse ein';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'Die biometrische Funktion ist derzeit deaktiviert. Bitte aktivieren Sie die Funktion „Biometrische Authentifizierung zulassen“ in den App-Einstellungen';

  @override
  String get unlockBeldexWallet => 'Schalten Sie die Beldex-Wallet frei';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => 'Bestätigen Sie Ihre PIN, Ihr Muster und Ihr Passwort für die Bildschirmsperre';

  @override
  String get doYouWantToChangeYournPrimaryAccount => 'Möchten Sie Ihr primäres Konto ändern?';

  @override
  String get rename => 'Umbenennen';

  @override
  String get addAccount => 'Konto hinzufügen';

  @override
  String get noAddressesInBook => 'Keine Adressen im Buch';

  @override
  String get bdx => 'BDX';

  @override
  String get howeverWeRecommendToScanTheBlockchainFromTheBlock => 'Wir empfehlen jedoch, die Blockchain von der Blockhöhe aus zu scannen, auf der Sie das Wallet erstellt haben, um alle Transaktionen und den korrekten Kontostand zu erhalten';

  @override
  String get youHaveScannedFromTheBlockHeight => 'Sie haben von der Blockhöhe aus gescannt';

  @override
  String get syncInfo => 'Informationen synchronisieren';

  @override
  String get doYouWantToReconnectnTheWallet => 'Möchten Sie die Verbindung wiederherstellen?\n Der Geldbeutel?';

  @override
  String get enterValidNameUpto15Characters => 'Geben Sie einen gültigen Namen mit bis zu 15 Zeichen ein';

  @override
  String get checkingNodeConnection => 'Knotenverbindung wird überprüft...';

  @override
  String get enterBdxToReceive => 'Geben Sie BDX zum Empfangen ein';

  @override
  String get addSubAddress => 'Unteradresse hinzufügen';

  @override
  String get shareQr => 'QR teilen';

  @override
  String get name => 'Name';

  @override
  String get enterValidHeightWithoutSpace => 'Geben Sie eine gültige Höhe ohne Leerzeichen ein';

  @override
  String get dateShouldNotBeEmpty => 'Das Datum darf nicht leer sein';

  @override
  String get walletRestore => 'Wallet-Wiederherstellung';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => 'Sie können den Seed nicht anzeigen, da Sie die Wiederherstellung mithilfe von Schlüsseln durchgeführt haben';

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'Geben Sie Ihren Samen niemals an Dritte weiter! Überprüfen Sie Ihre Umgebung, um sicherzustellen, dass niemand etwas übersieht';

  @override
  String get note => 'Notiz :';

  @override
  String get copySeed => 'Samen kopieren';

  @override
  String get accountAlreadyExist => 'Dieser Account existiert bereits';

  @override
  String get transactionInitiatedSuccessfully => 'Transaktion erfolgreich eingeleitet';

  @override
  String get enterAValidSubAddress => 'Geben Sie eine gültige Unteradresse ein';

  @override
  String get subaddressAlreadyExist => 'Unteradresse existiert bereits';

  @override
  String get labelName => 'Markenname';

  @override
  String get subAddress => 'Unteradresse';

  @override
  String get loadingTheWallet => 'Laden der Brieftasche...';

  @override
  String get youAreAboutToDeletenYourWallet => 'Sie sind dabei, zu löschen\n deine Geldbörse!';

  @override
  String get creatingTheTransaction => 'Erstellen der Transaktion';

  @override
  String get copyAndSaveTheSeedToContinue => 'Kopieren und speichern Sie den Seed, um fortzufahren';

  @override
  String get enterPin => 'Pin eingeben';

  @override
  String get test => 'prüfen';

  @override
  String get success => 'Erfolg';

  @override
  String get connectionFailed => 'Verbindung fehlgeschlagen';

  @override
  String get checking => 'Überprüfung...';

  @override
  String get testResult => 'Testergebnis:';

  @override
  String get passwordOptional => 'Passwort (optional)';

  @override
  String get userNameOptional => 'Benutzername (optional)';

  @override
  String get nodeNameOptional => 'Knotenname (optional)';

  @override
  String get addNode => 'Knoten hinzufügen';

  @override
  String get legalDisclaimer => 'Haftungsausschluss';

  @override
  String get howCanWenhelpYou => 'Wie können wir\ndir helfen?';

  @override
  String get removeContact => 'Kontakt entfernen';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => 'Möchten Sie den ausgewählten Kontakt wirklich entfernen?';

  @override
  String get theAddressAlreadyExist => 'Die Adresse existiert bereits';

  @override
  String get thisNameAlreadyExist => 'Dieser Name existiert bereits';

  @override
  String get enterAValidName => 'Geben Sie einen gültigen Namen ein';

  @override
  String get nameShouldNotBeEmpty => 'Der Name darf nicht leer sein';

  @override
  String get enterName => 'Name eingeben';

  @override
  String get accountName => 'Kontoname';

  @override
  String get playStore => 'Play Store';

  @override
  String get appstore => 'AppStore';

  @override
  String get allowFaceIdAuthentication => 'Gesichts-ID-Authentifizierung zulassen';

  @override
  String get enterAddress => 'Adresse eingeben';

  @override
  String get pleaseAddAMainnetNode => 'Bitte fügen Sie einen Mainnet-Knoten hinzu';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return 'Flash-Transaktionen sind Soforttransaktionen.\nDie Priorität $transactionPriority ist als Standardgebühr festgelegt.';
  }

  @override
  String get initiatingTransactionTitle => 'Transaktion wird eingeleitet..';

  @override
  String get initiatingTransactionDescription => 'Bitte schließen Sie dieses Fenster nicht und navigieren Sie nicht zu einer anderen App, bis die Transaktion eingeleitet wird';

  @override
  String get subAddresses => 'Unteradressen';

  @override
  String get loadingTheWalletDescription => 'Bitte schließen Sie dieses Fenster nicht und navigieren Sie nicht zu einer anderen App, bis wir die Wallet geladen haben';

  @override
  String get buyBns => 'Kaufen Sie BNS';

  @override
  String get bns => 'BNS';

  @override
  String get bnsUpdate => 'BNS-Update';

  @override
  String get bnsRenewal => 'BNS-Erneuerung';

  @override
  String get swap => 'Tauschen';

  @override
  String get nodeAlreadyExists => 'Dieser Knoten existiert bereits';

  @override
  String get networkErrorCheckConnection => 'Netzwerkfehler! Bitte überprüfen Sie Ihre Internetverbindung.';

  @override
  String get max => 'Max';
}
