import 'package:beldex_wallet/l10n.dart';

abstract class SyncStatus {
  const SyncStatus(this.currentHeight, this.targetHeight,this.blocksLeft);

  final int currentHeight;
  final int targetHeight;
  final int blocksLeft;

  double progress() => targetHeight > 0 ? currentHeight / targetHeight : 0.0;

  String title(AppLocalizations t);
}

class SyncingSyncStatus extends SyncStatus {
  const SyncingSyncStatus(int currentHeight, int targetHeight,int blocksLeft) : super(currentHeight, targetHeight,blocksLeft);

  @override
  double progress() => targetHeight > 0 ? currentHeight / targetHeight : 0.0;
  
  @override
  String title(AppLocalizations t){
    if(blocksLeft == 1) {
      return t.blockRemaining('$blocksLeft');
    }else if(blocksLeft == 0) {
      return t.sync_status_synchronized;
    }else{
      return t.blocksRemaining('$blocksLeft');
    }
  }

  @override
  String toString() => '$blocksLeft';
}

class SyncedSyncStatus extends SyncStatus {
  SyncedSyncStatus(int height) : super(height, height,0);

  @override
  double progress() => 1.0;

  @override
  String title(AppLocalizations t) => t.sync_status_synchronized;
}

class NotConnectedSyncStatus extends SyncStatus {
  const NotConnectedSyncStatus(int currentHeight) : super(currentHeight, 0,-1);

  @override
  double progress() => 0.0;

  @override
  String title(AppLocalizations t) => t.sync_status_not_connected;
}

class StartingSyncStatus extends SyncStatus {
  const StartingSyncStatus(int currentHeight) : super(currentHeight, 0,-1);
  
  @override
  double progress() => 0.0;

  @override
  String title(AppLocalizations t) => t.sync_status_starting_sync;
}

class FailedSyncStatus extends SyncStatus {
  const FailedSyncStatus(int currentHeight) : super(currentHeight, 0,-1);
  
  @override
  double progress() => 1.0;

  @override
  String title(AppLocalizations t) => t.sync_status_failed_connect;
}

class ConnectingSyncStatus extends SyncStatus {
  const ConnectingSyncStatus(int currentHeight) : super(currentHeight, 0,-1);
  
  @override
  double progress() => 0.0;

  @override
  String title(AppLocalizations t) => t.sync_status_connecting;
}

class ConnectedSyncStatus extends SyncStatus {
  const ConnectedSyncStatus(int currentHeight) : super(currentHeight, 0,-1);
  
  @override
  double progress() => 0.0;

  @override
  String title(AppLocalizations t) => t.sync_status_connected;
}