#! /bin/bash
#
# install.sh
#       git-flow make-less installer for *nix systems, by Rick Osborne
#
#       Based on the git-flow core Makefile:
#       http://github.com/nvie/gitflow/blob/master/Makefile

# Licensed under the same restrictions as git-flow:
#       http://github.com/nvie/gitflow/blob/develop/LICENSE

# Usage: [environment] install.sh [install|uninstall|help]
#
# where <environment> can be:
#       Installing INSTALL_INTO=$INSTALL_INTO" (default is /usr/local/bin)

# ensure we have permissions needed to write to the place
# that we want to install the code into
#
# $1: folder to check
check_write_access()
{
    local target="$1"

    # if $1 does not exist, we go and check that we can create it
    while [[ ! -d "$target" ]]; do
        target=$(dirname "$target")
    done

    # do we have write permissions?
    if [[ ! -w "$target" ]]; then
        echo "'$target' is not writable by $(whoami)"
        return 1
    fi
    return 0
}

# @TODO
#
# * detect a suitable prefix for Windows users
if [ -z "$INSTALL_INTO" ] ; then
    INSTALL_INTO="/usr/local/bin"
fi

REPO_DIR="$(dirname $0)"
EXEC_FILES="git-sf"
SCRIPT_FILES="git-sf-init git-sf-feature git-sf-hotfix git-sf-push git-sf-pull git-sf-release git-sf-support git-sf-update git-sf-upgrade git-sf-version springflow-common springflow-shFlags"
SUBMODULE_FILE="springflow-shFlags"

case "$1" in
    uninstall)
        echo "Uninstalling springflow from $INSTALL_INTO"
        if [ -d "$INSTALL_INTO" ] ; then
            for script_file in $SCRIPT_FILES $EXEC_FILES ; do
                echo "rm -vf $INSTALL_INTO/$script_file"
                rm -vf "$INSTALL_INTO/$script_file"
            done
        else
            echo "The '$INSTALL_INTO' directory was not found."
            echo "Do you need to set INSTALL_INTO ?"
        fi
        exit
        ;;
    help)
        echo "Usage: [environment] install.sh [install|uninstall|help]"
        echo "Environment:"
        echo "   INSTALL_INTO=$INSTALL_INTO"
        exit
        ;;
    *)
        # check write access first
        check_write_access "$INSTALL_INTO" || exit 1

        # if we get here, we can proceed with the install
        echo "Installing springflow to $INSTALL_INTO"
        if [ -f "$REPO_DIR/$SUBMODULE_FILE" ] ; then
            echo "Submodules look up to date"
        else
            echo "Updating submodules"
            lastcwd="$PWD"
            cd "$REPO_DIR"
            git submodule init -q
            git submodule update -q
            cd "$lastcwd"
        fi
        install -v -d -m 0755 "$INSTALL_INTO"
        for exec_file in $EXEC_FILES ; do
            install -v -m 0755 "$REPO_DIR/$exec_file" "$INSTALL_INTO"
        done
        for script_file in $SCRIPT_FILES ; do
            install -v -m 0644 "$REPO_DIR/$script_file" "$INSTALL_INTO"
        done
        exit
        ;;
esac
