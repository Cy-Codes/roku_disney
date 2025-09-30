sub logInfo(componentName as string, functionName as string, message as string)
    timestamp = CreateObject("roDateTime").ToISOString()
    ? "INFO [" + timestamp + "] " + componentName + "." + functionName + ": " + message
end sub

sub logDebug(componentName as string, functionName as string, message as string)
    sec = CreateObject("roRegistrySection", "RokuDisney")
    ? sec.Exists("DebugEnabled")
    ? sec.Read("DebugEnabled")
    if sec.Exists("DebugEnabled") and sec.Read("DebugEnabled") = "true"
        timestamp = CreateObject("roDateTime").ToISOString()
        ? "DEBUG [" + timestamp + "] " + componentName + "." + functionName + ": " + message
    end if
end sub

sub logError(componentName as string, functionName as string, message as string)
    timestamp = CreateObject("roDateTime").ToISOString()
    ? "ERROR [" + timestamp + "] " + componentName + "." + functionName + ": " + message
end sub