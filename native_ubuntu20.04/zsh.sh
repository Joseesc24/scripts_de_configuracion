#!/bin/bash

scripts_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source $scripts_path/commons.sh

home=$HOME
user=$USER

remove_and_ask_password

print_title "Iniciando Istalación Y Configuración De Zsh"

print_title "1/5 - Instalando Zsh"

the_package="zsh"

if dpkg -s $the_package &>/dev/null; then

    print_text "$the_package ya está instalado, no hace falta hacer más cambios"

else

    print_text "$the_package no está instalado, instalandolo $the_package"

    sudo apt-get install -y $the_package

fi

print_title "2/5 - Configurando Zsh Como Shell Por Defecto"

sudo usermod --shell $(which zsh) $user >/dev/null

print_title "3/5 - Instalando Oh-My-Zsh"

folder_path=$home/.oh-my-zsh

if test -d $folder_path; then

    print_text "oh-my-zsh ya está instalado, no hace falta hacer más cambios"

else

    print_text "oh-my-zsh no esta instalado, instalando oh-my-zsh"

    curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    zsh &

fi

print_title "4/5 - Instalando Plugins Oficiales De Oh-My-Zsh"

zsh_official_plugins=(
    "zsh-syntax-highlighting"
    "zsh-autosuggestions"
)

for plugin in "${zsh_official_plugins[@]}"; do

    folder_path=${ZSH_CUSTOM:-$home/.oh-my-zsh/custom}/plugins/$plugin

    if test -d $folder_path; then

        print_text "$plugin ya está instalado, no hace falta hacer más cambios"

    else

        print_text "$plugin no esta instalado, instalando $plugin"

        git clone https://github.com/zsh-users/$plugin $folder_path

    fi

done

print_title "5/5 - Instalando Powerlevel10k Para Oh-My-Zsh"

folder_path=${ZSH_CUSTOM:-$home/.oh-my-zsh/custom}/themes/powerlevel10k

if test -d $folder_path; then

    print_text "powerlevel10k ya está instalado, no hace falta hacer más cambios"

else

    print_text "powerlevel10k no está instalado, instalando powerlevel10k"

    git clone --depth=1 https://github.com/romkatv/powerlevel10k $folder_path

fi

print_title "Istalación Y Configuración De Zsh Finalizada, Reinicie Su Terminal"
