# Plate Recognizer

[Plate Recognizer](https://platerecognizer.com/) is a suite of software products that provide accurate and fast Automatic License Plate Recognition (ALPR)

This project deploys the Plate Recognizer [Stream](https://platerecognizer.com/stream/) product which processes live camera or video feeds and extracts any detected license plates. We will use webhooks to send that data to [Park Pow](https://parkpow.com/), Plate Recognizer's sister product for managing and enforcing parking. In addition, we'll show how those webhooks can also be used on-device to send a text or close a relay when one or more specific plates are detected.

We will be using the balena platform on a Raspberry Pi 4 for ease of deployment, and to make updating and managing our ALPR devices simple. (A fleet can be one or more devices!) We'll show how balenaCloud can be used to set Plate Recognizer settings no matter where the device is located, and remove the need to ssh into devices or edit config files.

For more details, see the accompanying blog post (TBA) otherwise use the information below to set up your device.

**This repo is not yet complete.**

## Setup and configuration

Running this project is as simple as deploying it to a balenaCloud application. You can do it in just one click by using the button below:

[![deploy button](https://balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/balena-labs-projects/plate-recognizer)

## Supported hardware

This project is developed for Raspberry Pi 4. Other hardware may be compatible, but is untested.

## Documentation

Head over to our [docs](https://www.balena.io/os/docs/raspberrypi4-64/getting-started/) for detailed installation and usage instructions.

## Getting Help

If you're encountering bugs, please raise an issue.

## Contributing

Do you want to help improve the project? We welcome PRs, and would be happy to discuss contributions via a raised feature request issue.
