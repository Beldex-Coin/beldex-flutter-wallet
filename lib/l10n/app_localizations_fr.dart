// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get unsupportedExchangePair => 'Paire d\'échange non prise en charge';

  @override
  String get account => 'Compte';

  @override
  String get accountAlreadyExist => 'Le compte existe déja';

  @override
  String get accountName => 'Nom du compte';

  @override
  String get accounts => 'Comptes';

  @override
  String get add => 'Ajouter';

  @override
  String get addAccount => 'Ajouter un compte';

  @override
  String get addAddress => 'Ajoutez l\'adresse';

  @override
  String get addBns => 'Ajouter BNS';

  @override
  String get addNode => 'Ajouter un nœud';

  @override
  String get address_book => 'Carnet d\'adresses';

  @override
  String get addressShouldNotBeEmpty => 'L\'adresse ne doit pas être vide';

  @override
  String get addSubAddress => 'Ajouter une sous-adresse';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'Après votre première transaction,\n  Vous pourrez le voir ici.';

  @override
  String get alert => 'Alerte';

  @override
  String get allowFaceIdAuthentication => 'Autoriser l’authentification avec Face ID';

  @override
  String get amount => 'Montant: ';

  @override
  String get amountReceived => 'Montant reçu';

  @override
  String get appstore => 'AppStore';

  @override
  String get are_you_sure => 'Es-tu sûr?';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => 'Êtes-vous sûr de vouloir supprimer le contact sélectionné?';

  @override
  String get auth_store_banned_for => 'Banni pour';

  @override
  String get auth_store_banned_minutes => 'minutes';

  @override
  String get auth_store_incorrect_password => 'Code PIN incorrect';

  @override
  String get authenticated => 'Authentifié';

  @override
  String get available_balance => 'Solde disponible';

  @override
  String get availableBdx => 'BDX disponibles : ';

  @override
  String get bdx => 'BDX';

  @override
  String get biometric_auth_reason => 'Scannez votre empreinte digitale pour vous authentifier';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'La fonctionnalité biométrique est actuellement désactivée. Veuillez activer la fonctionnalité d\'authentification biométrique dans les paramètres de l\'application.';

  @override
  String blockConfirmed(Object count) {
    return '$count Bloc';
  }

  @override
  String blockRemaining(Object status) {
    return '$status bloc restant';
  }

  @override
  String blocksConfirmed(Object count) {
    return '$count Blocs';
  }

  @override
  String blocksRemaining(Object status) {
    return '$status blocs restants';
  }

  @override
  String get bns => 'BNS';

  @override
  String get bnsAddRecord => 'Ajouter un enregistrement';

  @override
  String get bnsBackupOwner => 'Propriétaire de sauvegarde';

  @override
  String get bnsBchatId => 'ID BChat';

  @override
  String get bnsBelnetId => 'ID Belnet';

  @override
  String get bnsConfirmPurchase => 'Confirmer l\'achat';

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return 'Échec du déchiffrement de l’enregistrement BNS de $bnsName';
  }

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return 'Enregistrement BNS de $bnsName déchiffré avec succès';
  }

  @override
  String get bnsEncryptedBchatValue => 'Valeur BChat chiffrée';

  @override
  String get bnsEncryptedBelnetValue => 'Valeur Belnet chiffrée';

  @override
  String get bnsEncryptedEthValue => 'Valeur ETH chiffrée';

  @override
  String get bnsEncryptedWalletValue => 'Valeur de portefeuille chiffrée';

  @override
  String get bnsEnterValidWalletAddress => 'Veuillez saisir une adresse de portefeuille valide.';

  @override
  String get bnsEthAddress => 'Adresse ETH';

  @override
  String get bnsEthAddressDescription => 'Notre adresse ETH est compatible avec toutes les chaînes EVM';

  @override
  String get bnsExpirationHeight => 'Hauteur d\'expiration';

  @override
  String get bnsFetchingRecords => 'Récupération des enregistrements BNS depuis le réseau...';

  @override
  String get bnsInvalidBchatId => 'ID BChat invalide';

  @override
  String get bnsInvalidBelnetId => 'ID Belnet invalide';

  @override
  String get bnsInvalidEthAddress => 'Adresse ETH invalide';

  @override
  String get bnsInvalidName => 'Nom BNS invalide';

  @override
  String get bnsInvalidOwnerAddress => 'Adresse du propriétaire invalide.';

  @override
  String get bnsInvalidWalletAddress => 'Adresse de portefeuille invalide. Laissez ce champ vide si vous souhaitez utiliser le portefeuille actuel comme propriétaire du BNS.';

  @override
  String get bnsNameHint => 'Le nom à acheter via le service de noms Beldex';

  @override
  String get bnsNameIsTaken => 'Le nom BNS est déjà utilisé. Choisissez-en un autre.';

  @override
  String get bnsNewOwnerHint => 'Entrez l\'adresse du portefeuille du nouveau propriétaire';

  @override
  String get bnsNoteLabel => 'Remarque : ';

  @override
  String get bnsOwnerAndBackupDifferent => 'L’adresse du propriétaire et l’adresse de sauvegarde doivent être différentes.';

  @override
  String get bnsOwnerHint => 'L\'adresse du portefeuille du propriétaire';

  @override
  String get bnsOwnerLabel => 'Propriétaire';

  @override
  String get bnsOwnerOptional => 'Propriétaire (facultatif)';

  @override
  String get bnsPleaseFillField => 'Veuillez remplir ce champ';

  @override
  String get bnsPrice => 'Prix';

  @override
  String get bnsPurchase => 'Acheter';

  @override
  String get bnsPurchaseDescription => 'Achetez ou mettez à jour un enregistrement BNS. Si vous achetez un nom, il peut falloir une minute ou deux avant qu\'il n\'apparaisse dans la liste';

  @override
  String get bnsPurchasedSuccessfully => 'BNS acheté avec succès';

  @override
  String get bnsRecordNameHint => 'Un nom BNS qui vous appartient';

  @override
  String get bnsRecordNotFound => 'L’enregistrement BNS indiqué n’existe pas ou n’appartient pas à ce portefeuille.';

  @override
  String get bnsRecords => 'Enregistrements BNS';

  @override
  String get bnsRecordsDescription => 'Vous trouverez ici tous les noms BNS appartenant à ce portefeuille. Le décryptage d\'un enregistrement que vous possédez renverra le nom et la valeur de l\'enregistrement BNS.';

  @override
  String get bnsRenewAction => 'Renouveler';

  @override
  String get bnsRenewal => 'Renouvellement de BNS';

  @override
  String get bnsUpdate => 'Mise à jour du BNS';

  @override
  String get bnsUpdateAction => 'Mettre à jour';

  @override
  String get bnsUpdateHeight => 'Hauteur de mise à jour';

  @override
  String get bnsUpdateNote => 'Vous ne pouvez mettre à jour l\'adresse du propriétaire ou les valeurs qu\'un seul à la fois. Si vous souhaitez mettre à jour les deux, vous pouvez d\'abord mettre à jour la valeur avant le transfert de propriété ou après.';

  @override
  String get bnsUpdateOwner => 'Mettre à jour le propriétaire';

  @override
  String get bnsUpdateValues => 'Mettre à jour les valeurs';

  @override
  String get bnsYearFiveShort => '5 ans';

  @override
  String get bnsYearLabel => 'Année';

  @override
  String get bnsYearOneShort => '1 an';

  @override
  String get bnsYearTenShort => '10 ans';

  @override
  String get bnsYearTwoShort => '2 ans';

  @override
  String get bnsYouSave => 'Vous économisez ';

  @override
  String get buyBns => 'Acheter des BNS';

  @override
  String get cancel => 'Annuler';

  @override
  String change_current_node(Object node) {
    return 'Êtes-vous sûr de vouloir remplacer le nœud actuel par $node ?';
  }

  @override
  String get change_language => 'changer la langue';

  @override
  String get changelog => 'Journal des modifications';

  @override
  String get changeWallet => 'Changer de portefeuille';

  @override
  String get chooseLanguage => 'Choisissez la langue';

  @override
  String get chooseSeedLanguage => 'Choisissez la langue de départ';

  @override
  String get clear => 'clair';

  @override
  String get confirm_sending => 'confirmer l\'envoi';

  @override
  String get continue_text => 'Continuez';

  @override
  String get copied => 'Copié';

  @override
  String get copyAndSaveTheSeedToContinue => 'Copiez et enregistrez la graine pour continuer';

  @override
  String get copySeed => 'Copier la graine';

  @override
  String get create_new => 'Créer un nouveau portefeuille';

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'N’ENTREZ JAMAIS le $item de votre portefeuille Beldex dans un logiciel ou un site web autre que les portefeuilles Beldex OFFICIELS téléchargés directement depuis $app_store, le site web de Beldex ou le GitHub de Beldex. Êtes-vous sûr de vouloir accéder à votre portefeuille $item ?';
  }

  @override
  String get date => 'Date';

  @override
  String get dateShouldNotBeEmpty => 'La date ne doit pas être vide';

  @override
  String get delete => 'effacer';

  @override
  String get doYouWantToChangeYournPrimaryAccount => 'Voulez-vous modifier votre\n compte principal?';

  @override
  String get doYouWantToExitTheWallet => 'Voulez-vous sortir du portefeuille?';

  @override
  String get doYouWantToReconnectnTheWallet => 'Voulez-vous vous reconnecter\n le porte-feuille?';

  @override
  String get edit => 'Éditer';

  @override
  String get enterAddress => 'Entrer l\'adresse';

  @override
  String get enterAmount => 'Entrer le montant';

  @override
  String get enterAValidName => 'Entrez un nom valide';

  @override
  String get enterAValidNameUpto15Characters => 'Entrez un nom valide jusqu\'à 15 caractères';

  @override
  String get enterAValidNameUpto20Characters => 'Entrez un nom valide jusqu\'à 20 caractères';

  @override
  String get enterAValidSubAddress => 'Entrez une sous-adresse valide';

  @override
  String get enterBdxToReceive => 'Entrez BDX pour recevoir';

  @override
  String get enterBdxToSend => 'Entrez BDX pour envoyer';

  @override
  String get enterName => 'Entrez le nom';

  @override
  String get enterPin => 'Entrez le code PIN';

  @override
  String get enterValidHeightWithoutSpace => 'Entrez une hauteur valide sans espace';

  @override
  String get enterValidNameUpto15Characters => 'Entrez un nom valide jusqu\'à 15 caractères';

  @override
  String get enterWalletName => 'Entrez le nom du portefeuille';

  @override
  String get enterWalletName_ => 'Entrez le nom du portefeuille';

  @override
  String get enterYourPin => 'Entrez votre code PIN';

  @override
  String get error_text_address => 'Invalid BDX address';

  @override
  String get error_text_contact_name => 'Dans le nom du contact, les symboles ` , \' \" ne doivent pas être inclus\net doit comporter entre 1 et 32 ​​caractères';

  @override
  String get error_text_keys => 'Les clés de portefeuille ne peuvent contenir que 64 caractères hexadécimaux';

  @override
  String get error_text_node_address => 'Veuillez saisir une adresse iPv4';

  @override
  String get error_text_node_port => 'Le port du Node ne peut contenir que des nombres compris entre 0 et 65535';

  @override
  String get exchange => 'Échanger';

  @override
  String get exchangeRate => 'Taux de change';

  @override
  String get expandDetails => 'Voir plus de détails';

  @override
  String failed_authentication(Object state_error) {
    return 'Échec de l\'authentification. $state_error';
  }

  @override
  String get faq => 'FAQ';

  @override
  String get fee => 'Frais';

  @override
  String get filters => 'Filtrer par';

  @override
  String get fiveDecimals => '5 - Five (0.00000)';

  @override
  String get flashTransaction => 'Transaction flash';

  @override
  String get floatingExchangeRate => 'Taux de change flottant';

  @override
  String get floatingRateDescription => 'Le taux flottant peut changer à tout moment en raison des conditions du marché, vous pourriez recevoir plus ou moins de crypto que prévu.';

  @override
  String get fourDecimals => '4 - Four (0.0000)';

  @override
  String get full_balance => 'Solde complet';

  @override
  String get hidden_balance => 'solde caché';

  @override
  String get howCanWenhelpYou => 'Comment pouvons-nous\nT\'aider?';

  @override
  String get incoming => 'entrant';

  @override
  String get initiatingTransactionDescription => 'Veuillez ne pas fermer cette fenêtre ni accéder à une autre application tant que la transaction n\'a pas été initiée.';

  @override
  String get initiatingTransactionTitle => 'Initier une transaction..';

  @override
  String get labelName => 'Nom de l\'étiquette';

  @override
  String get legalDisclaimer => 'Avertissement légal';

  @override
  String get loadingTheWallet => 'Chargement du portefeuille...';

  @override
  String get loadingTheWalletDescription => 'Veuillez ne pas fermer cette fenêtre ni accéder à une autre application tant que nous n\'avons pas chargé le portefeuille.';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => 'Assurez-vous de faire une sauvegarde de votre\ngraine de récupération, adresse du portefeuille\net clés privées';

  @override
  String get max => 'Max.';

  @override
  String get maximumAmount => 'Montant maximum est ';

  @override
  String get minimumAmount => 'Montant minimum est ';

  @override
  String get myBns => 'Mon BNS';

  @override
  String get name => 'Nom';

  @override
  String get nameShouldNotBeEmpty => 'Le nom ne doit pas être vide';

  @override
  String get network_fee => 'Frais de réseau';

  @override
  String get networkErrorCheckConnection => 'Erreur réseau ! Veuillez vérifier votre connexion Internet.';

  @override
  String never_give_your(Object item) {
    return 'Ne donnez jamais votre $item de portefeuille Beldex à qui que ce soit !';
  }

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Ne saisissez jamais le $item de votre portefeuille Beldex dans un logiciel ou un site web autre que les portefeuilles officiels Beldex téléchargés directement depuis $appStore, le site web de Beldex ou le GitHub de Beldex.';
  }

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'Ne partagez jamais votre graine avec qui que ce soit! Vérifiez votre environnement pour vous assurer que personne ne vous oublie';

  @override
  String get new_subaddress_create => 'Créer';

  @override
  String get new_wallet => 'Nouveau portefeuille';

  @override
  String get no => 'Non';

  @override
  String get noAddressesInBook => 'Aucune adresse dans le carnets';

  @override
  String get node_address => 'L\'adresse du Node';

  @override
  String get node_port => 'Port du Node';

  @override
  String get node_reset_settings_title => 'Réinitialiser les paramètres';

  @override
  String get nodeAlreadyExists => 'Ce nœud existe déjà';

  @override
  String get nodeNameOptional => 'Nom du nœud (facultatif)';

  @override
  String get nodes => 'Nodes';

  @override
  String get nodes_list_reset_to_default_message => 'Êtes-vous sûr de vouloir réinitialiser les paramètres par défaut?';

  @override
  String get noInternet => 'Pas d\'Internet !';

  @override
  String get noInternetMessage => 'Vérifiez votre connexion Internet\net réessayez.';

  @override
  String get note => 'Note :';

  @override
  String get noTransactionsMessage => 'Il n\'y a pas de transactions ou\nd\'échanges à afficher..';

  @override
  String get noTransactionsYet => 'Pas de transactions pour le moment !';

  @override
  String get ok => 'Ok';

  @override
  String get outgoing => 'sortant';

  @override
  String get passwordOptional => 'Mot de passe (facultatif)';

  @override
  String get paste => 'Coller';

  @override
  String get pin_is_incorrect => 'Le code PIN est faux';

  @override
  String get playStore => 'Play Store';

  @override
  String get please_try_to_connect_to_another_node => 'veuillez essayer de vous connecter à un autre node';

  @override
  String get pleaseEnterAAmount => 'Veuillez saisir un montant';

  @override
  String get pleaseEnterABdxAddress => 'Veuillez entrer une adresse bdx';

  @override
  String get pleaseEnterAValidAmount => 'Veuillez entrer un montant valide';

  @override
  String get pleaseEnterAValidSeed => 'Veuillez saisir une graine valide';

  @override
  String get re_enter_your_pin => 'Entrez à nouveau votre code PIN';

  @override
  String get receive => 'recevoir';

  @override
  String get receiver => 'Récepteur';

  @override
  String get reconnect => 'se reconnecter';

  @override
  String get reconnectWallet => 'Reconnecter le portefeuille';

  @override
  String get recoverySeed => 'Semence de récupération';

  @override
  String get recoverySeedkey => 'Graine/clé de récupération';

  @override
  String get removeContact => 'Supprimer contact';

  @override
  String get removeWallet => 'Supprimer le portefeuille';

  @override
  String get rescan => 'réanalyser';

  @override
  String get rescanWallet => 'Analyser à nouveau le portefeuille';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get restore_address => 'Adresse';

  @override
  String get restore_description_from_keys => 'Utilisez les frappes générées enregistrées à partir de clés privées pour restaurer votre portefeuille';

  @override
  String get restore_description_from_seed => 'Utilisez la clé mnémotechnique de 25 mots ou la phrase de départ pour restaurer votre portefeuille.';

  @override
  String get restore_description_from_seed_keys => 'Restaurez votre portefeuille avec le Seed ou les clées que vous avez conservées dans un endroit sûr';

  @override
  String get restore_from_seed_placeholder => 'Veuillez entrer votre code ici';

  @override
  String get restore_next => 'Continuer';

  @override
  String get restore_recover => 'Restaurer';

  @override
  String get restore_restore_wallet => 'Restaurer le portefeuille';

  @override
  String get restore_title_from_keys => 'Récupération des clés';

  @override
  String get restore_title_from_seed => 'Restaurer à partir du Seed';

  @override
  String get restore_title_from_seed_keys => 'Restaurer à partir du seed ou des clés';

  @override
  String get restore_wallet => 'Restaurer un portefeuille';

  @override
  String get restoredViaKeys => 'Vous avez restauré via les clés';

  @override
  String get save => 'Sauvegarder';

  @override
  String get searchCoins => 'Rechercher des coins';

  @override
  String get searchCurrency => 'Rechercher une devise';

  @override
  String get seed_title => 'Graine';

  @override
  String get seedKeys => 'Graines et clés';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'Sélectionnez une option ci-dessous pour créer ou\n  Récupérer le portefeuille existant';

  @override
  String get selectLanguage => 'Sélectionner la langue';

  @override
  String get send => 'envoyer';

  @override
  String get send_beldex_address => 'Adresse Beldex ou nom BNS';

  @override
  String get send_estimated_fee => 'Frais estimés:';

  @override
  String send_priority(Object transactionPriority) {
    return '$transactionPriority la priorité est définie comme frais par défaut.\nAccédez au paramètre pour modifier la priorité de la transaction.';
  }

  @override
  String get sent => 'expédié';

  @override
  String get service_fee => 'Frais de service 0,25 %';

  @override
  String get settings_allow_biometric_authentication => 'Authentification biométrique';

  @override
  String get settings_balance_detail => 'Décimales';

  @override
  String get settings_change_pin => 'changer le code PIN';

  @override
  String get settings_currency => 'Devise';

  @override
  String get settings_current_node => 'Node actuel';

  @override
  String get settings_dark_mode => 'Mode Sombre';

  @override
  String get settings_display_balance_as => 'Afficher la balance comme';

  @override
  String get settings_enable_fiat_currency => 'Convertir la devise en fiat';

  @override
  String get settings_fee_priority => 'Priorité des frais';

  @override
  String get settings_personal => 'personnel';

  @override
  String get settings_save_recipient_address => 'Enregistrer l\'adresse du destinataire';

  @override
  String get settings_support => 'Soutien';

  @override
  String get settings_terms_and_conditions => 'Termes et conditions';

  @override
  String get settings_title => 'Paramètres';

  @override
  String get setup_pin => 'Configurer le code PIN';

  @override
  String get setup_successful => 'Votre code PIN a été configuré avec succès!';

  @override
  String get shareQr => 'Partager le code QR';

  @override
  String get show_keys => 'Afficher les clés';

  @override
  String get show_seed => 'Afficher le seed';

  @override
  String get spend_key_private => 'Clé de dépense (secret)';

  @override
  String get spend_key_public => 'Clé de dépense (publique)';

  @override
  String get status => 'Statut: ';

  @override
  String get subAddress => 'Sous-adresse';

  @override
  String get subaddressAlreadyExist => 'La sous-adresse existe déjà';

  @override
  String get swap => 'Échanger';

  @override
  String get swap_amount_from => 'Montant de';

  @override
  String get swap_amount_sent => 'Montant envoyé';

  @override
  String get swap_amount_to => 'Montant vers';

  @override
  String get swap_and => ' et ';

  @override
  String get swap_checkout => 'Paiement';

  @override
  String get swap_completed => 'Terminé';

  @override
  String get swap_confirm_and_make_payment => 'Confirmer et effectuer le paiement';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return 'Veuillez vous assurer de saisir l’adresse correcte pour la chaîne sélectionnée - $blockchain. Sinon, vous perdrez vos fonds.';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return 'Saisissez l’adresse du destinataire de $currency';
  }

  @override
  String get swap_exchange_rate => 'Taux de change';

  @override
  String get swap_failed => 'Échoué';

  @override
  String get swap_funds_not_received => 'Les fonds n\'ont pas été reçus dans les 3 heures. Veuillez vérifier les taux et créer une nouvelle transaction';

  @override
  String get swap_i_agree_with => 'J’accepte';

  @override
  String get swap_input_hash => 'Hash d\'entrée';

  @override
  String get swap_input_output_hash => 'Hachage d\'entrée/sortie';

  @override
  String get swap_network_fee => 'Frais de réseau';

  @override
  String get swap_network_label => 'RÉSEAU : ';

  @override
  String get swap_new_transaction => 'Nouvelle transaction';

  @override
  String get swap_open_history => 'Historique ouvert';

  @override
  String get swap_output_hash => 'Hash de sortie';

  @override
  String get swap_privacy_policy => 'Politique de confidentialité';

  @override
  String get swap_received_time => 'Heure reçue';

  @override
  String get swap_send_funds_notice => 'Vous avez 3 heures pour envoyer les fonds, sinon la transaction sera annulée automatiquement.\n\nL\'échange commencera une fois les fonds reçus.';

  @override
  String get swap_send_funds_to_address_below => 'Envoyez les fonds à l\'adresse ci-dessous';

  @override
  String get swap_service_fee => 'Frais de service 0,25 %';

  @override
  String get swap_start_over => 'Recommencer';

  @override
  String get swap_terms_of_use => 'Conditions d\'utilisation';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return 'Temps restant pour envoyer $amount $currency';
  }

  @override
  String swap_time_remaining(Object value) {
    return 'Temps restant : $value';
  }

  @override
  String get swap_transaction_preview => 'Aperçu de la transaction';

  @override
  String get swap_you_get => 'Vous recevez';

  @override
  String get swapNotAvailable => ' Le swap n\'est pas disponible\npour le moment';

  @override
  String get sync_status_connecting => 'CONNEXION';

  @override
  String get sync_status_failed_connect => 'ÉCHEC DE LA CONNEXION AU NODE';

  @override
  String get sync_status_starting_sync => 'DÉBUT DE LA SYNCHRONISATION';

  @override
  String get sync_status_synchronized => 'SYNCHRONISÉ';

  @override
  String get sync_status_synchronizing => 'SYNCHRONISATION';

  @override
  String get test => 'Test';

  @override
  String get testResult => 'Résultat du test:';

  @override
  String get theAddressAlreadyExist => 'L\'adresse existe déjà';

  @override
  String get thisNameAlreadyExist => 'Ce nom existe déjà';

  @override
  String get transaction_details_amount => 'Montant';

  @override
  String get transaction_details_height => 'Taille';

  @override
  String get transaction_details_recipient_address => 'Adresse du destinataire';

  @override
  String get transaction_details_transaction_id => 'ID Transaction';

  @override
  String get transaction_priority_blink => 'Flash';

  @override
  String get transaction_priority_slow => 'Lente';

  @override
  String get transactionInitiatedSuccessfully => 'Transaction initiée avec succès';

  @override
  String get transactions => 'transactions';

  @override
  String get transactions_by_date => 'transactions par date';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => 'Transférez votre BDX plus rapidement avec\n Transaction Flash!';

  @override
  String get tryAgain => 'Veuillez réessayer après quelques instants.';

  @override
  String get twoDecimals => '2 - Two (0.00)';

  @override
  String get usePattern => 'UTILISER LE SCHÉMA';

  @override
  String get userNameOptional => 'Nom d\'utilisateur (facultatif)';

  @override
  String version(Object currentVersion) {
    return 'Version $currentVersion';
  }

  @override
  String get view => 'Voir';

  @override
  String get view_key_private => 'Clé d\'observation (secret)';

  @override
  String get view_key_public => 'Clé d\'observation (publique)';

  @override
  String get wallet => 'Portefeuille';

  @override
  String get wallet_keys => 'Clés du portefeuille';

  @override
  String wallet_list_failed_to_load(Object error, Object wallet_name) {
    return 'Échec du chargement du portefeuille $wallet_name. $error';
  }

  @override
  String wallet_list_failed_to_remove(Object error, Object wallet_name) {
    return 'Échec de la suppression du portefeuille $wallet_name. $error';
  }

  @override
  String get wallet_list_load_wallet => 'Charger le portefeuille';

  @override
  String wallet_list_loading_wallet(Object wallet_name) {
    return 'Chargement du portefeuille $wallet_name';
  }

  @override
  String wallet_list_removing_wallet(Object wallet_name) {
    return 'Suppression du portefeuille $wallet_name';
  }

  @override
  String get wallet_list_title => 'Beldex Wallet';

  @override
  String get wallet_name => 'Nom du portefeuille';

  @override
  String get wallet_restoration_store_incorrect_seed_length => 'Longueur de la graine incorrecte';

  @override
  String get walletAddress => 'Adresse du portefeuille';

  @override
  String walletAlreadyExists(Object name) {
    return 'Un portefeuille nommé $name existe déjà !';
  }

  @override
  String get walletRestore => 'Restauration du portefeuille';

  @override
  String get wallets => 'Wallets';

  @override
  String get walletSettings => 'Paramètres du portefeuille';

  @override
  String get welcomeToBeldexWallet => 'Bienvenue sur le portefeuille Beldex :)';

  @override
  String get widgets_restore_from_blockheight => 'restaurer à partir du blockheight';

  @override
  String get widgets_restore_from_date => 'Restaurer à partir de la date';

  @override
  String get yes => 'Oui';

  @override
  String get yes_im_sure => 'Oui, je suis sûr!';

  @override
  String get yesterday => 'hier';

  @override
  String get youAreAboutToDeletenYourWallet => 'Vous êtes sur le point de supprimer\n ton portefeuille!';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => 'Vous ne pouvez pas afficher la graine, car vous avez effectué une restauration à l\'aide de clés';

  @override
  String get youGet => 'Vous recevez';

  @override
  String get youSend => 'Vous envoyez';

  @override
  String get zeroDecimal => '0 - Zero (000)';

  @override
  String changePinLength(Object value) {
    return 'Basculer vers $value-chiffre PIN';
  }

  @override
  String get pleaseEnterAValidHeight => 'Veuillez saisir une hauteur valide';

  @override
  String get invalidAddress => 'Adresse invalide';

  @override
  String get exchangePair => 'Paire d\'échange';

  @override
  String get payment => 'Paiement';

  @override
  String get bnsConfirmUpdate => 'Confirmer la mise à jour';

  @override
  String get bnsRenewedSuccessfully => 'BNS renouvelé avec succès';

  @override
  String get bnsSameBchatId => 'Même identifiant BChat';

  @override
  String get bnsSameBelnetId => 'Même identifiant BelNet';

  @override
  String get bnsSameEthAddress => 'Même adresse ETH';

  @override
  String get bnsSameOwnerAddress => 'Même adresse du propriétaire';

  @override
  String get bnsSameWalletAddress => 'Même adresse de portefeuille';

  @override
  String get bnsUpdatedSuccessfully => 'BNS mis à jour avec succès';

  @override
  String get bnsWaitForFetch => 'Veuillez patienter pendant que nous récupérons l’enregistrement BNS depuis le réseau';

  @override
  String get bnsYearFive => '5 ans';

  @override
  String get bnsYearOne => '1 an';

  @override
  String get bnsYearTen => '10 ans';

  @override
  String get bnsYearTwo => '2 ans';

  @override
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return 'Voulez-vous vraiment déverrouiller votre mise de $masterNodeKey ?';
  }

  @override
  String get checking => 'Vérification...';

  @override
  String get checkingNodeConnection => 'Vérification de la connexion du nœud...';

  @override
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return 'Valider la transaction\nMontant: $amount\nFee: $fee';
  }

  @override
  String get committingTheTransaction => 'Validation de la transaction';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => 'Confirmez votre code PIN, votre modèle et votre mot de passe de verrouillage d\'écran';

  @override
  String get connectionFailed => 'Échec de la connexion';

  @override
  String get do_you_want_to_exit_an_app => 'Voulez-vous quitter une application';

  @override
  String get enterAValidAddress => 'Entrez une adresse valide';

  @override
  String get error => 'Erreur';

  @override
  String get error_text_beldex => 'La valeur Beldex ne peut pas dépasser le solde disponible.\nLe nombre de décimales doit être inférieur ou égal à 9';

  @override
  String get error_text_fiat => 'La valeur du montant ne peut pas dépasser le solde disponible du compte.\nLe nombre de décimales doit être inférieur ou égal à 2';

  @override
  String get error_text_service_node => 'Une clé de nœud de service ne peut contenir que 64 caractères maximum';

  @override
  String get exchangeAmount => 'Montant de l\'échange';

  @override
  String get failedToGetOutputDistribution => 'Échec de l\'obtention de la distribution de sortie';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return 'Les transactions flash sont des transactions instantanées.\nLa priorité $transactionPriority est définie comme frais par défaut.';
  }

  @override
  String get important => 'IMPORTANT';

  @override
  String get keys_title => 'Clés';

  @override
  String get noPendingTransaction => 'Aucune transaction en attente';

  @override
  String get nothing_staked => 'Aucune contribution pour le moment';

  @override
  String openalias_alert_content(Object recipient_name) {
    return 'Vous envoyez de l\'argent à\n$recipient_name';
  }

  @override
  String get openalias_alert_title => 'Beldex-destinataire reconnu';

  @override
  String get pending => ' (en attente)';

  @override
  String get please_select => 'Veuillez sélectionner:';

  @override
  String get pleaseAddAMainnetNode => 'Veuillez ajouter un nœud de réseau principal';

  @override
  String get received => 'Reçu';

  @override
  String get reconnect_alert_text => 'Voulez-vous vraiment vous reconnecter?';

  @override
  String get reconnection => 'reconnexion';

  @override
  String get remove_node => 'supprimer le Node';

  @override
  String get remove_node_message => 'Vous voulez vraiment supprimer le Node sélectionné?';

  @override
  String get rename => 'Renommer';

  @override
  String router_no_route(Object name) {
    return 'Aucun itinéraire défini pour $name';
  }

  @override
  String get seed_language_chinese => 'Chinois';

  @override
  String get seed_language_dutch => 'Néerlandais';

  @override
  String get seed_language_english => 'Anglais';

  @override
  String get seed_language_french => 'Français';

  @override
  String get seed_language_german => 'Allemand';

  @override
  String get seed_language_italian => 'Italien';

  @override
  String get seed_language_japanese => 'Japonais';

  @override
  String get seed_language_portuguese => 'Portugais';

  @override
  String get seed_language_russian => 'Russe';

  @override
  String get seed_language_spanish => 'Espagnol';

  @override
  String get seed_share => 'Partager Seed';

  @override
  String get send_your_wallet => 'Votre portefeuille';

  @override
  String get sending => 'Envoyer';

  @override
  String get service_node_key => 'Clé de nœud de service';

  @override
  String get settings_none => 'Rien';

  @override
  String get stake_beldex => 'Stake Beldex';

  @override
  String get stake_more => 'Staker plus';

  @override
  String get start_staking => 'Commencer le staking';

  @override
  String get subaddress_title => 'Liste des sous-adresses';

  @override
  String get subAddresses => 'Sous-adresses';

  @override
  String get success => 'Succès';

  @override
  String get swap_confirmations => 'Confirmations';

  @override
  String get swap_confirmed => 'Confirmé';

  @override
  String swap_confirmed_in_blockchain(Object currencyFrom, Object currencyTo) {
    return 'Une fois $currencyFrom confirmé dans la blockchain, nous commencerons à l\'échanger contre $currencyTo';
  }

  @override
  String get swap_confirming_in_progress => 'Confirmation en cours';

  @override
  String swap_done_exchanging(Object currencyFrom, Object currencyTo) {
    return 'Échange terminé de $currencyFrom vers $currencyTo';
  }

  @override
  String swap_enter_extra_id(Object extraIdName) {
    return 'Saisissez $extraIdName';
  }

  @override
  String swap_enter_refund_address(Object currency) {
    return 'Saisissez l\'adresse de remboursement $currency';
  }

  @override
  String get swap_estimated_time => 'Temps estimé';

  @override
  String get swap_estimated_time_value => '5-30 min';

  @override
  String swap_exchange_address(Object currency, Object exchangeName) {
    return 'Adresse $exchangeName ($currency)';
  }

  @override
  String get swap_exchanging => 'Échange en cours';

  @override
  String swap_exchanging_currency(Object currencyFrom, Object currencyTo) {
    return 'Échange de $currencyFrom vers $currencyTo';
  }

  @override
  String get swap_expired => 'Expiré';

  @override
  String swap_extra_id_info(Object currency, Object extraIdName) {
    return 'Veuillez préciser le $extraIdName de votre adresse de réception $currency si votre portefeuille le fournit. Votre transaction ne passera pas si vous l\'omettez. Si votre portefeuille n\'a pas besoin de $extraIdName, désactivez la case.';
  }

  @override
  String get swap_funds_sent_to_wallet => 'Fonds envoyés vers votre portefeuille';

  @override
  String get swap_history => 'historique';

  @override
  String get swap_maximum_amount_changed => 'Le montant maximum a changé, la nouvelle valeur est ';

  @override
  String get swap_minimum_amount_changed => 'Le montant minimum a changé, la nouvelle valeur est ';

  @override
  String swap_my_wallet_requires_extra_id(Object extraIdName) {
    return 'Mon portefeuille nécessite $extraIdName';
  }

  @override
  String get swap_overdue => 'En retard';

  @override
  String swap_please_enter_extra_id(Object extraIdName) {
    return 'Veuillez saisir $extraIdName';
  }

  @override
  String get swap_process_wait => 'Le processus prendra quelques minutes. Veuillez patienter.';

  @override
  String swap_recipient_address_with_currency(Object currency) {
    return 'Adresse du destinataire ($currency)';
  }

  @override
  String get swap_refund_address => 'Adresse de remboursement';

  @override
  String get swap_refund_wallet_address => 'Adresse du portefeuille de remboursement';

  @override
  String get swap_see_input_hash_in_explorer => 'Voir le hash d\'entrée dans l\'explorateur';

  @override
  String get swap_sending_funds_to_wallet => 'Envoi des fonds vers votre portefeuille';

  @override
  String get swap_you_can_initiate_new_transaction => 'Vous pouvez lancer une nouvelle transaction. Vous pouvez toujours vérifier l\'état de cette transaction dans l\'historique ';

  @override
  String get swap_you_dont_have_to_wait_here => 'Vous n\'avez pas besoin d\'attendre ici';

  @override
  String get swap_you_sent => 'Vous avez envoyé';

  @override
  String get swapTransactionReport => 'Beldex_wallet_swap_transaction_report';

  @override
  String get sync_status_connected => 'CONNECTÉ';

  @override
  String get sync_status_not_connected => 'PAS CONNECTÉ';

  @override
  String get syncInfo => 'Informations de synchronisation';

  @override
  String get title_confirm_unlock_stake => 'Déverrouiller Stake';

  @override
  String get title_new_stake => 'Nouveau Stake';

  @override
  String get title_stakes => 'Stakes';

  @override
  String get today => 'aujourd\'hui';

  @override
  String get touchTheFingerprintSensor => 'Touchez le capteur d\'empreintes digitales';

  @override
  String transaction_details_copied(Object title) {
    return '$title copié dans le presse-papiers';
  }

  @override
  String get transaction_details_payment_id => 'ID de paiement';

  @override
  String get transaction_details_title => 'détails de la transaction';

  @override
  String get transaction_sent => 'Transaction envoyé!';

  @override
  String get transactionReport => 'Rapport de transaction';

  @override
  String get unable_unlock_stake => 'Impossible de déverrouiller le Stake';

  @override
  String get unlock_stake_requested => 'Déverrouillage du Stake demandé';

  @override
  String get unlockBeldexWallet => 'Déverrouiller le portefeuille Beldex';

  @override
  String get wallet_menu => 'Menu du portefeuille';

  @override
  String get your_contributions => 'Vos contributions';
}
