((magit-cherry-pick
  ("--ff"))
 (magit-commit
  ("--verbose"))
 (magit-dispatch nil)
 (magit-fetch nil)
 (magit-for-each-ref:--contains "origin/lazygit")
 (magit-log
  ("--decorate" "--graph" "-n256"))
 (magit-merge nil)
 (magit-pull nil)
 (magit-push nil
	     ("--force-with-lease"))
 (magit-rebase
  ("--autostash"))
 (magit-remote
  ("-f"))
 (magit-show-refs nil
		  ("--contains=origin/lazygit"))
 (magit-status-jump nil)
 (magit-submodule nil))
