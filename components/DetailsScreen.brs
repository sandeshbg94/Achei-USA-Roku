Sub Init()
    m.top.observeField("content","onContentChanged")
    m.Background = m.top.findNode("DetailsBackgroundPoster")
    m.TitleNode = m.top.findNode("DetailsTitle")
    m.ReleaseDateNode = m.top.findNode("ReleaseDate")
    m.StreamQualityLabel = m.top.findNode("StreamQuality")
    m.DescriptionLabel = m.top.findNode("Description")
    m.ContentDurationLabel = m.top.findNode("ContentDuration")
    m.VideoNode = m.top.findNode("DetailsScreenVideo")
    m.ButtonGroup = m.top.findNode("UserActionButtons")
    m.ButtonGroup.buttons = ["Watch Now","Add to WatchList"]
    m.ButtonGroup.observeField("buttonSelected","PlayVideo")
end Sub

function onContentChanged(msg as Object)
    if type(msg) = "roSGNodeEvent" and msg.getField() = "content"
        data = msg.getData()
        m.Background.uri = data.FHDPosterUrl
        m.TitleNode.text = UCase(data.title)
        m.DescriptionLabel.text = data.MetaData.Description
        m.ReleaseDateNode.text = "Premiered " + Left(data.MetaData.ReleaseDate,10)
        m.StreamQualityLabel.text = data.StreamQualities[0]
        m.ContentDurationLabel.text = Str(data.Length / 60) + " Minutes"
    end if
end function

function PlayVideo(msg as Object)
    if type(msg) = "roSGNodeEvent" and msg.getField() = "buttonSelected"
        if msg.getData() = 0
            m.VideoNode.content = m.top.content
            m.VideoNode.control = "play"
            m.VideoNode.visible = true
            m.VideoNode.setFocus(true)
        end if
    end if     
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if (key = "right" and press = true) or (key = "left" and press = true)
        if m.ButtonGroup.buttonFocused = 0
            m.ButtonGroup.focusButton = 1
        else
            m.ButtonGroup.focusButton = 0
        end if
        result = true
    else if key = "back" and press = true
        m.ButtonGroup.focusButton = 0
        if m.VideoNode.visible
           m.VideoNode.control = "stop"
           m.top.SetFocus(true)
           m.VideoNode.visible = false
           result = true
        else
            result = false       
        end if
    end if
    return result
end function