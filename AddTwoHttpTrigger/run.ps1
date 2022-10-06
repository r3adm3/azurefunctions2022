using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# { "name": "Azure" , "val1":1, "val2":2}

# Interact with query parameters or the body of the request.
$name = $Request.Query.Name
$val1 = $Request.Body.val1
$val2 = $Request.Body.val2

# Set default values so function can always run. 
if (-not $name) {
    $name = $Request.Body.Name
}
if (-not $val1){
    $val1 = 300
}
if (-not $val2){
    $val2 = 500
}

$myresult = $val1 + $val2

$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

if ($name) {
    $body = "Hello, $name ($myresult). This HTTP triggered function executed successfully."
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})

# emit line in logs that contains the result of adding two numbers
write-host "Added numbers: $myresult"
