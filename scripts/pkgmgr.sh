#!/bin/bash

# ===============================
# Package Manager
# ===============================

# Exit the script immediately if any command returns a non-zero exit status
set -e

# If the user did not specify a valid action...
ACTION="${1,,}"
if [[ "$ACTION" != "install" && "$ACTION" != "uninstall" && "$ACTION" != "update" ]]; then
    # Prompt the user to enter a valid action
    echo "$0: error: \"\$ACTION\" (aka \"\$1\") must be specified as install|uninstall|update"
    exit 1
fi

# If the user did not specify at least one package name...
if [ $# -lt 2 ]; then
    # Prompt the user to enter at least one package name
    echo "$0: error: \"\$PKGS\" (aka \"\$2\" ... \"\$N\") must have at least one package name passed to it"
    exit 1
fi

# Remove first argument (the package action), leaving only the package names
shift
PKGS="$@"

# Get the name of the Unix distribution
DISTRO=$(./getdistro.sh)

# Convert the Unix distribution name to all lowercase characters
DISTRO="${DISTRO,,}"

# If the Unix distribution is not supported...
if [ "$DISTRO" = "unknown" ]; then
    # Prompt the user and exit
    echo "$0: error: unsupported unix distribution"
    exit 1
fi

# Perform the user-specified action on the user-specified packages
case "$DISTRO:$ACTION" in
    # Ubuntu/Debian Actions
    ubuntu:install|debian:install)
        sudo apt update
        sudo apt install -y $PKGS
        ;;
    ubuntu:uninstall|debian:uninstall)
        sudo apt remove --purge -y $PKGS
        ;;
    ubuntu:update|debian:update)
        sudo apt update && sudo apt upgrade -y
        ;;
    ubuntu:check|debian:check)
        for pkg in $PKGS; do
            if dpkg -l | grep -q "^ii\s\+$pkg"; then
                echo "$0: note: $pkg is installed"
            else
                echo "$0: error: $pkg is NOT installed"
            fi
        done
        ;;

    # Fedora Actions
    fedora:install)
        sudo dnf install -y $PKGS
        ;;
    fedora:uninstall)
        sudo dnf remove -y $PKGS
        ;;
    fedora:update)
        sudo dnf upgrade -y
        ;;
    fedora:check|centos:check|rhel:check)
        for pkg in $PKGS; do
            if rpm -q "$pkg" >/dev/null 2>&1; then
                echo "$0: note: $pkg is installed"
            else
                echo "$0: error: $pkg is NOT installed"
            fi
        done
        ;;

    # Centos Actions
    centos:install|rhel:install)
        sudo yum install -y $PKGS
        ;;
    centos:uninstall|rhel:uninstall)
        sudo yum remove -y $PKGS
        ;;
    centos:update|rhel:update)
        sudo yum update -y
        ;;
    centos:check|rhel:check)
        for pkg in $PKGS; do
            if rpm -q "$pkg" >/dev/null 2>&1; then
                echo "$0: note: $pkg is installed"
            else
                echo "$0: error: $pkg is NOT installed"
            fi
        done
        ;;

    # Arch/Manjaro Actions
    arch:install|manjaro:install)
        sudo pacman -Syu --noconfirm $PKGS
        ;;
    arch:uninstall|manjaro:uninstall)
        sudo pacman -Rns --noconfirm $PKGS
        ;;
    arch:update|manjaro:update)
        sudo pacman -Syu --noconfirm
        ;;
    arch:check|manjaro:check)
        for pkg in $PKGS; do
            if pacman -Q "$pkg" >/dev/null 2>&1; then
                echo "$0: note: $pkg is installed"
            else
                echo "$0: error: $pkg is NOT installed"
            fi
        done
        ;;

    # Alphine Actions
    alpine:install)
        sudo apk add $PKGS
        ;;
    alpine:uninstall)
        sudo apk del $PKGS
        ;;
    alpine:update)
        sudo apk update && sudo apk upgrade
        ;;
    alpine:check)
        for pkg in $PKGS; do
            if apk info | grep -q "^$pkg$"; then
                echo "$0: note: $pkg is installed"
            else
                echo "$0: error: $pkg is NOT installed"
            fi
        done
        ;;

    # Termux (Android) Actions
    termux:install)
        pkg update -y
        pkg install -y $PKGS
        ;;
    termux:uninstall)
        pkg uninstall -y $PKGS
        ;;
    termux:update)
        pkg update -y && pkg upgrade -y
        ;;
    termux:check)
        for pkg in $PKGS; do
            if pkg list-installed | grep -q "^$pkg"; then
                echo "$0: note: $pkg is installed"
            else
                echo "$0: error: $pkg is NOT installed"
            fi
        done
        ;;

    # macOS Actions
    macos:install)
        if ! command -v brew >/dev/null 2>&1; then
            echo "$0: error: Homebrew not found. Install it first:"
            echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
            exit 1
        fi
        brew install $PKGS
        ;;
    macos:uninstall)
        brew uninstall $PKGS
        ;;
    macos:update)
        brew update && brew upgrade
        ;;
    macos:check)
        for pkg in $PKGS; do
            if brew list --formula | grep -q "^$pkg\$"; then
                echo "$0: note: $pkg is installed"
            else
                echo "$0: error: $pkg is NOT installed"
            fi
        done
        ;;

    # Unsupported Actions
    *)
        echo "$0: error: $ACTION is not supported on $DISTRO"
        exit 1
        ;;
esac

echo "$0: note: successfully completed $ACTION ${PKGS:+for: $PKGS}"

