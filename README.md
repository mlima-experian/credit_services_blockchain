# Aptos Credit Services

## Installation

To install the Aptos CLI, follow these steps:

**Windows x64 (with [Scoop](https://scoop.sh)):**
```
PS > scoop bucket add mvrpl https://github.com/mvrpl/windows-apps
PS > scoop install aptos-cli
```

**macOS or Linux [arm64 and x64] (with [Homebrew](https://brew.sh)):**
```
$ brew tap mvrpl/unix-apps https://github.com/mvrpl/unix-apps
$ brew install aptos-cli
```

## Usage

To run the tests for the smart contract, clone this repository and execute the following command in the terminal:

```
$ aptos move test --named-addresses users_contracts=default
```

## License

This project is licensed under the [GNU Affero General Public License v3.0](LICENSE.md).

## Testing

To run the tests for the smart contract, use the following command:

```
$ aptos move test --named-addresses users_contracts=default
```