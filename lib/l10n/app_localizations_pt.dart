// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get unsupportedExchangePair => 'Par de troca não suportado';

  @override
  String get account => 'Conta';

  @override
  String get accountAlreadyExist => 'A conta já existe';

  @override
  String get accountName => 'Nome da conta';

  @override
  String get accounts => 'Contas';

  @override
  String get add => 'Adicionar';

  @override
  String get addAccount => 'Adicionar conta';

  @override
  String get addAddress => 'Adicionar endereço';

  @override
  String get addBns => 'Adicionar BNS';

  @override
  String get addNode => 'Adicionar nó';

  @override
  String get address_book => 'Catálogo de Endereços';

  @override
  String get addressShouldNotBeEmpty => 'O endereço não pode estar vazio';

  @override
  String get addSubAddress => 'Adicionar Subendereço';

  @override
  String get afterYourFirstTransactionnYouWillBeAbleToView => 'Após sua primeira transação, você poderá\n visualizá-la aqui.';

  @override
  String get alert => 'Alerta';

  @override
  String get allowFaceIdAuthentication => 'Permitir autenticação com Face ID';

  @override
  String get amount => 'Valor';

  @override
  String get amountReceived => 'Valor recebido';

  @override
  String get appstore => 'AppStore';

  @override
  String get are_you_sure => 'Tem certeza?';

  @override
  String get areYouSureYouWantToRemoveSelectedContact => 'Tem certeza de que deseja remover o contato selecionado?';

  @override
  String get auth_store_banned_for => 'Banido por';

  @override
  String get auth_store_banned_minutes => 'minutos';

  @override
  String get auth_store_incorrect_password => 'PIN incorreto';

  @override
  String get authenticated => 'Autenticado';

  @override
  String get available_balance => 'Saldo disponível';

  @override
  String get availableBdx => 'BDX disponível :';

  @override
  String get bdx => 'BDX';

  @override
  String get biometric_auth_reason => 'Digitalize sua impressão digital para autenticar';

  @override
  String get biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside => 'Recurso biométrico atualmente desativado.\n Por favor, ative a autenticação biométrica\n nas configurações do aplicativo';

  @override
  String blockConfirmed(Object count) {
    return '$count bloco';
  }

  @override
  String blockRemaining(Object status) {
    return 'Resta $status bloco';
  }

  @override
  String blocksConfirmed(Object count) {
    return '$count blocos';
  }

  @override
  String blocksRemaining(Object status) {
    return 'Restam $status blocos';
  }

  @override
  String get bns => 'BNS';

  @override
  String get bnsAddRecord => 'Adicionar registro';

  @override
  String get bnsBackupOwner => 'Proprietário de backup';

  @override
  String get bnsBchatId => 'ID do BChat';

  @override
  String get bnsBelnetId => 'ID do Belnet';

  @override
  String get bnsConfirmPurchase => 'Confirmar compra';

  @override
  String bnsDecryptionFailure(Object bnsName) {
    return 'Falha ao descriptografar o registro BNS de $bnsName';
  }

  @override
  String bnsDecryptionSuccess(Object bnsName) {
    return 'Registro BNS de $bnsName descriptografado com sucesso';
  }

  @override
  String get bnsEncryptedBchatValue => 'Valor BChat criptografado';

  @override
  String get bnsEncryptedBelnetValue => 'Valor Belnet criptografado';

  @override
  String get bnsEncryptedEthValue => 'Valor ETH criptografado';

  @override
  String get bnsEncryptedWalletValue => 'Valor de carteira criptografado';

  @override
  String get bnsEnterValidWalletAddress => 'Insira um endereço de carteira válido.';

  @override
  String get bnsEthAddress => 'Endereço ETH';

  @override
  String get bnsEthAddressDescription => 'Nosso endereço ETH é compatível\n com todas as redes EVM';

  @override
  String get bnsExpirationHeight => 'Altura de expiração';

  @override
  String get bnsFetchingRecords => 'Buscando registro BNS na rede';

  @override
  String get bnsInvalidBchatId => 'ID do BChat inválido';

  @override
  String get bnsInvalidBelnetId => 'ID do Belnet inválido';

  @override
  String get bnsInvalidEthAddress => 'Endereço ETH inválido';

  @override
  String get bnsInvalidName => 'Nome BNS inválido';

  @override
  String get bnsInvalidOwnerAddress => 'Endereço do proprietário inválido.';

  @override
  String get bnsInvalidWalletAddress => 'Endereço da carteira inválido. Deixe em branco se quiser usar a carteira atual como proprietária do BNS.';

  @override
  String get bnsNameHint => 'O nome a ser adquirido via Beldex Name Service';

  @override
  String get bnsNameIsTaken => 'O nome BNS já está em uso. Escolha outro.';

  @override
  String get bnsNewOwnerHint => 'Insira o endereço da carteira do novo proprietário';

  @override
  String get bnsNoteLabel => 'Nota: Nosso endereço ETH é compatível\n com todas as redes EVM';

  @override
  String get bnsOwnerAndBackupDifferent => 'O endereço do proprietário e o endereço de backup devem ser diferentes.';

  @override
  String get bnsOwnerHint => 'O endereço da carteira do proprietário';

  @override
  String get bnsOwnerLabel => 'Proprietário';

  @override
  String get bnsOwnerOptional => 'Proprietário (Opcional)';

  @override
  String get bnsPleaseFillField => 'Por favor, preencha este campo';

  @override
  String get bnsPrice => 'Preço do';

  @override
  String get bnsPurchase => 'Comprar';

  @override
  String get bnsPurchaseDescription => 'Comprar ou atualizar um registro BNS.\n Se você comprar um nome, pode levar\n um ou dois minutos para aparecer na lista.';

  @override
  String get bnsPurchasedSuccessfully => 'BNS comprado com sucesso';

  @override
  String get bnsRecordNameHint => 'Um nome BNS que pertence a você';

  @override
  String get bnsRecordNotFound => 'O registro BNS informado não existe ou não pertence a esta carteira.';

  @override
  String get bnsRecords => 'Registros BNS';

  @override
  String get bnsRecordsDescription => 'Aqui você pode encontrar todos os nomes BNS pertencentes a esta carteira. Ao descriptografar um registro que você possui, será retornado o nome e o valor do registro BNS.';

  @override
  String get bnsRenewAction => 'Renovar';

  @override
  String get bnsRenewal => 'Renovação do BNS';

  @override
  String get bnsUpdate => 'Atualização BNS';

  @override
  String get bnsUpdateAction => 'Atualizar';

  @override
  String get bnsUpdateHeight => 'Altura de atualização';

  @override
  String get bnsUpdateNote => 'Você só pode atualizar o endereço do proprietário ou os valores por vez.\n Se quiser atualizar ambos, você pode atualizar os valores antes da transferência de propriedade ou após transferir a propriedade.';

  @override
  String get bnsUpdateOwner => 'Atualizar Proprietário';

  @override
  String get bnsUpdateValues => 'Atualizar Valores';

  @override
  String get bnsYearFiveShort => '5 anos';

  @override
  String get bnsYearLabel => 'Ano';

  @override
  String get bnsYearOneShort => '1 ano';

  @override
  String get bnsYearTenShort => '10 anos';

  @override
  String get bnsYearTwoShort => '2 anos';

  @override
  String get bnsYouSave => 'Você economiza';

  @override
  String get buyBns => 'Comprar BNS';

  @override
  String get cancel => 'Cancelar';

  @override
  String change_current_node(Object node) {
    return 'Tem certeza de que deseja alterar o nó atual para $node?';
  }

  @override
  String get change_language => 'Alterar idioma';

  @override
  String get changelog => 'Registro de alterações';

  @override
  String get changeWallet => 'Alterar carteira';

  @override
  String get chooseLanguage => 'Escolher idioma';

  @override
  String get chooseSeedLanguage => 'Escolha o idioma da seed';

  @override
  String get clear => 'Limpar';

  @override
  String get confirm_sending => 'Confirmar envio';

  @override
  String get continue_text => 'Continuar';

  @override
  String get copied => 'Copiado';

  @override
  String get copyAndSaveTheSeedToContinue => 'Copie e salve a seed para continuar';

  @override
  String get copySeed => 'Copiar seed';

  @override
  String get create_new => 'Criar nova carteira';

  @override
  String dangerzone_warning(Object app_store, Object item) {
    return 'NUNCA insira o $item da sua carteira Beldex em qualquer software ou site que não sejam as carteiras Beldex OFICIAIS baixadas diretamente da $app_store, do site da Beldex ou do GitHub da Beldex. Tem certeza de que deseja acessar sua carteira $item?';
  }

  @override
  String get date => 'Data';

  @override
  String get dateShouldNotBeEmpty => 'A data não deve estar vazia';

  @override
  String get delete => 'Excluir';

  @override
  String get doYouWantToChangeYournPrimaryAccount => 'Deseja alterar sua conta principal?';

  @override
  String get doYouWantToExitTheWallet => 'Você deseja sair da carteira?';

  @override
  String get doYouWantToReconnectnTheWallet => 'Você deseja reconectar a carteira?';

  @override
  String get edit => 'Editar';

  @override
  String get enterAddress => 'Inserir endereço';

  @override
  String get enterAmount => 'Digite o valor';

  @override
  String get enterAValidName => 'Insira um nome válido';

  @override
  String get enterAValidNameUpto15Characters => 'Insira um nome válido com até 15 caracteres';

  @override
  String get enterAValidNameUpto20Characters => 'Insira um nome válido com até 20 caracteres';

  @override
  String get enterAValidSubAddress => 'Insira um subendereço válido';

  @override
  String get enterBdxToReceive => 'Digite o BDX para receber';

  @override
  String get enterBdxToSend => 'Digite o BDX para enviar';

  @override
  String get enterName => 'Inserir nome';

  @override
  String get enterPin => 'Inserir PIN';

  @override
  String get enterValidHeightWithoutSpace => 'Digite um blockheight válido sem espaços';

  @override
  String get enterValidNameUpto15Characters => 'Digite um nome válido com até 15 caracteres';

  @override
  String get enterWalletName => 'Digite o nome da carteira';

  @override
  String get enterWalletName_ => 'Digite o nome da carteira';

  @override
  String get enterYourPin => 'Digite o seu PIN';

  @override
  String get error_text_address => 'Endereço BDX inválido';

  @override
  String get error_text_contact_name => 'O nome do contato não pode conter os símbolos \' ou \" e deve ter entre 1 e 32 caracteres';

  @override
  String get error_text_keys => 'As chaves da carteira devem conter apenas 64 caracteres em hexadecimal';

  @override
  String get error_text_node_address => 'Por favor, insira um endereço IPv4 válido';

  @override
  String get error_text_node_port => 'A porta do nó pode conter apenas números entre 0 e 65535';

  @override
  String get exchange => 'Trocar';

  @override
  String get exchangeRate => 'Taxa de câmbio';

  @override
  String get expandDetails => 'Expandir detalhes';

  @override
  String failed_authentication(Object state_error) {
    return 'Falha na autenticação. $state_error';
  }

  @override
  String get faq => 'FAQ';

  @override
  String get fee => 'Taxa';

  @override
  String get filters => 'Filtrar po';

  @override
  String get fiveDecimals => '5 - Cinco (0.00000)';

  @override
  String get flashTransaction => 'Transação Flash';

  @override
  String get floatingExchangeRate => 'Taxa de câmbio flutuante';

  @override
  String get floatingRateDescription => 'A taxa flutuante pode mudar a qualquer momento devido às condições do mercado, então você pode receber mais ou menos cripto do que o esperado.';

  @override
  String get fourDecimals => '4 - Quatro (0.0000)';

  @override
  String get full_balance => 'Saldo total';

  @override
  String get hidden_balance => 'Saldo oculto';

  @override
  String get howCanWenhelpYou => 'Como podemos ajudar você?';

  @override
  String get incoming => 'Entrada';

  @override
  String get initiatingTransactionDescription => 'Por favor, não feche esta janela nem navegue para outro aplicativo até que a transação seja iniciada';

  @override
  String get initiatingTransactionTitle => 'Iniciando transação..';

  @override
  String get labelName => 'Nome do rótulo';

  @override
  String get legalDisclaimer => 'Aviso Lega';

  @override
  String get loadingTheWallet => 'Carregando a carteira…';

  @override
  String get loadingTheWalletDescription => 'Por favor, não feche esta janela nem\n navegue para outro aplicativo até que\n a carteira seja carregada';

  @override
  String get makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate => 'Certifique-se de fazer backup da sua\n seed de recuperação, endereço da carteira\n e chaves privadas';

  @override
  String get max => 'Máx.';

  @override
  String get maximumAmount => 'O valor máximo é';

  @override
  String get minimumAmount => 'O valor mínimo é';

  @override
  String get myBns => 'Meu BNS';

  @override
  String get name => 'Nome';

  @override
  String get nameShouldNotBeEmpty => 'O nome não pode estar vazio';

  @override
  String get network_fee => 'Taxa de rede';

  @override
  String get networkErrorCheckConnection => 'Erro de rede! Por favor, verifique sua conexão com a internet.';

  @override
  String never_give_your(Object item) {
    return 'Nunca forneça o $item da sua carteira Beldex a ninguém!';
  }

  @override
  String neverInputYourBeldexWalletItemIntoAnySoftwareOr(Object appStore, Object item) {
    return 'Nunca insira o $item da sua carteira Beldex em qualquer software ou site que não sejam as carteiras oficiais Beldex baixadas diretamente da $appStore, do site da Beldex ou do GitHub da Beldex.';
  }

  @override
  String get neverShareYourSeedToAnyoneCheckYourSurroundingsTo => 'Nunca compartilhe sua seed com ninguém! Verifique ao seu redor para garantir que ninguém esteja olhando';

  @override
  String get new_subaddress_create => 'Criar';

  @override
  String get new_wallet => 'Nova carteira';

  @override
  String get no => 'Não';

  @override
  String get noAddressesInBook => 'Nenhum endereço no catálogo';

  @override
  String get node_address => 'Endereço do nó';

  @override
  String get node_port => 'Porta do nó';

  @override
  String get node_reset_settings_title => 'Redefinir configurações';

  @override
  String get nodeAlreadyExists => 'Este nó já existe';

  @override
  String get nodeNameOptional => 'Nome do nó (opcional)';

  @override
  String get nodes => 'Nós';

  @override
  String get nodes_list_reset_to_default_message => 'Tem certeza de que deseja redefinir as configurações\n para o padrão?';

  @override
  String get noInternet => 'Sem internet!';

  @override
  String get noInternetMessage => 'Por favor, verifique sua conexão com a internet e tente novamente.';

  @override
  String get note => 'Nota:';

  @override
  String get noTransactionsMessage => 'Não há transações ou trocas para mostrar.';

  @override
  String get noTransactionsYet => 'Ainda não há transações!';

  @override
  String get ok => 'Ok';

  @override
  String get outgoing => 'Saída';

  @override
  String get passwordOptional => 'Senha (opcional)';

  @override
  String get paste => 'Colar';

  @override
  String get pin_is_incorrect => 'PIN incorreto';

  @override
  String get playStore => 'Play Store';

  @override
  String get please_try_to_connect_to_another_node => 'Por favor, tente conectar a outro nó';

  @override
  String get pleaseEnterAAmount => 'Por favor, insira um valor';

  @override
  String get pleaseEnterABdxAddress => 'Por favor, insira um endereço BDX';

  @override
  String get pleaseEnterAValidAmount => 'Por favor, insira um valor válido';

  @override
  String get pleaseEnterAValidSeed => 'Por favor, insira uma seed válida';

  @override
  String get re_enter_your_pin => 'Digite novamente o seu PIN';

  @override
  String get receive => 'Receber';

  @override
  String get receiver => 'Destinatário';

  @override
  String get reconnect => 'Reconectar';

  @override
  String get reconnectWallet => 'Reconectar Carteira';

  @override
  String get recoverySeed => 'Seed de recuperação';

  @override
  String get recoverySeedkey => 'Seed/chave de recuperação';

  @override
  String get removeContact => 'Remover contato';

  @override
  String get removeWallet => 'Remover carteira';

  @override
  String get rescan => 'Reescanear';

  @override
  String get rescanWallet => 'Reescanear Carteira';

  @override
  String get reset => 'Redefinir';

  @override
  String get restore_address => 'Endereço';

  @override
  String get restore_description_from_keys => 'Use as sequências de teclas geradas a partir das chaves privadas para restaurar sua carteira';

  @override
  String get restore_description_from_seed => 'Use a chave mnemônica de 25 palavras ou frase seed para restaurar sua carteira.';

  @override
  String get restore_description_from_seed_keys => 'Recupere sua carteira usando a seed/chaves que você salvou em um local seguro';

  @override
  String get restore_from_seed_placeholder => 'Por favor, insira ou cole sua seed aqui';

  @override
  String get restore_next => 'Próximo';

  @override
  String get restore_recover => 'Restaurar';

  @override
  String get restore_restore_wallet => 'Restaurar carteira';

  @override
  String get restore_title_from_keys => 'Restaurar a partir das chaves';

  @override
  String get restore_title_from_seed => 'Restaurar a partir da seed';

  @override
  String get restore_title_from_seed_keys => 'Restaurar a partir da seed/chaves';

  @override
  String get restore_wallet => 'Usar carteira existente';

  @override
  String get restoredViaKeys => 'Você restaurou via chaves';

  @override
  String get save => 'Salvar';

  @override
  String get searchCoins => 'Buscar moedas';

  @override
  String get searchCurrency => 'Pesquisar moeda';

  @override
  String get seed_title => 'Seed';

  @override
  String get seedKeys => 'Seed e chaves';

  @override
  String get selectAnOptionBelowToCreateOrnRecoverExistingWallet => 'Selecione uma opção para criar ou recuperar uma carteira existente';

  @override
  String get selectLanguage => 'Selecionar idioma';

  @override
  String get send => 'Enviar';

  @override
  String get send_beldex_address => 'Endereço Beldex ou nome BNS';

  @override
  String get send_estimated_fee => 'Taxa estimada:';

  @override
  String send_priority(Object transactionPriority) {
    return 'A prioridade $transactionPriority está definida como a taxa padrão. Acesse as configurações para alterar a prioridade da transação.';
  }

  @override
  String get sent => 'Enviado';

  @override
  String get service_fee => 'Taxa de serviço 0,25%';

  @override
  String get settings_allow_biometric_authentication => 'Permitir autenticação biométrica';

  @override
  String get settings_balance_detail => 'Decimais';

  @override
  String get settings_change_pin => 'Alterar PIN';

  @override
  String get settings_currency => 'Moeda';

  @override
  String get settings_current_node => 'Nó atual';

  @override
  String get settings_dark_mode => 'Modo escuro';

  @override
  String get settings_display_balance_as => 'Exibir saldo como';

  @override
  String get settings_enable_fiat_currency => 'Ativar conversão para moeda fiduciária';

  @override
  String get settings_fee_priority => 'Prioridade de taxa';

  @override
  String get settings_personal => 'Pessoal';

  @override
  String get settings_save_recipient_address => 'Salvar endereço do destinatário';

  @override
  String get settings_support => 'Suporte';

  @override
  String get settings_terms_and_conditions => 'Termos e Condiçõe';

  @override
  String get settings_title => 'Configurações';

  @override
  String get setup_pin => 'Configurar PIN';

  @override
  String get setup_successful => 'Seu PIN foi configurado com sucesso!';

  @override
  String get shareQr => 'Compartilhar QR';

  @override
  String get show_keys => 'Mostrar chaves';

  @override
  String get show_seed => 'Mostrar seed';

  @override
  String get spend_key_private => 'Chave de Gasto';

  @override
  String get spend_key_public => 'Chave de gasto (pública)';

  @override
  String get status => 'Status:';

  @override
  String get subAddress => 'Subendereço';

  @override
  String get subaddressAlreadyExist => 'Subendereço já existe';

  @override
  String get swap => 'Trocar';

  @override
  String get swap_amount_from => 'Valor de';

  @override
  String get swap_amount_sent => 'Valor enviado';

  @override
  String get swap_amount_to => 'Valor para';

  @override
  String get swap_and => 'e';

  @override
  String get swap_checkout => 'Finalizar compra';

  @override
  String get swap_completed => 'Concluído';

  @override
  String get swap_confirm_and_make_payment => 'Confirmar e realizar pagamento';

  @override
  String swap_correct_chain_address(Object blockchain) {
    return 'Certifique-se de inserir o endereço correto para a rede selecionada - $blockchain. Caso contrário, você perderá seus fundos.';
  }

  @override
  String swap_enter_recipient_address(Object currency) {
    return 'Insira o endereço do destinatário de $currency';
  }

  @override
  String get swap_exchange_rate => 'Taxa de câmbio';

  @override
  String get swap_failed => 'Falhou';

  @override
  String get swap_funds_not_received => 'Os fundos não foram recebidos dentro de 3\nhoras. Por favor, verifique as taxas e crie\numa nova transação';

  @override
  String get swap_i_agree_with => 'Eu concordo com';

  @override
  String get swap_input_hash => 'Hash de entrada';

  @override
  String get swap_input_output_hash => 'Hash de entrada/saída';

  @override
  String get swap_network_fee => 'Taxa de rede';

  @override
  String get swap_network_label => 'REDE: ';

  @override
  String get swap_new_transaction => 'Nova transação';

  @override
  String get swap_open_history => 'Abrir histórico';

  @override
  String get swap_output_hash => 'Hash de saída';

  @override
  String get swap_privacy_policy => 'Política de privacidade';

  @override
  String get swap_received_time => 'Hora de recebimento';

  @override
  String get swap_send_funds_notice => 'Você tem 3 horas para enviar os fundos,\ncaso contrário, a transação será\ncancelada automaticamente.\nA troca será iniciada assim que\nos fundos forem recebidos.';

  @override
  String get swap_send_funds_to_address_below => 'Envie os fundos para o endereço abaixo';

  @override
  String get swap_service_fee => 'Taxa de serviço 0,25%';

  @override
  String get swap_start_over => 'Começar novamente';

  @override
  String get swap_terms_of_use => 'Termos de uso';

  @override
  String swap_time_left_to_send(Object amount, Object currency) {
    return 'Tempo restante para enviar $amount $currency';
  }

  @override
  String swap_time_remaining(Object value) {
    return 'Tempo restante: $value';
  }

  @override
  String get swap_transaction_preview => 'Pré-visualização da transação';

  @override
  String get swap_you_get => 'Você recebe';

  @override
  String get swapNotAvailable => 'O BDX Swap não está disponível no momento.';

  @override
  String get sync_status_connecting => 'Conectando';

  @override
  String get sync_status_failed_connect => 'Falha ao conectar ao nó';

  @override
  String get sync_status_starting_sync => 'Iniciando sincronização';

  @override
  String get sync_status_synchronized => 'SINCRONIZADO';

  @override
  String get sync_status_synchronizing => 'SINCRONIZANDO';

  @override
  String get test => 'Testar';

  @override
  String get testResult => 'Resultado do teste:';

  @override
  String get theAddressAlreadyExist => 'O endereço já existe';

  @override
  String get thisNameAlreadyExist => 'Este nome já existe';

  @override
  String get transaction_details_amount => 'Valor';

  @override
  String get transaction_details_height => 'Altura';

  @override
  String get transaction_details_recipient_address => 'Endereço do destinatário';

  @override
  String get transaction_details_transaction_id => 'ID da transação';

  @override
  String get transaction_priority_blink => 'Flash';

  @override
  String get transaction_priority_slow => 'Lenta';

  @override
  String get transactionInitiatedSuccessfully => 'Transação iniciada com sucesso';

  @override
  String get transactions => 'Transações';

  @override
  String get transactions_by_date => 'Transações por data';

  @override
  String get transferYourBdxMoreFasternWithFlashTransaction => 'Transfira seu BDX mais rápido com Transação Flash!';

  @override
  String get tryAgain => 'Por favor, tente novamente mais tarde.';

  @override
  String get twoDecimals => '2 - Dois (0.00)';

  @override
  String get usePattern => 'USAR PADRÃO';

  @override
  String get userNameOptional => 'Nome de usuário (opcional)';

  @override
  String version(Object currentVersion) {
    return 'Versão $currentVersion';
  }

  @override
  String get view => 'Visualizar';

  @override
  String get view_key_private => 'Chave de Visualização (privada)';

  @override
  String get view_key_public => 'Ver chave (pública)';

  @override
  String get wallet => 'Carteira';

  @override
  String get wallet_keys => 'Chaves da carteira';

  @override
  String wallet_list_failed_to_load(Object error, Object wallet_name) {
    return 'Falha ao carregar a carteira $wallet_name. $error';
  }

  @override
  String wallet_list_failed_to_remove(Object error, Object wallet_name) {
    return 'Falha ao remover a carteira $wallet_name. $error';
  }

  @override
  String get wallet_list_load_wallet => 'Carregar carteira';

  @override
  String wallet_list_loading_wallet(Object wallet_name) {
    return 'Carregando a carteira $wallet_name';
  }

  @override
  String wallet_list_removing_wallet(Object wallet_name) {
    return 'Removendo a carteira $wallet_name';
  }

  @override
  String get wallet_list_title => 'Carteira Beldex';

  @override
  String get wallet_name => 'Nome da carteira';

  @override
  String get wallet_restoration_store_incorrect_seed_length => 'Comprimento do seed incorreto';

  @override
  String get walletAddress => 'Endereço da Carteira';

  @override
  String walletAlreadyExists(Object name) {
    return 'Já existe uma carteira com o nome $name!';
  }

  @override
  String get walletRestore => 'Restauração da carteira';

  @override
  String get wallets => 'Carteiras';

  @override
  String get walletSettings => 'Configurações da carteira';

  @override
  String get welcomeToBeldexWallet => 'Bem-vindo à Carteira Beldex :)';

  @override
  String get widgets_restore_from_blockheight => 'Restaurar a partir do blockheight';

  @override
  String get widgets_restore_from_date => 'Restaurar a partir da data';

  @override
  String get yes => 'Sim';

  @override
  String get yes_im_sure => 'Sim, tenho certeza!';

  @override
  String get yesterday => 'Ontem';

  @override
  String get youAreAboutToDeletenYourWallet => 'Você está prestes a excluir sua carteira!';

  @override
  String get youCantViewTheSeedBecauseYouveRestoredUsingKeys => 'Você não pode visualizar o seed porque restaurou a carteira usando chaves';

  @override
  String get youGet => 'Você recebe';

  @override
  String get youSend => 'Você envia';

  @override
  String get zeroDecimal => '0 - Zero (000)';

  @override
  String changePinLength(Object value) {
    return 'Mudar para PIN de $value dígitos';
  }

  @override
  String get pleaseEnterAValidHeight => 'Por favor, insira uma altura válida';

  @override
  String get invalidAddress => 'Endereço inválido';

  @override
  String get exchangePair => 'Par de troca';

  @override
  String get payment => 'Pagamento';

  @override
  String get bnsConfirmUpdate => 'Confirmar atualização';

  @override
  String get bnsRenewedSuccessfully => 'BNS renovado com sucesso';

  @override
  String get bnsSameBchatId => 'Mesmo ID do BChat';

  @override
  String get bnsSameBelnetId => 'Mesmo ID do BelNet';

  @override
  String get bnsSameEthAddress => 'Mesmo endereço ETH';

  @override
  String get bnsSameOwnerAddress => 'Mesmo endereço do proprietário';

  @override
  String get bnsSameWalletAddress => 'Mesmo endereço da carteira';

  @override
  String get bnsUpdatedSuccessfully => 'BNS atualizado com sucesso';

  @override
  String get bnsWaitForFetch => 'Aguarde enquanto buscamos o registro BNS da rede';

  @override
  String get bnsYearFive => '5 anos';

  @override
  String get bnsYearOne => '1 ano';

  @override
  String get bnsYearTen => '10 anos';

  @override
  String get bnsYearTwo => '2 anos';

  @override
  String body_confirm_unlock_stake(Object masterNodeKey) {
    return 'Tem certeza de que deseja desbloquear sua participação de $masterNodeKey?';
  }

  @override
  String get checking => 'Verificando...';

  @override
  String get checkingNodeConnection => 'Verificando a conexão com o nó...';

  @override
  String commit_transaction_amount_fee(Object amount, Object fee) {
    return 'Confirmar transação\nValor: $amount\nTaxa: $fee';
  }

  @override
  String get committingTheTransaction => 'Confirmando a transação';

  @override
  String get confirmYourScreenLockPinpatternAndPassword => 'Confirme o PIN, padrão ou senha de bloqueio da tela';

  @override
  String get connectionFailed => 'Falha na conexão';

  @override
  String get do_you_want_to_exit_an_app => 'Deseja sair do aplicativo?';

  @override
  String get enterAValidAddress => 'Insira um endereço válido';

  @override
  String get error => 'Erro';

  @override
  String get error_text_beldex => 'O valor de Beldex não pode exceder o saldo disponível.\nO número de casas decimais deve ser menor ou igual a 9';

  @override
  String get error_text_fiat => 'O valor do montante não pode exceder o saldo disponível.\nO número de casas decimais deve ser menor ou igual a 2';

  @override
  String get error_text_service_node => 'Uma chave de Master Node pode conter apenas 64 caracteres hexadecimais';

  @override
  String get exchangeAmount => 'Valor da troca';

  @override
  String get failedToGetOutputDistribution => 'Falha ao obter a distribuição da saída';

  @override
  String flashTransactionPriority(Object transactionPriority) {
    return 'As transações Flash são transações instantâneas.\nA prioridade $transactionPriority está definida como a taxa padrão';
  }

  @override
  String get important => 'IMPORTANTE';

  @override
  String get keys_title => 'Chaves';

  @override
  String get noPendingTransaction => 'Nenhuma transação pendente';

  @override
  String get nothing_staked => 'Nada em staking ainda';

  @override
  String openalias_alert_content(Object recipient_name) {
    return 'Você enviará fundos para\n$recipient_name';
  }

  @override
  String get openalias_alert_title => 'Destinatário Beldex detectado';

  @override
  String get pending => '(pendente)';

  @override
  String get please_select => 'Selecione:';

  @override
  String get pleaseAddAMainnetNode => 'Adicione um nó da rede principal';

  @override
  String get received => 'Recebido';

  @override
  String get reconnect_alert_text => 'Tem certeza de que deseja se reconectar?';

  @override
  String get reconnection => 'Reconexão';

  @override
  String get remove_node => 'Remover nó';

  @override
  String get remove_node_message => 'Tem certeza de que deseja remover o nó selecionado?';

  @override
  String get rename => 'Renomear';

  @override
  String router_no_route(Object name) {
    return 'Nenhuma rota definida para $name';
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
  String get seed_share => 'Compartilhar seed';

  @override
  String get send_your_wallet => 'Sua carteira';

  @override
  String get sending => 'Enviando';

  @override
  String get service_node_key => 'Chave do Master Node';

  @override
  String get settings_none => 'Nenhum';

  @override
  String get stake_beldex => 'Fazer staking de Beldex';

  @override
  String get stake_more => 'Fazer mais staking';

  @override
  String get start_staking => 'Começar o staking';

  @override
  String get subaddress_title => 'Lista de subendereços';

  @override
  String get subAddresses => 'Subendereços';

  @override
  String get success => 'Sucesso';

  @override
  String get swap_confirmations => 'Confirmações';

  @override
  String get swap_confirmed => 'Confirmado';

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
