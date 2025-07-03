function __architect_using_command
    set cmd (commandline -opc)
    if test (count $cmd) -ge 1
        and test $cmd[1] = "architect"
            return 0
    end
    return 1
end
complete -c architect -f -n '__architect_using_command' -l clone -d 'Clone Architect config and dotfiles from git repo'
complete -c architect -f -n '__architect_using_command' -l make-config -d 'Generate template config'
complete -c architect -f -n '__architect_using_command' -l validate -d 'Validate config file'
complete -c architect -f -n '__architect_using_command' -l dry-run -d 'Simulate operations'
complete -c architect -f -n '__architect_using_command' -l force -d 'Force operations'
complete -c architect -f -n '__architect_using_command' -l take-snapshot-now -d 'Save current package list as snapshot'
complete -c architect -f -n '__architect_using_command' -l rollback -d 'Revert to latest snapshot'
complete -c architect -f -n '__architect_using_command' -l diff -d 'Show package differences'
complete -c architect -f -n '__architect_using_command' -l apply-diff -d 'Apply package differences'
complete -c architect -f -n '__architect_using_command' -l no-snapshot -d 'Skip automatic snapshot'
complete -c architect -f -n '__architect_using_command' -l list-snapshots -d 'List snapshots'
complete -c architect -f -n '__architect_using_command' -l purge-all-snapshots -d 'Purge all snapshots'
complete -c architect -f -n '__architect_using_command' -l purge-snapshots -d 'Purge snapshots keeping last n'
complete -c architect -f -n '__architect_using_command' -l install-aur-only -d 'Install only AUR packages'
complete -c architect -f -n '__architect_using_command' -l pacstrap -d 'Bootstrap Arch system'
complete -c architect -f -n '__architect_using_command' -l dotfiles-sync -d 'Sync dotfiles'
complete -c architect -f -n '__architect_using_command' -l dotfiles-edit -d 'Edit dotfiles'
complete -c architect -f -n '__architect_using_command' -l dotfiles-status -d 'Show dotfiles status'
complete -c architect -f -n '__architect_using_command' -l dotfiles-restore -d 'Restore dotfiles'
complete -c architect -f -n '__architect_using_command' -l dotfiles-git-init -d 'Git init for dotfiles'
complete -c architect -f -n '__architect_using_command' -l dotfiles-git-status -d 'Git status for dotfiles'
complete -c architect -f -n '__architect_using_command' -l dotfiles-commit -d 'Commit dotfiles'
complete -c architect -f -n '__architect_using_command' -l dotfiles-push -d 'Push dotfiles'
complete -c architect -f -n '__architect_using_command' -l dotfiles-set-url -d 'Set dotfiles git remote URL'
complete -c architect -f -n '__architect_using_command' -l generate-completions -d 'Generate autocomplete for bash and fish'
