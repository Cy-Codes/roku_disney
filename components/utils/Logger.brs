' ToDo: Wouldn't hurt to add a flag for logging levels.
' Doubt I'll find time this week. -CyM

sub init()
    ? "Init Logger"
end sub

sub info(componentName as string, functionName as string, message as string)
    timestamp = CreateObject("roDateTime").ToISOString()
    ? "INFO [" + timestamp + "] " + componentName + "." + functionName + ": " + message
end sub

sub debug(componentName as string, functionName as string, message as string)
    sec = CreateObject("roRegistrySection", "RokuDisney")
    if sec.Exists("DebugEnabled") and sec.Read("DebugEnabled") = "true"
        timestamp = CreateObject("roDateTime").ToISOString()
        ? "DEBUG [" + timestamp + "] " + componentName + "." + functionName + ": " + message
    end if
end sub

sub error(componentName as string, functionName as string, message as string)
    timestamp = CreateObject("roDateTime").ToISOString()
    ? "ERROR [" + timestamp + "] " + componentName + "." + functionName + ": " + message
end sub