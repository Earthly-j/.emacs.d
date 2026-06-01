(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))
(provide 'path_shell)


;;   When you type 'flutter' in the terminal...
;;   the system looks in your $PATH:
;;   -------------------------------------------------------
;;   | /opt/homebrew/bin/    (This folder is in your $PATH)|
;;   |                                                     |
;;   |  flutter  ───────────────┐                          |
;;   |  (This is just a         │  (SYMLINK / SHORTCUT)    |
;;   |   shortcut pointer)      │                          |
;;   ---------------------------│---------------------------
;;                              │
;;                              V
;;   -------------------------------------------------------
;;   | /opt/homebrew/share/flutter/bin/                    |
;;   |                                                     |
;;   |  flutter  <─────────── This is the REAL program!    |
;;   |                                                     |
;;   -------------------------------------------------------
;;
