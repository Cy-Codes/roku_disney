sub init()
    m.componentName = m.top.subType()
    logInfo(m.componentName, "init", "MainScene initialized")

    m.progress = CreateObject("roSGNode", "ProgressDialog")
    m.progress.title = "Fetching content"
    m.progress.message = "Press " + chr(10) + " to reload content."
    m.top.dialog = m.progress
    m.homeUri = m.top.baseUri + m.top.homePostfixUri
    makeRequest({ uri: m.homeUri }, "uriResult")

    m.aRowList = m.top.findNode("aRowList")
end sub

' @description handle key presses from roku remote
' @param key string name of key pressed
' @returns true if key handled, faile if not
function onKeyEvent(key as string, press as boolean) as boolean
    if press
        logDebug(m.componentName, "onKeyEvent", key)
        if key = "replay" or key = "OK"
            logDebug(m.componentName, "onKeyEvent", key + " pressed")
            makeRequest({ uri: m.homeUri }, "uriResult")
            return true
        end if
    end if
    return false
end function

' @description creates uriFetcher to get data from network
' @param params params {uri: required, method: GET if not defined}
' @param callback the callback that will listen for uriFetcher results
sub makeRequest(params as object, callback as string)
    logDebug(m.componentName, "makeRequest", "Fetching data")
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
    msgType = type(msg)
    if msgType = "roSGNodeEvent"
        context = msg.getRoSGNode()
        response = msg.getData()
        if response.code = 200
            content = ParseJson(response.content)
            m.progress.close = true
            m.aRowList.visible = true
            m.aRowList.setFocus(true)
        else
            logError(m.componentName, "uriResult", "Failed to get network results.")
            m.progress.close = true
            ' ToDo: Show message to user about replay to attempt to reload the home.json
        end if
    end if
end sub