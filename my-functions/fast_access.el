;; ──────────────────────────────────────────────
;; 5. FAST FILE OPENING: Lightning Shortcuts
;; ──────────────────────────────────────────────

;; First, we create tiny functions that know the file path
(defun my/open-init-el ()
  "Open the main Emacs init file."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun my/open-keybindings ()
  "Open the custom keybindings file."
  (interactive)
  (find-file "~/.emacs.d/lisp/my-keybindings.el"))

;; Now, add this inside your (general-define-key ...) block:
;; right under your "p" (Project) settings:

   ;; "e" stands for Emacs Config
   "e" '(:ignore t :which-key "Emacs Config")
   "e i" '(my/open-init-el :which-key "init.el")
   "e k" '(my/open-keybindings :which-key "Keybindings")



;; ──────────────────────────────────────────────
;; 6. RECENT FILES: Spotlight-style search
;; ──────────────────────────────────────────────
(recentf-mode 1) ;; Turn on the history tracker
(setq recentf-max-menu-items 25) ;; Remember last 25 files

;; Add to your logical key tree:
;; "r" stands for Recent/Resume
"r" '(:ignore t :which-key "Recent/Resume")
"r r" '(recentf-open-files :which-key "Recent Files")

;; ──────────────────────────────────────────────
;; 7. PROJECTILE: Project-level fast file access
;; ──────────────────────────────────────────────
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  
  ;; Tell Projectile about Flutter/Dart projects
  (add-to-list 'projectile-project-root-files "pubspec.yaml"))

;; Update your "p" (Project) tree inside general-define-key:
"p" '(:ignore t :which-key "Project")
"p f" '(projectile-find-file :which-key "Find File in Project") ;; Fuzzy search!
"p p" '(projectile-switch-project :which-key "Switch Project")



;; ──────────────────────────────────────────────
;; 8. EMACS SERVER: Allow terminal to send files to GUI
;; ──────────────────────────────────────────────
(server-start)

(provide 'fast_access)


;; Wait until Dired loads before attaching the Spacebar
(with-eval-after-load 'dired
  (bind-key "C-c SPC" #'my/macos-quick-look dired-mode-map)) ;; Changed from "SPC" to "C-c SPC"
