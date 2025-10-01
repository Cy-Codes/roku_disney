sub init()
    m.componentName = m.top.subType()
    logInfo(m.componentName, "init", "MainScene initialized")

    m.aRowList = m.top.findNode("aRowList")
    m.aRowList.setFocus(true)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "OK"
            logDebug(m.componentName, "okKeyEvent", "OK pressed")
        end if
    end if
end function

' ToDo: support sending verb in params to specify HTTP request type
sub makeRequest(params as object, callback as string)
    m.uriFetcher = CreateObject("roSGNode", "UriFetcher")
    logInfo(m.componentName, "makeRequest", params?.uri)
    context = CreateObject("roSGNode", "Node")
    if type(params) = "roAssociativeArray"
        context.addFields({ params: params, response: {} })
        context.observeField("response", callback)
        m.uriFetcher.request = { context: context }
    end if
end sub

sub uriResult(msg as object)
    ? "MainScene: uriResult"
    msgType = type(msg)
    if msgType = "roSGNodeEvent"
        ? "Results recieved"
        context = msg.getRoSGNode()
        response = msg.getData()

        if response.code = 200
            content = ParseJson(response.content)
        else
            logError(m.componentName, "uriResult", "Failed to get network results.")
        end if
    end if
end sub