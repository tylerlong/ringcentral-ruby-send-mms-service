# RingCentral Ruby MMS sending service


## Setup

```
bundle install
cp .env.sample .env
```

Edit `.env` file to specify your credentials


## Run

```
ruby index.rb
```


## Usage

HTTP Post to http://localhost:4567 with the following parameters:

- receiver
- text
- file_url
- file_type

For example:

```
curl -X POST http://localhost:4567 \
-F "receiver=6508888888" \
-F "text=hello world" \
-F "file_url=https://www.baidu.com/img/bd_logo1.png" \
-F "file_type=image/png"
```


## Deploy

You can deploy this app to any server with a public adress, so that you can access it from anywhere.

You can also add some [password protection](http://recipes.sinatrarb.com/p/middleware/rack_auth_basic_and_digest) so that only you can use this service.
