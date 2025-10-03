sub init()
    m.componentName = m.top.subType()
    logInfo(m.componentName, "init", "")
    m.progress = CreateObject("roSGNode", "ProgressDialog")
    m.progress.title = "Loading"
    m.progress.message = "Fetching home content"
    m.top.dialog = m.progress
    makeRequest({ uri: getHomeUrl() }, "uriResult")
end sub

' @description handle key presses from roku remote
' @param key string name of key pressed
' @returns true if key handled, faile if not
function onKeyEvent(key as string, press as boolean) as boolean
    if press
        logDebug(m.componentName, "onKeyEvent", key)
        if key = "OK"
            logDebug(m.componentName, "onKeyEvent", key + " pressed")
            return true
        else if key = "Replay"
            logDebug(m.componentName, "okKeyEvent", key + " pressed")
        end if
    end if
    return false
end function

' ToDo: Move this elsewhere. I'd like the MainScene to be as thin as possible.
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

' @description callback to handle results foir the home.json
' @param msg object data from home.json
sub uriResult(msg as object)
    msgType = type(msg)
    if msgType = "roSGNodeEvent"
        logDebug(m.componentName, "uriResult", "msgType: roSGNodeEvent")
        context = msg.getRoSGNode()
        response = msg.getData()
        ' content = ParseJson(response.content)
        m.progress.close = true
        m.aRowList.visible = true
        m.aRowList.setFocus(true)
    else
        logError(m.componentName, "uriResult", "Failed to get network results.")
        m.progress.close = true
        ' ToDo: Show message to user about replay to attempt to reload the home.json
    end if
end sub

sub setUpRows()
    m.aRowList = m.top.findNode("aRowList")
    m.aRowList.setFocus(true)
end sub