#include <stdint.h>

struct BeldexWalletListener;

typedef int8_t (*on_new_block_callback)(uint64_t height);
typedef int8_t (*on_need_to_refresh_callback)(void);

typedef struct BeldexWalletListener
{
    // on_money_spent_callback *on_money_spent;
    // on_money_received_callback *on_money_received;
    // on_unconfirmed_money_received_callback *on_unconfirmed_money_received;
    // on_new_block_callback *on_new_block;
    // on_updated_callback *on_updated;
    // on_refreshed_callback *on_refreshed;

    on_new_block_callback on_new_block;
} BeldexWalletListener;

struct TestListener {
    // int8_t x;
    on_new_block_callback on_new_block;
};
