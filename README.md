<p align="center">
<img src="https://i.imgur.com/IQPPXAn.png">
</p>

# Algorand Node Companion App
[![Stars][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

Algorand Node Companion App is a mobile, web and desktop application that can manage, operate and track the status of your Algorand node.
The goal of the app is help new users easily set up their Algorand Node and provide a uniform interface to easily participate in consensus, all straight from the application.

<p align="center">
<img src="https://i.imgur.com/szHTZXL.png">
</p>

## Features
* Start & stopping node
* Updating node
* Sync using Fast-Catchup
* Participating in consensus
* Telemetry
* Switching network
* MainNet Metrics Dashboard

## Supported OS

### Algorand Node Companion App
The Algorand Node Companion App securily stores your passphrase in an encrypted box and the encryption key is stored in the Keychain for iOS and KeyStore for Android.

Operating System | Supported | Encrypted
---------------- | ---------------- | ----------------
Android | :heavy_check_mark:  | :heavy_check_mark:
iOS | :heavy_check_mark: | :heavy_check_mark:
Web | :heavy_check_mark: | :x:
Windows | :heavy_check_mark: | :x:
MacOS | :heavy_check_mark: | :x:
Linux | :heavy_check_mark: | :x:

### Algorand Node Bridge

Operating System | Supported
---------------- | ----------------
MacOS | :heavy_check_mark:
Linux (tested on Raspberry Pi 4) | :heavy_check_mark:
Windows | :x:

## How does it work?
The Algorand Node Bridge (ANB) serves a WebSocket server that accepts JSON-RPC commands and translates them to shell commands that are executed on the node.
ANB should be installed on the platform where the node is running.

The Algorand Node Companion App (ANCA) opens a full-duplex communication channel over a single TCP connection to the Algorand Node Bridge.
ANCA is optimized for mobile, but can also run on web and desktop (Windows, Mac & Linux) - Only tested on Android, iOS & web.

## Instructions

### Install Algorand Node Bridge
The Algorand Node Bridge should be installed on the operating system where your node is running.
Find the latest version for your OS on the [Releases](https://github.com/RootSoft/algorand-node-companion-app/releases) tab.
**It is recommended to run ANB with a self-signed SSL certificate**

```bash
# Create a self-signed x509 certificate
openssl req -x509 -sha256 -days 365 -newkey rsa:2048 -keyout anb_pk.pem -out anb_cert.pem

# Make and change directory to anb
mkdir ~/anb
cd ~/anb

# Download the latest version for your OS - See releases
wget [URL-TO-EXECUTABLE]

# Change permissions
chmod 544 anb

# Start a secure Algorand Node Bridge - See Arguments for all options
./anb --cert .ssh/anb_cert.pem --identity .ssh/anb_pk.pem --password pkpassword --verbose
```

After you run the Algorand Node Bridge, the console will print something like the following:
> Serving at wss://192.168.66.157:4042
> Authorization token: xxxxx

You can now use the Algorand Node Companion App to connect with the Algorand Node Bridge and use the long-lived authorization token for a secure connection.

## Arguments
These arguments can be specified when running the node.

Argument | Abbreviation | Description
---------------- | ---------------- | ----------------
--ip-address | -a  | The ip address to connect with. Defaults to the first ipv4 network address.
--port| -p  | The port to connect with. Defaults to 4042.
--working-directory | -d  | The directory where the node lives. Defaults to $HOME/node.
--cert | -c  | Optional public key certificate
--identity | -i  | Optional private key
--password | /  | The password for the identity/private key file.
--token | -t  | A long-lived authorization token. Defaults to a random, cryptographically secure token.
--verbose | -v  | A flag to displays or gets extended information

## Build from source
You can also build the Algorand Node Bridge from source yourself and compile it using the Dart SDK.
[Get the Dart SDK](https://dart.dev/get-dart)

```bash
git clone
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

## Roadmap
* Node discovery
* Register offline
* Manage & renew participation keys
* Sign transactions using Native Algorand Wallet, AlgoSigner & MyAlgo Connect
* Tests

## Video

[![IMAGE ALT TEXT](http://img.youtube.com/vi/3sbW-vnjhS0/0.jpg)](http://www.youtube.com/watch?v=3sbW-vnjhS0 "Algorand Node Companion App")

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