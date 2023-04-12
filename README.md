# Geolocation API

Nim bindings for the [Geolocation Web API](https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API).

## Basic usage

```nim
import std/strformat

import webgeolocation

proc success(position: GeolocationPosition): void =
    let 
        lat = position.coords.latitude
        lon = position.coords.longitude
    echo fmt"https://www.openstreetmap.org/#map=18/{lat}/{lon}".cstring
    echo fmt"Latitude: {lat}, Longitude: {lon}".cstring

proc error(error: GeolocationPositionError): void  =
    echo "Unable to retrieve your position: ".cstring & error.message
 
if isGeolocationAvailable():
  geolocation.getCurrentPosition(success, error)
else:
  echo "Geolcation API is unavailable!"
```

## Demo

The demo presented on the MDN page for the Geolocation API
is included in the `tests/` directory.

You will need [Karax](https://github.com/karaxnim/karax) to build it.

### Instructions

Run `nimble demo`. This will build a small Karax application which
you can access at `http://localhost:8080`.

