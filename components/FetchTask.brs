Sub Init()
    m.top.functionName = "fetchContent"
End Sub

function fetchContent()
    url = CreateObject("roUrlTransfer")
    url.SetCertificatesFile("common:/certs/ca-bundle.crt")
    url.AddHeader("X-Roku-Reserved-Dev-Id", "")
    url.InitClientCertificates()
    url.SetUrl("https://hosttec.online/rokuxml/achei/achei.json")
    rawData = url.GetToString()
    if rawData <> invalid and rawData <> ""
        content = parseJson(rawData)
        formatContent(content)
    end if
end function

function formatContent(content as Object)
    'Formats the Json fetched into content node and also maintains videos mapped to their ids for deeplinking
    data = CreateObject("roSGNode", "ContentNode")
    mediaIndex = {}
    for each category in content.categories
        row = data.createChild("ContentNode")
        row.title = category.name
        for each item in content.tvSpecials
            for each playlist in content.playlists
                if playlist.name = category.playlistName
                    for each id in playlist.itemIds
                        if id = item.id
                           childrow = row.createChild("ContentNode")
                           childrow.title = item.title
                           childrow.SDPosterUrl = item.thumbnail
                           childrow.HDPosterUrl = item.thumbnail
                           metaData = {}
                           metaData["ReleaseDate"] = item.releaseDate
                           metaData["Description"] = item.shortDescription
                           metaData["Genre"] = item.genres[0]
                           childrow.addField("MetaData","assocarray",true)
                           childrow.MetaData = metaData
                           childrow.FHDPosterUrl = item.thumbnail
                           childrow.Length = item.content.duration * 60
                           for each video in item.content.videos
                                childrow.Url = video.url
                                childrow.StreamQualities = [video.quality]
                                mediaIndex[id] = video
                                mediaIndex[id]["title"] = item.title
                           end for
                        end if
                    end for
                end if
            end for
        end for
    end for
    m.top.content = data
    m.top.mediaIndex = mediaIndex
end function
