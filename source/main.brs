sub main()
    ? "main: createScreen"
    screen = CreateObject("roSGScreen")
    port = CreateObject("roMessagePort")
    screen.setMessagePort(port)
    scene = screen.CreateScene("MainScene")
    screen.show()
    scene.setFocus(true)

    ' I'll put this in a func after I solve why my logger.functions() are invalid
    isDebugMode = true ' change to false for prod
    logger = CreateObject("roSGNode", "Logger")
    sec = createObject("roRegistrySection", "RokuDisney")
    if isDebugMode
        sec.write("DebugEnabled", "true")
        ? type(logger.info)
        if type(logger.info) <> "Invalid" ' I'm very confident this shouldn't be returning a string of "Invalid"
            logger.info("main.brs", "main()", "DEBUG MODE ENABLED")
        else
            ? "logger functions still invalid"
        end if
    else
        sec.write("DebugEnabled", "false")
    end if
    sec.flush()
    if type(logger.info) <> invalid
        logger.info("main.brs", "main()", "Logger configured")
    else
        ? "Logger encountered an issue"
    end if

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub