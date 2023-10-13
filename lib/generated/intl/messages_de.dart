// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static m0(status) => "${status} verbleibende Blöcke";

  static m1(status) => "${status} Verbleibende Blockierung";

  static m2(masterNodeKey) => "Möchtest du wirkklich dein Stake von ${masterNodeKey} entsperren?";

  static m3(node) => "Möchten Sie den aktuellen Knoten wirklich auf ändern? ${node}?";

  static m4(language) => "Ändern Sie die Sprache zu ${language}?";

  static m5(amount, fee) => "Transaktion festschreiben\nMenge: ${amount}\nGebühr: ${fee}";

  static m6(key) => "Kopiert ${key} in die Zwischenablage";

  static m7(item, app_store) => "Geben sie NIEMALS ihren Beldex wallet ${item} in einer andere software oder website außer den OFFIZIELLEN Beldex wallets aus dem ${app_store}, der Beldex website, der dem Beldex GitHub.\nMöchtest du wirklich fortfahren?";

  static m8(state_error) => "Authentifizierung fehlgeschlagen. ${state_error}";

  static m9(transactionPriority) => "Flash-Transaktionen sind Soforttransaktionen.\nDie Priorität ${transactionPriority} ist als Standardgebühr festgelegt.";

  static m10(item, appStore) => "Geben Sie Ihr Beldex-Wallet ${item} niemals in eine andere Software oder Website ein als die offiziellen Beldex-Wallets, die Sie direkt aus dem ${appStore},\\n der Beldex-Website oder dem Beldex GitHub heruntergeladen haben.";

  static m11(item) => "Geben sie NIEMALS ihren Beldex wallet ${item} weiter!";

  static m12(recipient_name) => "Sie senden Geld an\n${recipient_name}";

  static m13(name) => "Keine Route definiert für ${name}";

  static m14(transactionPriority) => "${transactionPriority} Priorität ist als Standardgebühr festgelegt.\nGehen Sie zu Einstellung, um die Transaktionspriorität zu ändern.";

  static m15(title) => "${title} in die Zwischenablage kopiert";

  static m16(currentVersion) => "Ausführung ${currentVersion}";

  static m17(wallet_name, error) => "Laden fehlgeschlagen ${wallet_name} Wallet. ${error}";

  static m18(wallet_name, error) => "Fehler beim Entfernen ${wallet_name} Wallet. ${error}";

  static m19(wallet_name) => "Wallet ${wallet_name} wird geladen";

  static m20(wallet_name) => "Wallet ${wallet_name} entfernen";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "Blocks_remaining" : m0,
    "accept" : MessageLookupByLibrary.simpleMessage("Akzeptieren"),
    "account" : MessageLookupByLibrary.simpleMessage("Konto"),
    "accountAlreadyExist" : MessageLookupByLibrary.simpleMessage("Dieser Account existiert bereits"),
    "accountName" : MessageLookupByLibrary.simpleMessage("Kontoname"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Konten"),
    "add" : MessageLookupByLibrary.simpleMessage("Hinzufügen"),
    "addAccount" : MessageLookupByLibrary.simpleMessage("Konto hinzufügen"),
    "addAddress" : MessageLookupByLibrary.simpleMessage("Adresse hinzufügen"),
    "addNode" : MessageLookupByLibrary.simpleMessage("Knoten hinzufügen"),
    "addSubAddress" : MessageLookupByLibrary.simpleMessage("Unteradresse hinzufügen"),
    "add_new_word" : MessageLookupByLibrary.simpleMessage("Neues Wort hinzufügen"),
    "address_book" : MessageLookupByLibrary.simpleMessage("Adressbuch"),
    "afterYourFirstTransactionnYouWillBeAbleToView" : MessageLookupByLibrary.simpleMessage("Nach Ihrer ersten Transaktion\n Sie können es hier ansehen."),
    "alert" : MessageLookupByLibrary.simpleMessage("Alarm"),
    "all" : MessageLookupByLibrary.simpleMessage("ALLE"),
    "allowFaceIdAuthentication" : MessageLookupByLibrary.simpleMessage("Gesichts-ID-Authentifizierung zulassen"),
    "amount" : MessageLookupByLibrary.simpleMessage("Menge "),
    "amount_detail_detailed" : MessageLookupByLibrary.simpleMessage("4 - Detailliert"),
    "amount_detail_none" : MessageLookupByLibrary.simpleMessage("0 - Keine"),
    "amount_detail_normal" : MessageLookupByLibrary.simpleMessage("2 - Normal"),
    "amount_detail_ultra" : MessageLookupByLibrary.simpleMessage("9 - Ultra"),
    "appstore" : MessageLookupByLibrary.simpleMessage("AppStore"),
    "areYouSureYouWantToRemoveSelectedContact" : MessageLookupByLibrary.simpleMessage("Möchten Sie den ausgewählten Kontakt wirklich entfernen?"),
    "are_you_sure" : MessageLookupByLibrary.simpleMessage("Bist du sicher?"),
    "auth_store_ban_timeout" : MessageLookupByLibrary.simpleMessage("Auszeit verbieten"),
    "auth_store_banned_for" : MessageLookupByLibrary.simpleMessage("Gebannt für "),
    "auth_store_banned_minutes" : MessageLookupByLibrary.simpleMessage(" Protokoll"),
    "auth_store_incorrect_password" : MessageLookupByLibrary.simpleMessage("Falsches PIN"),
    "authenticated" : MessageLookupByLibrary.simpleMessage("Authentifiziert"),
    "authentication" : MessageLookupByLibrary.simpleMessage("Authentifizierung"),
    "availableBdx" : MessageLookupByLibrary.simpleMessage("Verfügbares BDX : "),
    "available_balance" : MessageLookupByLibrary.simpleMessage("Verfügbares Guthaben"),
    "bdx" : MessageLookupByLibrary.simpleMessage("BDX"),
    "beldex_available_balance" : MessageLookupByLibrary.simpleMessage("Beldex verfügbares Guthaben"),
    "beldex_full_balance" : MessageLookupByLibrary.simpleMessage("Beldex volles Guthaben"),
    "beldex_hidden" : MessageLookupByLibrary.simpleMessage("Beldex versteckt"),
    "biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside" : MessageLookupByLibrary.simpleMessage("Die biometrische Funktion ist derzeit deaktiviert. Bitte aktivieren Sie die Funktion „Biometrische Authentifizierung zulassen“ in den App-Einstellungen"),
    "biometric_auth_reason" : MessageLookupByLibrary.simpleMessage("Scannen Sie Ihren Fingerabdruck zur Authentifizierung"),
    "blockRemaining" : m1,
    "body_confirm_unlock_stake" : m2,
    "byUsingThisAppYouAgreeToTheTermsOf" : MessageLookupByLibrary.simpleMessage("Durch die Nutzung dieser App stimmen Sie den unten aufgeführten Vertragsbedingungen zu"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "change" : MessageLookupByLibrary.simpleMessage("Veränderung"),
    "changeWallet" : MessageLookupByLibrary.simpleMessage("Geldbörse wechseln"),
    "change_current_node" : m3,
    "change_language" : MessageLookupByLibrary.simpleMessage("Sprache ändern"),
    "change_language_to" : m4,
    "changelog" : MessageLookupByLibrary.simpleMessage("Änderungsprotokoll"),
    "checking" : MessageLookupByLibrary.simpleMessage("Überprüfung..."),
    "checkingNodeConnection" : MessageLookupByLibrary.simpleMessage("Knotenverbindung wird überprüft..."),
    "chooseLanguage" : MessageLookupByLibrary.simpleMessage("Sprache wählen"),
    "chooseSeedLanguage" : MessageLookupByLibrary.simpleMessage("Wählen Sie die Seed-Sprache"),
    "clear" : MessageLookupByLibrary.simpleMessage("Löschen"),
    "commit_transaction_amount_fee" : m5,
    "committingTheTransaction" : MessageLookupByLibrary.simpleMessage("Festschreiben der Transaktion"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Bestätigen"),
    "confirmYourScreenLockPinpatternAndPassword" : MessageLookupByLibrary.simpleMessage("Bestätigen Sie Ihre PIN, Ihr Muster und Ihr Passwort für die Bildschirmsperre"),
    "confirm_sending" : MessageLookupByLibrary.simpleMessage("Bestätigen Sie das Senden"),
    "connectionFailed" : MessageLookupByLibrary.simpleMessage("Verbindung fehlgeschlagen"),
    "contact" : MessageLookupByLibrary.simpleMessage("Kontakt"),
    "contact_name" : MessageLookupByLibrary.simpleMessage("Name des Ansprechpartners"),
    "continue_text" : MessageLookupByLibrary.simpleMessage("Fortsetzen"),
    "copied" : MessageLookupByLibrary.simpleMessage("Kopiert"),
    "copied_key_to_clipboard" : m6,
    "copied_to_clipboard" : MessageLookupByLibrary.simpleMessage("In die Zwischenablage kopiert"),
    "copy" : MessageLookupByLibrary.simpleMessage("Kopieren"),
    "copyAndSaveTheSeedToContinue" : MessageLookupByLibrary.simpleMessage("Kopieren und speichern Sie den Seed, um fortzufahren"),
    "copySeed" : MessageLookupByLibrary.simpleMessage("Samen kopieren"),
    "create_new" : MessageLookupByLibrary.simpleMessage("Neu erstellen"),
    "creatingTheTransaction" : MessageLookupByLibrary.simpleMessage("Erstellen der Transaktion"),
    "dangerzone" : MessageLookupByLibrary.simpleMessage("Gefahrenzone"),
    "dangerzone_warning" : m7,
    "dateShouldNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Das Datum darf nicht leer sein"),
    "delete" : MessageLookupByLibrary.simpleMessage("Löschen"),
    "digit_pin" : MessageLookupByLibrary.simpleMessage("-stelliger PIN"),
    "doYouWantToChangeYournPrimaryAccount" : MessageLookupByLibrary.simpleMessage("Möchten Sie Ihr primäres Konto ändern?"),
    "doYouWantToExitTheWallet" : MessageLookupByLibrary.simpleMessage("Möchten Sie das Wallet verlassen?"),
    "doYouWantToReconnectnTheWallet" : MessageLookupByLibrary.simpleMessage("Möchten Sie die Verbindung wiederherstellen?\n Der Geldbeutel?"),
    "do_you_want_to_exit_an_app" : MessageLookupByLibrary.simpleMessage("Möchten Sie eine App beenden?"),
    "edit" : MessageLookupByLibrary.simpleMessage("Bearbeiten"),
    "enterAValidAddress" : MessageLookupByLibrary.simpleMessage("Geben Sie eine gültige Adresse ein"),
    "enterAValidName" : MessageLookupByLibrary.simpleMessage("Geben Sie einen gültigen Namen ein"),
    "enterAValidNameUpto15Characters" : MessageLookupByLibrary.simpleMessage("Geben Sie einen gültigen Namen mit bis zu 15 Zeichen ein"),
    "enterAValidSubAddress" : MessageLookupByLibrary.simpleMessage("Geben Sie eine gültige Unteradresse ein"),
    "enterAddress" : MessageLookupByLibrary.simpleMessage("Adresse eingeben"),
    "enterAmount" : MessageLookupByLibrary.simpleMessage("Menge eingeben"),
    "enterBdxToReceive" : MessageLookupByLibrary.simpleMessage("Geben Sie BDX zum Empfangen ein"),
    "enterBdxToSend" : MessageLookupByLibrary.simpleMessage("Geben Sie BDX zum Senden ein"),
    "enterName" : MessageLookupByLibrary.simpleMessage("Name eingeben"),
    "enterPin" : MessageLookupByLibrary.simpleMessage("Pin eingeben"),
    "enterValidHeightWithoutSpace" : MessageLookupByLibrary.simpleMessage("Geben Sie eine gültige Höhe ohne Leerzeichen ein"),
    "enterValidNameUpto15Characters" : MessageLookupByLibrary.simpleMessage("Geben Sie einen gültigen Namen mit bis zu 15 Zeichen ein"),
    "enterWalletName" : MessageLookupByLibrary.simpleMessage("Geben Sie den Wallet-Namen ein"),
    "enterWalletName_" : MessageLookupByLibrary.simpleMessage("Geben Sie den Wallet-Namen ein"),
    "enterYourPin" : MessageLookupByLibrary.simpleMessage("PIN eingeben"),
    "error" : MessageLookupByLibrary.simpleMessage("Error"),
    "error_text_account_name" : MessageLookupByLibrary.simpleMessage("Der Kontoname darf nur Buchstaben und Zahlen enthalten\nund muss zwischen 1 und 15 Zeichen lang sein"),
    "error_text_address" : MessageLookupByLibrary.simpleMessage("Invalid BDX address"),
    "error_text_amount" : MessageLookupByLibrary.simpleMessage("Betrag kann nur Zahlen enthalten"),
    "error_text_beldex" : MessageLookupByLibrary.simpleMessage("Der Beldex-Wert kann das verfügbare Guthaben nicht überschreiten.\nDie Anzahl der Nachkommastellen muss kleiner oder gleich 9 sein"),
    "error_text_contact_name" : MessageLookupByLibrary.simpleMessage("Im Kontaktname könne die Symbole ` , \' \" nicht enthalten sein\nund muss zwischen 1 und 32 Zeichen lang sein"),
    "error_text_crypto_currency" : MessageLookupByLibrary.simpleMessage("Die Anzahl der Nachkommastellen\nmuss kleiner oder gleich 12 sein."),
    "error_text_fiat" : MessageLookupByLibrary.simpleMessage("Der Wert des Betrags darf den verfügbaren Kontostand nicht überschreiten.\nDie Anzahl der Nachkommastellen muss kleiner oder gleich 2 sein"),
    "error_text_keys" : MessageLookupByLibrary.simpleMessage("Walletschlüssel können nur 64 hexadezimale Zeichen enthalten"),
    "error_text_node_address" : MessageLookupByLibrary.simpleMessage("Bitte geben Sie eine iPv4-Adresse ein"),
    "error_text_node_port" : MessageLookupByLibrary.simpleMessage("Der Knotenport kann nur Nummern zwischen 0 und 65535 enthalten"),
    "error_text_payment_id" : MessageLookupByLibrary.simpleMessage("Die Zahlungs-ID kann nur 16 bis 64 hexadezimale Zeichen enthalten"),
    "error_text_service_node" : MessageLookupByLibrary.simpleMessage("Master Node Schlüssel können nur 64 hexadezimale Zeichen enthalten"),
    "error_text_subaddress_name" : MessageLookupByLibrary.simpleMessage("Im Namen der Unteradresse könne die Symbole ` , \' \" nicht enthalten sein\nund muss zwischen 1 und 20 Zeichen lang sein"),
    "error_text_wallet_name" : MessageLookupByLibrary.simpleMessage("Der Walletname darf nur Buchstaben und Zahlen enthalten\nund muss zwischen 1 und 15 Zeichen lang sein"),
    "failed_authentication" : m8,
    "faq" : MessageLookupByLibrary.simpleMessage("FAQ"),
    "fetching" : MessageLookupByLibrary.simpleMessage("aktualisieren"),
    "filters" : MessageLookupByLibrary.simpleMessage("Filter"),
    "first_wallet_text" : MessageLookupByLibrary.simpleMessage("Das tolle Wallet\nfür Beldex"),
    "fiveDecimals" : MessageLookupByLibrary.simpleMessage("5 - Five (0.00000)"),
    "flashTransaction" : MessageLookupByLibrary.simpleMessage("Flash-Transaktion"),
    "flashTransactionPriority" : m9,
    "fourDecimals" : MessageLookupByLibrary.simpleMessage("4 - Four (0.0000)"),
    "full_balance" : MessageLookupByLibrary.simpleMessage("Volles Guthaben"),
    "hidden_balance" : MessageLookupByLibrary.simpleMessage("Verstecktes Guthaben"),
    "howCanWenhelpYou" : MessageLookupByLibrary.simpleMessage("Wie können wir\ndir helfen?"),
    "howeverWeRecommendToScanTheBlockchainFromTheBlock" : MessageLookupByLibrary.simpleMessage("Wir empfehlen jedoch, die Blockchain von der Blockhöhe aus zu scannen, auf der Sie das Wallet erstellt haben, um alle Transaktionen und den korrekten Kontostand zu erhalten"),
    "iAgreeToTermsOfUse" : MessageLookupByLibrary.simpleMessage("Ich stimme den Nutzungsbedingungen zu"),
    "id" : MessageLookupByLibrary.simpleMessage("ID: "),
    "important" : MessageLookupByLibrary.simpleMessage("WICHTIG"),
    "incoming" : MessageLookupByLibrary.simpleMessage("Eingehend"),
    "incorrect_seed" : MessageLookupByLibrary.simpleMessage("Der eingegebene Text ist ungültig."),
    "initiatingTransactionDescription" : MessageLookupByLibrary.simpleMessage("Bitte schließen Sie dieses Fenster nicht und navigieren Sie nicht zu einer anderen App, bis die Transaktion eingeleitet wird"),
    "initiatingTransactionTitle" : MessageLookupByLibrary.simpleMessage("Transaktion wird eingeleitet.."),
    "keys_title" : MessageLookupByLibrary.simpleMessage("Schlüssel"),
    "labelName" : MessageLookupByLibrary.simpleMessage("Markenname"),
    "legalDisclaimer" : MessageLookupByLibrary.simpleMessage("Haftungsausschluss"),
    "loadingTheWallet" : MessageLookupByLibrary.simpleMessage("Laden der Brieftasche..."),
    "loading_your_wallet" : MessageLookupByLibrary.simpleMessage("Wallet wird geladen"),
    "login" : MessageLookupByLibrary.simpleMessage("Einloggen"),
    "makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate" : MessageLookupByLibrary.simpleMessage("Stellen Sie sicher, dass Sie eine Sicherungskopie Ihrer Daten erstellen\nWiederherstellungs-Seed, Wallet-Adresse\nUnd private Schlüssel"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "nameShouldNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Der Name darf nicht leer sein"),
    "neverInputYourBeldexWalletItemIntoAnySoftwareOr" : m10,
    "neverShareYourSeedToAnyoneCheckYourSurroundingsTo" : MessageLookupByLibrary.simpleMessage("Geben Sie Ihren Samen niemals an Dritte weiter! Überprüfen Sie Ihre Umgebung, um sicherzustellen, dass niemand etwas übersieht"),
    "never_give_your" : m11,
    "new_subaddress_create" : MessageLookupByLibrary.simpleMessage("Erstellen"),
    "new_subaddress_label_name" : MessageLookupByLibrary.simpleMessage("Name"),
    "new_subaddress_title" : MessageLookupByLibrary.simpleMessage("Neue Unteradresse"),
    "new_wallet" : MessageLookupByLibrary.simpleMessage("Neues wallet"),
    "no" : MessageLookupByLibrary.simpleMessage("NEIN"),
    "noAddressesInBook" : MessageLookupByLibrary.simpleMessage("Keine Adressen im Buch"),
    "noTransactionsYet" : MessageLookupByLibrary.simpleMessage("Noch keine Transaktionen!"),
    "nodeNameOptional" : MessageLookupByLibrary.simpleMessage("Knotenname (optional)"),
    "node_address" : MessageLookupByLibrary.simpleMessage("Knotenadresse"),
    "node_new" : MessageLookupByLibrary.simpleMessage("Neuer Knoten"),
    "node_port" : MessageLookupByLibrary.simpleMessage("Knotenport"),
    "node_reset_settings_title" : MessageLookupByLibrary.simpleMessage("Einstellungen zurücksetzen"),
    "nodes" : MessageLookupByLibrary.simpleMessage("Knoten"),
    "nodes_list_reset_to_default_message" : MessageLookupByLibrary.simpleMessage("Möchten Sie die Einstellungen wirklich auf die Standardeinstellungen zurücksetzen?"),
    "note" : MessageLookupByLibrary.simpleMessage("Notiz :"),
    "nothing_staked" : MessageLookupByLibrary.simpleMessage("Noch nichts gestaked"),
    "ok" : MessageLookupByLibrary.simpleMessage("Ok"),
    "openalias_alert_content" : m12,
    "openalias_alert_title" : MessageLookupByLibrary.simpleMessage("Beldex-Empfänger erkannt"),
    "outgoing" : MessageLookupByLibrary.simpleMessage("Ausgehend"),
    "password" : MessageLookupByLibrary.simpleMessage("Passwort"),
    "passwordOptional" : MessageLookupByLibrary.simpleMessage("Passwort (optional)"),
    "paste" : MessageLookupByLibrary.simpleMessage("Einfügen"),
    "pending" : MessageLookupByLibrary.simpleMessage(" (steht aus)"),
    "pin_is_incorrect" : MessageLookupByLibrary.simpleMessage("PIN ist falsch"),
    "playStore" : MessageLookupByLibrary.simpleMessage("Play Store"),
    "pleaseAddAMainnetNode" : MessageLookupByLibrary.simpleMessage("Bitte fügen Sie einen Mainnet-Knoten hinzu"),
    "pleaseEnterAAmount" : MessageLookupByLibrary.simpleMessage("Bitte geben Sie einen Betrag ein"),
    "pleaseEnterABdxAddress" : MessageLookupByLibrary.simpleMessage("Bitte geben Sie eine BDX-Adresse ein"),
    "pleaseEnterAValidAmount" : MessageLookupByLibrary.simpleMessage("Bitte geben Sie einen gültigen Betrag ein"),
    "pleaseEnterAValidSeed" : MessageLookupByLibrary.simpleMessage("Bitte geben Sie einen gültigen Seed ein"),
    "please_make_selection" : MessageLookupByLibrary.simpleMessage("Bitte treffen Sie unten eine Auswahl zu\nErstellen oder Wiederherstellen Ihres Wallets."),
    "please_select" : MessageLookupByLibrary.simpleMessage("Bitte auswählen:"),
    "please_try_to_connect_to_another_node" : MessageLookupByLibrary.simpleMessage("Bitte versuchen Sie, eine Verbindung zu einem anderen Knoten herzustellen"),
    "re_enter_your_pin" : MessageLookupByLibrary.simpleMessage("Geben Sie Ihre PIN erneut ein"),
    "receive" : MessageLookupByLibrary.simpleMessage("Erhalten"),
    "receive_amount" : MessageLookupByLibrary.simpleMessage("Menge"),
    "received" : MessageLookupByLibrary.simpleMessage("Empfangen"),
    "reconnect" : MessageLookupByLibrary.simpleMessage("Erneut verbinden"),
    "reconnectWallet" : MessageLookupByLibrary.simpleMessage("Wallet erneut verbinden"),
    "reconnect_alert_text" : MessageLookupByLibrary.simpleMessage("Sind Sie sicher, dass Sie die Verbindung wiederherstellen möchten?"),
    "reconnection" : MessageLookupByLibrary.simpleMessage("Wiederverbindung"),
    "recoverySeed" : MessageLookupByLibrary.simpleMessage("Erholungssamen"),
    "recoverySeedkey" : MessageLookupByLibrary.simpleMessage("Wiederherstellungssamen/-schlüssel"),
    "reload_fiat" : MessageLookupByLibrary.simpleMessage("Fiat-Kurs neuladen"),
    "remove" : MessageLookupByLibrary.simpleMessage("Löschen"),
    "removeContact" : MessageLookupByLibrary.simpleMessage("Kontakt entfernen"),
    "removeWallet" : MessageLookupByLibrary.simpleMessage("Wallet entfernen"),
    "remove_node" : MessageLookupByLibrary.simpleMessage("Knoten entfernen"),
    "remove_node_message" : MessageLookupByLibrary.simpleMessage("Möchten Sie den ausgewählten Knoten wirklich entfernen?"),
    "rename" : MessageLookupByLibrary.simpleMessage("Umbenennen"),
    "rescan" : MessageLookupByLibrary.simpleMessage("Erneut scannen"),
    "rescanWallet" : MessageLookupByLibrary.simpleMessage("Wallet erneut scannen"),
    "reset" : MessageLookupByLibrary.simpleMessage("Zurücksetzen"),
    "restore_address" : MessageLookupByLibrary.simpleMessage("Adresse"),
    "restore_description_from_backup" : MessageLookupByLibrary.simpleMessage("Sie können die gesamte Beldex Wallet-App aus ihrer Sicherungsdatei wiederherstellen."),
    "restore_description_from_keys" : MessageLookupByLibrary.simpleMessage("Verwenden Sie die generierten Tastenanschläge, die von privaten Schlüsseln gespeichert wurden, um Ihre Brieftasche wiederherzustellen"),
    "restore_description_from_seed" : MessageLookupByLibrary.simpleMessage("Verwenden Sie den 25-Wörter-Mnemonikschlüssel oder die Seed-Phrase, um Ihre Brieftasche wiederherzustellen."),
    "restore_description_from_seed_keys" : MessageLookupByLibrary.simpleMessage("Stellen sie Ihr Wallet mit Seed / Schlüsseln, welche Sie an einem sicheren Ort aufbewahrt haben, wieder her"),
    "restore_from_seed_placeholder" : MessageLookupByLibrary.simpleMessage("Bitte geben Sie hier Ihren Code ein"),
    "restore_next" : MessageLookupByLibrary.simpleMessage("Weiter"),
    "restore_recover" : MessageLookupByLibrary.simpleMessage("Wiederherstellen"),
    "restore_restore_wallet" : MessageLookupByLibrary.simpleMessage("Wallet wiederherstellen"),
    "restore_seed_keys_restore" : MessageLookupByLibrary.simpleMessage("Seed / Schlüssel wiederherstellen"),
    "restore_spend_key_private" : MessageLookupByLibrary.simpleMessage("Ausgabe-Schlüssel (geheim)"),
    "restore_title_from_backup" : MessageLookupByLibrary.simpleMessage("Aus einer Sicherungsdatei wiederherstellen"),
    "restore_title_from_keys" : MessageLookupByLibrary.simpleMessage("Wiederherstellen von Schlüsseln"),
    "restore_title_from_seed" : MessageLookupByLibrary.simpleMessage("Aus Seed wiederherstellen"),
    "restore_title_from_seed_keys" : MessageLookupByLibrary.simpleMessage("Vom Seed / Schlüssel wiederherstellen"),
    "restore_view_key_private" : MessageLookupByLibrary.simpleMessage("Anzeige-Schlüssel (geheim)"),
    "restore_wallet" : MessageLookupByLibrary.simpleMessage("Wallet wiederherstellen"),
    "restore_wallet_name" : MessageLookupByLibrary.simpleMessage("Walletname"),
    "restore_wallet_restore_description" : MessageLookupByLibrary.simpleMessage("Beschreibung zur Wiederherstellung des Wallets"),
    "router_no_route" : m13,
    "save" : MessageLookupByLibrary.simpleMessage("Speichern"),
    "seedKeys" : MessageLookupByLibrary.simpleMessage("Samen & Schlüssel"),
    "seed_language_chinese" : MessageLookupByLibrary.simpleMessage("Chinesisch"),
    "seed_language_choose" : MessageLookupByLibrary.simpleMessage("Bitte wählen Sie die Ausgangssprache"),
    "seed_language_dutch" : MessageLookupByLibrary.simpleMessage("Niederländisch"),
    "seed_language_english" : MessageLookupByLibrary.simpleMessage("Englisch"),
    "seed_language_french" : MessageLookupByLibrary.simpleMessage("Französisch"),
    "seed_language_german" : MessageLookupByLibrary.simpleMessage("Deutsch"),
    "seed_language_italian" : MessageLookupByLibrary.simpleMessage("Italienisch"),
    "seed_language_japanese" : MessageLookupByLibrary.simpleMessage("Japanisch"),
    "seed_language_next" : MessageLookupByLibrary.simpleMessage("Weiter"),
    "seed_language_portuguese" : MessageLookupByLibrary.simpleMessage("Portugiesisch"),
    "seed_language_russian" : MessageLookupByLibrary.simpleMessage("Russisch"),
    "seed_language_spanish" : MessageLookupByLibrary.simpleMessage("Spanisch"),
    "seed_share" : MessageLookupByLibrary.simpleMessage("Teilen Sie Seed"),
    "seed_title" : MessageLookupByLibrary.simpleMessage("Seed"),
    "selectAnOptionBelowToCreateOrnRecoverExistingWallet" : MessageLookupByLibrary.simpleMessage("Wählen Sie unten eine Option zum Erstellen oder aus\n  Vorhandene Wallet wiederherstellen"),
    "selectLanguage" : MessageLookupByLibrary.simpleMessage("Sprache auswählen"),
    "send" : MessageLookupByLibrary.simpleMessage("Senden"),
    "send_beldex" : MessageLookupByLibrary.simpleMessage("Beldex Senden"),
    "send_beldex_address" : MessageLookupByLibrary.simpleMessage("Beldex-Adresse"),
    "send_creating_transaction" : MessageLookupByLibrary.simpleMessage("Transaktion erstellen"),
    "send_error_currency" : MessageLookupByLibrary.simpleMessage("Die Währung kann nur Zahlen enthalten"),
    "send_estimated_fee" : MessageLookupByLibrary.simpleMessage("Geschätzte Gebühr:"),
    "send_priority" : m14,
    "send_title" : MessageLookupByLibrary.simpleMessage("Senden Sie"),
    "send_your_wallet" : MessageLookupByLibrary.simpleMessage("Dein Wallet"),
    "sending" : MessageLookupByLibrary.simpleMessage("Senden"),
    "sent" : MessageLookupByLibrary.simpleMessage("Geschickt"),
    "service_node_key" : MessageLookupByLibrary.simpleMessage("Master Node Schlüssel"),
    "settings_all" : MessageLookupByLibrary.simpleMessage("ALLE"),
    "settings_allow_biometric_authentication" : MessageLookupByLibrary.simpleMessage("Biometrische Authentifizierung"),
    "settings_balance_detail" : MessageLookupByLibrary.simpleMessage("Dezimalstellen"),
    "settings_change_language" : MessageLookupByLibrary.simpleMessage("Sprache ändern"),
    "settings_change_pin" : MessageLookupByLibrary.simpleMessage("PIN ändern"),
    "settings_currency" : MessageLookupByLibrary.simpleMessage("Währung"),
    "settings_current_node" : MessageLookupByLibrary.simpleMessage("Aktueller Knoten"),
    "settings_dark_mode" : MessageLookupByLibrary.simpleMessage("Dunkler Modus"),
    "settings_display_balance_as" : MessageLookupByLibrary.simpleMessage("Kontostand anzeigen als"),
    "settings_display_on_dashboard_list" : MessageLookupByLibrary.simpleMessage("Anzeige in der Dashboard-Liste"),
    "settings_enable_fiat_currency" : MessageLookupByLibrary.simpleMessage("In Fiat Währung umrechnen"),
    "settings_fee_priority" : MessageLookupByLibrary.simpleMessage("Gebührenpriorität"),
    "settings_nodes" : MessageLookupByLibrary.simpleMessage("Knoten"),
    "settings_none" : MessageLookupByLibrary.simpleMessage("Keiner"),
    "settings_personal" : MessageLookupByLibrary.simpleMessage("Persönlich"),
    "settings_save_recipient_address" : MessageLookupByLibrary.simpleMessage("Empfängeradresse speichern"),
    "settings_support" : MessageLookupByLibrary.simpleMessage("Unterstützung"),
    "settings_terms_and_conditions" : MessageLookupByLibrary.simpleMessage("Geschäftsbedingungen"),
    "settings_title" : MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "settings_transactions" : MessageLookupByLibrary.simpleMessage("Transaktionen"),
    "settings_wallets" : MessageLookupByLibrary.simpleMessage("Wallets"),
    "setup_pin" : MessageLookupByLibrary.simpleMessage("PIN einrichten"),
    "setup_successful" : MessageLookupByLibrary.simpleMessage("Ihre PIN wurde erfolgreich eingerichtet!"),
    "shareQr" : MessageLookupByLibrary.simpleMessage("QR teilen"),
    "share_address" : MessageLookupByLibrary.simpleMessage("Adresse teilen "),
    "show_keys" : MessageLookupByLibrary.simpleMessage("Schlüssel anzeigen"),
    "show_seed" : MessageLookupByLibrary.simpleMessage("Seed zeigen"),
    "spend_key_private" : MessageLookupByLibrary.simpleMessage("Ausgabe-Schlüssel (geheim)"),
    "spend_key_public" : MessageLookupByLibrary.simpleMessage("Ausgabe-Schlüssel (öffentlich)"),
    "stake_beldex" : MessageLookupByLibrary.simpleMessage("Beldex staken"),
    "stake_more" : MessageLookupByLibrary.simpleMessage("Mehr staken"),
    "start_staking" : MessageLookupByLibrary.simpleMessage("Starte zu staken"),
    "status" : MessageLookupByLibrary.simpleMessage("Status: "),
    "subAddress" : MessageLookupByLibrary.simpleMessage("Unteradresse"),
    "subaddressAlreadyExist" : MessageLookupByLibrary.simpleMessage("Unteradresse existiert bereits"),
    "subaddress_title" : MessageLookupByLibrary.simpleMessage("Unteradressenliste"),
    "subaddresses" : MessageLookupByLibrary.simpleMessage("Unteradressen"),
    "success" : MessageLookupByLibrary.simpleMessage("Erfolg"),
    "syncInfo" : MessageLookupByLibrary.simpleMessage("Informationen synchronisieren"),
    "sync_status_connected" : MessageLookupByLibrary.simpleMessage("IN VERBINDUNG GEBRACHT"),
    "sync_status_connecting" : MessageLookupByLibrary.simpleMessage("ANSCHLUSS"),
    "sync_status_failed_connect" : MessageLookupByLibrary.simpleMessage("Verbindung zum Knoten fehlgeschlagen"),
    "sync_status_not_connected" : MessageLookupByLibrary.simpleMessage("NICHT VERBUNDEN"),
    "sync_status_starting_sync" : MessageLookupByLibrary.simpleMessage("STARTEN DER SYNCHRONISIERUNG"),
    "sync_status_synchronized" : MessageLookupByLibrary.simpleMessage("SYNCHRONISIERT"),
    "sync_status_synchronizing" : MessageLookupByLibrary.simpleMessage("SYNCHRONISIERUNG"),
    "test" : MessageLookupByLibrary.simpleMessage("prüfen"),
    "testResult" : MessageLookupByLibrary.simpleMessage("Testergebnis:"),
    "theAddressAlreadyExist" : MessageLookupByLibrary.simpleMessage("Die Adresse existiert bereits"),
    "thisNameAlreadyExist" : MessageLookupByLibrary.simpleMessage("Dieser Name existiert bereits"),
    "title_confirm_unlock_stake" : MessageLookupByLibrary.simpleMessage("Stake entsperren"),
    "title_new_stake" : MessageLookupByLibrary.simpleMessage("Neuer Stake"),
    "title_stakes" : MessageLookupByLibrary.simpleMessage("Stakes"),
    "today" : MessageLookupByLibrary.simpleMessage("Heute"),
    "touchTheFingerprintSensor" : MessageLookupByLibrary.simpleMessage("Berühren Sie den Fingerabdrucksensor"),
    "transactionInitiatedSuccessfully" : MessageLookupByLibrary.simpleMessage("Transaktion erfolgreich eingeleitet"),
    "transaction_details_amount" : MessageLookupByLibrary.simpleMessage("Betrag"),
    "transaction_details_copied" : m15,
    "transaction_details_date" : MessageLookupByLibrary.simpleMessage("Datum"),
    "transaction_details_height" : MessageLookupByLibrary.simpleMessage("Höhe"),
    "transaction_details_recipient_address" : MessageLookupByLibrary.simpleMessage("Empfängeradresse"),
    "transaction_details_title" : MessageLookupByLibrary.simpleMessage("Transaktionsdetails"),
    "transaction_details_transaction_id" : MessageLookupByLibrary.simpleMessage("Transaktions-ID"),
    "transaction_priority_blink" : MessageLookupByLibrary.simpleMessage("Flash"),
    "transaction_priority_slow" : MessageLookupByLibrary.simpleMessage("Langsam"),
    "transaction_sent" : MessageLookupByLibrary.simpleMessage("Transaktion gesendet!"),
    "transactions" : MessageLookupByLibrary.simpleMessage("Transaktionen"),
    "transactions_by_date" : MessageLookupByLibrary.simpleMessage("Transaktionen nach Datum"),
    "transferYourBdxMoreFasternWithFlashTransaction" : MessageLookupByLibrary.simpleMessage("Tanchbir, deine Bits mehr Pastor\n  Mit Flash-Transaktion!"),
    "twoDecimals" : MessageLookupByLibrary.simpleMessage("2 - Two (0.00)"),
    "unable_unlock_stake" : MessageLookupByLibrary.simpleMessage("Stake Entsperrung nicht möglich"),
    "unlockBeldexWallet" : MessageLookupByLibrary.simpleMessage("Schalten Sie die Beldex-Wallet frei"),
    "unlock_stake_requested" : MessageLookupByLibrary.simpleMessage("Stake Entsperrung angefragt"),
    "use" : MessageLookupByLibrary.simpleMessage("Wechseln zu "),
    "usePattern" : MessageLookupByLibrary.simpleMessage("VERWENDEN SIE MUSTER"),
    "userNameOptional" : MessageLookupByLibrary.simpleMessage("Benutzername (optional)"),
    "version" : m16,
    "view_key_private" : MessageLookupByLibrary.simpleMessage("Anzeige-Schlüssel (geheim)"),
    "view_key_public" : MessageLookupByLibrary.simpleMessage("Anzeige-Schlüssel (öffentlich)"),
    "wallet" : MessageLookupByLibrary.simpleMessage("Geldbörse"),
    "walletAddress" : MessageLookupByLibrary.simpleMessage("Wallet-Adresse"),
    "walletRestore" : MessageLookupByLibrary.simpleMessage("Wallet-Wiederherstellung"),
    "walletSettings" : MessageLookupByLibrary.simpleMessage("Wallet-Einstellungen"),
    "wallet_keys" : MessageLookupByLibrary.simpleMessage("Wallet Schlüssel"),
    "wallet_list_create_new_wallet" : MessageLookupByLibrary.simpleMessage("Neues wallet erstellen"),
    "wallet_list_failed_to_load" : m17,
    "wallet_list_failed_to_remove" : m18,
    "wallet_list_load_wallet" : MessageLookupByLibrary.simpleMessage("Wallet laden"),
    "wallet_list_loading_wallet" : m19,
    "wallet_list_removing_wallet" : m20,
    "wallet_list_restore_wallet" : MessageLookupByLibrary.simpleMessage("Wallet wiederherstellen"),
    "wallet_list_title" : MessageLookupByLibrary.simpleMessage("Beldex Wallet"),
    "wallet_menu" : MessageLookupByLibrary.simpleMessage("Wallet-Menü"),
    "wallet_name" : MessageLookupByLibrary.simpleMessage("Walletname"),
    "wallet_restoration_store_incorrect_seed_length" : MessageLookupByLibrary.simpleMessage("Falsche Seed-länge"),
    "wallets" : MessageLookupByLibrary.simpleMessage("Wallets"),
    "welcome" : MessageLookupByLibrary.simpleMessage("Willkommen\nim Beldex WALLET"),
    "welcomeToBeldexWallet" : MessageLookupByLibrary.simpleMessage("Willkommen bei Beldex Wallet :)"),
    "widgets_address" : MessageLookupByLibrary.simpleMessage("Adresse"),
    "widgets_or" : MessageLookupByLibrary.simpleMessage("oder"),
    "widgets_restore_from_blockheight" : MessageLookupByLibrary.simpleMessage("Aus Blockhöhe wiederherstellen"),
    "widgets_restore_from_date" : MessageLookupByLibrary.simpleMessage("Vom Datum wiederherstellen"),
    "widgets_seed" : MessageLookupByLibrary.simpleMessage("Seed"),
    "yes" : MessageLookupByLibrary.simpleMessage("Ja"),
    "yes_im_sure" : MessageLookupByLibrary.simpleMessage("Ja, Ich bin mir sicher!"),
    "yesterday" : MessageLookupByLibrary.simpleMessage("Gestern"),
    "youAreAboutToDeletenYourWallet" : MessageLookupByLibrary.simpleMessage("Sie sind dabei, zu löschen\n deine Geldbörse!"),
    "youCantViewTheSeedBecauseYouveRestoredUsingKeys" : MessageLookupByLibrary.simpleMessage("Sie können den Seed nicht anzeigen, da Sie die Wiederherstellung mithilfe von Schlüsseln durchgeführt haben"),
    "youDontHaveEnoughUnlockedBalance" : MessageLookupByLibrary.simpleMessage("Ihr Guthaben reicht nicht aus"),
    "youHaveScannedFromTheBlockHeight" : MessageLookupByLibrary.simpleMessage("Sie haben von der Blockhöhe aus gescannt"),
    "your_contributions" : MessageLookupByLibrary.simpleMessage("Deine Anteile"),
    "zeroDecimal" : MessageLookupByLibrary.simpleMessage("0 - Zero (000)")
  };
}
