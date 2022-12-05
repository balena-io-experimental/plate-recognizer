# Plate Recognizer

[Plate Recognizer](https://platerecognizer.com/) is a suite of software products that provide accurate and fast Automatic License Plate Recognition (ALPR)

This project deploys the Plate Recognizer [Stream](https://platerecognizer.com/stream/) product which processes live camera or video feeds and extracts any detected license plates. This repo uses a Raspberry Pi 4 on the balena platform for ease of deployment, and to make updating and managing a fleet of  ALPR devices from any location simple. (A fleet can be one or more devices!)

For more details, see the accompanying blog post (TBA).

## Project features
- Use the balenaCloud dashboard to set some basic Plate Recognizer Stream configurations - no need to ssh or edit config files!
- Add webhook targets via the dashboard - we show an example using [Park Pow](https://parkpow.com/)
- An example container is included to show how to consume the Plate Rec API
- The example container sends a text and closes a GPIO output when a license plate on a custom list is detected


## Quick start

Running this project is as simple as deploying it to a balenaCloud application. You can do it in just one click by using the button below:

[![deploy button](https://balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/balena-labs-projects/plate-recognizer)

If you don't have one, you'll be prompted to set up a balenaCloud account (the first ten devices are free and full-featured!) then burn the downloaded image to a micro SD card, boot it up, and the ALPR application will download and start running. You will need to add some device variables to get it working - see "setup and confirguration" below.

If you want to make cahnges to the project and push them to your device, you'll need to use the balenaCLI. See the [Getting Started](https://www.balena.io/os/docs/raspberrypi4-64/getting-started/) guide for more information.

## Supported hardware

This project is developed for Raspberry Pi 4. Other Pi hardware (such as the 3B+) may be compatible, but is untested.

## Setup and configuration

Plate Recognizer Stream is a paid product - see their pricing page to sign up and obtain a license key and token. One you have these, you can set them on your balenaCloud dashboard as [device variables](https://www.balena.io/docs/learn/manage/variables/):
`LICENSE_KEY` and `TOKEN` (select the `alpr` service for both.)

The following Stream configuration parameters can be set in a similar way via the balenaCloud dashboard. (See the Stream [configuration page](https://guides.platerecognizer.com/docs/stream/configuration#parameters) for definitions of these parameters)

| Stream parameter  |  Device variable | 
|---|---|
|url|`CAMERA1_URL`|
|regions|`REGIONS`   | 
|timezone|`TIMEZONE`   |
|mmc|`MMC` |
|webhook_targets|`WEBHOOK_TARGETS`|
|webhook_header|`WEBHOOK_HEADER`|

** NOTE: For the above variables to take effect, you must set `USE_VARS` to the value `true` **
 
If you want to use any parameters not listed above, or want to edit the config.ini file manually, make sure to set `USE_VARS` to false or delete the variable alltogether. If you edit the config.ini file while `USE_VARS` is `true` you will lose any changes to the file. The config.ini file is located at `/user-data/config.ini` and is on a persistent volume that will survive container restarts.

Here's an example of some device variables in the dashboard:

![ALPR logs](https://github.com/balena-labs-projects/plate-recognizer/blob/main/images/device-variables.png)

Note that you can set any variables at the fleet level in balenaCloud so they apply to all the devices in your fleet without having to edit each one separately! 

If all is well, you should start seeing Stream data in the logs section of your balenaCloud dashboard:

![ALPR logs](https://github.com/balena-labs-projects/plate-recognizer/blob/main/images/alpr-log.png)

### The plate-alert service

We have included a service called plate-alert that consumes the Plate Recognizer Stream API on the device. To use it, add `http://plate-alert:5000` to your webhook_targets, either using a device variable or by editing config.ini as described above and in the [Stream documentation](https://guides.platerecognizer.com/docs/stream/configuration)

The plate-alert service will let your device send you a text and make GPIO 20 (BCM numbering) go high when a plate on a custom list is detected. You can use the GPIO output to light an LED, close a relay, or some other type of signaling. To reset the GPIO to low, momentarily connect GPIO 26 to ground. (Such as with a momentary SPST pushbutton)

To set the alert plate list, use the device variable `PLATE_LIST` and set to a comma-delimited list of license plates. Make all letters lower case and do not use any quotes. For example: `abc123,f45ccv,jrf556,705gat,jjk877`

To receive a text, you'll need to set up a Twilio account and obtain a Twilio phone number. (Free [Twilio trial accounts](https://www.twilio.com/docs/usage/tutorials/how-to-use-your-free-trial-account) are available.) Once you have that, set the following device variables:

| Variable  |  Description | 
|---|---|
|`TWILIO_ACCOUNT_SID`|SID from your Twilio console|
|`TWILIO_AUTH_TOKEN`|Token from your Twilio console   | 
|`TWILIO_FROM`|Twilio phone number from your Twilio console   |
|`TWILIO_TO`|Number to send text to - must be verified for free trials in Twilio console|

You can use the plate-alert service as a template for building your own interaction with Plate Recognizer.

### Using Park Pow
Park Pow is a sister product of Plate Recognizer used for parking garage management, and interfaces directly with Stream. Add `https://app.parkpow.com/api/v1/webhook-receiver/` to your webhook_targets (you can add more than one target, separated by a comma) and follow the integration steps [here](https://guides.platerecognizer.com/docs/parkpow/integrations#stream).

Note that under many general use cases, you can flash the Raspberry Pi 4 and set the configuration via balenaCloud without ever logging into the device itself!

## Getting Help

If you're encountering bugs, please raise an issue.

## Contributing

Do you want to help improve the project? We welcome PRs, and would be happy to discuss contributions via a raised feature request issue.
