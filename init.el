
;; ============================================================
;; BOOTSTRAP
;; ============================================================
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; ============================================================
;; POINTERS (Load our modular files)
;; ============================================================
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'my-ascii-art)  
(require 'cursors)  
;; (require 'consult)
(require 'treemacs)
(require 'bread_crumb)
(require 'org_capture)
(require 'font)
(require 'org_drill)
(require 'inputmethod)
(require 'tts)
;; REMOVED (require 'flycheck) here! Use-package handles it below.
(require 'epkg)
(require 'ox_hugo)
(require 'path_shell) ;; for flutter connect package
(require 'Flutter_connect)
(require 'lsp_dap)

(require 'my-completion)
(require 'espeakk)
(require 'ox-publishh)
(require 'glimps_peep)
(require 'pacman)
(require 'line_number)

(add-to-list 'load-path (expand-file-name "my-functions" user-emacs-directory))
(require 'quick-cloze)
(require 'fast_access)
(require 'renameFile)
(require 'my/add-custom-module)
;; ============================================================y
;; CORFU SETUP (Autocomplete UI - Fast like VS Code)
;; ============================================================
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode 1) ;; TURN ON Corfu globally
  :config
  (setq corfu-auto-delay 0.0)  
  (setq corfu-auto-prefix 1)   
  (setq corfu-cycle t))

;; Safety Nets to stop Org-mode crashes
(add-hook 'org-mode-hook (lambda () (setq-local corfu-auto nil)))
(add-hook 'minibuffer-setup-hook (lambda () (setq-local corfu-auto nil)))

;; ============================================================
;; CAPE SETUP (Backend that feeds safe text to Corfu)
;; ============================================================b
(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-dict)
  (add-to-list 'completion-at-point-functions #'cape-symbol)
  :config
  ;; Strip broken invisible text properties
  (advice-add 'cape-capf :around #'cape-wrap-purify))

;; ============================================================
;; FLYCHECK SETUP (Syntax Checking)
;; ============================================================
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)) ;; Turns Flycheck on globally!

;; ============================================================
;; CORE SETTINGS (Moved from my-core.el for simplicity)
;; ============================================================
(setq byte-compile-warnings t)

;; Add Homebrew to Emacs exec-path
(let ((brew-path (concat (substring (shell-command-to-string "brew --prefix 2>/dev/null") 0 -1) "/bin")))
  (when (file-exists-p brew-path)
    (add-to-list 'exec-path brew-path)
    (setenv "PATH" (concat brew-path ":" (getenv "PATH")))))

;; Set custom file so Emacs doesn't litter init.el
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file 'no-error 'no-message))

;; ============================================================
;; UI SETTINGS (Moved from my-ui.el for simplicity)
;; ============================================================
;; FIXED: Removed the extra closing parenthesis here
(add-hook 'prog-mode-hook #'display-line-numbers-mode) 
(electric-pair-mode 1)

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode . enable-paredit-mode)
         (lisp-mode . enable-paredit-mode)))

(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)

;; Turned the Flycheck error list key back on!
(global-set-key (kbd "C-c e") 'flycheck-list-errors)

(global-visual-line-mode 1)

;; ============================================================
;; CUSTOM NAVIGATION
;; ============================================================
(defun my/visit-module-at-point ()
  "If cursor is on a module name in a require statement, open that file."
  (interactive)
  (let* ((module-name (symbol-at-point))
         (file-name (concat (symbol-name module-name) ".el")) 
         (full-path (expand-file-name file-name (concat user-emacs-directory "lisp/"))))
    (if (file-exists-p full-path)
        (find-file full-path)
      (message "❌ File not found: %s" full-path))))

(global-set-key (kbd "C-c f") 'my/visit-module-at-point)
(define-key emacs-lisp-mode-map (kbd "M-.") #'xref-find-definitions)

;; ============================================================
;; CUSTOM VARIABLES (Must be at the very bottom!)
;; ============================================================
;; NOTE: Put flycheck back in the list so use-package can manage it!
(custom-set-variables
 '(package-selected-packages '(flycheck epkg paredit use-package corfu vertico cape)))
(custom-set-faces)

;;; init.el ends here
(put 'downcase-region 'disabled nil)
