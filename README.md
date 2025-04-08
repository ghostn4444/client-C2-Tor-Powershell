# client-C2-Tor-Powershell
Ao invés de usar ferramentas tradicionais como Netcat ou Bash reverse shells, que geralmente são comuns em ambientes Linux, usamos PowerShell — que, por padrão, não possui uma forma nativa de se comunicar com serviços SOCKS5 (como os oferecidos pelo Tor). Por isso, é necessário criar a conexão manualmente via sockets.
