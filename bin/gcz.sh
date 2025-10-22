#!/usr/bin/env bash

# conventional commits

check_exists() {
    type "$1" &>/dev/null
    if [[ $? -ne 0 ]]; then
        echo "$1 not found, exiting."
        exit
    fi
}

check_exists "git"
check_exists "gum"

check_added_files() {
    git status | grep "Changes to be committed" >/dev/null

    if [ $? -ne 0 ]; then
        echo "There are no changes to be committed."
        echo "Did you forget to add?"
        echo "Are you in a valid git repo?"
        exit 1
    fi
}

check_added_files

available_commit_types=("feat" "fix" "docs" "style" "refactor" "perf" "test" "build" "ci" "chore")

final_commit_msg=""

selected_commit_type=$(gum filter --header="Type of commit" ${available_commit_types[@]})
if [ $? -ne 0 ] || [ -z $selected_commit_type ]; then
    exit
fi
final_commit_msg=$selected_commit_type

# Scope of the commit (optional)
selected_scope=$(gum input --header="Scope of the commit (optional)")
if [ $? -ne 0 ]; then
    exit
elif [ -z $selected_scope ]; then
    final_commit_msg="${final_commit_msg}"
else
    final_commit_msg="${final_commit_msg}(${selected_scope})"
fi

# Breaking change
gum confirm "Is this a breaking change?"
is_breaking=$?
if [ $is_breaking -ne 0 -a $is_breaking -ne 1 ]; then
    exit
fi

if [ $is_breaking -eq 0 ]; then
    final_commit_msg="${final_commit_msg}!"
fi

# Commit Message
commit_message=$(gum input --header="Commit message" --char-limit=50)
if [ $? -ne 0 ]; then
    exit
fi

if [[ -z "${commit_message}" ]]; then
    echo "Empty commit message, aborting"
    exit 1
fi

final_commit_msg="${final_commit_msg}: ${commit_message}"

# Description of the message
description=$(gum write --placeholder "Details of this change")

# Breaking change description (if breaking change)
breaking_description=""
if [ $is_breaking -eq 0 ]; then
    breaking_description=$(gum write --placeholder "Describe the breaking change")
    if [ -z "${breaking_description}" ]; then
        echo "Breaking change description is required for breaking changes"
        exit 1
    fi
fi

# Build final commit message with body and footers
if [ ! -z "${description}" ] || [ ! -z "${breaking_description}" ]; then
    commit_body=""

    # Add description if present
    if [ ! -z "${description}" ]; then
        commit_body="${description}"
    fi

    # Add BREAKING CHANGE footer if present
    if [ ! -z "${breaking_description}" ]; then
        if [ ! -z "${commit_body}" ]; then
            commit_body="${commit_body}

BREAKING CHANGE: ${breaking_description}"
        else
            commit_body="BREAKING CHANGE: ${breaking_description}"
        fi
    fi

    gum confirm "Commit changes?" && git commit -m "${final_commit_msg}" -m "${commit_body}"
else
    gum confirm "Commit changes?" && git commit -m "${final_commit_msg}"
fi
