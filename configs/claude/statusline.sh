#!/bin/bash

# Status line script for Claude Code
# Reads JSON session data from stdin

input=$(cat)

# Colors
ORANGE='\033[38;5;208m'
GREEN='\033[32m'
LIGHT_BLUE='\033[94m'
BOLD='\033[1m'
RESET='\033[0m'

# Extract data from JSON stdin
MODEL=$(echo "$input" | jq -r '.model.display_name // "Claude"')
CWD=$(echo "$input" | jq -r '.workspace.current_dir // empty')
EFFORT=$(echo "$input" | jq -r '.reasoning_effort // .effort_level // .effort // empty')

# Model + effort in orange brackets
if [ -n "$EFFORT" ]; then
    printf "${ORANGE}[${MODEL} | ${EFFORT}]${RESET} "
else
    printf "${ORANGE}[${MODEL}]${RESET} "
fi

# Collapse home directory to ~
if [[ "$CWD" == "$HOME"* ]]; then
    CWD="~${CWD#$HOME}"
fi

# Truncate if more than 3 directories past ~
# e.g. ~/a/b/c/d/e -> ~/.../c/d/e
if [[ "$CWD" == ~/* ]]; then
    REST="${CWD#~/}"
    IFS='/' read -ra PARTS <<< "$REST"
    if [ ${#PARTS[@]} -gt 3 ]; then
        LAST3="${PARTS[-3]}/${PARTS[-2]}/${PARTS[-1]}"
        CWD="~/.../${LAST3}"
    fi
fi

# Directory in green
printf "📁 ${GREEN}${CWD}${RESET}"

# Git status (only if in a git repo)
if git rev-parse --is-inside-work-tree &>/dev/null; then
    BRANCH=$(git branch --show-current 2>/dev/null)

    # Count staged and modified files (ignoring untracked)
    STAGED=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    MODIFIED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')

    # Build git status string
    GIT_STATUS=""
    [ "$STAGED" -gt 0 ] && GIT_STATUS="${GIT_STATUS}+${STAGED} "
    [ "$MODIFIED" -gt 0 ] && GIT_STATUS="${GIT_STATUS}~${MODIFIED} "
    GIT_STATUS="${GIT_STATUS% }"

    if [ -n "$GIT_STATUS" ]; then
        printf " (${BOLD}${LIGHT_BLUE}${BRANCH}${RESET} ${GIT_STATUS})"
    else
        printf " (${BOLD}${LIGHT_BLUE}${BRANCH}${RESET})"
    fi
fi

printf "\n"
