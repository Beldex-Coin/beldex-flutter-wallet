#import "BeldexCoinPlugin.h"
#import <beldex_coin/beldex_coin-Swift.h>
//#include "../External/android/monero/include/wallet2_api.h"

@implementation BeldexCoinPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBeldexCoinPlugin registerWithRegistrar:registrar];
}
@end
