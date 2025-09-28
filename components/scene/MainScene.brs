sub init()
    ? "MainScene: init()"
    m.uriFetcher = CreateObject("roSGNode", "UriFetcher")
    m.statusLabel = m.top.findNode("dataRecieved")
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "OK"
            ? "OK key event, makeRequest()"
            uri = "https://cd-static.bamgrid.com/dp-117731241344/home.json"
            makeRequest({ uri: uri }, "uriResult")
        end if
    end if
end function

sub makeRequest(parameters as object, callback as string)
    ? "MainScene: makeRequest()"
    context = CreateObject("roSGNode", "Node")
    if type(parameters) = "roAssociativeArray"
        context.addFields({ parameters: parameters, response: {} })
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
            m.statusLabel.text = "200: Success"
            content = ParseJson(response.content)
        else
            m.statusLabel.text = "Shits Fucked!"
        end if
    end if
end sub