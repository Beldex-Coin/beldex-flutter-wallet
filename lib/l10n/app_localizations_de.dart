// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get unsupportedExchangePair => 'Nicht unterstütztes Exchange-Paar';

  @override
  String get account => 'Konto';

  @override
  String get accountAlreadyExist => 'Konto existiert bereits';

  @override
  String get accountName => 'Kontoname';

  @override
  String get accounts => 'Konten';

  @override
  String get add => 'Hinzufügen';

  @override
  String get addAccount => 'Konto hinzufügen';

  @override
  String get addAddress => 'Adresse hinzufügen';

  @override
  String get addBns => 'BNS hinzufügen';

  @override
  String get addNode => 'Knoten hinzufügen';

  @override
  String get address_book => 'Adressbuch';

  @override
  String get addressShouldNotBeEmpty => 'Adresse darf nicht leer sein';

  @override
  String get addSubAddress => 'Unteradresse hinzufügen';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'Nach Ihrer ersten Transaktion können Sie diese hier sehen.';

  @override
  String get alert => 'Warnung';

  @override
  String get allowFaceIdAuthentication => 'Face-ID-Authentifizierung zulassen';

  @override
  String get amount => 'Betrag ';

  @override
  String get amountReceived => 'Empfangener Betrag';

  @override
  String get appstore => 'AppStore';

  @override
  String get are_you_sure => 'Sind Sie sicher?';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => 'Sind Sie sicher, dass Sie den ausgewählten Kontakt entfernen möchten?';

  @override
  String get auth_store_banned_for => 'Gesperrt wegen';

  @override
  String get auth_store_banned_minutes => 'Minuten';

  @override
  String get auth_store_incorrect_password => 'Falsches PIN';

  @override
  String get authenticated => 'Authentifiziert';

  @override
  String get available_balance => 'Verfügbarer Saldo';

  @override
  String get availableBdx => 'Verfügbares BDX : ';

  @override
  String get bdx => 'BDX';

  @override
  String get biometric_auth_reason => 'Scannen Sie Ihren Fingerabdruck zur Authentifizierung';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'Biometrische Funktion derzeit deaktiviert. Bitte aktivieren Sie die biometrische Authentifizierungsfunktion in den App-Einstellungen';

  @override
  String blockConfirmed(Object count) {
    return '$count Block';
  }

  @override
  String blockRemaining(Object status) {
    return 'Noch $status Block';
  }

  @override
  String blocksConfirmed(Object count) {
    return '$count Blöcke';
  }

  @override
  String blocksRemaining(Object status) {
    return 'Noch $status Blöcke';
  }

  @override
  String get bns => 'BNS';

  @override
  String get bnsAddRecord => 'Datensatz hinzufügen';

  @override
  String get bnsBackupOwner => 'Backup-Besitzer';

  @override
  String get bnsBchatId => 'BChat-ID';

  @override
  String get bnsBelnetId => 'Belnet-ID';

  @override
  String get bnsConfirmPurchase => 'Kauf bestätigen';

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return 'BNS-Eintrag für $bnsName konnte nicht entschlüsselt werden';
  }

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return 'BNS-Eintrag für $bnsName erfolgreich entschlüsselt';
  }

  @override
  String get bnsEncryptedBchatValue => 'Verschlüsselter BChat-Wert';

  @override
  String get bnsEncryptedBelnetValue => 'Verschlüsselter Belnet-Wert';

  @override
  String get bnsEncryptedEthValue => 'Verschlüsselter ETH-Wert';

  @override
  String get bnsEncryptedWalletValue => 'Verschlüsselter Wallet-Wert';

  @override
  String get bnsEnterValidWalletAddress => 'Geben Sie eine gültige Wallet-Adresse ein';

  @override
  String get bnsEthAddress => 'ETH-Adresse';

  @override
  String get bnsEthAddressDescription => 'Unsere ETH-Adresse ist mit allen EVM-Chains kompatibel';

  @override
  String get bnsExpirationHeight => 'Ablaufhöhe';

  @override
  String get bnsFetchingRecords => 'BNS-Datensätze werden aus dem Netzwerk abgerufen...';

  @override
  String get bnsInvalidBchatId => 'Ungültige BChat-ID';

  @override
  String get bnsInvalidBelnetId => 'Ungültige Belnet-ID';

  @override
  String get bnsInvalidEthAddress => 'Ungültige ETH-Adresse';

  @override
  String get bnsInvalidName => 'Ungültiger BNS-Name';

  @override
  String get bnsInvalidOwnerAddress => 'Ungültige Besitzeradresse.';

  @override
  String get bnsInvalidWalletAddress => 'Ungültige Wallet-Adresse. Lassen Sie das Feld leer, wenn Sie die aktuelle Wallet als BNS-Eigentümer verwenden möchten.';

  @override
  String get bnsNameHint => 'Der Name, der über den Beldex Name Service gekauft werden soll';

  @override
  String get bnsNameIsTaken => 'Der BNS-Name ist bereits vergeben. Wählen Sie einen anderen Namen.';

  @override
  String get bnsNewOwnerHint => 'Geben Sie die Wallet-Adresse des neuen Eigentümers ein';

  @override
  String get bnsNoteLabel => 'Hinweis: ';

  @override
  String get bnsOwnerAndBackupDifferent => 'Die Besitzer- und Backup-Adresse müssen unterschiedlich sein.';

  @override
  String get bnsOwnerHint => 'Die Wallet-Adresse des Besitzers';

  @override
  String get bnsOwnerLabel => 'Besitzer';

  @override
  String get bnsOwnerOptional => 'Besitzer (optional)';

  @override
  String get bnsPleaseFillField => 'Bitte füllen Sie dieses Feld aus';

  @override
  String get bnsPrice => '-Preis';

  @override
  String get bnsPurchase => 'Kaufen';

  @override
  String get bnsPurchaseDescription => 'Kaufen oder aktualisieren Sie einen BNS-Eintrag. Wenn Sie einen Namen kaufen, kann es ein oder zwei Minuten dauern, bis er in der Liste erscheint';

  @override
  String get bnsPurchasedSuccessfully => 'BNS erfolgreich gekauft';

  @override
  String get bnsRecordNameHint => 'Ein BNS-Name, der Ihnen gehört';

  @override
  String get bnsRecordNotFound => 'Der angegebene BNS-Eintrag existiert nicht oder gehört nicht zu dieser Wallet.';

  @override
  String get bnsRecords => 'BNS-Datensätze';

  @override
  String get bnsRecordsDescription => 'Hier finden Sie alle BNS-Namen, die dieser Wallet gehören. Das Entschlüsseln eines Eintrags, den Sie besitzen, gibt den Namen und den Wert des BNS-Eintrags zurück.';

  @override
  String get bnsRenewAction => 'Erneuern';

  @override
  String get bnsRenewal => 'BNS-Verlängerung';

  @override
  String get bnsUpdate => 'BNS-Aktualisierung';

  @override
  String get bnsUpdateAction => 'Aktualisieren';

  @override
  String get bnsUpdateHeight => 'Aktualisierungshöhe';

  @override
  String get bnsUpdateNote => 'Sie können entweder die Eigentümeradresse oder die Werte gleichzeitig aktualisieren. Wenn Sie beides aktualisieren möchten, können Sie entweder die Werte vor der Übertragung des Eigentums oder danach aktualisieren.';

  @override
  String get bnsUpdateOwner => 'Eigentümer aktualisieren';

  @override
  String get bnsUpdateValues => 'Werte aktualisieren';

  @override
  String get bnsYearFiveShort => '5 Jahre';

  @override
  String get bnsYearLabel => 'Jahr';

  @override
  String get bnsYearOneShort => '1 Jahr';

  @override
  String get bnsYearTenShort => '10 Jahre';

  @override
  String get bnsYearTwoShort => '2 Jahre';

  @override
  String get bnsYouSave => 'Sie sparen';

  @override
  String get buyBns => 'BNS kaufen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String change_current_node(Object node) {
    return 'Möchten Sie den aktuellen Node wirklich zu $node ändern?';
  }

  @override
  String get change_language => 'Sprache ändern';

  @override
  String get changelog => 'Änderungsprotokoll';

  @override
  String get changeWallet => 'Wallet wechseln';

  @override
  String get chooseLanguage => 'Sprache wählen';

  @override
  String get chooseSeedLanguage => 'Seed-Sprache wählen';

  @override
  String get clear => 'Löschen';

  @override
  String get confirm_sending => 'Senden bestätigen';

  @override
  String get continue_text => 'Weiter';

  @override
  String get copied => 'Kopiert';

  @override
  String get copyAndSaveTheSeedToContinue => 'Kopieren und speichern Sie den Seed, um fortzufahren';

  @override
  String get copySeed => 'Seed kopieren';

  @override
  String get create_new => 'Neue Wallet erstellen';

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'Geben Sie $item Ihrer Beldex-Wallet NIEMALS in eine andere Software oder Website ein, außer in die OFFIZIELLEN Beldex-Wallets, die direkt von $app_store, der Beldex-Website oder dem Beldex-GitHub heruntergeladen wurden. Möchten Sie wirklich auf Ihre Wallet $item zugreifen?';
  }

  @override
  String get date => 'Datum';

  @override
  String get dateShouldNotBeEmpty => 'Das Datum darf nicht leer sein';

  @override
  String get delete => 'Löschen';

  @override
  String get doYouWantToChangeYournPrimaryAccount => 'Möchten Sie Ihr primäres Konto ändern?';

  @override
  String get doYouWantToExitTheWallet => 'Möchten Sie die Wallet beenden?';

  @override
  String get doYouWantToReconnectnTheWallet => 'Möchten Sie die Wallet wieder verbinden?';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get enterAddress => 'Adresse eingeben';

  @override
  String get enterAmount => 'Betrag eingeben';

  @override
  String get enterAValidName => 'Geben Sie einen gültigen Namen ein';

  @override
  String get enterAValidNameUpto15Characters => 'Geben Sie einen gültigen Namen mit maximal 15 Zeichen ein';

  @override
  String get enterAValidNameUpto20Characters => 'Geben Sie einen gültigen Namen mit bis zu 20 Zeichen ein';

  @override
  String get enterAValidSubAddress => 'Geben Sie eine gültige Unteradresse ein';

  @override
  String get enterBdxToReceive => 'BDX zum Empfangen eingeben';

  @override
  String get enterBdxToSend => 'BDX zum Senden eingeben';

  @override
  String get enterName => 'Name eingeben';

  @override
  String get enterPin => 'PIN eingeben';

  @override
  String get enterValidHeightWithoutSpace => 'Geben Sie eine gültige Höhe ohne Leerzeichen ein';

  @override
  String get enterValidNameUpto15Characters => 'Geben Sie einen gültigen Namen mit bis zu 15 Zeichen ein';

  @override
  String get enterWalletName => 'Wallet-Name eingeben';

  @override
  String get enterWalletName_ => 'Wallet-Name eingeben';

  @override
  String get enterYourPin => 'Geben Sie Ihre PIN ein';

  @override
  String get error_text_address => 'Ungültige BDX-Adresse';

  @override
  String get error_text_contact_name => 'Der Kontaktname darf keine „ “ oder \' Zeichen enthalten und muss zwischen 1 und 32 Zeichen lang sein';

  @override
  String get error_text_keys => 'Wallet-Keys dürfen nur 64 Zeichen in Hex enthalten ';

  @override
  String get error_text_node_address => 'Bitte geben Sie eine iPv4-Adresse ein';

  @override
  String get error_text_node_port => 'Der Knotenport kann nur Nummern zwischen 0 und 65535 enthalten';

  @override
  String get exchange => 'Tauschen';

  @override
  String get exchangeRate => 'Wechselkurs';

  @override
  String get expandDetails => 'Details erweitern';

  @override
  String failed_authentication(Object state_error) {
    return 'Authentifizierung fehlgeschlagen. $state_error';
  }

  @override
  String get faq => 'FAQ';

  @override
  String get fee => 'Gebühr';

  @override
  String get filters => 'Filtern nach';

  @override
  String get fiveDecimals => '5 - Fünf (0.00000)';

  @override
  String get flashTransaction => 'Blitz-Transaktion';

  @override
  String get floatingExchangeRate => 'Schwankender Wechselkurs';

  @override
  String get floatingRateDescription => 'Der schwankende Kurs kann sich jederzeit aufgrund der Marktbedingungen ändern, sodass Sie möglicherweise mehr oder weniger Krypto erhalten als erwartet.';

  @override
  String get fourDecimals => '4 - Vier (0.0000)';

  @override
  String get full_balance => 'Gesamtsaldo';

  @override
  String get hidden_balance => 'Verborgener Saldo';

  @override
  String get howCanWenhelpYou => 'Wie können wir Ihnen helfen?';

  @override
  String get incoming => 'Eingehend';

  @override
  String get initiatingTransactionDescription => 'Bitte schließen Sie dieses Fenster nicht und wechseln Sie nicht zu einer anderen App, bis die Transaktion initiiert wurde';

  @override
  String get initiatingTransactionTitle => 'Transaktion wird initiiert…';

  @override
  String get labelName => 'Bezeichnungsname';

  @override
  String get legalDisclaimer => 'Rechtlicher Hinweis';

  @override
  String get loadingTheWallet => 'Wallet wird geladen…';

  @override
  String get loadingTheWalletDescription => 'Bitte schließen Sie dieses Fenster nicht und wechseln Sie nicht zu einer anderen App, bis die Wallet geladen ist';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => 'Stellen Sie sicher, dass Sie ein Backup Ihres Wiederherstellungs-Seeds, Ihrer Wallet-Adresse und Ihrer privaten Schlüssel erstellt haben';

  @override
  String get max => 'Max.';

  @override
  String get maximumAmount => 'Höchstbetrag ist';

  @override
  String get minimumAmount => 'Mindestbetrag ist';

  @override
  String get myBns => 'Mein BNS';

  @override
  String get name => 'Name';

  @override
  String get nameShouldNotBeEmpty => 'Name darf nicht leer sein';

  @override
  String get network_fee => 'Netzwerkgebühr';

  @override
  String get networkErrorCheckConnection => 'Netzwerkfehler! Bitte überprüfen Sie die Internetverbindung.';

  @override
  String never_give_your(Object item) {
    return 'Geben Sie $item Ihrer Beldex-Wallet niemals an andere weiter!';
  }

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Geben Sie $item Ihrer Beldex-Wallet niemals in eine andere Software oder Website ein, außer in die offiziellen Beldex-Wallets, die direkt aus dem $appStore, von der Beldex-Website oder dem Beldex-GitHub heruntergeladen wurden.';
  }

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'eilen Sie Ihren Seed niemals mit jemandem! Überprüfen Sie Ihre Umgebung, um sicherzustellen, dass niemand hinsieht';

  @override
  String get new_subaddress_create => 'Erstellen';

  @override
  String get new_wallet => 'Neue Wallet';

  @override
  String get no => 'NEIN';

  @override
  String get noAddressesInBook => 'Keine Adressen im Adressbuch';

  @override
  String get node_address => 'Knotenadresse';

  @override
  String get node_port => 'Knotenport';

  @override
  String get node_reset_settings_title => 'Einstellungen zurücksetzen';

  @override
  String get nodeAlreadyExists => 'Dieser Knoten existiert bereits';

  @override
  String get nodeNameOptional => 'Knotenname (optional)';

  @override
  String get nodes => 'Knoten';

  @override
  String get nodes_list_reset_to_default_message => 'Möchten Sie die Einstellungen wirklich auf die Standardeinstellungen zurücksetzen?';

  @override
  String get noInternet => 'Kein Internet!';

  @override
  String get noInternetMessage => 'Bitte überprüfen Sie Ihre Internetverbindung und\n versuchen Sie es erneut.';

  @override
  String get note => 'Hinweis:';

  @override
  String get noTransactionsMessage => 'Es wurden keine Transaktionen oder Exchanges durchgeführt, die angezeigt werden können.';

  @override
  String get noTransactionsYet => 'Noch keine Transaktionen!';

  @override
  String get ok => 'Ok';

  @override
  String get outgoing => 'Ausgehend';

  @override
  String get passwordOptional => 'Passwort (optional)';

  @override
  String get paste => 'Einfügen';

  @override
  String get pin_is_incorrect => 'PIN ist falsch';

  @override
  String get playStore => 'Play Store';

  @override
  String get please_try_to_connect_to_another_node => 'Bitte versuchen Sie, eine Verbindung zu einem anderen Node herzustellen';

  @override
  String get pleaseEnterAAmount => 'Bitte geben Sie einen Betrag ein';

  @override
  String get pleaseEnterABdxAddress => 'Bitte geben Sie eine BDX-Adresse ein';

  @override
  String get pleaseEnterAValidAmount => 'Bitte geben Sie einen gültigen Betrag ein';

  @override
  String get pleaseEnterAValidSeed => 'Bitte geben Sie einen gültigen Seed ein';

  @override
  String get re_enter_your_pin => 'PIN erneut eingeben';

  @override
  String get receive => 'Empfangen';

  @override
  String get receiver => 'Empfänger';

  @override
  String get reconnect => 'Wieder verbinden';

  @override
  String get reconnectWallet => 'Wallet wieder verbinden';

  @override
  String get recoverySeed => 'Erholungssamen';

  @override
  String get recoverySeedkey => 'Wiederherstellungs-Seed/-Schlüssel';

  @override
  String get removeContact => 'Kontakt entfernen';

  @override
  String get removeWallet => 'Wallet entfernen';

  @override
  String get rescan => 'Neu scannen';

  @override
  String get rescanWallet => 'Wallet neu scannen';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get restore_address => 'Adresse';

  @override
  String get restore_description_from_keys => 'Verwenden Sie die gespeicherten Tastenschläge aus den privaten Keys, um Ihre Wallet wiederherzustellen';

  @override
  String get restore_description_from_seed => 'Verwenden Sie den 25-Wort-Mnemonic-Schlüssel oder Seed-Phrase, um Ihre Wallet wiederherzustellen.';

  @override
  String get restore_description_from_seed_keys => 'Stellen Sie Ihre Wallet aus dem Seed/den Keys wieder her, den/die Sie an einem sicheren Ort gespeichert haben';

  @override
  String get restore_from_seed_placeholder => 'Bitte geben Sie hier Ihren Seed ein oder fügen Sie ihn ein';

  @override
  String get restore_next => 'Weiter';

  @override
  String get restore_recover => 'Wiederherstellen';

  @override
  String get restore_restore_wallet => 'Wallet wiederherstellen';

  @override
  String get restore_title_from_keys => 'Aus Keys wiederherstellen';

  @override
  String get restore_title_from_seed => 'Aus Seed wiederherstellen';

  @override
  String get restore_title_from_seed_keys => 'Wiederherstellen aus Seed/Keys';

  @override
  String get restore_wallet => 'Bestehende Wallet verwenden';

  @override
  String get restoredViaKeys => 'Sie haben über Keys wiederhergestellt';

  @override
  String get save => 'Speichern';

  @override
  String get searchCoins => 'Coins suchen ';

  @override
  String get searchCurrency => 'Währung suchen';

  @override
  String get seed_title => 'Seed';

  @override
  String get seedKeys => 'Seed & Schlüssel';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'Wählen Sie eine Option, um eine bestehende Wallet\\n zu erstellen oder wiederherzustellen';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get send => 'Senden';

  @override
  String get send_beldex_address => 'Beldex-Adresse oder BNS-Name';

  @override
  String get send_estimated_fee => 'Geschätzte Gebühr:';

  @override
  String send_priority(Object transactionPriority) {
    return 'Die Priorität $transactionPriority ist als Standardgebühr festgelegt. Gehen Sie zu den Einstellungen, um die Transaktionspriorität zu ändern.';
  }

  @override
  String get sent => 'Gesendet';

  @override
  String get service_fee => 'Servicegebühr 0,25 %';

  @override
  String get settings_allow_biometric_authentication => 'Biometrische Authentifizierung zulassen';

  @override
  String get settings_balance_detail => 'Dezimalstellen';

  @override
  String get settings_change_pin => 'PIN ändern';

  @override
  String get settings_currency => 'Währung';

  @override
  String get settings_current_node => 'Aktueller Knoten';

  @override
  String get settings_dark_mode => 'Dunkelmodus';

  @override
  String get settings_display_balance_as => 'Kontostand anzeigen als';

  @override
  String get settings_enable_fiat_currency => 'Flat-Währungsumrechnung aktivieren';

  @override
  String get settings_fee_priority => 'Gebührenpriorität';

  @override
  String get settings_personal => 'Persönlich';

  @override
  String get settings_save_recipient_address => 'Empfängeradresse speichern';

  @override
  String get settings_support => 'Unterstützung';

  @override
  String get settings_terms_and_conditions => 'Geschäftsbedingungen';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get setup_pin => 'PIN einrichten';

  @override
  String get setup_successful => 'Ihre PIN wurde erfolgreich eingerichtet!';

  @override
  String get shareQr => 'QR teilen';

  @override
  String get show_keys => 'Schlüssel anzeigen';

  @override
  String get show_seed => 'Seed zeigen';

  @override
  String get spend_key_private => 'Spend Key (privat)';

  @override
  String get spend_key_public => 'Ausgabe-Schlüssel (öffentlich)';

  @override
  String get status => 'Status: ';

  @override
  String get subAddress => 'Unteradresse';

  @override
  String get subaddressAlreadyExist => 'Unteradresse existiert bereits';

  @override
  String get swap => 'Swap';

  @override
  String get swap_amount_from => 'Betrag von';

  @override
  String get swap_amount_sent => 'Gesendeter Betrag';

  @override
  String get swap_amount_to => 'Betrag zu';

  @override
  String get swap_and => ' und ';

  @override
  String get swap_checkout => 'Kasse';

  @override
  String get swap_completed => 'Abgeschlossen';

  @override
  String get swap_confirm_and_make_payment => 'Bestätigen & Zahlung durchführen';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return 'Bitte stellen Sie sicher, dass Sie die richtige Adresse für die ausgewählte Chain – $blockchain – eingeben. Andernfalls verlieren Sie Ihre Guthaben.';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return 'Geben Sie Ihre $currency-Empfängeradresse ein';
  }

  @override
  String get swap_exchange_rate => 'Wechselkurs';

  @override
  String get swap_failed => 'Fehlgeschlagen';

  @override
  String get swap_funds_not_received => 'Die Mittel wurden innerhalb von 3 Stunden nicht empfangen. Bitte überprüfen Sie die Kurse und erstellen Sie eine neue Transaktion';

  @override
  String get swap_i_agree_with => 'Ich stimme zu';

  @override
  String get swap_input_hash => 'Eingabe-Hash';

  @override
  String get swap_input_output_hash => 'Eingabe-/Ausgabe Code';

  @override
  String get swap_network_fee => 'Netzwerkgebühr';

  @override
  String get swap_network_label => 'NETZWERK: ';

  @override
  String get swap_new_transaction => 'Neue Transaktion';

  @override
  String get swap_open_history => 'Verlauf öffnen';

  @override
  String get swap_output_hash => 'Ausgabe-Hash';

  @override
  String get swap_privacy_policy => 'Datenschutzrichtlinie';

  @override
  String get swap_received_time => 'Erhaltene Zeit';

  @override
  String get swap_send_funds_notice => 'Sie haben 3 Stunden Zeit, um die Mittel zu senden, andernfalls wird die Transaktion automatisch abgebrochen.\nDer Austausch wird gestartet, sobald die Mittel eingegangen sind.';

  @override
  String get swap_send_funds_to_address_below => 'Senden Sie die Mittel an die untenstehende Adresse';

  @override
  String get swap_service_fee => 'Servicegebühr 0,25%';

  @override
  String get swap_start_over => 'Neu starten';

  @override
  String get swap_terms_of_use => 'Nutzungsbedingungen';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return 'Verbleibende Zeit zum Senden von $amount $currency';
  }

  @override
  String swap_time_remaining(Object value) {
    return 'Verbleibende Zeit: $value';
  }

  @override
  String get swap_transaction_preview => 'Transaktionsvorschau';

  @override
  String get swap_you_get => 'Sie erhalten';

  @override
  String get swapNotAvailable => ' Swap ist momentan nicht verfügbar';

  @override
  String get sync_status_connecting => 'Verbinden';

  @override
  String get sync_status_failed_connect => 'Fehler beim Verbinden mit dem Node';

  @override
  String get sync_status_starting_sync => 'Synchronisation starten';

  @override
  String get sync_status_synchronized => 'SYNCHRONISIERT';

  @override
  String get sync_status_synchronizing => 'SYNCHRONISIERUNG';

  @override
  String get test => 'prüfen';

  @override
  String get testResult => 'Testergebnis:';

  @override
  String get theAddressAlreadyExist => 'Die Adresse existiert bereits';

  @override
  String get thisNameAlreadyExist => 'Dieser Name existiert bereits';

  @override
  String get transaction_details_amount => 'Betrag';

  @override
  String get transaction_details_height => 'Höhe';

  @override
  String get transaction_details_recipient_address => 'Empfängeradresse';

  @override
  String get transaction_details_transaction_id => 'Transaktions-ID';

  @override
  String get transaction_priority_blink => 'Flash';

  @override
  String get transaction_priority_slow => 'Langsam';

  @override
  String get transactionInitiatedSuccessfully => 'Transaktion erfolgreich initiiert';

  @override
  String get transactions => 'Transaktionen';

  @override
  String get transactions_by_date => 'Transaktionen nach Datum';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => 'Übertragen Sie Ihre BDX schneller mit Blitz-Transaktion!';

  @override
  String get tryAgain => 'Bitte versuchen Sie es später noch einmal.';

  @override
  String get twoDecimals => '2 - Zwei (0.00)';

  @override
  String get usePattern => 'MUSTER VERWENDEN';

  @override
  String get userNameOptional => 'Benutzername (optional)';

  @override
  String version(Object currentVersion) {
    return 'Version $currentVersion';
  }

  @override
  String get view => 'Anzeigen';

  @override
  String get view_key_private => 'View Key (privat)';

  @override
  String get view_key_public => 'Anzeige-Schlüssel (öffentlich)';

  @override
  String get wallet => 'Geldbörse';

  @override
  String get wallet_keys => 'Wallet Schlüssel';

  @override
  String wallet_list_failed_to_load(Object error, Object wallet_name) {
    return 'Wallet $wallet_name konnte nicht geladen werden. $error';
  }

  @override
  String wallet_list_failed_to_remove(Object error, Object wallet_name) {
    return 'Wallet $wallet_name konnte nicht entfernt werden. $error';
  }

  @override
  String get wallet_list_load_wallet => 'Wallet laden';

  @override
  String wallet_list_loading_wallet(Object wallet_name) {
    return 'Wallet $wallet_name wird geladen';
  }

  @override
  String wallet_list_removing_wallet(Object wallet_name) {
    return 'Wallet $wallet_name wird entfernt';
  }

  @override
  String get wallet_list_title => 'Beldex Wallet';

  @override
  String get wallet_name => 'Wallet-Name';

  @override
  String get wallet_restoration_store_incorrect_seed_length => 'Falsche Seed-länge';

  @override
  String get walletAddress => 'Wallet-Adresse';

  @override
  String walletAlreadyExists(Object name) {
    return 'Eine Wallet mit dem Namen $name existiert bereits!';
  }

  @override
  String get walletRestore => 'Wallet-Wiederherstellung';

  @override
  String get wallets => 'Wallets';

  @override
  String get walletSettings => 'Wallet-Einstellungen';

  @override
  String get welcomeToBeldexWallet => 'Willkommen bei Beldex Wallet :)';

  @override
  String get widgets_restore_from_blockheight => 'Wiederherstellen ab Blockhöhe';

  @override
  String get widgets_restore_from_date => 'Wiederherstellen ab Datum';

  @override
  String get yes => 'Ja';

  @override
  String get yes_im_sure => 'Ja, Ich bin mir sicher!';

  @override
  String get yesterday => 'Gestern';

  @override
  String get youAreAboutToDeletenYourWallet => 'Sie sind dabei, Ihre Wallet zu löschen!';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => 'Sie können den Seed nicht anzeigen, da Sie die Wiederherstellung mithilfe von Schlüsseln durchgeführt haben';

  @override
  String get youGet => 'Sie erhalten';

  @override
  String get youSend => 'Sie senden';

  @override
  String get zeroDecimal => '0 - Null (000)';

  @override
  String changePinLength(Object value) {
    return 'Wechseln zu $value-stelliger PIN';
  }

  @override
  String get pleaseEnterAValidHeight => 'Bitte geben Sie eine gültige Höhe ein';

  @override
  String get invalidAddress => 'Ungültige Adresse';

  @override
  String get exchangePair => 'Handelspaar';

  @override
  String get payment => 'Zahlung';

  @override
  String get bnsConfirmUpdate => 'Eigentümer aktualisieren';

  @override
  String get bnsRenewedSuccessfully => 'BNS erfolgreich verlängert';

  @override
  String get bnsSameBchatId => 'Gleiche BChat-ID';

  @override
  String get bnsSameBelnetId => 'Gleiche BelNet-ID';

  @override
  String get bnsSameEthAddress => 'Gleiche ETH-Adresse';

  @override
  String get bnsSameOwnerAddress => 'Gleiche Besitzeradresse';

  @override
  String get bnsSameWalletAddress => 'Gleiche Wallet-Adresse';

  @override
  String get bnsUpdatedSuccessfully => 'BNS erfolgreich aktualisiert';

  @override
  String get bnsWaitForFetch => 'Bitte warten Sie, bis wir den BNS-Eintrag aus dem Netzwerk abrufen';

  @override
  String get bnsYearFive => '5 Jahre';

  @override
  String get bnsYearOne => '1 Jahr';

  @override
  String get bnsYearTen => '10 Jahre';

  @override
  String get bnsYearTwo => '2 Jahre';

  @override
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return 'Möchten Sie Ihren Stake wirklich von $masterNodeKey entsperren?';
  }

  @override
  String get checking => 'Überprüfung...';

  @override
  String get checkingNodeConnection => 'Knotenverbindung wird überprüft...';

  @override
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return 'Transaktion festschreiben\nMenge: $amount\nGebühr: $fee';
  }

  @override
  String get committingTheTransaction => 'Festschreiben der Transaktion';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => 'Bestätigen Sie Ihre PIN, Ihr Muster und Ihr Passwort für die Bildschirmsperre';

  @override
  String get connectionFailed => 'Verbindung fehlgeschlagen';

  @override
  String get do_you_want_to_exit_an_app => 'Möchten Sie eine App beenden?';

  @override
  String get enterAValidAddress => 'Geben Sie eine gültige Adresse ein';

  @override
  String get error => 'Fehler';

  @override
  String get error_text_beldex => 'Der Beldex-Wert kann das verfügbare Guthaben nicht überschreiten.\nDie Anzahl der Nachkommastellen muss kleiner oder gleich 9 sein';

  @override
  String get error_text_fiat => 'Der Wert des Betrags darf den verfügbaren Kontostand nicht überschreiten.\nDie Anzahl der Nachkommastellen muss kleiner oder gleich 2 sein';

  @override
  String get error_text_service_node => 'Master Node Schlüssel können nur 64 hexadezimale Zeichen enthalten';

  @override
  String get exchangeAmount => 'Exchange-Betrag';

  @override
  String get failedToGetOutputDistribution => 'Fehler beim Abrufen der Output-Verteilung';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return 'Flash-Transaktionen sind Soforttransaktionen.\nDie Priorität $transactionPriority ist als Standardgebühr festgelegt.';
  }

  @override
  String get important => 'WICHTIG';

  @override
  String get keys_title => 'Schlüssel';

  @override
  String get noPendingTransaction => 'Keine ausstehende Transaktion';

  @override
  String get nothing_staked => 'Noch nichts gestaked';

  @override
  String openalias_alert_content(Object recipient_name) {
    return 'Sie senden Geld an\n$recipient_name';
  }

  @override
  String get openalias_alert_title => 'Beldex-Empfänger erkannt';

  @override
  String get pending => ' (steht aus)';

  @override
  String get please_select => 'Bitte auswählen:';

  @override
  String get pleaseAddAMainnetNode => 'Bitte fügen Sie einen Mainnet-Knoten hinzu';

  @override
  String get received => 'Empfangen';

  @override
  String get reconnect_alert_text => 'Sind Sie sicher, dass Sie die Verbindung wiederherstellen möchten?';

  @override
  String get reconnection => 'Wiederverbindung';

  @override
  String get remove_node => 'Knoten entfernen';

  @override
  String get remove_node_message => 'Möchten Sie den ausgewählten Knoten wirklich entfernen?';

  @override
  String get rename => 'Umbenennen';

  @override
  String router_no_route(Object name) {
    return 'Keine Route definiert für $name';
  }

  @override
  String get seed_language_chinese => 'Chinesisch';

  @override
  String get seed_language_dutch => 'Niederländisch';

  @override
  String get seed_language_english => 'Englisch';

  @override
  String get seed_language_french => 'Französisch';

  @override
  String get seed_language_german => 'Deutsch';

  @override
  String get seed_language_italian => 'Italienisch';

  @override
  String get seed_language_japanese => 'Japanisch';

  @override
  String get seed_language_portuguese => 'Portugiesisch';

  @override
  String get seed_language_russian => 'Russisch';

  @override
  String get seed_language_spanish => 'Spanisch';

  @override
  String get seed_share => 'Teilen Sie Seed';

  @override
  String get send_your_wallet => 'Dein Wallet';

  @override
  String get sending => 'Senden';

  @override
  String get service_node_key => 'Master Node Schlüssel';

  @override
  String get settings_none => 'Keiner';

  @override
  String get stake_beldex => 'Beldex staken';

  @override
  String get stake_more => 'Mehr staken';

  @override
  String get start_staking => 'Starte zu staken';

  @override
  String get subaddress_title => 'Unteradressenliste';

  @override
  String get subAddresses => 'Unteradressen';

  @override
  String get success => 'Erfolg';

  @override
  String get swap_confirmations => 'Bestätigungen';

  @override
  String get swap_confirmed => 'Bestätigt';

  @override
  String swap_confirmed_in_blockchain(Object currencyFrom, Object currencyTo) {
    return 'Sobald $currencyFrom im Blockchain bestätigt ist, beginnen wir mit dem Austausch zu $currencyTo';
  }

  @override
  String get swap_confirming_in_progress => 'Bestätigung läuft';

  @override
  String swap_done_exchanging(Object currencyFrom, Object currencyTo) {
    return 'Austausch von $currencyFrom zu $currencyTo abgeschlossen';
  }

  @override
  String swap_enter_extra_id(Object extraIdName) {
    return 'Geben Sie $extraIdName ein';
  }

  @override
  String swap_enter_refund_address(Object currency) {
    return 'Geben Sie Ihre $currency-Rückerstattungsadresse ein';
  }

  @override
  String get swap_estimated_time => 'Geschätzte Zeit';

  @override
  String get swap_estimated_time_value => '5-30 Min.';

  @override
  String swap_exchange_address(Object currency, Object exchangeName) {
    return '$exchangeName-Adresse ($currency)';
  }

  @override
  String get swap_exchanging => 'Tausch läuft';

  @override
  String swap_exchanging_currency(Object currencyFrom, Object currencyTo) {
    return 'Austausch von $currencyFrom zu $currencyTo';
  }

  @override
  String get swap_expired => 'Abgelaufen';

  @override
  String swap_extra_id_info(Object currency, Object extraIdName) {
    return 'Bitte geben Sie die $extraIdName für Ihre $currency-Empfängeradresse an, falls Ihr Wallet sie benötigt. Ihre Transaktion kann nicht ausgeführt werden, wenn Sie sie weglassen. Wenn Ihr Wallet keine $extraIdName benötigt, entfernen Sie das Häkchen.';
  }

  @override
  String get swap_funds_sent_to_wallet => 'Gelder an Ihre Wallet gesendet';

  @override
  String get swap_history => 'Verlauf';

  @override
  String get swap_maximum_amount_changed => 'Der Maximalbetrag wurde geändert, der neue Wert ist ';

  @override
  String get swap_minimum_amount_changed => 'Der Mindestbetrag wurde geändert, der neue Wert ist ';

  @override
  String swap_my_wallet_requires_extra_id(Object extraIdName) {
    return 'Mein Wallet benötigt $extraIdName';
  }

  @override
  String get swap_overdue => 'Überfällig';

  @override
  String swap_please_enter_extra_id(Object extraIdName) {
    return 'Bitte geben Sie $extraIdName ein';
  }

  @override
  String get swap_process_wait => 'Der Vorgang dauert einige Minuten. Bitte warten.';

  @override
  String swap_recipient_address_with_currency(Object currency) {
    return 'Empfängeradresse ($currency)';
  }

  @override
  String get swap_refund_address => 'Rückerstattungsadresse';

  @override
  String get swap_refund_wallet_address => 'Rückerstattungs-Wallet-Adresse';

  @override
  String get swap_see_input_hash_in_explorer => 'Eingabe-Hash im Explorer anzeigen';

  @override
  String get swap_sending_funds_to_wallet => 'Gelder werden an Ihre Wallet gesendet';

  @override
  String get swap_you_can_initiate_new_transaction => 'Sie können eine neue Transaktion starten. Sie können den Status dieser Transaktion jederzeit in der Transaktion anzeigen ';

  @override
  String get swap_you_dont_have_to_wait_here => 'Sie müssen hier nicht warten';

  @override
  String get swap_you_sent => 'Sie haben gesendet';

  @override
  String get swapTransactionReport => 'Beldex_Wallet_Tauschbericht';

  @override
  String get sync_status_connected => 'IN VERBINDUNG GEBRACHT';

  @override
  String get sync_status_not_connected => 'NICHT VERBUNDEN';

  @override
  String get syncInfo => 'Informationen synchronisieren';

  @override
  String get title_confirm_unlock_stake => 'Stake entsperren';

  @override
  String get title_new_stake => 'Neuer Stake';

  @override
  String get title_stakes => 'Stakes';

  @override
  String get today => 'Heute';

  @override
  String get touchTheFingerprintSensor => 'Berühren Sie den Fingerabdrucksensor';

  @override
  String transaction_details_copied(Object title) {
    return '$title in die Zwischenablage kopiert';
  }

  @override
  String get transaction_details_payment_id => 'Zahlungs-ID';

  @override
  String get transaction_details_title => 'Transaktionsdetails';

  @override
  String get transaction_sent => 'Transaktion gesendet!';

  @override
  String get transactionReport => 'Transaktionsbericht';

  @override
  String get unable_unlock_stake => 'Stake Entsperrung nicht möglich';

  @override
  String get unlock_stake_requested => 'Stake Entsperrung angefragt';

  @override
  String get unlockBeldexWallet => 'Schalten Sie die Beldex-Wallet frei';

  @override
  String get wallet_menu => 'Wallet-Menü';

  @override
  String get your_contributions => 'Deine Anteile';
}
