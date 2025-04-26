module users_contracts::db {
    use std::error;
    use std::signer;
    use std::vector;
    use aptos_framework::timestamp;

    const ENOT_OWNER: u64 = 1;

    struct UserContracts has key, store, drop {
        users_contracts: vector<ContractInfo>,
    }

    struct ContractInfo has store, copy, drop {
        contract_addr: address,
        user_addr: address,
        added_at: u64
    }

    fun init_module(owner: &signer) {
        move_to(owner, UserContracts { users_contracts: vector[] })
    }

    inline fun only_owner(owner: &signer) {
        assert!(signer::address_of(owner) == @users_contracts, error::permission_denied(ENOT_OWNER));
    }

    public entry fun add_active_contract(caller: &signer, contract_addr: address, user_addr: address) acquires UserContracts {
        only_owner(caller);

        let contract_info = ContractInfo {
            contract_addr,
            user_addr,
            added_at: timestamp::now_seconds()
        };

        let user_contracts = borrow_global_mut<UserContracts>(@users_contracts);

        vector::push_back(&mut user_contracts.users_contracts, contract_info)
    }

    public entry fun drop_active_contract(caller: &signer, contract_addr: address, user_addr: address) acquires UserContracts {
        only_owner(caller);

        let user_contracts = borrow_global_mut<UserContracts>(@users_contracts);

        let contracts = vector[];

        vector::for_each(user_contracts.users_contracts, |m| {
            if (m.user_addr != user_addr && m.contract_addr != contract_addr) {
                vector::push_back(&mut contracts, m)
            }
        });

        user_contracts.users_contracts = contracts
    }

    #[view]
    public fun get_user_active_contracts(user_addr: address): vector<ContractInfo> acquires UserContracts {
        let user_contracts = borrow_global_mut<UserContracts>(@users_contracts);

        let contracts = vector[];

        vector::for_each(user_contracts.users_contracts, |m| {
            if (m.user_addr == user_addr) {
                vector::push_back(&mut contracts, m)
            }
        });

        contracts
    }

    #[test(aptos_framework = @std, owner = @users_contracts, alice = @0x1234, contract_signer = @0x100)]
    fun test_add_drop_contract_to_user(
        aptos_framework: &signer,
        owner: &signer,
        alice: &signer,
        contract_signer: &signer
    ) acquires UserContracts {
        timestamp::set_time_has_started_for_testing(aptos_framework);
        timestamp::update_global_time_for_test_secs(1000);

        init_module(owner);

        let contracts_alice = get_user_active_contracts(signer::address_of(alice));

        assert!(vector::length(&contracts_alice) == 0, 1);

        let contract_addr = signer::address_of(contract_signer);

        add_active_contract(owner, contract_addr, signer::address_of(alice));

        contracts_alice = get_user_active_contracts(signer::address_of(alice));

        assert!(vector::length(&contracts_alice) == 1, 1);

        drop_active_contract(owner, contract_addr, signer::address_of(alice));

        contracts_alice = get_user_active_contracts(signer::address_of(alice));

        assert!(vector::length(&contracts_alice) == 0, 1);
    }
}