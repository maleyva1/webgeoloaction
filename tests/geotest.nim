include karax/prelude

import std/strformat

import webgeolocation

var 
    gStatus: cstring = ""
    gText: cstring = ""
    gLink: cstring =""
    kxi: KaraxInstance

proc success(position: GeolocationPosition): void =
    let 
        lat = position.coords.latitude
        lon = position.coords.longitude
    gStatus = "".kstring;
    gLink = fmt"https://www.openstreetmap.org/#map=18/{lat}/{lon}".cstring
    gText = fmt"Latitude: {lat}, Longitude: {lon}".cstring
    # Need to let Karax know to redraw
    kxi.redraw()

proc error(error: GeolocationPositionError): void  =
    gStatus = "Unable to retrieve your position: ".kstring & error.message
    # Need to let Karax know to redraw
    kxi.redraw()

proc createDom(): VNode =
    result = buildHtml(tdiv):
        p:
            text gStatus
        a(href= gLink):
            text gText
        tdiv()
        button(id= "find-me"):
            text "Click me"
            proc onclick() =
                gText = ""
                gLink = ""
                if isGeolocationAvailable():
                    #let options = newGelocationOptions(10, 500, true)
                    gStatus = "Locating...".kstring
                    geolocation.getCurrentPosition(success, error)
                else:
                    gStatus = "Geolcation is not supported by your browser".kstring

kxi = setRenderer createDom
