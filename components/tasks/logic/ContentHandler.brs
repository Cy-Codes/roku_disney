' @description parse home.json into object of data I'll use
' @param json content from home.json
' @return object of data I will use in this app from home.json
function createCuratedSet(json as object) as object
    m.componentName = m.top.subType()

    containers = json.data.StandardCollection.containers
    ? "containers size: ", containers.count()
    ' set up rows of stuff if CuratedSet
    for each container in containers
        set = container.set
        contentTitle = set.text.title.full.set.default.content
        icon = set
        if set.type = "CuratedSet"
            ' I don't think I need container.type past this check -CyM
            curatedSet = {
                title: contentTitle
                ' icon is later, get the others working first.
                ' icon: sets.items[1.78].uri?
            }
            ? "curatedSet: ", curatedSet
        else
            ' Shouldn't be any other type, but log the unexpected -CyM
            ' log.e ToDo: add a component lib that's functionally Timber.
            ? "what type are you? ", set.type
        end if
    end for
end function

' @description parse {refId}.json into object of data I'll use
' @param json content from {refId}.json
' @return object of data I will use in this app from {refId}.json
function createSetRef(json as object) as object
    set = container.set
    if set.type = "SetRef" ' Move this to createSetRef
        setRef = {
            refId: set.refId ' I think the uri to show images are in here -CyM
            title: contentTitle
        }
        ? "setRef: ", setRef
    else
        ' Shouldn't be any other type, but log the unexpected -CyM
        ' log.e ToDo: add a component lib that's functionally Timber.
        ? "what type are you? ", set.type
    end if
end function