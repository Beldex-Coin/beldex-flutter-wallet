import 'package:beldex_wallet/generated/l10n.dart';

abstract class SyncStatus {
  const SyncStatus(this.currentHeight, this.targetHeight,this.blocksLeft);

  final int currentHeight;
  final int targetHeight;
  final int blocksLeft;

  double progress() => targetHeight > 0 ? currentHeight / targetHeight : 0.0;

  String title();
}

class SyncingSyncStatus extends SyncStatus {
  const SyncingSyncStatus(int currentHeight, int targetHeight,int blocksLeft) : super(currentHeight, targetHeight,blocksLeft);

  @override
  double progress() => targetHeight > 0 ? currentHeight / targetHeight : 0.0;
  
  @override
  String title(){
    if(blocksLeft == 1) {
      return S.current.blockRemaining('$blocksLeft');
    }else if(blocksLeft == 0) {
      return S.current.sync_status_synchronized;
    }else{
      return S.current.Blocks_remaining('$blocksLeft');
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
  String title() => S.current.sync_status_synchronized;
}

class NotConnectedSyncStatus extends SyncStatus {
  const NotConnectedSyncStatus(int currentHeight) : super(currentHeight, 0,-1);

  @override
  double progress() => 0.0;

  @override
  String title() => S.current.sync_status_not_connected;
}

class StartingSyncStatus extends SyncStatus {
  const StartingSyncStatus(int currentHeight) : super(currentHeight, 0,-1);
  
  @override
  double progress() => 0.0;

  @override
  String title() => S.current.sync_status_starting_sync;
}

class FailedSyncStatus extends SyncStatus {
  const FailedSyncStatus(int currentHeight) : super(currentHeight, 0,-1);
  
  @override
  double progress() => 1.0;

  @override
  String title() => S.current.sync_status_failed_connect;
}

class ConnectingSyncStatus extends SyncStatus {
  const ConnectingSyncStatus(int currentHeight) : super(currentHeight, 0,-1);
  
  @override
  double progress() => 0.0;

  @override
  String title() => S.current.sync_status_connecting;
}

class ConnectedSyncStatus extends SyncStatus {
  const ConnectedSyncStatus(int currentHeight) : super(currentHeight, 0,-1);
  
  @override
  double progress() => 0.0;

  @override
  String title() => S.current.sync_status_connected;
}