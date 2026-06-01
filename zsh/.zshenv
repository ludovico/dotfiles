# List all jira issues in current project, assigned to me
function j {
  PROJECT="${1:-FDN}"

  jira issue list --plain -p${PROJECT} -s~DONE --jql "assignee = currentUser()" --columns key,summary,status
}

# Aliases
