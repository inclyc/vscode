#!/usr/bin/env bash
#
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.

# when run in remote terminal, use the remote cli
if [ -n "$VSCODE_IPC_HOOK_CLI" ]; then
	REMOTE_CLI="$(which -a '@@APPNAME@@' | grep /remote-cli/)"
	if [ -n "$REMOTE_CLI" ]; then
		"$REMOTE_CLI" "$@"
		exit $?
	fi
fi

export VSCODE_NODE_OPTIONS=$NODE_OPTIONS
export VSCODE_NODE_REPL_EXTERNAL_MODULE=$NODE_REPL_EXTERNAL_MODULE
unset NODE_OPTIONS
unset NODE_REPL_EXTERNAL_MODULE

CLI="$VSCODE_PATH/resources/app/out/cli.js"
ELECTRON_RUN_AS_NODE=1 "$ELECTRON" "$CLI" "$VSCODE_PATH/resources/app" "$@"

exit $?
