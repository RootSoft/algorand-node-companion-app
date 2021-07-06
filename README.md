<p align="center">
<img src="https://i.imgur.com/IQPPXAn.png">
</p>

# Algorand Node Companion App
[![Stars][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

Algorand is a public blockchain and protocol that aims to deliver decentralization, scale and security for all participants.
Their PURE PROOF OF STAKE™ consensus mechanism ensures full participation, protection, and speed within a truly decentralized network. With blocks finalized in seconds, Algorand’s transaction throughput is on par with large payment and financial networks. And Algorand is the first blockchain to provide immediate transaction finality. No forking. No uncertainty.

## Introduction
Algorand Node Companion App is a mobile, web and desktop application that can manage, operate and track the status of your Algorand node.
The goal of the app is help new users easily set up their Algorand Node and provide a uniform interface to easily participate in consensus, all straight from the application.

## Features
* Start & stopping node
* Updating node
* Sync using Fast-Catchup
* Participating in consensus
* Telemetry
* Switching network
* MainNet Metrics Dashboard

## How does it work?
The Algorand Node Bridge (ANB) serves a WebSocket server that accepts JSON-RPC commands and translates them to shell commands that are executed on the node.
ANB should be installed on the platform where the node is running.

The Algorand Node Companion App (ANCA) opens a full-duplex communication channel over a single TCP connection to the Algorand Node Bridge.
ANCA is optimized for mobile, but can also run on web and desktop (Windows, Mac & Linux) - Only tested on Android, iOS & web.

## Caution / Words Of Advice

The current version of Algorand Node Companion App does not support authentication, so be careful when running this on public networks. Anyone with the ip address will be able to connect and operate your node.

## How to build the app?

Make sure to install Dart if you want to build or compile ANB yourself:
[Get the Dart SDK](https://dart.dev/get-dart)

```bash
cd algorand_node_bridge
dart run bin/bridge.dart
```

You can also specify the ip address, port and debugging options:
```
dart run bin/bridge.dart -i 127.0.0.1 -p 4042 -d
```

Or compile the source:

```bash
dart compile exe bin/bridge.dart -o bin/anb
cd bin
./anb
```

## Supported OS

### Algorand Node Companion App

Operating System | Supported | Encrypted
---------------- | ---------------- | ----------------
Android | :heavy_check_mark:  | :heavy_check_mark:
iOS | :heavy_check_mark: | :heavy_check_mark:
Web | :heavy_check_mark: | :x:
Windows | :heavy_check_mark: | :x:
MacOS | :heavy_check_mark: | :x:
Linux | :heavy_check_mark: | :x:

The Algorand Node Companion App securily stores your passphrase in an encrypted box and the encryption key is stored in the Keychain for iOS and KeyStore for Android.


### Algorand Node Bridge

Operating System | Supported
---------------- | ----------------
MacOS | :heavy_check_mark:
Linux (tested on Raspberry Pi 4) | :heavy_check_mark:
Windows | :x:

## Roadmap
* Authentication
* Node discovery
* Register offline
* Manage & renew participation keys
* Sign transactions using Native Algorand Wallet, AlgoSigner & MyAlgo Connect
* Tests

## Changelog

Please see [CHANGELOG](CHANGELOG.md) for more information on what has changed recently.

## Contributing & Pull Requests
Feel free to send pull requests.

Please see [CONTRIBUTING](.github/CONTRIBUTING.md) for details.

## Credits

- [Tomas Verhelst](https://github.com/rootsoft)
- [All Contributors](../../contributors)

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[stars-shield]: https://img.shields.io/github/stars/rootsoft/algorand-node-companion-app.svg?style=for-the-badge&logo=github&colorB=deeppink&label=stars
[stars-url]: https://packagist.org/packages/rootsoft/algorand-node-companion-app
[issues-shield]: https://img.shields.io/github/issues/rootsoft/algorand-node-companion-app.svg?style=for-the-badge
[issues-url]: https://github.com/rootsoft/algorand-node-companion-app/issues
[license-shield]: https://img.shields.io/github/license/rootsoft/algorand-node-companion-app.svg?style=for-the-badge
[license-url]: https://github.com/RootSoft/algorand-node-companion-app/blob/master/LICENSE