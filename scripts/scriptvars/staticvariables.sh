#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
##################
## General Vars ##
##################

## Repo Name
git_repo_name=piholeparser

## Vars Saved Outside the Repo
OUTSIDEDIRVARS=/etc/"$git_repo_name".sh
if
[[ -f $OUTSIDEDIRVARS ]]
then
  source $OUTSIDEDIRVARS
else
  echo "Outside Vars File Missing, Exiting."
  exit
fi

# We'll set the locale here for idn later
export LC_ALL=C.UTF-8

## These are the colors used throughout the script.
red='\e[1;31m%s\e[0m\n'
green='\e[1;32m%s\e[0m\n'
yellow='\e[1;33m%s\e[0m\n'
blue='\e[1;34m%s\e[0m\n'
magenta='\e[1;35m%s\e[0m\n'
cyan='\e[1;36m%s\e[0m\n'
orange='\e[38;5;166m%s\e[0m\n'
lightblue='\e[38;5;111m%s\e[0m\n'

## Download as a Browser
AGENTDOWNLOAD="User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.89 Safari/537.36"

## Github 100MB limit
GITHUBLIMIT=104857600
GITHUBLIMITMB=100

## On Screen Text
DIVIDERBAR="___________________________________________________________"
DIVIDERBARB="___________________________________________________________"

#################
## Main Folder ##
#################

## Directory
MAINREPOFOLDERDIR="$git_local_repo_path"
MAINREPOFOLDERGIT="https://github.com/$git_repo_owner/$git_repo_name/blob/$git_repo_branch/"
MAINREPOFOLDERGITB="https://github.com/$git_repo_owner/$git_repo_name/"
MAINREPOFOLDERGITRAW="https://raw.githubusercontent.com/$git_repo_owner/$git_repo_name/$git_repo_branch/"
MAINREPOFOLDERGITTAG="[Return To Repository]($MAINREPOFOLDERGITB)"

## README.md
MAINREPOREADMEMD="$MAINREPOFOLDERDIR"README.md
MAINREPOREADMEMDGIT="$MAINREPOFOLDERGIT"README.md

#####################
## Recent Run Logs ##
#####################

## Main Logs Folder
RECENTRUNLOGSDIR="$MAINREPOFOLDERDIR"RecentRunLogs/
RECENTRUNLOGSDIRGIT="$MAINREPOFOLDERGIT"RecentRunLogs/
RECENTRUNLOGSDIRCLEAN="$RECENTRUNLOGSDIR*/"

## Main Log .md
MAINRECENTRUNLOGMD="$RECENTRUNLOGSDIR"Mainlog.md
MAINRECENTRUNLOGMDGIT="$RECENTRUNLOGSDIRGIT"Mainlog.md
MAINRECENTRUNLOGMDGITTAG="[Return To Main]($MAINRECENTRUNLOGMDGIT)"

## Top Level Scripts Logs
TOPLEVELSCRIPTSLOGSDIR="$RECENTRUNLOGSDIR"TopLevelScripts/
TOPLEVELSCRIPTSLOGSDIRGIT="$RECENTRUNLOGSDIRGIT"TopLevelScripts/

## Clean Log Directories
CLEANRECENTRUNLOGSONE="$RECENTRUNLOGSDIR*.md"
CLEANRECENTRUNLOGSTWO=$RECENTRUNLOGSDIR'*/*.md'
CLEANRECENTRUNLOGSTHREE=$RECENTRUNLOGSDIR'*/*/*.md'

########################
## Subscribable Lists ##
########################

## Main Subscribable Lists Folder
SUBSCRIBABLELISTSDIR="$MAINREPOFOLDERDIR"Subscribable-Lists/
SUBSCRIBABLELISTSDIRGITRAW="$MAINREPOFOLDERGITRAW"Subscribable-Lists/

## Country Codes Lists
COUNTRYCODESSUBSDIR="$SUBSCRIBABLELISTSDIR"CountryCodesLists/
    COUNTRYCODESLISTSSUBALL="$COUNTRYCODESSUBSDIR*.txt"

## Combined Blacklists
COMBINEDBLACKLISTSSUBDIR="$SUBSCRIBABLELISTSDIR"CombinedBlacklists/
COMBINEDBLACKLISTSSUBDIRGITRAW="$SUBSCRIBABLELISTSDIRGITRAW"CombinedBlacklists/
    COMBINEDBLACKLISTSSUBALL="$COMBINEDBLACKLISTSSUBDIR*.txt"
    COMBINEDBLACKLISTS="$COMBINEDBLACKLISTSSUBDIR"CombinedBlackLists.txt
    COMBINEDBLACKLISTSGITRAW="$COMBINEDBLACKLISTSSUBDIRGITRAW"CombinedBlackLists.txt
    COMBINEDBLACKLISTSDBB="$COMBINEDBLACKLISTSSUBDIR"DeathbybandaidList.txt
    COMBINEDBLACKLISTSDBBGITRAW="$COMBINEDBLACKLISTSSUBDIRGITRAW"DeathbybandaidList.txt
    COMBINEDBLACKLISTSDBBWOPORN="$COMBINEDBLACKLISTSSUBDIR"DeathbybandaidList-withoutporn.txt
    COMBINEDBLACKLISTSDBBWOPORNGITRAW="$COMBINEDBLACKLISTSSUBDIRGITRAW"DeathbybandaidList-withoutporn.txt

## Combined Whitelists
COMBINEDWHITELISTSSUBDIR="$SUBSCRIBABLELISTSDIR"CombinedWhitelists/
    COMBINEDWHITELISTSSUBALL="$COMBINEDWHITELISTSSUBDIR*.txt"
    COMBINEDWHITELISTS="$COMBINEDWHITELISTSSUBDIR"CombinedWhiteLists.txt
    COMBINEDWHITELISTSDBB="$COMBINEDWHITELISTSSUBDIR"DeathbybandaidList.txt

## Parsed Blacklists
PARSEDBLACKLISTSSUBDIR="$SUBSCRIBABLELISTSDIR"ParsedBlacklists/
    PARSEDBLACKLISTSSUBALL="$PARSEDBLACKLISTSSUBDIR*.txt"

## Parsed Whitelists
PARSEDWHITELISTSSUBDIR="$SUBSCRIBABLELISTSDIR"ParsedWhitelists/
    PARSEDWHITELISTSSUBALL="$PARSEDWHITELISTSSUBDIR*.txt"

####################
## Mirrored Files ##
####################

## Main Mirrored Directory
MIRROREDFILESDIR="$MAINREPOFOLDERDIR"MirroredFiles/
MIRROREDLISTSDIRRAW="$MAINREPOFOLDERGITRAW"MirroredFiles/

## Mirrored Black Lists
    MIRROREDBLACKLISTSSUBDIR="$MIRROREDFILESDIR"MirroredBlacklists/
    MIRROREDBLACKLISTSSUBDIRGITRAW="$MIRROREDLISTSDIRRAW"MirroredBlacklists/
        MIRROREDBLACKLISTSSUBALL="$MIRROREDBLACKLISTSSUBDIR*.txt"

## Mirrored White Lists
    MIRROREDWHITELISTSSUBDIR="$MIRROREDFILESDIR"MirroredWhiteists/
        MIRROREDWHITELISTSSUBALL="$MIRROREDWHITELISTSSUBDIR*.txt"

## Mirrored TLD Lists
    MIRROREDTLDLISTSSUBDIR="$MIRROREDFILESDIR"MirroredTLDlists/
        MIRROREDTLDLISTSSUBALL="$MIRROREDTLDLISTSSUBDIR*.txt"

##################
## Script Lists ##
##################

## Main Folder for .lst files
SCRIPTLSTSDIR="$MAINREPOFOLDERDIR"ScriptLsts/

## Black lsts Folder
    BLACKLSTSDIR="$SCRIPTLSTSDIR"Blacklsts/
        COMBINEDBLACKLISTSSOURCE="$BLACKLSTSDIR"CombinedBlackLsts.lst

## Black Domains, small internal lists
    BLACKDOMAINSDIR="$BLACKLSTSDIR"BlackDomains/
        BLACKDOMAINSALL="$BLACKDOMAINSDIR*.domains"
        BLACKSCRIPTDOMAINS="$BLACKDOMAINSDIR"Script.domains

## Black lst's
    BLACKLSTALL="$BLACKLSTSDIR"'*/*.lst'

## Dead Lists
    DEADBLACKLSTDIR="$BLACKLSTSDIR"DeadBlacklsts/
        DEADBLACKLSTALL="$DEADBLACKLSTDIR*.lst"

## Main Black lst folder (active)
    MAINBLACKLSTSDIR="$BLACKLSTSDIR"MainBlacklsts/

## Lists that don't survive parsing
    BLACKLSTSTHATDIEDIR="$BLACKLSTSDIR"BlacklstsThatDie/
        BLACKLSTSTHATDIEALL="$BLACKLSTSTHATDIEDIR*.list"

## White lsts Folder
    WHITELSTSDIR="$SCRIPTLSTSDIR"Whitelsts/
        COMBINEDWHITELISTSSOURCE="$WHITELSTSDIR"CombinedWhiteLsts.lst

## White Domains, small internal lists
    WHITEDOMAINSDIR="$WHITELSTSDIR"WhiteDomains/
        WHITEDOMAINSALL="$WHITEDOMAINSDIR*.domains"
        WHITESCRIPTDOMAINS="$WHITEDOMAINSDIR"Script.domains

## WHITE lst's
    WHITELSTALL="$WHITELSTSDIR"'*/*.lst'

## Dead Lists
    DEADWHITELSTDIR="$WHITELSTSDIR"DeadWhitelsts/
        DEADWHITELSTALL="$DEADWHITELSTDIR*.lst"

## Main WHITE lst folder (active)
    MAINWHITELSTSDIR="$WHITELSTSDIR"MainWhitelsts/

## Lists that don't survive parsing
    WHITELSTSTHATDIEDIR="$WHITELSTSDIR"WhitelistsThatDie/
        WHITELSTSTHATDIEALL="$WHITELSTSTHATDIEDIR*.list"

## TLD lsts Folder
    TLDLSTSDIR="$SCRIPTLSTSDIR"TLDlsts/

## TLD Backup
        TLDBKUPDIR="$TLDLSTSDIR"Backup/
            TLDBKUP="$TLDBKUPDIR"TLDBackup.txt

## Main TLD lst Folder
    MAINTLDLSTSDIR="$TLDLSTSDIR"MainTLDlsts/
        TLDLSTALL="$MAINTLDLSTSDIR*.lst"

## Country Codes TLD's
    COUNTRYCODESTLDDIR="$SCRIPTLSTSDIR"CountryCodes/
        COUNTRYCODESTLDALL="$COUNTRYCODESTLDDIR*.lst"

#################
## Scripts Dir ##
#################

## Main Scripts Folder
SCRIPTSDIR="$MAINREPOFOLDERDIR"scripts/

## The Script That Ties it all together
TOPRUNSCRIPT="$SCRIPTSDIR"runscripts.sh

## Installer Script
INSTALLERSCRIPT="$SCRIPTSDIR$git_repo_name"install.sh
INSTALLERSCRIPTRAW="$MAINREPOFOLDERGITRAW$git_repo_name"install.sh

## Scriptvars
SCRIPTVARSDIR="$SCRIPTSDIR"scriptvars/
    MAINREPOREADMEMDDEFAULT="$SCRIPTVARSDIR"README.md.default
    DYNOVARS="$SCRIPTVARSDIR"dynamicvariables.sh

## Parsing Process
PARSINGPROCESSSCRIPTSDIR="$SCRIPTSDIR"Parsing-Process/
PARSINGPROCESSSCRIPTSALL="$PARSINGPROCESSSCRIPTSDIR*.sh"

## Tool Scripts
####### Insert later

## Top Level Scripts
TOPLEVELSCRIPTSDIR="$SCRIPTSDIR"TopLevelScripts/

## Common Scripts
    COMMONSCRIPTSDIR="$SCRIPTSDIR"CommonScripts/
        AVATARSCRIPT="$COMMONSCRIPTSDIR"avatar.sh
        DELETETEMPFILE="$COMMONSCRIPTSDIR"deletetempfile.sh
        RUNLOGSCRIPT="$COMMONSCRIPTSDIR"RecentRunLogs.sh
        PUSHTOGITHUBSCRIPT="$COMMONSCRIPTSDIR"Pushing-Lists-To-Github.sh
        update_config_file="$COMMONSCRIPTSDIR"Update-Config-File.sh

##############
## Temp Dir ##
##############

## Temp Folder
TEMPDIR="$git_local_repo_path"temp/

## Temp Files
TEMPFILE="$TEMPDIR"tempfile.txt
FILETEMP="$TEMPDIR"filetemp.txt

## .temp files
TRYNACATCHFIlES="$TEMPDIR"trynacatchfiles.temp
TRYNACATCHINVALIDS="$TEMPDIR"trynacatchinvalids.temp
NOHTTPSLISTS="$TEMPDIR"listswithouthttps.temp
TLDCOMPARED="$TEMPDIR"tldcomparison.temp
TEMPLOGMAIN="$TEMPDIR"mainlog.temp
MORETHANONESOURCE="$TEMPDIR"listswithmorethanonesource.temp
VALIDDOMAINTLD="$TEMPDIR"validdomaintld.temp
WHITELISTTEMP="$TEMPDIR"whitelist.temp
BLACKLISTTEMP="$TEMPDIR"blacklist.temp
PARSEAVERAGEFILETIME="$TEMPDIR"parseaveragetime.temp
PARSEAVERAGEFILELINES="$TEMPDIR"parseaveragelines.temp

## Compressed Temp
COMPRESSEDTEMPTAR="$TEMPDIR"compressedseventemporaryfile.tar.gz
COMPRESSEDTEMPSEVEN="$TEMPDIR"compressedseventemporaryfile.7z
COMPRESSEDTEMPZIP="$TEMPDIR"compressedziptemporaryfile.zip

## Temp Vars
TEMPVARS="$TEMPDIR"tempvars.sh
TEMPPARSEVARS="$TEMPDIR"tempparsevars.sh

## Temp Cleanup
TEMPCLEANUPONE="$TEMPDIR*.txt" #TEMPCLEANUP
TEMPCLEANUPTWO="$TEMPDIR*.temp" #TEMPCLEANUPB
TEMPCLEANUPTHREE="$TEMPDIR*.sh" #TEMPCLEANUPC

## Lettered Temps
TEMPFILEA="$TEMPDIR"tempfileA.txt
TEMPFILEB="$TEMPDIR"tempfileB.txt
TEMPFILEC="$TEMPDIR"tempfileC.txt
TEMPFILED="$TEMPDIR"tempfileD.txt
TEMPFILEE="$TEMPDIR"tempfileE.txt
TEMPFILEF="$TEMPDIR"tempfileF.txt
TEMPFILEG="$TEMPDIR"tempfileG.txt
TEMPFILEH="$TEMPDIR"tempfileH.txt
TEMPFILEI="$TEMPDIR"tempfileI.txt
TEMPFILEJ="$TEMPDIR"tempfileJ.txt
TEMPFILEK="$TEMPDIR"tempfileK.txt
TEMPFILEL="$TEMPDIR"tempfileL.txt
TEMPFILEM="$TEMPDIR"tempfileM.txt
TEMPFILEN="$TEMPDIR"tempfileN.txt
TEMPFILEO="$TEMPDIR"tempfileO.txt
TEMPFILEP="$TEMPDIR"tempfileP.txt
TEMPFILEQ="$TEMPDIR"tempfileQ.txt
TEMPFILER="$TEMPDIR"tempfileR.txt
TEMPFILES="$TEMPDIR"tempfileS.txt
TEMPFILET="$TEMPDIR"tempfileT.txt
TEMPFILEU="$TEMPDIR"tempfileU.txt
TEMPFILEV="$TEMPDIR"tempfileV.txt
TEMPFILEW="$TEMPDIR"tempfileW.txt
TEMPFILEX="$TEMPDIR"tempfileX.txt
TEMPFILEY="$TEMPDIR"tempfileY.txt
TEMPFILEZ="$TEMPDIR"tempfileZ.txt
