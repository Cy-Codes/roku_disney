sub init()
    m.componentName = m.top.subType()
    m.port = CreateObject("roMessagePort")
    m.top.observeField("request", m.port)
    m.top.functionName = "go"
    m.top.control = "RUN"
    m.urlTransfer = CreateObject("roUrlTransfer")
end sub

sub go()
    while true
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGNodeEvent"
            request = CreateObject("roUrlTransfer")
            request.setMessagePort(m.port)
            request.setCertificatesFile("common:/certs/ca-bundle.crt")
            ' I don't need the devId, but I'll want to reference this later.
            request.addHeader("X-Roku-Reserved-Dev-Id", "")
            msgParams = msg.getData().context.params
            m.url = msgParams.uri
            ' Expected if fetching setRef & used in processResponse(msg) to verify what I'm processing
            m.refId = msgParams.refId
            request.setUrl(m.url)
            request.setPort(m.port)
            request.asyncGetToString()
        else if msgType = "roUrlEvent"
            processResponse(msg)
        end if
    end while
end sub

' @description Handle response from roUrlTransfer
' @param msg response from roUrlTransfer
sub processResponse(msg as object)
    failureReason = msg.getFailureReason()
    responseCode = msg.getResponseCode()
    logDebug(m.componentName, "ProcessResponse", "FailureReason: " + failureReason + " code: " + responseCode.toStr())
    ' ToDo: support other response codes.
    if failureReason = "OK"
        ' I hate this hack. I hope I have time to fix this. -CyM
        ' Only haveing 2 URLs to check, this'll work, but oh so unexceptable.
        if m.url = getHomeUrl()
            curatedSets = handleContent(parseJson(msg.getString()))
            ' FixMe: I doub't I need to pass the responseCode on.
            m.result = { code: msg.getResponseCode(), content: curatedSets }
        else ' if m.url = getSetRefUrl(m.refId) ' Maybe check this way and use else for logError(unk url)
            setRefs = handleContent(parseJson(msg.getString()))
            m.result = { code: msg.getResponseCode(), content: setRefs }
        end if
        context = m.top.request.context
        if context <> invalid
            context.response = m.result
        else
            logError(m.componentName, "processResponse", "Response context is invalid")
        end if
    else
        logError(m.componentName, "processResponse", "Unexpected response: " + failureReason + " code: " + responseCode)
    end if
end sub