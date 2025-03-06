<# 
Script PowerShell nommé "Astra.ps1" – Mode Gamer
Objectif : Désactiver les services Windows jugés superflus pour un usage gaming, tout en laissant actifs les services essentiels (Wi‑Fi, Bluetooth, etc.).
Important :
- Sauvegarder en UTF‑8 sans BOM.
- Lancer "chcp 65001" en console PowerShell pour forcer l'encodage en UTF‑8.
#>

# Forcer l'encodage UTF‑8 pour la sortie console
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Variables globales pour les statistiques
$global:LogStats = @{
    Success = 0
    Warning = 0
    Error   = 0
}

# Fonction d'affichage de logs avec style hacker
function Write-Log {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("INFO","SUCCESS","WARNING","ERROR")]
        [string]$Level,
        [Parameter(Mandatory=$true)]
        [string]$Message
    )
    switch ($Level) {
        "INFO"    { Write-Host "[INFO]    /--> $Message" -ForegroundColor White }
        "SUCCESS" { Write-Host "[SUCCESS] \==> $Message" -ForegroundColor Green; $global:LogStats.Success++ }
        "WARNING" { Write-Host "[WARNING] |--> $Message" -ForegroundColor Yellow; $global:LogStats.Warning++ }
        "ERROR"   { Write-Host "[ERROR]   \--> $Message" -ForegroundColor Red; $global:LogStats.Error++ }
    }
}

# Fonction pour afficher le header stylé "Astra – Mode Gamer" avec la date/heure
function Show-Header {
    $dateTime = Get-Date -Format "dddd, dd MMMM yyyy HH:mm:ss"
    Write-Host "/////////////////////////////////////////////////////////////" -ForegroundColor Cyan
    Write-Host "//                                                         //" -ForegroundColor Cyan
    Write-Host "    _    ____ _____ ____      _    " -ForegroundColor Cyan
    Write-Host "   / \  / ___|_   _|  _ \    / \   " -ForegroundColor Cyan
    Write-Host "  / _ \ \___ \ | | | |_) |  / _ \  " -ForegroundColor Cyan
    Write-Host " / ___ \ ___) || | |  _ <  / ___ \ " -ForegroundColor Cyan
    Write-Host "/_/   \_\____/ |_| |_| \_\/_/   \_\" -ForegroundColor Cyan
    Write-Host "//                                                         //" -ForegroundColor Cyan
    Write-Host "//                       A S T R A                         //" -ForegroundColor Cyan
    Write-Host "/////////////////////////////////////////////////////////////" -ForegroundColor Cyan
    Write-Host "//  Date/Heure : $dateTime" -ForegroundColor Magenta
    Write-Host "/////////////////////////////////////////////////////////////" -ForegroundColor Cyan
    Write-Host ""
}


# Fonction pour afficher le footer stylé avec résumé
function Show-Footer {
    Write-Host ""
    Write-Host "/////////////////////////////////////////////////////////////" -ForegroundColor Cyan
    Write-Host "//                  RÉSUMÉ DES OPÉRATIONS                   //" -ForegroundColor Cyan
    Write-Host "/////////////////////////////////////////////////////////////" -ForegroundColor Cyan
    Write-Host "  Succès   : $($global:LogStats.Success)" -ForegroundColor Green
    Write-Host "  Warnings : $($global:LogStats.Warning)" -ForegroundColor Yellow
    Write-Host "  Erreurs  : $($global:LogStats.Error)" -ForegroundColor Red
    Write-Host "/////////////////////////////////////////////////////////////" -ForegroundColor Cyan
}

# Fonction pour désactiver un service avec gestion des erreurs et logs
function Disable-ServiceCustom {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ServiceName,
        [string]$Comment
    )
    
    Write-Log -Level "INFO" -Message "Traitement de $ServiceName : $Comment"
    $service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
    if ($service) {
        try {
            Set-Service -Name $ServiceName -StartupType Disabled -ErrorAction Stop
            if ($service.Status -eq 'Running') {
                Stop-Service -Name $ServiceName -Force -ErrorAction Stop
            }
            Write-Log -Level "SUCCESS" -Message "$ServiceName a été désactivé avec succès."
        }
        catch {
            Write-Log -Level "ERROR" -Message "$ServiceName : $_"
        }
    }
    else {
        Write-Log -Level "WARNING" -Message "Service $ServiceName introuvable sur ce système."
    }
}

# Affichage du header
Show-Header

# Liste des services à désactiver pour le mode Gamer.
# Cette liste désactive la télémétrie, certains services Xbox et autres services non essentiels pour un PC gamer.
$servicesToDisable = @(
    @{ Name = "DiagTrack";           Comment = "Télémetrie et diagnostics (désactivé pour booster la réactivité)" },
    @{ Name = "WaaSMedicSvc";        Comment = "Service de réparation Windows Update (peut gêner les perfs)" },
    @{ Name = "XblAuthManager";      Comment = "Authentification Xbox (non utilisé si tu joues sur PC)" },
    @{ Name = "XboxNetApiSvc";       Comment = "Réseau Xbox (inutile en mode gamer PC)" },
    @{ Name = "XblGameSave";         Comment = "Sauvegarde Xbox Live (désactive si non utilisé)" },
    @{ Name = "GamingServices";      Comment = "Services de jeux Microsoft (désactive si non utilisé)" },
    @{ Name = "GamingServicesNet";   Comment = "Services de jeux réseau Microsoft (désactive si non utilisé)" },
    @{ Name = "WSearch";             Comment = "Recherche Windows (peut être désactivé pour alléger le système)" },
    @{ Name = "RemoteRegistry";      Comment = "Registre à distance (sécurité et perfs)" },
    @{ Name = "Fax";                 Comment = "Service de télécopie (inutile)" },
    @{ Name = "RetailDemo";          Comment = "Mode démo (inutile)" },
    @{ Name = "OneSyncSvc";          Comment = "Synchronisation des applications (peut être désactivée)" },
    @{ Name = "SysMain";             Comment = "Anciennement Superfetch (peut être désactivé pour booster les perfs)" },
    @{ Name = "WbioSrvc";            Comment = "Biométrie (désactive si tu n'utilises pas de lecteur d'empreintes)" }
)

# Traitement de la liste des services
foreach ($svc in $servicesToDisable) {
    Disable-ServiceCustom -ServiceName $svc.Name -Comment $svc.Comment
}

# Affichage du footer avec le résumé
Show-Footer