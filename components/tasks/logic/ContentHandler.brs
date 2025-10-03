sub handleContent(json as object, fromUrl as string) as object
    m.componentName = m.top.subType()
    setList = CreateObject("roList")
    containers = json.data.StandardCollection.containers
    for each container in containers
        set = container.set
        setType = set.type
        ' I know it's not right.
        ' I want something semi presentable to turn in.
        if setType = "CuratedSet" 'and fromUrl = "home"
            setList.addTail(createCuratedSet(set))
            ' I don't have time for this
            ' else if setType = "SetRef" and fromUrl = "refId"
            '     setList.addTail(createSetRef(set))
        else
            logWarning(m.componentName, "createCuratedSet", "Unexpected setType: " + setType)
        end if
    end for
    return setList
end sub

' @description parse out unused data from curatedSet
' @param set a single curatedSet from home.json
' @return curratedSet object of essential data
function createCuratedSet(set as object) as object
    contentTitle = set.text.title.full.set.default.content
    tiles = CreateObject("roList")
    try
        for each item in set.items
            ' my try catches aren't catching anything, would love to know why. -CyM
            ' Some tiles are labled series other program.
            ' I don't have the time to understand why right now.
            tileUrl = item.image.tile["1.78"]?.series?.default?.url
            if tileUrl = invalid
                tileUrl = item.image.tile["1.78"]?.program?.default?.url
            end if
            tileTitle = item.text.title.full?.series?.default?.content
            if tileTitle = invalid
                tileTitle = item.text.title.full?.program?.default?.content
            end if
            tiles.addTail({ tileTitle: tileTitle, tileUrl: tileUrl })
            ' CuratedSet seems a bit too broad,
            ' I think I'm getting a couple of ext that are not structured the way I want
        end for
    catch e
        ? e
    end try
    curatedSet = {
        title: contentTitle
        tiles: tiles
    }
    return curatedSet
end function

' @description parse out unused data from setRef
' @param set a single setRef from sets/{refId}.json
' @return setRef of essential data
function createSetRef(set as object) as object
    setRef = {
        refId: set.refId ' I think the uri to show images are in here -CyM
        title: "Something"
    }
    return setRef
end function