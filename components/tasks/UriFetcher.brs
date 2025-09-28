sub init()
    ? "UriFetcher: init()"
    m.port = CreateObject("roMessagePort")
    m.top.observeField("request", m.port)
    m.top.functionName = "go"
    m.top.control = "RUN"
    m.urlTransfer = CreateObject("roUrlTransfer")
end sub

sub go()
    ? "UriFetcher: go()"
    while true
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGNodeEvent"
            ? "roSGNodeEvent, do urlXfer"
            ? "msg: " + msg.getField() ' verify request type.
            request = CreateObject("roUrlTransfer")
            request.setMessagePort(m.port)
            request.setCertificatesFile("common:/certs/ca-bundle.crt")
            request.initClientCertificates()
            request.setUrl(msg.getData().context.parameters.uri)
            request.setPort(m.port)
            request.asyncGetToString()
        else if msgType = "roUrlEvent"
            ? "roUrlEvent, handle response"
            processResponse(msg)
        end if
    end while
end sub

sub processResponse(msg as object)
    ? "UriFetcher: processResponse(msg)"
    '  this does at least get my data from the home.json
    if msg.getResponseCode() = 200
        ? "https://home.json: code 200"
        result = { code: msg.getResponseCode(), content: msg.getString() }
        context = m.top.request.context
        if context <> invalid
            context.response = result
        end if
    end if
end sub