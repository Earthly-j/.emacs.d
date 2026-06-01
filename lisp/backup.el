;; 1. Define the directory where you want your backups to go
(setq my-backup-directory (expand-file-name "backups/" user-emacs-directory))

;; 2. Create the directory if it doesn't already exist
(unless (file-exists-p my-backup-directory)
  (make-directory my-backup-directory t))

;; 3. Route backup files (ending in ~) to that directory
(setq backup-directory-alist
      `((".*" . ,my-backup-directory)))

;; 4. Route auto-save files (starting and ending with #) to that directory
(setq auto-save-file-name-transforms
      `((".*" ,my-backup-directory t)))
;; Keep multiple versions of backups
(setq version-control t     ;; Use versioned backups (e.g. file.~1~, file.~2~)
      kept-new-versions 6   ;; Keep the 6 newest versions
      kept-old-versions 2   ;; Keep the 2 oldest versions
      delete-old-versions t ;; Automatically delete excess old versions
      backup-by-copying t)  ;; Copy the file instead of renaming (safer for symlinks)

(provide 'backup)
