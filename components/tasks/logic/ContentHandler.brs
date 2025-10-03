' ToDo: I may want to add a field for the sets as a roList.

sub handleContent(json as object) as object
    m.componentName = m.top.subType()
    containers = json.data.StandardCollection.containers
    for each container in containers
        set = container.set
        setType = set.type
        if setType = "CuratedSet"
            curatedSets = [] ' append result to curated set and return
            createCuratedSet(set)
        else if setType = "SetRef"
            setRefs = [] ' append result to setRefs and return
            createSetRef(set)
        else
            logWarning(m.componentName, "createCuratedSet", "Unexpected setType: " + setType)
        end if
    end for
end sub

' @description parse out unused data from curatedSet
' @param set a single curatedSet from home.json
' @return currated setRef of
function createCuratedSet(set as object) as object
    contentTitle = set.text.title.full.set.default.content
    curatedSet = {
        title: contentTitle
        ' icon is later, get the others working first.
        ' icon: sets.items[1.78].uri?
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