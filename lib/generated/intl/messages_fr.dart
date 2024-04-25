// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static m0(status) => "${status} blocs restants";

  static m1(status) => "${status} Bloc restant";

  static m2(masterNodeKey) => "Voulez-vous vraiment débloquer votre mise de${masterNodeKey}?";

  static m3(node) => "Voulez-vous vraiment changer le Node actuel vers ${node}?";

  static m4(language) => "Changez la langue en ${language}?";

  static m5(amount, fee) => "Valider la transaction\nMontant: ${amount}\nFee: ${fee}";

  static m6(key) => "Clé ${key} dans le presse-papiers";

  static m7(item, app_store) => "Ne JAMAIS saisir  vos identifiants de votre Wallet Beldex ${item} dans tout logiciel ou site Web autre que les portefeuilles OFFICIELS Beldex téléchargés directement à partir du ${app_store}, le site internet Beldex, ou Beldex sur GitHub.\nÊtes-vous sûr de vouloir accéder à votre portefeuille ${item}?";

  static m8(state_error) => "Échec de l\'authentification. ${state_error}";

  static m9(transactionPriority) => "Les transactions flash sont des transactions instantanées.\nLa priorité ${transactionPriority} est définie comme frais par défaut.";

  static m10(item, appStore) => "Ne saisissez jamais votre portefeuille Beldex ${item} dans un logiciel ou un site Web autre que \\ n les portefeuilles Beldex officiels téléchargés directement depuis l \'${appStore}, \\ n le site Web beldex ou le GitHub beldex.";

  static m11(item) => "Ne donnez JAMAIS votre Wallet Beldex à qui que ce soit! ${item} à qui que ce soit!";

  static m12(recipient_name) => "Vous envoyez de l\'argent à\n${recipient_name}";

  static m13(name) => "Aucun itinéraire défini pour ${name}";

  static m14(transactionPriority) => "${transactionPriority} la priorité est définie comme frais par défaut.\nAccédez au paramètre pour modifier la priorité de la transaction.";

  static m15(title) => "${title} copié dans le presse-papiers";

  static m16(currentVersion) => "Version ${currentVersion}";

  static m17(wallet_name, error) => "Échec du chargement du portefeuille ${wallet_name}. ${error}";

  static m18(wallet_name, error) => "Erreur lors de la suppression ${wallet_name} Wallet. ${error}";

  static m19(wallet_name) => "chargement du ${wallet_name} wallet";

  static m20(wallet_name) => "Wallet ${wallet_name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "Blocks_remaining" : m0,
    "accept" : MessageLookupByLibrary.simpleMessage("J\'accepte"),
    "account" : MessageLookupByLibrary.simpleMessage("Compte"),
    "accountAlreadyExist" : MessageLookupByLibrary.simpleMessage("Le compte existe déja"),
    "accountName" : MessageLookupByLibrary.simpleMessage("Nom du compte"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Comptes"),
    "add" : MessageLookupByLibrary.simpleMessage("Ajouter"),
    "addAccount" : MessageLookupByLibrary.simpleMessage("Ajouter un compte"),
    "addAddress" : MessageLookupByLibrary.simpleMessage("Ajoutez l\'adresse"),
    "addNode" : MessageLookupByLibrary.simpleMessage("Ajouter un nœud"),
    "addSubAddress" : MessageLookupByLibrary.simpleMessage("Ajouter une sous-adresse"),
    "add_new_word" : MessageLookupByLibrary.simpleMessage("Ajouter un nouveau mot"),
    "address_book" : MessageLookupByLibrary.simpleMessage("Carnet d\'adresses"),
    "afterYourFirstTransactionnYouWillBeAbleToView" : MessageLookupByLibrary.simpleMessage("Après votre première transaction,\n  Vous pourrez le voir ici."),
    "alert" : MessageLookupByLibrary.simpleMessage("Alerte"),
    "all" : MessageLookupByLibrary.simpleMessage("TOUT"),
    "allowFaceIdAuthentication" : MessageLookupByLibrary.simpleMessage("Autoriser l\'authentification par identification faciale"),
    "amount" : MessageLookupByLibrary.simpleMessage("Montant: "),
    "amount_detail_detailed" : MessageLookupByLibrary.simpleMessage("4 - Détaillé"),
    "amount_detail_none" : MessageLookupByLibrary.simpleMessage("0 - Aucun"),
    "amount_detail_normal" : MessageLookupByLibrary.simpleMessage("2 - Normal"),
    "amount_detail_ultra" : MessageLookupByLibrary.simpleMessage("9 - Ultra"),
    "appstore" : MessageLookupByLibrary.simpleMessage("AppStore"),
    "areYouSureYouWantToRemoveSelectedContact" : MessageLookupByLibrary.simpleMessage("Êtes-vous sûr de vouloir supprimer le contact sélectionné?"),
    "are_you_sure" : MessageLookupByLibrary.simpleMessage("Es-tu sûr?"),
    "auth_store_ban_timeout" : MessageLookupByLibrary.simpleMessage("Interdire le délai d\'expiration"),
    "auth_store_banned_for" : MessageLookupByLibrary.simpleMessage("Interdit pour "),
    "auth_store_banned_minutes" : MessageLookupByLibrary.simpleMessage(" Protocole"),
    "auth_store_incorrect_password" : MessageLookupByLibrary.simpleMessage("mauvais code PIN"),
    "authenticated" : MessageLookupByLibrary.simpleMessage("Authentifié"),
    "authentication" : MessageLookupByLibrary.simpleMessage("Authentification"),
    "availableBdx" : MessageLookupByLibrary.simpleMessage("BDX disponibles : "),
    "available_balance" : MessageLookupByLibrary.simpleMessage("Solde disponible"),
    "bdx" : MessageLookupByLibrary.simpleMessage("BDX"),
    "beldex_available_balance" : MessageLookupByLibrary.simpleMessage("Beldex solde disponible"),
    "beldex_full_balance" : MessageLookupByLibrary.simpleMessage("Beldex solde complet"),
    "beldex_hidden" : MessageLookupByLibrary.simpleMessage("Beldex caché"),
    "biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside" : MessageLookupByLibrary.simpleMessage("La fonctionnalité biométrique est actuellement désactivée. Veuillez activer la fonctionnalité d\'authentification biométrique dans les paramètres de l\'application."),
    "biometric_auth_reason" : MessageLookupByLibrary.simpleMessage("Scannez votre empreinte digitale pour l\'authentification"),
    "blockRemaining" : m1,
    "bns" : MessageLookupByLibrary.simpleMessage("BNS"),
    "bnsRenewal" : MessageLookupByLibrary.simpleMessage("Renouvellement du BNS"),
    "bnsUpdate" : MessageLookupByLibrary.simpleMessage("Mise à jour du BNS"),
    "body_confirm_unlock_stake" : m2,
    "buyBns" : MessageLookupByLibrary.simpleMessage("Acheter des BNS"),
    "byUsingThisAppYouAgreeToTheTermsOf" : MessageLookupByLibrary.simpleMessage("En utilisant cette application, vous acceptez les termes de l\'accord ci-dessous"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Annuler"),
    "change" : MessageLookupByLibrary.simpleMessage("Changement"),
    "changeWallet" : MessageLookupByLibrary.simpleMessage("Changer de portefeuille"),
    "change_current_node" : m3,
    "change_language" : MessageLookupByLibrary.simpleMessage("changer la langue"),
    "change_language_to" : m4,
    "changelog" : MessageLookupByLibrary.simpleMessage("Journal des modifications"),
    "checking" : MessageLookupByLibrary.simpleMessage("Vérification..."),
    "checkingNodeConnection" : MessageLookupByLibrary.simpleMessage("Vérification de la connexion du nœud..."),
    "chooseLanguage" : MessageLookupByLibrary.simpleMessage("Choisissez la langue"),
    "chooseSeedLanguage" : MessageLookupByLibrary.simpleMessage("Choisissez la langue de départ"),
    "clear" : MessageLookupByLibrary.simpleMessage("clair"),
    "commit_transaction_amount_fee" : m5,
    "committingTheTransaction" : MessageLookupByLibrary.simpleMessage("Validation de la transaction"),
    "confirm" : MessageLookupByLibrary.simpleMessage("confirmer"),
    "confirmYourScreenLockPinpatternAndPassword" : MessageLookupByLibrary.simpleMessage("Confirmez votre code PIN, votre modèle et votre mot de passe de verrouillage d\'écran"),
    "confirm_sending" : MessageLookupByLibrary.simpleMessage("confirmer l\'envoi"),
    "connectionFailed" : MessageLookupByLibrary.simpleMessage("La connexion a échoué"),
    "contact" : MessageLookupByLibrary.simpleMessage("Contact"),
    "contact_name" : MessageLookupByLibrary.simpleMessage("Nom du contact"),
    "continue_text" : MessageLookupByLibrary.simpleMessage("Continuez"),
    "copied" : MessageLookupByLibrary.simpleMessage("Copié"),
    "copied_key_to_clipboard" : m6,
    "copied_to_clipboard" : MessageLookupByLibrary.simpleMessage("Copié dans le presse-papiers"),
    "copy" : MessageLookupByLibrary.simpleMessage("copier"),
    "copyAndSaveTheSeedToContinue" : MessageLookupByLibrary.simpleMessage("Copiez et enregistrez la graine pour continuer"),
    "copySeed" : MessageLookupByLibrary.simpleMessage("Copier la graine"),
    "create_new" : MessageLookupByLibrary.simpleMessage("Créer un nouveau portefeuille"),
    "creatingTheTransaction" : MessageLookupByLibrary.simpleMessage("Création de la transaction"),
    "dangerzone" : MessageLookupByLibrary.simpleMessage("zone de danger"),
    "dangerzone_warning" : m7,
    "dateShouldNotBeEmpty" : MessageLookupByLibrary.simpleMessage("La date ne doit pas être vide"),
    "delete" : MessageLookupByLibrary.simpleMessage("effacer"),
    "digit_pin" : MessageLookupByLibrary.simpleMessage("-chiffre PIN"),
    "doYouWantToChangeYournPrimaryAccount" : MessageLookupByLibrary.simpleMessage("Voulez-vous modifier votre\n compte principal?"),
    "doYouWantToExitTheWallet" : MessageLookupByLibrary.simpleMessage("Voulez-vous sortir du portefeuille?"),
    "doYouWantToReconnectnTheWallet" : MessageLookupByLibrary.simpleMessage("Voulez-vous vous reconnecter\n le porte-feuille?"),
    "do_you_want_to_exit_an_app" : MessageLookupByLibrary.simpleMessage("Voulez-vous quitter une application"),
    "edit" : MessageLookupByLibrary.simpleMessage("Éditer"),
    "enterAValidAddress" : MessageLookupByLibrary.simpleMessage("Entrez une adresse valide"),
    "enterAValidName" : MessageLookupByLibrary.simpleMessage("Entrez un nom valide"),
    "enterAValidNameUpto15Characters" : MessageLookupByLibrary.simpleMessage("Entrez un nom valide jusqu\'à 15 caractères"),
    "enterAValidSubAddress" : MessageLookupByLibrary.simpleMessage("Entrez une sous-adresse valide"),
    "enterAddress" : MessageLookupByLibrary.simpleMessage("Entrer l\'adresse"),
    "enterAmount" : MessageLookupByLibrary.simpleMessage("Entrer le montant"),
    "enterBdxToReceive" : MessageLookupByLibrary.simpleMessage("Entrez BDX pour recevoir"),
    "enterBdxToSend" : MessageLookupByLibrary.simpleMessage("Entrez BDX pour envoyer"),
    "enterName" : MessageLookupByLibrary.simpleMessage("Entrez le nom"),
    "enterPin" : MessageLookupByLibrary.simpleMessage("Entrez le code PIN"),
    "enterValidHeightWithoutSpace" : MessageLookupByLibrary.simpleMessage("Entrez une hauteur valide sans espace"),
    "enterValidNameUpto15Characters" : MessageLookupByLibrary.simpleMessage("Entrez un nom valide jusqu\'à 15 caractères"),
    "enterWalletName" : MessageLookupByLibrary.simpleMessage("Entrez le nom du portefeuille"),
    "enterWalletName_" : MessageLookupByLibrary.simpleMessage("Entrez le nom du portefeuille"),
    "enterYourPin" : MessageLookupByLibrary.simpleMessage("Entrez votre code PIN"),
    "error" : MessageLookupByLibrary.simpleMessage("erreur"),
    "error_text_account_name" : MessageLookupByLibrary.simpleMessage("Le nom du compte ne peut contenir que des lettres et des chiffres\net doit comporter entre 1 et 15 caractères"),
    "error_text_address" : MessageLookupByLibrary.simpleMessage("Invalid BDX address"),
    "error_text_amount" : MessageLookupByLibrary.simpleMessage("Le montant ne peut contenir que des nombres"),
    "error_text_beldex" : MessageLookupByLibrary.simpleMessage("La valeur Beldex ne peut pas dépasser le solde disponible.\nLe nombre de décimales doit être inférieur ou égal à 9"),
    "error_text_contact_name" : MessageLookupByLibrary.simpleMessage("Dans le nom du contact, les symboles ` , \' \" ne doivent pas être inclus\net doit comporter entre 1 et 32 ​​caractères"),
    "error_text_crypto_currency" : MessageLookupByLibrary.simpleMessage("Le nombre de décimales\nm doit être inférieur ou égal à 12."),
    "error_text_fiat" : MessageLookupByLibrary.simpleMessage("La valeur du montant ne peut pas dépasser le solde disponible du compte.\nLe nombre de décimales doit être inférieur ou égal à 2"),
    "error_text_keys" : MessageLookupByLibrary.simpleMessage("Les clés de portefeuille ne peuvent contenir que 64 caractères hexadécimaux"),
    "error_text_node_address" : MessageLookupByLibrary.simpleMessage("Veuillez saisir une adresse iPv4"),
    "error_text_node_port" : MessageLookupByLibrary.simpleMessage("Le port du Node ne peut contenir que des nombres compris entre 0 et 65535"),
    "error_text_payment_id" : MessageLookupByLibrary.simpleMessage("L\'ID de paiement ne peut contenir que 16 à 64 caractères hexadécimaux"),
    "error_text_service_node" : MessageLookupByLibrary.simpleMessage("Une clé de nœud de service ne peut contenir que 64 caractères maximum"),
    "error_text_subaddress_name" : MessageLookupByLibrary.simpleMessage("Au nom de la sous-adresse, les symboles ` , \' \" ne pas être inclus\net doit comporter entre 1 et 20 caractères"),
    "error_text_wallet_name" : MessageLookupByLibrary.simpleMessage("Le nom du portefeuille ne peut contenir que des lettres et des chiffres\net doit comporter entre 1 et 15 caractères"),
    "failed_authentication" : m8,
    "faq" : MessageLookupByLibrary.simpleMessage("FAQ"),
    "fetching" : MessageLookupByLibrary.simpleMessage("Récupération"),
    "filters" : MessageLookupByLibrary.simpleMessage("filtres"),
    "first_wallet_text" : MessageLookupByLibrary.simpleMessage("Super Wallet\npour Beldex"),
    "fiveDecimals" : MessageLookupByLibrary.simpleMessage("5 - Five (0.00000)"),
    "flashTransaction" : MessageLookupByLibrary.simpleMessage("Transaction flash"),
    "flashTransactionPriority" : m9,
    "fourDecimals" : MessageLookupByLibrary.simpleMessage("4 - Four (0.0000)"),
    "full_balance" : MessageLookupByLibrary.simpleMessage("Solde complet"),
    "hidden_balance" : MessageLookupByLibrary.simpleMessage("solde caché"),
    "howCanWenhelpYou" : MessageLookupByLibrary.simpleMessage("Comment pouvons-nous\nT\'aider?"),
    "howeverWeRecommendToScanTheBlockchainFromTheBlock" : MessageLookupByLibrary.simpleMessage("Cependant, nous vous recommandons de scanner la blockchain à partir de la hauteur de bloc à laquelle vous avez créé le portefeuille pour obtenir toutes les transactions et corriger le solde."),
    "iAgreeToTermsOfUse" : MessageLookupByLibrary.simpleMessage("J\'accepte les conditions d\'utilisation"),
    "id" : MessageLookupByLibrary.simpleMessage("ID: "),
    "important" : MessageLookupByLibrary.simpleMessage("IMPORTANTE"),
    "incoming" : MessageLookupByLibrary.simpleMessage("entrant"),
    "incorrect_seed" : MessageLookupByLibrary.simpleMessage("Le texte saisi n\'est pas valide."),
    "initiatingTransactionDescription" : MessageLookupByLibrary.simpleMessage("Veuillez ne pas fermer cette fenêtre ni accéder à une autre application tant que la transaction n\'a pas été initiée."),
    "initiatingTransactionTitle" : MessageLookupByLibrary.simpleMessage("Initier une transaction.."),
    "keys_title" : MessageLookupByLibrary.simpleMessage("Clés"),
    "labelName" : MessageLookupByLibrary.simpleMessage("Nom de l\'étiquette"),
    "legalDisclaimer" : MessageLookupByLibrary.simpleMessage("Avertissement légal"),
    "loadingTheWallet" : MessageLookupByLibrary.simpleMessage("Chargement du portefeuille..."),
    "loadingTheWalletDescription" : MessageLookupByLibrary.simpleMessage("Veuillez ne pas fermer cette fenêtre ni accéder à une autre application tant que nous n\'avons pas chargé le portefeuille."),
    "loading_your_wallet" : MessageLookupByLibrary.simpleMessage("chargement du portefeuille"),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate" : MessageLookupByLibrary.simpleMessage("Assurez-vous de faire une sauvegarde de votre\ngraine de récupération, adresse du portefeuille\net clés privées"),
    "name" : MessageLookupByLibrary.simpleMessage("Nom"),
    "nameShouldNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Le nom ne doit pas être vide"),
    "neverInputYourBeldexWalletItemIntoAnySoftwareOr" : m10,
    "neverShareYourSeedToAnyoneCheckYourSurroundingsTo" : MessageLookupByLibrary.simpleMessage("Ne partagez jamais votre graine avec qui que ce soit! Vérifiez votre environnement pour vous assurer que personne ne vous oublie"),
    "never_give_your" : m11,
    "new_subaddress_create" : MessageLookupByLibrary.simpleMessage("Créer"),
    "new_subaddress_label_name" : MessageLookupByLibrary.simpleMessage("Nom"),
    "new_subaddress_title" : MessageLookupByLibrary.simpleMessage("Nouvelle sous-adresse"),
    "new_wallet" : MessageLookupByLibrary.simpleMessage("Nouveau portefeuille"),
    "no" : MessageLookupByLibrary.simpleMessage("Non"),
    "noAddressesInBook" : MessageLookupByLibrary.simpleMessage("Aucune adresse dans le carnets"),
    "noTransactionsYet" : MessageLookupByLibrary.simpleMessage("Aucune transaction pour l\'instant!"),
    "nodeNameOptional" : MessageLookupByLibrary.simpleMessage("Nom du nœud (facultatif)"),
    "node_address" : MessageLookupByLibrary.simpleMessage("L\'adresse du Node"),
    "node_new" : MessageLookupByLibrary.simpleMessage("Nouveau Node"),
    "node_port" : MessageLookupByLibrary.simpleMessage("Port du Node"),
    "node_reset_settings_title" : MessageLookupByLibrary.simpleMessage("Réinitialiser les paramètres"),
    "nodes" : MessageLookupByLibrary.simpleMessage("Nodes"),
    "nodes_list_reset_to_default_message" : MessageLookupByLibrary.simpleMessage("Êtes-vous sûr de vouloir réinitialiser les paramètres par défaut?"),
    "note" : MessageLookupByLibrary.simpleMessage("Note :"),
    "nothing_staked" : MessageLookupByLibrary.simpleMessage("Aucune contribution pour le moment"),
    "ok" : MessageLookupByLibrary.simpleMessage("Ok"),
    "openalias_alert_content" : m12,
    "openalias_alert_title" : MessageLookupByLibrary.simpleMessage("Beldex-destinataire reconnu"),
    "outgoing" : MessageLookupByLibrary.simpleMessage("sortant"),
    "password" : MessageLookupByLibrary.simpleMessage("Mot de Passe"),
    "passwordOptional" : MessageLookupByLibrary.simpleMessage("Mot de passe (facultatif)"),
    "paste" : MessageLookupByLibrary.simpleMessage("Coller"),
    "pending" : MessageLookupByLibrary.simpleMessage(" (en attente)"),
    "pin_is_incorrect" : MessageLookupByLibrary.simpleMessage("Le code PIN est faux"),
    "playStore" : MessageLookupByLibrary.simpleMessage("Play Store"),
    "pleaseAddAMainnetNode" : MessageLookupByLibrary.simpleMessage("Veuillez ajouter un nœud de réseau principal"),
    "pleaseEnterAAmount" : MessageLookupByLibrary.simpleMessage("Veuillez saisir un montant"),
    "pleaseEnterABdxAddress" : MessageLookupByLibrary.simpleMessage("Veuillez entrer une adresse bdx"),
    "pleaseEnterAValidAmount" : MessageLookupByLibrary.simpleMessage("Veuillez entrer un montant valide"),
    "pleaseEnterAValidSeed" : MessageLookupByLibrary.simpleMessage("Veuillez saisir une graine valide"),
    "please_make_selection" : MessageLookupByLibrary.simpleMessage("Veuillez faire un choix ci-dessous\nCréez ou restaurez votre portefeuille."),
    "please_select" : MessageLookupByLibrary.simpleMessage("Veuillez sélectionner:"),
    "please_try_to_connect_to_another_node" : MessageLookupByLibrary.simpleMessage("veuillez essayer de vous connecter à un autre node"),
    "re_enter_your_pin" : MessageLookupByLibrary.simpleMessage("Entrez à nouveau votre code PIN"),
    "receive" : MessageLookupByLibrary.simpleMessage("recevoir"),
    "receive_amount" : MessageLookupByLibrary.simpleMessage("Montant"),
    "received" : MessageLookupByLibrary.simpleMessage("a reçu"),
    "reconnect" : MessageLookupByLibrary.simpleMessage("se reconnecter"),
    "reconnectWallet" : MessageLookupByLibrary.simpleMessage("Reconnecter le portefeuille"),
    "reconnect_alert_text" : MessageLookupByLibrary.simpleMessage("Voulez-vous vraiment vous reconnecter?"),
    "reconnection" : MessageLookupByLibrary.simpleMessage("reconnexion"),
    "recoverySeed" : MessageLookupByLibrary.simpleMessage("Semence de récupération"),
    "recoverySeedkey" : MessageLookupByLibrary.simpleMessage("Graine/clé de récupération"),
    "reload_fiat" : MessageLookupByLibrary.simpleMessage("Actualiser le taux fiat"),
    "remove" : MessageLookupByLibrary.simpleMessage("supprimer"),
    "removeContact" : MessageLookupByLibrary.simpleMessage("Supprimer contact"),
    "removeWallet" : MessageLookupByLibrary.simpleMessage("Supprimer le portefeuille"),
    "remove_node" : MessageLookupByLibrary.simpleMessage("supprimer le Node"),
    "remove_node_message" : MessageLookupByLibrary.simpleMessage("Vous voulez vraiment supprimer le Node sélectionné?"),
    "rename" : MessageLookupByLibrary.simpleMessage("Renommer"),
    "rescan" : MessageLookupByLibrary.simpleMessage("réanalyser"),
    "rescanWallet" : MessageLookupByLibrary.simpleMessage("Analyser à nouveau le portefeuille"),
    "reset" : MessageLookupByLibrary.simpleMessage("Réinitialiser"),
    "restore_address" : MessageLookupByLibrary.simpleMessage("Adresse"),
    "restore_description_from_backup" : MessageLookupByLibrary.simpleMessage("Vous pouvez restaurer l\'intégralité de l\'application Beldex Wallet à partir de son fichier de sauvegarde."),
    "restore_description_from_keys" : MessageLookupByLibrary.simpleMessage("Utilisez les frappes générées enregistrées à partir de clés privées pour restaurer votre portefeuille"),
    "restore_description_from_seed" : MessageLookupByLibrary.simpleMessage("Utilisez la clé mnémotechnique de 25 mots ou la phrase de départ pour restaurer votre portefeuille."),
    "restore_description_from_seed_keys" : MessageLookupByLibrary.simpleMessage("Restaurez votre portefeuille avec le Seed ou les clées que vous avez conservées dans un endroit sûr"),
    "restore_from_seed_placeholder" : MessageLookupByLibrary.simpleMessage("Veuillez entrer votre code ici"),
    "restore_next" : MessageLookupByLibrary.simpleMessage("Continuer"),
    "restore_recover" : MessageLookupByLibrary.simpleMessage("Restaurer"),
    "restore_restore_wallet" : MessageLookupByLibrary.simpleMessage("Restauration du portefeuille"),
    "restore_seed_keys_restore" : MessageLookupByLibrary.simpleMessage("Restaurer depuis le Seed ou les clés"),
    "restore_spend_key_private" : MessageLookupByLibrary.simpleMessage("Clé de dépense (secret)"),
    "restore_title_from_backup" : MessageLookupByLibrary.simpleMessage("Restaurer à partir d\'un fichier de sauvegarde"),
    "restore_title_from_keys" : MessageLookupByLibrary.simpleMessage("Récupération des clés"),
    "restore_title_from_seed" : MessageLookupByLibrary.simpleMessage("Restaurer à partir du Seed"),
    "restore_title_from_seed_keys" : MessageLookupByLibrary.simpleMessage("Restaurer à partir du seed ou des clés"),
    "restore_view_key_private" : MessageLookupByLibrary.simpleMessage("Clé d\'observation (secret)"),
    "restore_wallet" : MessageLookupByLibrary.simpleMessage("Restaurer un portefeuille"),
    "restore_wallet_name" : MessageLookupByLibrary.simpleMessage("Nom du portefeuille"),
    "restore_wallet_restore_description" : MessageLookupByLibrary.simpleMessage("Description de la restauration du portefeuille"),
    "router_no_route" : m13,
    "save" : MessageLookupByLibrary.simpleMessage("Sauvegarder"),
    "seedKeys" : MessageLookupByLibrary.simpleMessage("Graines et clés"),
    "seed_language_chinese" : MessageLookupByLibrary.simpleMessage("Chinois"),
    "seed_language_choose" : MessageLookupByLibrary.simpleMessage("Veuillez sélectionner la langue source"),
    "seed_language_dutch" : MessageLookupByLibrary.simpleMessage("Néerlandais"),
    "seed_language_english" : MessageLookupByLibrary.simpleMessage("Anglais"),
    "seed_language_french" : MessageLookupByLibrary.simpleMessage("Français"),
    "seed_language_german" : MessageLookupByLibrary.simpleMessage("Allemand"),
    "seed_language_italian" : MessageLookupByLibrary.simpleMessage("Italien"),
    "seed_language_japanese" : MessageLookupByLibrary.simpleMessage("Japonais"),
    "seed_language_next" : MessageLookupByLibrary.simpleMessage("Continuer"),
    "seed_language_portuguese" : MessageLookupByLibrary.simpleMessage("Portugais"),
    "seed_language_russian" : MessageLookupByLibrary.simpleMessage("Russe"),
    "seed_language_spanish" : MessageLookupByLibrary.simpleMessage("Espagnol"),
    "seed_share" : MessageLookupByLibrary.simpleMessage("Partager Seed"),
    "seed_title" : MessageLookupByLibrary.simpleMessage("Seed"),
    "selectAnOptionBelowToCreateOrnRecoverExistingWallet" : MessageLookupByLibrary.simpleMessage("Sélectionnez une option ci-dessous pour créer ou\n  Récupérer le portefeuille existant"),
    "selectLanguage" : MessageLookupByLibrary.simpleMessage("Choisir la langue"),
    "send" : MessageLookupByLibrary.simpleMessage("envoyer"),
    "send_beldex" : MessageLookupByLibrary.simpleMessage("Envoyer Beldex"),
    "send_beldex_address" : MessageLookupByLibrary.simpleMessage("Adresse Beldex ou nom BNS"),
    "send_creating_transaction" : MessageLookupByLibrary.simpleMessage("Créer une transaction"),
    "send_error_currency" : MessageLookupByLibrary.simpleMessage("La devise ne peut contenir que des nombres"),
    "send_estimated_fee" : MessageLookupByLibrary.simpleMessage("Frais estimés:"),
    "send_priority" : m14,
    "send_title" : MessageLookupByLibrary.simpleMessage("Envoyer des"),
    "send_your_wallet" : MessageLookupByLibrary.simpleMessage("Votre portefeuille"),
    "sending" : MessageLookupByLibrary.simpleMessage("Envoyer"),
    "sent" : MessageLookupByLibrary.simpleMessage("expédié"),
    "service_node_key" : MessageLookupByLibrary.simpleMessage("Clé de nœud de service"),
    "settings_all" : MessageLookupByLibrary.simpleMessage("TOUT"),
    "settings_allow_biometric_authentication" : MessageLookupByLibrary.simpleMessage("Authentification biométrique"),
    "settings_balance_detail" : MessageLookupByLibrary.simpleMessage("Décimales"),
    "settings_change_language" : MessageLookupByLibrary.simpleMessage("changer de langue"),
    "settings_change_pin" : MessageLookupByLibrary.simpleMessage("changer le code PIN"),
    "settings_currency" : MessageLookupByLibrary.simpleMessage("Devise"),
    "settings_current_node" : MessageLookupByLibrary.simpleMessage("Node actuel"),
    "settings_dark_mode" : MessageLookupByLibrary.simpleMessage("Mode Sombre"),
    "settings_display_balance_as" : MessageLookupByLibrary.simpleMessage("Afficher la balance comme"),
    "settings_display_on_dashboard_list" : MessageLookupByLibrary.simpleMessage("Afficher dans la liste du tableau de bord"),
    "settings_enable_fiat_currency" : MessageLookupByLibrary.simpleMessage("Convertir la devise en fiat"),
    "settings_fee_priority" : MessageLookupByLibrary.simpleMessage("Priorité des frais"),
    "settings_nodes" : MessageLookupByLibrary.simpleMessage("Node"),
    "settings_none" : MessageLookupByLibrary.simpleMessage("Rien"),
    "settings_personal" : MessageLookupByLibrary.simpleMessage("personnel"),
    "settings_save_recipient_address" : MessageLookupByLibrary.simpleMessage("Enregistrer l\'adresse du destinataire"),
    "settings_support" : MessageLookupByLibrary.simpleMessage("Soutien"),
    "settings_terms_and_conditions" : MessageLookupByLibrary.simpleMessage("Termes et conditions"),
    "settings_title" : MessageLookupByLibrary.simpleMessage("Paramètres"),
    "settings_transactions" : MessageLookupByLibrary.simpleMessage("Transactions"),
    "settings_wallets" : MessageLookupByLibrary.simpleMessage("Portefeuilles"),
    "setup_pin" : MessageLookupByLibrary.simpleMessage("Configurer le code PIN"),
    "setup_successful" : MessageLookupByLibrary.simpleMessage("Votre code PIN a été configuré avec succès!"),
    "shareQr" : MessageLookupByLibrary.simpleMessage("Partager le code QR"),
    "share_address" : MessageLookupByLibrary.simpleMessage("Partager l\'adresse "),
    "show_keys" : MessageLookupByLibrary.simpleMessage("Afficher les clés"),
    "show_seed" : MessageLookupByLibrary.simpleMessage("Afficher le seed"),
    "spend_key_private" : MessageLookupByLibrary.simpleMessage("Clé de dépense (secret)"),
    "spend_key_public" : MessageLookupByLibrary.simpleMessage("Clé de dépense (publique)"),
    "stake_beldex" : MessageLookupByLibrary.simpleMessage("Stake Beldex"),
    "stake_more" : MessageLookupByLibrary.simpleMessage("Staker plus"),
    "start_staking" : MessageLookupByLibrary.simpleMessage("Commencer le staking"),
    "status" : MessageLookupByLibrary.simpleMessage("Statut: "),
    "subAddress" : MessageLookupByLibrary.simpleMessage("Sous-adresse"),
    "subAddresses" : MessageLookupByLibrary.simpleMessage("Sous-adresses"),
    "subaddressAlreadyExist" : MessageLookupByLibrary.simpleMessage("La sous-adresse existe déjà"),
    "subaddress_title" : MessageLookupByLibrary.simpleMessage("Liste des sous-adresses"),
    "subaddresses" : MessageLookupByLibrary.simpleMessage("Sous-adresses"),
    "success" : MessageLookupByLibrary.simpleMessage("Succès"),
    "syncInfo" : MessageLookupByLibrary.simpleMessage("Informations de synchronisation"),
    "sync_status_connected" : MessageLookupByLibrary.simpleMessage("CONNECTÉ"),
    "sync_status_connecting" : MessageLookupByLibrary.simpleMessage("CONNEXION"),
    "sync_status_failed_connect" : MessageLookupByLibrary.simpleMessage("ÉCHEC DE LA CONNEXION AU NODE"),
    "sync_status_not_connected" : MessageLookupByLibrary.simpleMessage("PAS CONNECTÉ"),
    "sync_status_starting_sync" : MessageLookupByLibrary.simpleMessage("DÉBUT DE LA SYNCHRONISATION"),
    "sync_status_synchronized" : MessageLookupByLibrary.simpleMessage("SYNCHRONISÉ"),
    "sync_status_synchronizing" : MessageLookupByLibrary.simpleMessage("SYNCHRONISATION"),
    "test" : MessageLookupByLibrary.simpleMessage("Test"),
    "testResult" : MessageLookupByLibrary.simpleMessage("Résultat du test:"),
    "theAddressAlreadyExist" : MessageLookupByLibrary.simpleMessage("L\'adresse existe déjà"),
    "thisNameAlreadyExist" : MessageLookupByLibrary.simpleMessage("Ce nom existe déjà"),
    "title_confirm_unlock_stake" : MessageLookupByLibrary.simpleMessage("Déverrouiller Stake"),
    "title_new_stake" : MessageLookupByLibrary.simpleMessage("Nouveau Stake"),
    "title_stakes" : MessageLookupByLibrary.simpleMessage("Stakes"),
    "today" : MessageLookupByLibrary.simpleMessage("aujourd\'hui"),
    "touchTheFingerprintSensor" : MessageLookupByLibrary.simpleMessage("Touchez le capteur d\'empreintes digitales"),
    "transactionInitiatedSuccessfully" : MessageLookupByLibrary.simpleMessage("Transaction initiée avec succès"),
    "transaction_details_amount" : MessageLookupByLibrary.simpleMessage("Montant"),
    "transaction_details_copied" : m15,
    "transaction_details_date" : MessageLookupByLibrary.simpleMessage("Date"),
    "transaction_details_height" : MessageLookupByLibrary.simpleMessage("Taille"),
    "transaction_details_recipient_address" : MessageLookupByLibrary.simpleMessage("Adresse du destinataire"),
    "transaction_details_title" : MessageLookupByLibrary.simpleMessage("détails de la transaction"),
    "transaction_details_transaction_id" : MessageLookupByLibrary.simpleMessage("ID Transaction"),
    "transaction_priority_blink" : MessageLookupByLibrary.simpleMessage("Flash"),
    "transaction_priority_slow" : MessageLookupByLibrary.simpleMessage("Lente"),
    "transaction_sent" : MessageLookupByLibrary.simpleMessage("Transaction envoyé!"),
    "transactions" : MessageLookupByLibrary.simpleMessage("transactions"),
    "transactions_by_date" : MessageLookupByLibrary.simpleMessage("transactions par date"),
    "transferYourBdxMoreFasternWithFlashTransaction" : MessageLookupByLibrary.simpleMessage("Transférez votre BDX plus rapidement\n  avec Transaction Flash!"),
    "twoDecimals" : MessageLookupByLibrary.simpleMessage("2 - Two (0.00)"),
    "unable_unlock_stake" : MessageLookupByLibrary.simpleMessage("Impossible de déverrouiller le Stake"),
    "unlockBeldexWallet" : MessageLookupByLibrary.simpleMessage("Déverrouiller le portefeuille Beldex"),
    "unlock_stake_requested" : MessageLookupByLibrary.simpleMessage("Déverrouillage du Stake demandé"),
    "use" : MessageLookupByLibrary.simpleMessage("Basculer vers "),
    "usePattern" : MessageLookupByLibrary.simpleMessage("UTILISER LE MODÈLE"),
    "userNameOptional" : MessageLookupByLibrary.simpleMessage("Nom d\'utilisateur (facultatif)"),
    "version" : m16,
    "view_key_private" : MessageLookupByLibrary.simpleMessage("Clé d\'observation (secret)"),
    "view_key_public" : MessageLookupByLibrary.simpleMessage("Clé d\'observation (publique)"),
    "wallet" : MessageLookupByLibrary.simpleMessage("Portefeuille"),
    "walletAddress" : MessageLookupByLibrary.simpleMessage("Adresse du portefeuille"),
    "walletRestore" : MessageLookupByLibrary.simpleMessage("Restauration du portefeuille"),
    "walletSettings" : MessageLookupByLibrary.simpleMessage("Paramètres du portefeuille"),
    "wallet_keys" : MessageLookupByLibrary.simpleMessage("Clés du portefeuille"),
    "wallet_list_create_new_wallet" : MessageLookupByLibrary.simpleMessage("Créer un nouveau portefeuille"),
    "wallet_list_failed_to_load" : m17,
    "wallet_list_failed_to_remove" : m18,
    "wallet_list_load_wallet" : MessageLookupByLibrary.simpleMessage("Charger le portefeuille"),
    "wallet_list_loading_wallet" : m19,
    "wallet_list_removing_wallet" : m20,
    "wallet_list_restore_wallet" : MessageLookupByLibrary.simpleMessage("Restaurer le portefeuille"),
    "wallet_list_title" : MessageLookupByLibrary.simpleMessage("Beldex Wallet"),
    "wallet_menu" : MessageLookupByLibrary.simpleMessage("Menu du portefeuille"),
    "wallet_name" : MessageLookupByLibrary.simpleMessage("Nom du portefeuille"),
    "wallet_restoration_store_incorrect_seed_length" : MessageLookupByLibrary.simpleMessage("mauvaise longueur du Seed"),
    "wallets" : MessageLookupByLibrary.simpleMessage("Wallets"),
    "welcome" : MessageLookupByLibrary.simpleMessage("Bienvenu sur\nBeldex WALLET"),
    "welcomeToBeldexWallet" : MessageLookupByLibrary.simpleMessage("Bienvenue sur le portefeuille Beldex :)"),
    "widgets_address" : MessageLookupByLibrary.simpleMessage("Adresse"),
    "widgets_or" : MessageLookupByLibrary.simpleMessage("ou"),
    "widgets_restore_from_blockheight" : MessageLookupByLibrary.simpleMessage("restaurer à partir du blockheight"),
    "widgets_restore_from_date" : MessageLookupByLibrary.simpleMessage("Restaurer à partir de la date"),
    "widgets_seed" : MessageLookupByLibrary.simpleMessage("Seed"),
    "yes" : MessageLookupByLibrary.simpleMessage("Oui"),
    "yes_im_sure" : MessageLookupByLibrary.simpleMessage("Oui, je suis sûr!"),
    "yesterday" : MessageLookupByLibrary.simpleMessage("hier"),
    "youAreAboutToDeletenYourWallet" : MessageLookupByLibrary.simpleMessage("Vous êtes sur le point de supprimer\n ton portefeuille!"),
    "youCantViewTheSeedBecauseYouveRestoredUsingKeys" : MessageLookupByLibrary.simpleMessage("Vous ne pouvez pas afficher la graine, car vous avez effectué une restauration à l\'aide de clés"),
    "youDontHaveEnoughUnlockedBalance" : MessageLookupByLibrary.simpleMessage("Vous n\'avez pas suffisamment de solde débloqué"),
    "youHaveScannedFromTheBlockHeight" : MessageLookupByLibrary.simpleMessage("Vous avez scanné à partir de la hauteur du bloc"),
    "your_contributions" : MessageLookupByLibrary.simpleMessage("Vos contributions"),
    "zeroDecimal" : MessageLookupByLibrary.simpleMessage("0 - Zero (000)")
  };
}
