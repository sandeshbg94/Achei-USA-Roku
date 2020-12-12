' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 

sub Main(args)
    showChannelSGScreen(args)
end sub

sub showChannelSGScreen(args)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    scene.backgroundColor = "0x000000FF"
    scene.backgroundURI = ""
    screen.show()
    deeplink = getDeepLinks(args)
    m.global = screen.getGlobalNode()
    m.global.addField("deeplink", "assocarray", false)
    m.global.deeplink = deeplink

    while(true)
        msg = wait(0, m.port)
    msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub

Function getDeepLinks(args) as Object
    deeplink = Invalid

    if args.contentid <> Invalid and args.mediaType <> Invalid
        deeplink = {
            id: args.contentId
            type: args.mediaType
        }
    end if

    return deeplink
end Function
