when not defined(js):
  {.error: "Geolocation API is only available for the JS target".}

from std/dom import navigator
import std/jsffi

## Nim bindings for the Geolocation Web API. Will only compile for the JS
## target.
##
## Refer to this_ page for more information.
##
## .. this_: https://developer.mozilla.org/en-US/docs/Web/API/Geolocation/getCurrentPosition
##

type
  Geolocation* = JsObject ## \
  ## Geolocation object
  GeolocationPosition* =  ref object of JsObject ## \
  ## Represents the Geolocation Position
  ##
    coords*: GeolocationCoordinates
    timestamp*: culong
  GeolocationCoordinates* = ref object of JsObject ## \
  ## The GeolocationCoordinates interface represents the position
  ## and altitude of the device on Earth, as well as the accuracy
  ## with which these properties are calculated.
  ##
    latitude*: cdouble
    longitude*: cdouble
    altitude*: cdouble
    accuracy*: cdouble
    altitudeAccuracy*: cdouble
    heading*: cdouble
    speed*: cdouble
  GeolocationPositionErrorCode* {.pure.} = enum ## \
  ## Refer to this_ page for more information
  ##
  ## .. _this: https://developer.mozilla.org/en-US/docs/Web/API/GeolocationPositionError/code
  ##
    PermissionDenied = 1,
    PositionUnavailable = 2,
    Timeout = 3
  GeolocationPositionError* = ref object of JsObject ## \
  ## The `GeolocationPositionError` interface represents the
  ## reason of an error occurring when using the geolocating device.
  ##
    code*: GeolocationPositionErrorCode
    message*: cstring
  OnSuccess* = proc(position: GeolocationPosition): void ## \
  ## Type alias for the callback in `getCurrentPosition()` when it succeeeds.
  ##
  OnError* = proc(error: GeolocationPositionError): void ## \
  ## Type alias for the callback in `getCurrentPosition()` when it fails.
  ##
  GeolocationOptions* = ref object of JsObject ## \
  ## An optional `JsObject` passed in `getCurrentPosition()`.
  ## Refer to the parameters section on this_ page.
  ##
  ## .. this_: https://developer.mozilla.org/en-US/docs/Web/API/Geolocation/getCurrentPosition
  ##
    maximumAge*: culong
    timeout*: culong
    enableHighAccuracy*: bool

var geolocation* {.importjs: "navigator.geolocation".}: Geolocation ## \
## Corresponds to the global `navigator.geolocation`
##
## From MDN:
##
##     The Geolocation interface represents an object able to obtain the
##     position of the device programmatically. It gives Web content
##     access to the location of the device. This allows a website
##     or app to offer customized results based on the user's location.
##

proc isGeolocationAvailable*(): bool =
  ## Helper proc to determine if Geolocation API is available.
  ##
  ## Not originally part of the Geolocation API.
  ##
  return geolocation != jsUndefined

proc newGelocationOptions*(maximumAge, timeout: Natural; enableHighAccuracy: bool): GeolocationOptions=
  ## Create a new `GeolocationOptions`. To be used with `getCurrentPosition`
  ##
  new result
  result.maximumAge = maximumAge.culong
  result.timeout = timeout.culong
  result.enableHighAccuracy = enableHighAccuracy

proc getCurrentPosition*(gelocation: Geolocation; success: OnSuccess; error: OnError = nil; options: GeolocationOptions = nil): void {.importjs: "#.getCurrentPosition(@)".} ## \
## Determines the device's current location and gives back a `GeolocationPosition` object with the data.
##
proc watchPosition*(gelocation: Geolocation; success: OnSuccess; error: OnError = nil; options: GeolocationOptions = nil): cint {.importjs: "#.watchPosition(@)".} ## \
## Returns a `culong` value representing the newly established callback function to be
## invoked whenever the device location changes.
## 

proc clearWatch*(gelocation: Geolocation; watchId: cint): void {.importjs: "#.clearWatch(@)".} ## \
## Removes the particular handler previously installed using `watchPosition()`.
##
