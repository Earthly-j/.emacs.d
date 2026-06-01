;; rename-current-file.el
(defun my_renameFile()
  "Rename current buffer and file, using VC (git mv) if available."
  (interactive)
  (let* ((filename (buffer-file-name))
         (new-name (read-file-name "New file name: " nil nil nil filename)))
    (cond
     ((not (and filename (file-exists-p filename)))
      (message "Buffer is not visiting an existing file!"))
     ((string= new-name "") (message "Aborted"))
     ((string= new-name filename) (message "Aborted (same name)"))
     (t
      ;; If file is under version control (like Git), use vc-rename-file
      (if (vc-backend filename)
          (vc-rename-file filename new-name)
        (rename-file filename new-name 1))
      (set-visited-file-name new-name t)
      (rename-buffer (file-name-nondirectory new-name))
      (set-buffer-modified-p nil)
      (message "File renamed to %s" new-name)))))

(global-set-key (kbd "C-c b") 'my_remaneFile')

;; Provide must match the filename! 
;; If file is rename-current-file.el, provide 'rename-current-file
(provide 'renameFile)
