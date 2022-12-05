# Plate Recognizer

[Plate Recognizer](https://platerecognizer.com/) is a suite of software products that provide accurate and fast Automatic License Plate Recognition (ALPR)

This project deploys the Plate Recognizer [Stream](https://platerecognizer.com/stream/) product which processes live camera or video feeds and extracts any detected license plates. This repo uses a Raspberry Pi 4 on the balena platform for ease of deployment, and to make updating and managing a fleet of  ALPR devices from any location simple. (A fleet can be one or more devices!)

For more details, see the accompanying blog post (TBA).

## Project features
- Use the balenaCloud dashboard to set some basic Plate Recognizer Stream configurations - no need to ssh or edit config files!
- Add webhook targets via the dashboard - we show an example using [Park Pow](https://parkpow.com/)
- An example container is included to show how to consume the Plate Rec API
- The example container sends a text and closes a GPIO output when a license plate on a custom list is detected

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
