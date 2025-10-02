' @description parse out data I want from home.json
' @param json content from home.json
sub createContainers(json as object)
    ' ToDo: name things better
    containers = json.data.StandardCollection.containers
    ? "containers size: ", containers.count()
    ' set up rows of stuff if CuratedSet
    for each container in containers
        set = container.set
        contentTitle = set.text.title.full.set.default.content
        if set.type = "CuratedSet"
            ' I don't think I need container.type past this check -CyM
            curatedSet = {
                title: contentTitle
                ' icon is later, get the others working first.
                ' icon: sets.items[1.78].uri?
            }
            ? "curatedSet: ", curatedSet
        else if set.type = "SetRef"
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
    end for
end sub