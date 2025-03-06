# Optimisation Windows - Mode Gamer

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)  [![forthebadge](http://forthebadge.com/images/badges/powered-by-electricity.svg)](http://forthebadge.com)

Script PowerShell développé par Astra pour optimiser les performances des appareils et serveurs Windows en désactivant les services non essentiels pour le gaming, tout en préservant les fonctionnalités principales.

## Pour commencer

Ce script permet d'optimiser rapidement un système Windows en désactivant les services superflus qui peuvent impacter les performances, notamment pour les jeux vidéo.

### Pré-requis

Pour utiliser ce script, vous aurez besoin de :

- Windows 10 ou Windows 11
- PowerShell 5.1 ou supérieur
- Droits administrateur sur votre système

### Installation

1. Téléchargez le fichier `Astra.ps1`
2. Assurez-vous que le fichier est enregistré en UTF-8 sans BOM
3. Placez-le à l'emplacement de votre choix

## Démarrage

Pour lancer le script :

1. Ouvrez PowerShell en tant qu'administrateur
2. Exécutez la commande suivante pour définir l'encodage UTF-8 :
   ```powershell
   chcp 65001
   ```
3. Naviguez vers le dossier contenant le script
4. Exécutez le script :
   ```powershell
   .\Astra.ps1
   ```

Le script affichera une interface stylisée avec des indicateurs colorés pour suivre la progression des opérations.

## Fonctionnalités

Le programme principal du script est "main", qui orchestre l'ensemble du processus d'optimisation.

Le script désactive les services Windows suivants :
- DiagTrack (Télémétrie et diagnostics)
- WaaSMedicSvc (Service de réparation Windows Update)
- Services Xbox (XblAuthManager, XboxNetApiSvc, XblGameSave)
- GamingServices et GamingServicesNet (si non utilisés)
- WSearch (Recherche Windows)
- RemoteRegistry (Registre à distance)
- Fax (Service de télécopie)
- RetailDemo (Mode démo)
- OneSyncSvc (Synchronisation des applications)
- SysMain (Anciennement Superfetch)
- WbioSrvc (Biométrie)

## Fabriqué avec

* [PowerShell](https://docs.microsoft.com/en-us/powershell/) - Langage de script et shell de Microsoft
* [Visual Studio Code](https://code.visualstudio.com/) - Éditeur de code (probable)

## Personnalisation

Pour personnaliser la liste des services à désactiver, modifiez la liste `$servicesToDisable` dans le script selon vos besoins.

Pour réactiver un service après utilisation du script :
```powershell
Set-Service -Name "NomDuService" -StartupType Automatic
Start-Service -Name "NomDuService"
```

## Versions

**Dernière version :** 1.0

## Auteurs

* **Astra** - *Développement initial* - [Astra](https://exemple.com)

## License

Ce projet est sous licence propriétaire appartenant à Astra.

## Avertissement

Utilisez ce script à vos propres risques. Il est recommandé de créer un point de restauration système avant son exécution.