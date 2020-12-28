# Completions for `op` (1Password CLI tool)

function __fish_seen_any_subcommands_of
    for subcmd in $argv[2..-1]
        __fish_seen_subcommand_from $argv[1]
        and __fish_seen_subcommand_from $subcmd
        and return 0
    end
end

function __fish_seen_all_subcommands
    for cmd in $argv
        __fish_seen_subcommand_from $cmd
        or return 1
    end
    return 0
end

function __fish_complete_op_cmds
    argparse s/short -- $argv

    set -l op_commands \
        "add,Grant access to groups or vaults" \
        "completion,Generate shell completion info" \
        "confirm,Confirm users" \
        "create,Create an object" \
        "delete,Remove an object" \
        "edit,Edit an object" \
        "encode,Encode JSON data w/ base64url" \
        "forget,Remove a 1Password account from this device" \
        "get,Get details about an object" \
        "help,Get help for a command" \
        "list,List objects and events" \
        "reactivate,Reactivate a suspended user" \
        "remove,Revoke access to groups or vaults" \
        "signin,Sign into a 1Password account" \
        "signout,Sign out of a 1Password account" \
        "suspend,Suspend a user" \
        "update,Check for and download any new updates"

    if set -q _flag_short
        string split -f1 "," $op_commands
    else
        string replace ',' \t $op_commands
    end
end

function __fish_complete_op_subcmds
    argparse s/short -- $argv

    set op_add_subcmds \
        "group,Grant a group access to a vault" \
        "user,Grant a user access to a vault or group"

    set op_completion_subcmds \
        "bash,Generate completions for bash" \
        "zsh,Generate completions for zsh"

    set op_create_subcmds \
        "document,Create a document" \
        "group,Create a group" \
        "item,Create an item" \
        "user,Create a user" \
        "vault,Create a vault"

    set op_delete_subcmds \
        "document,Move a document to the Trash" \
        "group,Remove a group" \
        "item,Move an item to the Trash" \
        "trash,Empty a vault's Trash" \
        "user,Completely remove a user" \
        "vault,Remove a vault"

    set op_edit_subcmds \
        "group,Edit a group's name or description" \
        "item,Edit an item's details" \
        "user,Edit a user's name or Travel Mode status" \
        "vault,Edit a vault's name"

    set op_get_subcmds \
        "account,Get details about your account" \
        "document,Download a document" \
        "group,Get details about a group" \
        "item,Get item details" \
        "template,Get an item template" \
        "totp,Get the one-time password for an item" \
        "user,Get details about a user" \
        "vault,Get details about a vault"

    set op_list_subcmds \
        "documents,List documents" \
        "events,List events from the Activity Log" \
        "groups,List groups" \
        "items,List items" \
        "templates,List templates" \
        "users,List users" \
        "vaults,List vaults"

    set op_remove_subcmds \
        "group,Revoke a group's access to a vault" \
        "user,Revoke a user's access to a vault or group"

    set subcmd_var "op_"$argv[1]"_subcmds"

    if set -q _flag_short
        string split -f1 "," $$subcmd_var
    else
        string replace ',' \t $$subcmd_var
    end
end

function __fish_complete_op_categories
    set op_categories \
        Login "Bank Account" Membership Server \
        "Secure Note" Database "Outdoor License" "Social Security Number" \
        "Credit Card" "Driver License" Passport "Software License" \
        Identity "Email Account" "Reward Program" "Wireless Router"

    printf "%s\n" $op_categories
end

# Commands

complete op -n __fish_is_first_arg -x -a "(__fish_complete_op_cmds)"

# Subcommands

for _cmd_ in (__fish_complete_op_cmds -s)
    for _subcmd_ in (__fish_complete_op_subcmds -s $_cmd_)
        complete op -n "__fish_seen_subcommand_from $_cmd_; and __fish_is_nth_token 2" -x -a "(__fish_complete_op_subcmds $_cmd_)"
        break
    end
end
set -e _cmd_ _subcmd_

# Global flags
complete op -s h -l help -d "Get help"
complete op -l account -x -d "Use the account w/ this shorthand"
complete op -l session -x -d "Authenticate w/ this session token"

# `op add`
complete op -n "__fish_seen_all_subcommands add user" -l role -x -a "member manager" -d "Set user's role in a group"

# `op confirm`
complete op -n "__fish_seen_subcommand_from confirm" -l all -d "Confirm all unconfirmed users"

# `op create`
complete op -n "not __fish_seen_all_subcommands create document" --no-files
complete op -n "__fish_seen_all_subcommands create document" -l file-name -r -F -d "Save a file from standard input"
complete op -n "__fish_seen_any_subcommands_of create document item" -l tags -x -d "Add tags (comma-separated)"
complete op -n "__fish_seen_any_subcommands_of create document item" -l title -x -d "Set the title"
complete op -n "__fish_seen_any_subcommands_of create document item" -l vault -x -d "Save to this vault"
complete op -n "__fish_seen_any_subcommands_of create group vault" -l description -x -d "Set the description"
complete op -n "__fish_seen_all_subcommands create item" -x -a "(__fish_complete_op_categories)"
complete op -n "__fish_seen_all_subcommands create item" -l url -x -d "Set the associated URL"
complete op -n "__fish_seen_all_subcommands create item" -l generate-password -x -a "letters digits symbols" -d "Assign a random password (recipe optional)"
complete op -n "__fish_seen_all_subcommands create user" -l language -x -a "en de es fr it ja ko pt-BR ru zh-Hans zh-Hant" -d "Set the user's account language"
complete op -n "__fish_seen_all_subcommands create vault" -l allow-admins-to-manage -x -a "true false" -d "If admins can manage access"

# `op delete`
complete op -n "__fish_seen_any_subcommands_of delete document item" -l vault -x -d "Delete from this vault"

# `op edit`
complete op -n "__fish_seen_any_subcommands_of edit group vault" -l name -x -d "Change the name"
complete op -n "__fish_seen_all_subcommands edit group" -l description -x -d "Change the group's description"
complete op -n "__fish_seen_all_subcommands edit item" -l generate-password -a "letters digits symbols" -d "Assign a random password (recipe optional)"
complete op -n "__fish_seen_all_subcommands edit item" -l vault -x -d "Look in this vault"
complete op -n "__fish_seen_all_subcommands edit user" -l travelmode -x -a "on off" -d "Turn Travel Mode on or off"

# `op get`
complete op -n "__fish_seen_all_subcommands get document" -l output -r -F -d "Save to PATH instead of stdout"
complete op -n "__fish_seen_any_subcommands_of get document item" -l trash -d "Include items from the Trash"
complete op -n "__fish_seen_any_subcommands_of get document totp" -l vault -x -d "Look in this vault"
complete op -n "__fish_seen_all_subcommands get item" -l fields -x -d "Only return data from these fields"
complete op -n "__fish_seen_all_subcommands get item" -l format -n "__fish_seen_argument -l fields" -x -a "csv json" -d "Return data in this format"
complete op -n "__fish_seen_all_subcommands get item" -l share-link -x -d "Get a shareable link for the item"
complete op -n "__fish_seen_all_subcommands get item" -l vault -x -d "Look in this vault"
complete op -n "__fish_seen_all_subcommands get template" -x -a "(__fish_complete_op_categories)" -d "Template category"
complete op -n "__fish_seen_all_subcommands get user" -l fingerprint -d "Get the user's public key fingerprint"
complete op -n "__fish_seen_all_subcommands get user" -l publickey -d "Get the user's public key"

# `op list`
complete op -n "__fish_seen_any_subcommands_of list documents items" -l trash -d "Include items in the Trash"
complete op -n "__fish_seen_any_subcommands_of list documents items" -l vault -x -d "Only list items in this vault"
complete op -n "__fish_seen_all_subcommands list events" -l eventid -x -d "Start listing from this event ID"
complete op -n "__fish_seen_all_subcommands list events" -n "__fish_seen_argument -l eventid" -l older -d "List events from before the specified event"
complete op -n "__fish_seen_all_subcommands list groups" -l user -x -d "List groups that a user belongs to"
complete op -n "__fish_seen_all_subcommands list groups" -l vault -x -d "List groups that have direct access to a vault"
complete op -n "__fish_seen_all_subcommands list items" -l categories -x -a "(__fish_complete_op_categories)" -d "Only list these categories (comma-separated)"
complete op -n "__fish_seen_all_subcommands list items" -l tags -x -d "Only list these tags (comma-separated)"
complete op -n "__fish_seen_all_subcommands list users" -l group -x -d "List users who belong to a group"
complete op -n "__fish_seen_all_subcommands list users" -l vault -x -d "List users that have direct access to a vault"
complete op -n "__fish_seen_all_subcommands list vaults" -l group -x -d "List vaults a group has access to"
complete op -n "__fish_seen_all_subcommands list vaults" -l user -x -d "List vaults a user has access to"

# `op signin`
complete op -n "__fish_seen_subcommand_from signin" -l raw -d "Only return the session token"
complete op -n "__fish_seen_subcommand_from signin" -l shorthand -x -d "Set the short account name"

# `op signout`
complete op -n "__fish_seen_subcommand_from signout" -l forget -d "Remove account details from this device"

# `op update`
complete op -n "__fish_seen_subcommand_from update" -l directory -r -F -d "Download update to this path"
