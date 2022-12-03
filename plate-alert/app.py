from flask import Flask
from flask import request
import json
import os
import errno
from twilio.rest import Client
import RPi.GPIO as GPIO
import requests

# inspired by https://github.com/parkpow/deep-license-plate-recognition/blob/master/webhooks/webhook_reader_flask.py

def button_press(channel):
    GPIO.output(20, GPIO.LOW)
    print("GPIO 20 set low.")
    
GPIO.setmode(GPIO.BCM)

plates = os.getenv('PLATE_LIST')
plate_list = plates.split(",") if plates else []

account_sid = (os.getenv('TWILIO_ACCOUNT_SID', '0'))
auth_token = (os.getenv('TWILIO_AUTH_TOKEN', '0'))
text_from = (os.getenv('TWILIO_FROM', '0'))
text_to = (os.getenv('TWILIO_TO', '0'))
can_text = True
if account_sid == "0" or auth_token == "0" or text_to == "0" or text_from == "0":
    can_text = False
else:
    client = Client(account_sid, auth_token)

# Set reset button input
GPIO.setup(26, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.add_event_detect(26, GPIO.RISING, callback=button_press, bouncetime=500)
# Set LED output
GPIO.setup(20, GPIO.OUT)

# Use balena supervisor API to get device info to use for texting
r = requests.get(os.getenv('BALENA_SUPERVISOR_ADDRESS') + "/v2/device/name?apikey=" + os.getenv('BALENA_SUPERVISOR_API_KEY'))
api_info = r.json()

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def process_request():
    if request.method == 'GET':
        return 'Send a POST request instead.'
    else:
        # Files exist for multipart/form-data
        files = request.files
        app.logger.debug(f'files: {files}')
        if files:
            # Request contains image
            # If you want to attach the image to a SMS text,
            # you could do so here using the files variable

            form = request.form
            json_data = json.loads(form['json'])
        else:
            # Request contains json
            json_data = request.json

        try:
            plate = json_data["data"]["results"][0]["plate"]
        except Exception as e:
            plate = ""

        if plate in plate_list:
            # Turn on GPIO
            GPIO.output(20, GPIO.HIGH)
            # Send a text
            if can_text:
                msg_text = "Hello, plate {0} detected by Plate Recognizer device {1}.".format(plate, api_info["deviceName"])
                message = client.messages.create(body=msg_text,from_=os.environ['TWILIO_FROM'],to=os.environ['TWILIO_TO'])
                print("Plate {0} in PLATE_LIST; GPIO 20 enabled and text sent with result SID: {1}".format(plate, message.sid))
            else:
                print("Plate {} in PLATE_LIST; GPIO 20 enabled.".format(plate))
        else:
            print("Plate {} not in PLATE_LIST; no action taken.".format(plate))
        return 'OK'
