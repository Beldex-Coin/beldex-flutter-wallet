import 'package:beldex_wallet/generated/l10n.dart';

abstract class SyncStatus {
  const SyncStatus();

  double progress();

  String title();

  int blockLeft();
}

class SyncingSyncStatus extends SyncStatus {
  SyncingSyncStatus(this.blocksLeft, this.ptc);

  final double ptc;
  final int blocksLeft;

  @override
  double progress() => ptc;

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

  @override
  int blockLeft() {
    return blocksLeft;
  }
}

class SyncedSyncStatus extends SyncStatus {
  @override
  double progress() => 1.0;

  @override
  String title() => S.current.sync_status_synchronized;

  @override
  int blockLeft() {
    return 0;
  }
}

class NotConnectedSyncStatus extends SyncStatus {
  const NotConnectedSyncStatus();

  @override
  double progress() => 0.0;

  @override
  String title() => S.current.sync_status_not_connected;

  @override
  int blockLeft() {
    return -1;
  }
}

class StartingSyncStatus extends SyncStatus {
  @override
  double progress() => 0.0;

  @override
  String title() => S.current.sync_status_starting_sync;

  @override
  int blockLeft() {
    return -1;
  }
}

class FailedSyncStatus extends SyncStatus {
  @override
  double progress() => 1.0;

  @override
  String title() => S.current.sync_status_failed_connect;

  @override
  int blockLeft() {
    return -1;
  }
}

class ConnectingSyncStatus extends SyncStatus {
  @override
  double progress() => 0.0;

  @override
  String title() => S.current.sync_status_connecting;

  @override
  int blockLeft() {
    return -1;
  }
}

class ConnectedSyncStatus extends SyncStatus {
  @override
  double progress() => 0.0;

  @override
  String title() => S.current.sync_status_connected;

  @override
  int blockLeft() {
    return -1;
  }
}