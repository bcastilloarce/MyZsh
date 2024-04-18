#!/bin/zsh
# Archivo: .zshrc
# Última modificación: [17-04-2024]

## CONFIGURACIÓN DE MI ZSH ##

# CodeWhisperer pre block. Mantener en la parte superior de este archivo.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"

## CONFIGURACIÓN DEL SISTEMA ##

# Establecer la variable PATH para incluir directorios de binarios de usuario y sistema
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Establecer la ruta de instalación de Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"

# Agregar el directorio bin de Homebrew al PATH
export PATH="/opt/homebrew/bin:$PATH"

# Establecer Brew Shellenv
eval $(/opt/homebrew/bin/brew shellenv)

## CONFIGURACIÓN DE OH-MY-ZSH ##

# Establecer el tema a utilizar por Oh-My-Zsh
ZSH_THEME="tarcadia"

# Definir los plugins a utilizar por Oh-My-Zsh
plugins=(z git thefuck vscode zsh-autosuggestions zsh-syntax-highlighting)

## PERSONALIZACIÓN DEL TERMINAL ##

# Inicializar el sistema de completado de Zsh
autoload -U compinit && compinit

# Actualizar automáticamente Oh-My-Zsh una vez al día
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 1

# Habilitar el autocompletado de comandos
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

# Habilitar corrección (comentar para deshabilitar)
setopt CORRECT

## FUENTES DE SCRIPTS ##

# Fuente del script principal de Oh-My-Zsh
source "$ZSH/oh-my-zsh.sh"

# Fuente del script de sugerencias automáticas de Zsh
source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Fuente del script de autojump
AUTOJUMP_SCRIPT="/opt/homebrew/etc/profile.d/autojump.sh"
[ -f "$AUTOJUMP_SCRIPT" ] && source "$AUTOJUMP_SCRIPT"

# Fuente del script Z.sh
Z_SCRIPT="/opt/homebrew/etc/profile.d/z.sh"
[ -f "$Z_SCRIPT" ] && source "$Z_SCRIPT"

# Fuente del script de inicio de Broot
BROOT_SCRIPT="/Users/medianoche/.config/broot/launcher/bash/br"
[ -f "$BROOT_SCRIPT" ] && source "$BROOT_SCRIPT"

# Fuente del script de completado de Bash y Shell si está disponible
BASH_COMPLETION_SCRIPT="/opt/homebrew/etc/profile.d/bash_completion.sh"
[[ -r "$BASH_COMPLETION_SCRIPT" ]] && source "$BASH_COMPLETION_SCRIPT"

# Fuente del script de integración de shell de iTerm2 si está disponible
ITERM_INTEGRATION_SCRIPT="${HOME}/.iterm2_shell_integration.zsh"
[[ -e "$ITERM_INTEGRATION_SCRIPT" ]] && source "$ITERM_INTEGRATION_SCRIPT"

# Configurar grep para que sea más nice
grep-flag-available() { echo | grep $1 "" >/dev/null 2>&1; }
local GREP_OPTIONS=""
if grep-flag-available --color=auto; then GREP_OPTIONS+=" --color=auto"; fi
if grep-flag-available --exclude-dir=.cvs; then GREP_OPTIONS+=" --exclude-dir={.bzr,CVS,.git,.hg,.svn}"; fi
if grep-flag-available --exclude=.cvs; then GREP_OPTIONS+=" --exclude={.bzr,CVS,.git,.hg,.svn}"; fi
alias grep="grep $GREP_OPTIONS"
unfunction grep-flag-available

## ALIAS PERSONALIZADOS ##

# Alias para mostrar todas las definiciones de alias en el archivo .zshrc
alias okalias='grep "^alias" ~/.zshrc | cat'

# Abrir archivo Zshrc en Visual Studio Code
alias zshrc='code ~/.zshrc'

# Abrir directorio de Oh-My-Zsh en Visual Studio Code
alias ohmyzsh='code ~/.oh-my-zsh'

# Muestra registros del sistema por intervalo de tiempo
alias log1='log_show_1h() { log show --last 1h \
 --predicate "eventMessage contains \"$1\""; }; log_show_1h'
alias log12='log_show_12h() { log show --last 12h \
--predicate "eventMessage contains \"$1\""; }; log_show_12h'
alias log24='log_show_24h() { log show --last 24h \
--predicate "eventMessage contains \"$1\""; }; log_show_24h'
alias logx='log_show() { log show \
 --predicate "eventMessage contains \"$1\""; }; log_show'

# Buscar archivos por nombre
alias find123="find / -name \$1 2>/dev/null"

# Expulsar un disco
alias eject4='diskutil unmountDisk /dev/disk4 && sleep 2 && diskutil eject /dev/disk4'

# Update virus definitions using sudo freshclam
alias okupdateclam='sudo freshclam'

# Scan external volume /Volumes/Clips
alias okscanclips='sudo freshclam && clamdscan --recursive --exclude-dir=ok --bell -v \
/Volumes/Clips > ~/Desktop/clamav_clips_error_log.json'

# Scan external volume /Volumes/MiniMac
alias okscanminimac='sudo freshclam && clamdscan --recursive --exclude-dir=ok --bell -v \
/Volumes/MiniMac > ~/Desktop/clamav_minimac_error_log.json'

# Scan external volume /Volumes/Install macOS Sonoma
alias okscaninstall='sudo freshclam && clamdscan --recursive --exclude-dir=ok --bell -v \
/Volumes/Install\ macOS\ Sonoma > ~/Desktop/clamav_install_error_log.json'

# Scan external volume /Volumes/Otros
alias okscanotros='sudo freshclam && clamdscan --recursive --exclude-dir=ok --bell -v \
/Volumes/Otros > ~/Desktop/clamav_otros_error_log.json'

# Matar procesos por nombre
alias okpid='pids=$(pidof "$1"); if [ -z "$pids" ]; then\
echo "No se encontraron procesos con el nombre: $1"; return 1; fi;\
echo "Detalles de los procesos encontrados:"; ps aux | grep "$1";\
echo "PID de los procesos encontrados: $pids"; echo -n "¿Desea\
 matar los procesos? (s/n): "; read response < /dev/tty;\
if [[ $response == "s" ]]; then for pid in $pids; do sudo\
 pkill $pid; done; fi'

# Alias para Homebrew
alias bi='brew install'
alias bre='brew reinstall'
alias bu='brew uninstall'
alias bs='brew search'
alias bl='brew list'

# Actualizar Homebrew, verificar dependencias faltantes y limpiar
alias okbrew='brew update && brew upgrade && brew missing &&\
 brew cleanup && brew doctor'

# Función para actualizar pip y los paquetes instalados
alias okpip='pip3 install --upgrade pip;\
outdated_packages=$(pip3 list --outdated | awk "NR>2 {print \$1}");\
if [[ -n $outdated_packages ]]; then echo "Actualizando\
 paquetes desactualizados..."; for package in $outdated_packages;\
 do pip3 install --upgrade $package; done; else echo "No hay\
 paquetes desactualizados."; fi; pip3 check'

# Activar entorno virtual de Python
alias okvenv='source $HOME/Python3/bin/activate'

# Aleatorizar direcciones MAC de red
alias rando034x='sudo /opt/homebrew/opt/spoof-mac/bin/spoof-mac\
 randomize en0 && sudo /opt/homebrew/opt/spoof-mac/bin/spoof-mac\
 randomize en3 && sudo /opt/homebrew/opt/spoof-mac/bin/spoof-mac\
 randomize en4 && spoof-mac list'

alias rando034="sudo /opt/homebrew/bin/macchanger -r en0 && sudo /opt/homebrew/bin/macchanger \
-r en3 && sudo /opt/homebrew/bin/macchanger -r en4 && /opt/homebrew/bin/macchanger -s en0"

# Ejecutar HandBrakeCLI con un preset específico (Archivos)
alias hand123='function _hand123() { HandBrakeCLI --preset-import-file \
/opt/homebrew/Cellar/handbrake/1.7.3/SuperVideos.json -i "$1" -o \
"${1%.*}_REPARADO.mp4"; }; _hand123'

# Ejecutar HandBrakeCLI con un preset específico (Carpetas)
alias hand1234='function _hand1234() { for item in "$@"; do if [ -d "$item" ]; then \
for file in "$item"/*; do if [ -f "$file" ]; then HandBrakeCLI --preset-import-file \
/opt/homebrew/Cellar/handbrake/1.7.3/SuperVideos.json -i "$file" -o "${file%.*}_REPARADO.mp4"; \
fi; done; elif [ -f "$item" ]; then HandBrakeCLI --preset-import-file \
/opt/homebrew/Cellar/handbrake/1.7.3/SuperVideos.json -i "$item" -o "${item%.*}_REPARADO.mp4"; \
fi; done; }; _hand1234'

# Concatenar dos archivos de video
alias okunirff='ffmpeg -i "$1" -i "$2" -filter_complex\
 "[0:v:0][1:v:0]concat=n=2:v=1:a=0[outv]" -map "[outv]"\
 "${1%.*}(EXTENDIDO).mp4"'

# Normalizar el volumen de un archivo de video
alias okvolumen='for file in "$@"; do original_volume=$(ffmpeg\
 -i "$file" -af "volumedetect" -vn -sn -dn -f null /dev/null 2>&1\
 | awk "/mean_volume/ {print \$NF}"); normalized_volume=$(ffmpeg\
 -i "$file" -af loudnorm=I=-16:LRA=11:TP=-1.5 -f null - 2>&1\
 | awk "/Output Integrated/ {print \$NF}"); if (( $(awk "BEGIN\
 {print ($normalized_volume > $original_volume)}") )); then\
 ffmpeg -i "$file" -af loudnorm=I=-16:LRA=11:TP=-1.5\
 "${file%.*}_normalized.mp4"; else echo "El volumen original de $file\
 no es menor que el volumen normalizado. No se aplicó normalización.";\
 fi; done'

# Mostrar información detallada de medios incluyendo el volumen
alias infomedia='mediainfo "$1" \
--Inform="General;%MuxingMode_MoreInfo%: %CodecID%:\
 %CodecID_Description%: %CodecID_Version%:\
 %Format%: %FileSize% (%FileSize/String%)\nAudio;%Volume%"\
 | awk -F ":" "{print \$1 \": \" \$2}"'

# Alias para buscar en archivos .plist
alias gre='grep -rl "$1" /Users/medianoche/Library/Preferences/*.plist'

# CodeWhisperer post block. Mantener al final de este archivo.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
