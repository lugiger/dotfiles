#!/bin/sh

EXIT_CODE=0

hook_type=$(basename "$0")
hooks=~/.dotfiles/git/hooks

echo "Executing $hook_type hook(s)"

for hook in "$hooks"/*."$hook_type"; do
	[ -e "$hook" ] || continue
	echo ""
	echo "Executing ${hook}"
	"$hook"
	EXIT_CODE=$((EXIT_CODE + $?))
done

if [ "$EXIT_CODE" -ne 0 ]; then
	echo ""
	echo "Commit failed."
fi

exit "$EXIT_CODE"
