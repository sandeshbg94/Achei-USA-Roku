' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********  

sub init()
    m.scene = m.top.getScene()
    m.Loader = m.top.findNode("Loading")
    m.Loader.poster.uri = "pkg:/images/Spin.png"
    m.HomeScreen = m.top.findNode("HomeScreen")
    m.CategoryList = m.top.findNode("CategoryList")
    m.TitleNode = m.top.findNode("SpecialsTitle")
    m.QualityNode = m.top.findNode("Quality")
    m.ReleaseDateNode = m.top.findNode("ReleaseDate")
    m.PosterNode = m.top.findNode("BackgroundPoster")
    m.Description = m.top.findNode("Description")
    m.Genre = m.top.findNode("Genre")
    m.DetailsScreen = m.top.findNode("DetailsScreen")
    m.VideoNode = m.top.findNode("DeepLinkVideoNode")
    m.CategoryList.setFocus(true)
    m.CategoryList.observefield("rowItemFocused","onRowItemFocused")
    m.CategoryList.observeField("rowItemSelected","onRowItemSelected")
    m.CategoryList.observeField("media","playVideo")
End sub

sub onRowItemFocused(msg as Object)
    if type(msg) = "roSGNodeEvent" and msg.getField() = "rowItemFocused"
        m.Loader.visible = false
        FocusedContentId = msg.getData()
        FocusedContent = m.CategoryList.content.getChild(FocusedContentId[0]).getChild(FocusedContentId[1])
        m.PosterNode.uri = FocusedContent.FHDPosterUrl
        m.TitleNode.text = UCase(FocusedContent.title)
        m.ReleaseDateNode.text = Left(FocusedContent.MetaData.ReleaseDate,10) 
        m.QualityNode.text = FocusedContent.StreamQualities[0]
        m.Description.text = FocusedContent.MetaData.Description
        m.Genre.text = FocusedContent.MetaData.Genre
    end if
end sub

sub onRowItemSelected(msg as Object)
    if type(msg) = "roSGNodeEvent" and msg.getField() = "rowItemSelected"
        SelectedContentId = msg.getData()
        SelectedContent  = m.CategoryList.content.getChild(SelectedContentId[0]).getChild(SelectedContentId[1])
        m.DetailsScreen.content = SelectedContent
        m.DetailsScreen.visible = true
        m.HomeScreen.visible = false
        m.scene.backExitsScene = false
        m.DetailsScreen.findNode("UserActionButtons").focusButton = 0
        m.DetailsScreen.setFocus(true)
    end if
end sub                    

function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if (key = "back") and press = true
        if m.HomeScreen.visible = false and m.DetailsScreen.visible
            m.DetailsScreen.visible = false
            m.HomeScreen.visible= true 
            m.CategoryList.setFocus(true)
            m.scene.backExitsScene = true
            result = true
        else if m.VideoNode.visible
            m.VideoNode.control = "stop"
            m.scene.backExitsScene = true
            m.CategoryList.setFocus(true)
            m.VideoNode.visible = false
            result = true
        end if
    end if
    return result

end function
                       
            
function playVideo(msg as Object)
    if type(msg) = "roSGNodeEvent" and msg.getField() = "media"
        media = msg.getData()
        videocontent = createObject("RoSGNode","ContentNode")
        videocontent.title = media.title
        videocontent.url = media.url
        m.VideoNode.content = videocontent
        m.scene.backExitsScene = false 
        m.VideoNode.control = "play"
        m.VideoNode.visible = true
        m.VideoNode.setFocus(true)
     end if
end function
            


                        