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

  static m1(masterNodeKey) => "Möchtest du wirkklich dein Stake von ${masterNodeKey} entsperren?";

  static m2(node) => "Möchten Sie den aktuellen Knoten wirklich auf ändern? ${node}?";

  static m3(language) => "Ändern Sie die Sprache zu ${language}?";

  static m4(amount, fee) => "Transaktion festschreiben\nMenge: ${amount}\nGebühr: ${fee}";

  static m5(key) => "Kopiert ${key} in die Zwischenablage";

  static m6(item, app_store) => "Geben sie NIEMALS ihren Beldex wallet ${item} in einer andere software oder website außer den OFFIZIELLEN Beldex wallets aus dem ${app_store}, der Beldex website, der dem Beldex GitHub.\nMöchtest du wirklich fortfahren?";

  static m7(state_error) => "Authentifizierung fehlgeschlagen. ${state_error}";

  static m8(item) => "Geben sie NIEMALS ihren Beldex wallet ${item} weiter!";

  static m9(recipient_name) => "Sie senden Geld an\n${recipient_name}";

  static m10(name) => "Keine Route definiert für ${name}";

  static m11(transactionPriority) => "${transactionPriority} Priorität ist als Standardgebühr festgelegt.\nGehen Sie zu Einstellung, um die Transaktionspriorität zu ändern.";

  static m12(title) => "${title} in die Zwischenablage kopiert";

  static m13(currentVersion) => "Ausführung ${currentVersion}";

  static m14(wallet_name, error) => "Laden fehlgeschlagen ${wallet_name} Wallet. ${error}";

  static m15(wallet_name, error) => "Fehler beim Entfernen ${wallet_name} Wallet. ${error}";

  static m16(wallet_name) => "Wallet ${wallet_name} wird geladen";

  static m17(wallet_name) => "Wallet ${wallet_name} entfernen";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "Blocks_remaining" : m0,
    "accept" : MessageLookupByLibrary.simpleMessage("Annehmen"),
    "account" : MessageLookupByLibrary.simpleMessage("Konto"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Konten"),
    "add" : MessageLookupByLibrary.simpleMessage("Hinzufügen"),
    "add_new_word" : MessageLookupByLibrary.simpleMessage("Neues Wort hinzufügen"),
    "address_book" : MessageLookupByLibrary.simpleMessage("Adressbuch"),
    "address_book_menu" : MessageLookupByLibrary.simpleMessage("Adressbuch"),
    "all" : MessageLookupByLibrary.simpleMessage("ALLE"),
    "amount" : MessageLookupByLibrary.simpleMessage("Menge "),
    "amount_detail_detailed" : MessageLookupByLibrary.simpleMessage("4 - Detailliert"),
    "amount_detail_none" : MessageLookupByLibrary.simpleMessage("0 - Keine"),
    "amount_detail_normal" : MessageLookupByLibrary.simpleMessage("2 - Normal"),
    "amount_detail_ultra" : MessageLookupByLibrary.simpleMessage("9 - Ultra"),
    "are_you_sure" : MessageLookupByLibrary.simpleMessage("Are you sure?"),
    "auth_store_ban_timeout" : MessageLookupByLibrary.simpleMessage("Auszeit verbieten"),
    "auth_store_banned_for" : MessageLookupByLibrary.simpleMessage("Gebannt für "),
    "auth_store_banned_minutes" : MessageLookupByLibrary.simpleMessage(" Protokoll"),
    "auth_store_incorrect_password" : MessageLookupByLibrary.simpleMessage("Falsches PIN"),
    "authenticated" : MessageLookupByLibrary.simpleMessage("Authentifiziert"),
    "authentication" : MessageLookupByLibrary.simpleMessage("Authentifizierung"),
    "available_balance" : MessageLookupByLibrary.simpleMessage("Verfügbares Guthaben"),
    "beldex_available_balance" : MessageLookupByLibrary.simpleMessage("Beldex verfügbares Guthaben"),
    "beldex_full_balance" : MessageLookupByLibrary.simpleMessage("Beldex volles Guthaben"),
    "beldex_hidden" : MessageLookupByLibrary.simpleMessage("Beldex versteckt"),
    "biometric_auth_reason" : MessageLookupByLibrary.simpleMessage("Scannen Sie Ihren Fingerabdruck zur Authentifizierung"),
    "body_confirm_unlock_stake" : m1,
    "byUsingThisAppYouAgreeToTheTermsOf" : MessageLookupByLibrary.simpleMessage("Durch die Nutzung dieser App stimmen Sie den unten aufgeführten Vertragsbedingungen zu"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "change" : MessageLookupByLibrary.simpleMessage("Veränderung"),
    "change_current_node" : m2,
    "change_language" : MessageLookupByLibrary.simpleMessage("Sprache ändern"),
    "change_language_to" : m3,
    "changelog" : MessageLookupByLibrary.simpleMessage("Änderungsprotokoll"),
    "clear" : MessageLookupByLibrary.simpleMessage("Löschen"),
    "commit_transaction_amount_fee" : m4,
    "confirm" : MessageLookupByLibrary.simpleMessage("Bestätigen"),
    "confirm_sending" : MessageLookupByLibrary.simpleMessage("Bestätigen Sie das Senden"),
    "contact" : MessageLookupByLibrary.simpleMessage("Kontakt"),
    "contact_name" : MessageLookupByLibrary.simpleMessage("Name des Ansprechpartners"),
    "continue_text" : MessageLookupByLibrary.simpleMessage("Fortsetzen"),
    "copied_key_to_clipboard" : m5,
    "copied_to_clipboard" : MessageLookupByLibrary.simpleMessage("In die Zwischenablage kopiert"),
    "copy" : MessageLookupByLibrary.simpleMessage("Kopieren"),
    "create_new" : MessageLookupByLibrary.simpleMessage("Neu erstellen"),
    "dangerzone" : MessageLookupByLibrary.simpleMessage("Wichtig"),
    "dangerzone_warning" : m6,
    "delete" : MessageLookupByLibrary.simpleMessage("Löschen"),
    "digit_pin" : MessageLookupByLibrary.simpleMessage("-stelliger PIN"),
    "do_you_want_to_exit_an_app" : MessageLookupByLibrary.simpleMessage("Do you want to exit an App"),
    "edit" : MessageLookupByLibrary.simpleMessage("Bearbeiten"),
    "enter_your_pin" : MessageLookupByLibrary.simpleMessage("PIN eingeben"),
    "enter_your_pin_again" : MessageLookupByLibrary.simpleMessage("Geben Sie Ihre PIN erneut ein"),
    "error" : MessageLookupByLibrary.simpleMessage("Error"),
    "error_text_account_name" : MessageLookupByLibrary.simpleMessage("Der Kontoname darf nur Buchstaben und Zahlen enthalten\nund muss zwischen 1 und 15 Zeichen lang sein"),
    "error_text_address" : MessageLookupByLibrary.simpleMessage("Invalid BDX address"),
    "error_text_amount" : MessageLookupByLibrary.simpleMessage("Betrag kann nur Zahlen enthalten"),
    "error_text_beldex" : MessageLookupByLibrary.simpleMessage("Der Beldex-Wert kann das verfügbare Guthaben nicht überschreiten.\nDie Anzahl der Nachkommastellen muss kleiner oder gleich 12 sein"),
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
    "failed_authentication" : m7,
    "faq" : MessageLookupByLibrary.simpleMessage("FAQ"),
    "fetching" : MessageLookupByLibrary.simpleMessage("aktualisieren"),
    "filters" : MessageLookupByLibrary.simpleMessage("Filter"),
    "first_wallet_text" : MessageLookupByLibrary.simpleMessage("Das tolle Wallet\nfür Beldex"),
    "full_balance" : MessageLookupByLibrary.simpleMessage("Volles Guthaben"),
    "hidden_balance" : MessageLookupByLibrary.simpleMessage("Verstecktes Guthaben"),
    "iAgreeToTermsOfUse" : MessageLookupByLibrary.simpleMessage("Ich stimme den Nutzungsbedingungen zu"),
    "id" : MessageLookupByLibrary.simpleMessage("ID: "),
    "incoming" : MessageLookupByLibrary.simpleMessage("Eingehend"),
    "incorrect_seed" : MessageLookupByLibrary.simpleMessage("Der eingegebene Text ist ungültig."),
    "keys_title" : MessageLookupByLibrary.simpleMessage("Schlüssel"),
    "loading_your_wallet" : MessageLookupByLibrary.simpleMessage("Wallet wird geladen"),
    "login" : MessageLookupByLibrary.simpleMessage("Einloggen"),
    "never_give_your" : m8,
    "new_subaddress_create" : MessageLookupByLibrary.simpleMessage("Erstellen"),
    "new_subaddress_label_name" : MessageLookupByLibrary.simpleMessage("Name"),
    "new_subaddress_title" : MessageLookupByLibrary.simpleMessage("Neue Unteradresse"),
    "new_wallet" : MessageLookupByLibrary.simpleMessage("Neues wallet"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "node_address" : MessageLookupByLibrary.simpleMessage("Knotenadresse"),
    "node_new" : MessageLookupByLibrary.simpleMessage("Neuer Knoten"),
    "node_port" : MessageLookupByLibrary.simpleMessage("Knotenport"),
    "node_reset_settings_title" : MessageLookupByLibrary.simpleMessage("Einstellungen zurücksetzen"),
    "nodes" : MessageLookupByLibrary.simpleMessage("Knoten"),
    "nodes_list_reset_to_default_message" : MessageLookupByLibrary.simpleMessage("Möchten Sie die Einstellungen wirklich auf die Standardeinstellungen zurücksetzen?"),
    "nothing_staked" : MessageLookupByLibrary.simpleMessage("Noch nichts gestaked"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "openalias_alert_content" : m9,
    "openalias_alert_title" : MessageLookupByLibrary.simpleMessage("Beldex-Empfänger erkannt"),
    "outgoing" : MessageLookupByLibrary.simpleMessage("Ausgehend"),
    "password" : MessageLookupByLibrary.simpleMessage("Passwort"),
    "paste" : MessageLookupByLibrary.simpleMessage("Einfügen"),
    "pending" : MessageLookupByLibrary.simpleMessage(" (steht aus)"),
    "pin_is_incorrect" : MessageLookupByLibrary.simpleMessage("PIN ist falsch"),
    "please_make_selection" : MessageLookupByLibrary.simpleMessage("Bitte treffen Sie unten eine Auswahl zu\nErstellen oder Wiederherstellen Ihres Wallets."),
    "please_select" : MessageLookupByLibrary.simpleMessage("Bitte auswählen:"),
    "please_try_to_connect_to_another_node" : MessageLookupByLibrary.simpleMessage("Bitte versuchen Sie, eine Verbindung zu einem anderen Knoten herzustellen"),
    "receive" : MessageLookupByLibrary.simpleMessage("Erhalten"),
    "receive_amount" : MessageLookupByLibrary.simpleMessage("Menge"),
    "received" : MessageLookupByLibrary.simpleMessage("Empfangen"),
    "reconnect" : MessageLookupByLibrary.simpleMessage("Erneut verbinden"),
    "reconnect_alert_text" : MessageLookupByLibrary.simpleMessage("Sind Sie sicher, dass Sie die Verbindung wiederherstellen möchten?"),
    "reconnection" : MessageLookupByLibrary.simpleMessage("Wiederverbindung"),
    "reload_fiat" : MessageLookupByLibrary.simpleMessage("Fiat-Kurs neuladen"),
    "remove" : MessageLookupByLibrary.simpleMessage("Löschen"),
    "remove_node" : MessageLookupByLibrary.simpleMessage("Knoten entfernen"),
    "remove_node_message" : MessageLookupByLibrary.simpleMessage("Möchten Sie den ausgewählten Knoten wirklich entfernen?"),
    "rescan" : MessageLookupByLibrary.simpleMessage("Erneut scannen"),
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
    "router_no_route" : m10,
    "save" : MessageLookupByLibrary.simpleMessage("Speichern"),
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
    "send" : MessageLookupByLibrary.simpleMessage("Senden"),
    "send_beldex" : MessageLookupByLibrary.simpleMessage("Beldex Senden"),
    "send_beldex_address" : MessageLookupByLibrary.simpleMessage("Beldex-Adresse"),
    "send_creating_transaction" : MessageLookupByLibrary.simpleMessage("Transaktion erstellen"),
    "send_error_currency" : MessageLookupByLibrary.simpleMessage("Die Währung kann nur Zahlen enthalten"),
    "send_estimated_fee" : MessageLookupByLibrary.simpleMessage("Geschätzte Gebühr:"),
    "send_priority" : m11,
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
    "share_address" : MessageLookupByLibrary.simpleMessage("Adresse teilen "),
    "show_keys" : MessageLookupByLibrary.simpleMessage("Schlüssel anzeigen"),
    "show_seed" : MessageLookupByLibrary.simpleMessage("Seed zeigen"),
    "spend_key_private" : MessageLookupByLibrary.simpleMessage("Ausgabe-Schlüssel (geheim)"),
    "spend_key_public" : MessageLookupByLibrary.simpleMessage("Ausgabe-Schlüssel (öffentlich)"),
    "stake_beldex" : MessageLookupByLibrary.simpleMessage("Beldex staken"),
    "stake_more" : MessageLookupByLibrary.simpleMessage("Mehr staken"),
    "start_staking" : MessageLookupByLibrary.simpleMessage("Starte zu staken"),
    "status" : MessageLookupByLibrary.simpleMessage("Status: "),
    "subaddress_title" : MessageLookupByLibrary.simpleMessage("Unteradressenliste"),
    "subaddresses" : MessageLookupByLibrary.simpleMessage("Unteradressen"),
    "sync_status_connected" : MessageLookupByLibrary.simpleMessage("IN VERBINDUNG GEBRACHT"),
    "sync_status_connecting" : MessageLookupByLibrary.simpleMessage("ANSCHLUSS"),
    "sync_status_failed_connect" : MessageLookupByLibrary.simpleMessage("Verbindung zum Knoten fehlgeschlagen"),
    "sync_status_not_connected" : MessageLookupByLibrary.simpleMessage("NICHT VERBUNDEN"),
    "sync_status_starting_sync" : MessageLookupByLibrary.simpleMessage("STARTEN DER SYNCHRONISIERUNG"),
    "sync_status_synchronized" : MessageLookupByLibrary.simpleMessage("SYNCHRONISIERT"),
    "sync_status_synchronizing" : MessageLookupByLibrary.simpleMessage("SYNCHRONISIERUNG"),
    "title_confirm_unlock_stake" : MessageLookupByLibrary.simpleMessage("Stake entsperren"),
    "title_new_stake" : MessageLookupByLibrary.simpleMessage("Neuer Stake"),
    "title_stakes" : MessageLookupByLibrary.simpleMessage("Stakes"),
    "today" : MessageLookupByLibrary.simpleMessage("Heute"),
    "transaction_details_amount" : MessageLookupByLibrary.simpleMessage("Betrag"),
    "transaction_details_copied" : m12,
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
    "unable_unlock_stake" : MessageLookupByLibrary.simpleMessage("Stake Entsperrung nicht möglich"),
    "unlock_stake_requested" : MessageLookupByLibrary.simpleMessage("Stake Entsperrung angefragt"),
    "use" : MessageLookupByLibrary.simpleMessage("Wechseln zu "),
    "version" : m13,
    "view_key_private" : MessageLookupByLibrary.simpleMessage("Anzeige-Schlüssel (geheim)"),
    "view_key_public" : MessageLookupByLibrary.simpleMessage("Anzeige-Schlüssel (öffentlich)"),
    "wallet_keys" : MessageLookupByLibrary.simpleMessage("Wallet Schlüssel"),
    "wallet_list_create_new_wallet" : MessageLookupByLibrary.simpleMessage("Neues wallet erstellen"),
    "wallet_list_failed_to_load" : m14,
    "wallet_list_failed_to_remove" : m15,
    "wallet_list_load_wallet" : MessageLookupByLibrary.simpleMessage("Wallet laden"),
    "wallet_list_loading_wallet" : m16,
    "wallet_list_removing_wallet" : m17,
    "wallet_list_restore_wallet" : MessageLookupByLibrary.simpleMessage("Wallet wiederherstellen"),
    "wallet_list_title" : MessageLookupByLibrary.simpleMessage("Beldex Wallet"),
    "wallet_menu" : MessageLookupByLibrary.simpleMessage("Wallet-Menü"),
    "wallet_name" : MessageLookupByLibrary.simpleMessage("Walletname"),
    "wallet_restoration_store_incorrect_seed_length" : MessageLookupByLibrary.simpleMessage("Falsche Seed-länge"),
    "wallets" : MessageLookupByLibrary.simpleMessage("Wallets"),
    "welcome" : MessageLookupByLibrary.simpleMessage("Willkommen\nim Beldex WALLET"),
    "widgets_address" : MessageLookupByLibrary.simpleMessage("Adresse"),
    "widgets_or" : MessageLookupByLibrary.simpleMessage("oder"),
    "widgets_restore_from_blockheight" : MessageLookupByLibrary.simpleMessage("Aus Blockhöhe wiederherstellen"),
    "widgets_restore_from_date" : MessageLookupByLibrary.simpleMessage("Vom Datum wiederherstellen"),
    "widgets_seed" : MessageLookupByLibrary.simpleMessage("Seed"),
    "yes" : MessageLookupByLibrary.simpleMessage("Yes"),
    "yes_im_sure" : MessageLookupByLibrary.simpleMessage("Ja, Ich bin mir sicher!"),
    "yesterday" : MessageLookupByLibrary.simpleMessage("Gestern"),
    "your_contributions" : MessageLookupByLibrary.simpleMessage("Deine Anteile")
  };
}
