sub main()
    ' showChannelRSGScreen()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.show()

    debugEnabled = true
    setup(debugEnabled)

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub

' @description Create's, shows, and setsFocus of MainScene
sub showChannelRSGScreen()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.show()
end sub

' @description Create  RokuDisney registry and set DebugEnabled flag
' @param isDebugMode should debug logs be enabled
' @returns void
sub setup(isDebugMode as boolean)
    sec = createObject("roRegistrySection", "RokuDisney")
    if isDebugMode
        sec.write("DebugEnabled", "true")
    else
        sec.write("DebugEnabled", "false")
    end if
    sec.flush()
    if sec.read("DebugEnabled") = "true"
        ? "DEBUG MODE ENABLED"
    end if
end sub