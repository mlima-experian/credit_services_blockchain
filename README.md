# Credit Services SmartContract

## Installation

To install the Aptos CLI, follow these steps:

**Windows x64 (with [Scoop](https://scoop.sh)):**
```ps
scoop bucket add mvrpl https://github.com/mvrpl/windows-apps
scoop install aptos-cli
```

**macOS or Linux [arm64 and x64] (with [Homebrew](https://brew.sh)):**
```sh
brew tap mvrpl/unix-apps https://github.com/mvrpl/unix-apps
brew install aptos-cli
```

## Usage

[Smart Contract on Devnet](https://explorer.aptoslabs.com/account/0xc6dfeb52d2e7fa26b6d7884f562e19123601ad9210a708a5c8649bfbe5864838/modules/code/db?network=devnet)

## Testing

To run the tests for the smart contract, use the following command:

```
$ aptos move test --named-addresses users_contracts=default
```

## License

This project is licensed under the [GNU Affero General Public License v3.0](LICENSE.md).