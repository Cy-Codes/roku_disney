sub logInfo(componentName as string, functionName as string, message as string)
    timestamp = CreateObject("roDateTime").ToISOString()
    ? "INFO [" + timestamp + "] " + componentName + "." + functionName + ": " + message
end sub

sub logDebug(componentName as string, functionName as string, message as string)
    sec = CreateObject("roRegistrySection", "RokuDisney")
    if sec.Exists("DebugEnabled") and sec.Read("DebugEnabled") = "true"
        timestamp = CreateObject("roDateTime").ToISOString()
        ? "DEBUG [" + timestamp + "] " + componentName + "." + functionName + ": " + message
    end if
end sub

sub logWarning(componentName as string, funcitonName as string, message as string)
    timestamp = CreateObject("roDateTime").ToISOString()
    ? "WARNING [" + timestamp + "]" + componentName + "." + funcitonName + ":" + message
end sub

sub logError(componentName as string, functionName as string, message as string)
    timestamp = CreateObject("roDateTime").ToISOString()
    ? "ERROR [" + timestamp + "] " + componentName + "." + functionName + ": " + message
end sub