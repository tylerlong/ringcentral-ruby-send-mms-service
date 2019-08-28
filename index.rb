require 'dotenv/load'
require 'sinatra'
require 'down'
require 'ringcentral'

RINGCENTRAL_SERVER_URL = ENV['RINGCENTRAL_SERVER_URL']
RINGCENTRAL_CLIENT_ID = ENV['RINGCENTRAL_CLIENT_ID']
RINGCENTRAL_CLIENT_SECRET = ENV['RINGCENTRAL_CLIENT_SECRET']
RINGCENTRAL_USERNAME = ENV['RINGCENTRAL_USERNAME']
RINGCENTRAL_EXTENSION = ENV['RINGCENTRAL_EXTENSION']
RINGCENTRAL_PASSWORD = ENV['RINGCENTRAL_PASSWORD']

post '/' do
    status 200
    receiver = params['receiver']
    text = params['text']
    file_url = params['file_url']
    file_type = params['file_type']

    tempfile = Down.download(file_url)
    file_type ||= tempfile.content_type

    rc = RingCentral.new(RINGCENTRAL_CLIENT_ID, RINGCENTRAL_CLIENT_SECRET, RINGCENTRAL_SERVER_URL)
    rc.authorize(username: RINGCENTRAL_USERNAME, extension: RINGCENTRAL_EXTENSION, password: RINGCENTRAL_PASSWORD)
    r = rc.post('/restapi/v1.0/account/~/extension/~/sms',
        payload: {
            to: [{ phoneNumber: receiver }],
            from: { phoneNumber: RINGCENTRAL_USERNAME },
            text: text
        },
        files: [
            [tempfile.path, file_type]
        ]
    )
    rc.revoke()
    body 'OK'
end
