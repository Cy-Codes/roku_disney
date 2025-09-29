sub init()
    m.top.functionName = "fetchHomeContent"
end sub

sub fetchHomeContent()
    ' tracking request time for debugging ToDo: Remove or comment out for release
    tiemSpan = createObject("roTimeSpan")

    homeContent = createObject("roSGNode", "ContentNode")


    request = createObject("roUrlTransfer")
    request.setMessagePort(port)
    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.addHeader("X-Roku-Reserved-Dev-Id", "")
    request.initClientCertificates()
    ' FixMe: put the url in a const
    request.setUrl(m.top.homeUri)
    ' FixMe: add error checking to this!
    response = request.getToString()
    json = parseJson(response)
    ? "fetch took", tiemSpan.totalMilliseconds().toStr(), " milliseconds"

    createContainers(json)
end sub

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