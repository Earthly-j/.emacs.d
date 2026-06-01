;; ──────────────────────────────────────────────
;; 3. PEEP-DIRED: Quick Look inside Emacs
;; ──────────────────────────────────────────────
(use-package peep-dired
  :ensure t
  :config
  ;; Wait until Dired loads before attaching the "v" key
  (with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "v") 'peep-dired)) ;; Changed P to v
  
  ;; Navigation inside the preview
  (define-key peep-dired-mode-map (kbd "n") 'peep-dired-next-file)
  (define-key peep-dired-mode-map (kbd "p") 'peep-dired-prev-file)
  (define-key peep-dired-mode-map (kbd "v") 'peep-dired-kill)) ;; Changed P to v (press v again to close)


;; ──────────────────────────────────────────────
;; 4. MACOS QUICK LOOK: Trigger the real Mac popup
;; ──────────────────────────────────────────────
(defun my/macos-quick-look ()
  "Trigger macOS Quick Look (Space) on the current file in Dired."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (call-process "qlmanage" nil 0 nil "-p" file)))

;; Wait until Dired loads before attaching the Spacebar
(with-eval-after-load 'dired
  (bind-key "SPC" #'my/macos-quick-look dired-mode-map))

(provide 'glimps_peep)
