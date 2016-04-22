## Prerequisites

### Get CocoaPods
```
[sudo] gem install cocoapods
``

## How to

Install dependencies with
```shell
pod install
```

Then open `turtle-ios.xcworkspace` (**not to be confused with `turtle.xcodeproj`**)

Open `Config.swift` and adjust the parameters to your needs

| parameter | defaultValue | description |
|-----------|:------------:|-------------|
|  baseURL  | | homepage of the website to show
|  tokenRegistrationURL | | endpoint where to send the device token for push notifications
|  deviceTokenKey | | payload key of the deviceToken (e.g. `{ "deviceToken": "123123123123" }`)
|  notificationURLKey | | notification payload key of the url to open
|  cacheLogging | *false* | whether to log the cache activity
|  cacheMaxFileSize | *24* | the maximum file size that will be cached (2^24 = 16MB)
|  cacheMaxCacheSize | *30* | the maximum file size that will be cached (2^30 = 256MB)

