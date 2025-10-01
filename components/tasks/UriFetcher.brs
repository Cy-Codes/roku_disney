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
            request.initClientCertificates()
            request.setUrl(msg.getData().context.params.uri)
            request.setPort(m.port)
            request.asyncGetToString()
        else if msgType = "roUrlEvent"
            processResponse(msg)
        end if
    end while
end sub

' @description Create  RokuDisney registry and set DebugEnabled flag
' @param isDebugMode should debug logs be enabled
' @returns void
sub processResponse(msg as object)
    responseCode = msg.getResponseCode()
    ' ToDo: support other response codes
    ' I know I don't need it for this demo, but not having it bugs me.
    if msg.getResponseCode() = 200
        result = { code: msg.getResponseCode(), content: msg.getString() }
        context = m.top.request.context
        if context <> invalid
            context.response = result
        end if
    else
        logError(m.componentName, "processResponse", "Unexpected response code: " + responseCode)
    end if
end sub