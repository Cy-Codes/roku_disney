sub init()
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
            request.initClientCertificates()
            ' FixMe: put the url builder back.
            request.setUrl(msg.getData().context.params.uri)
            request.setPort(m.port)
            request.asyncGetToString()
        else if msgType = "roUrlEvent"
            processResponse(msg)
        end if
    end while
end sub

sub processResponse(msg as object)
    '  this does at least get my data from the home.json
    if msg.getResponseCode() = 200
        result = { code: msg.getResponseCode(), content: msg.getString() }
        context = m.top.request.context
        if context <> invalid
            context.response = result
        end if
    end if
end sub