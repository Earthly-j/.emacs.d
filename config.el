(message "🔥 JASON'S CONFIG LOADED SUCCESSFULLY! 🔥")
;; ============================================================
;; FIX GUI EMACS ENVIRONMENT (macOS only)
;; ============================================================

(when (eq window-system 'mac)
  ;; Fix GUI Emacs not having shell PATH
  (use-package exec-path-from-shell
    :ensure t
    :config
    (exec-path-from-shell-initialize)
    (message "✅ Fixed GUI Emacs PATH from shell")))

(require 'org)
(require 'org-capture)
(require 'org-agenda)

(defconst my-org-directory "~/org/")
(defconst my-trust-funnel-file (concat my-org-directory "trust-funnel.org"))
(defconst my-red-flags-file (concat my-org-directory "red-flags.org"))

(add-to-list 'org-agenda-files my-trust-funnel-file)
(add-to-list 'org-agenda-files my-red-flags-file)

(setq org-todo-keywords '((sequence "ST0(OBSERVE)" "ST1(TEST)" "ST2(VERIFY)" "ST3(MEET)" "ST4(TIER1)" "ST5(TIER2)" "ST6(TIER3)" "ST7(TIER4)" "|" "PASS(✓)" "FAIL(✗)" "HOLD(⏸)")))

(setq org-capture-templates
      '(("p" "Person" entry (file my-trust-funnel-file)
         "* ST0(OBSERVE) %^{Nick}\n:PROPERTIES:\n:Date: %U\n:END:\n%?" :prepend t)

        ("i" "Log" entry (clock)
         "** %U %^{Type}\n:PROPERTIES:\n:With: %^{Who}\n:END:\n%?" :clock-in t)

        ("!" "Flag" entry (file my-red-flags-file)
         "* RED FLAG %U\n:PROPERTIES:\n:Who: %^{Who}\n:END:\n%?" :immediate-finish t)))

(define-prefix-command 'my-trust-map)
(global-set-key (kbd "C-c t") 'my-trust-map)
(define-key my-trust-map (kbd "c") #'org-capture)
(define-key my-trust-map (kbd "a") #'org-agenda)
(define-key my-trust-map (kbd "f") `(lambda () (interactive) (find-file ,my-trust-funnel-file)))

(message "✅ Loaded")

;; ============================================================
;; ELISP ERROR CHECKING (REPLACES BROKEN lsp-ellsp!)
;; ============================================================

;; Option A: Flycheck (SIMPLE - works immediately!)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit))

;; Option B: Elsa (ADVANCED - optional, uncomment if desired)
;; (use-package elsa
;;   :ensure t
;;   :hook (emacs-lisp-mode . elsa-mode))
;;
;; (use-package flycheck-elsa
;;   :after (flycheck elsa)
;;   :ensure t
;;   :config
;;   (flycheck-elsa-setup))

;; ============================================================
;; LSP MODE - FOR OTHER LANGUAGES ONLY (Python, Rust, etc.)
;; NOT needed for Elisp files! Emacs handles those natively.
;; ============================================================

;; Uncomment ONLY if you work with other languages:
;; (use-package lsp-mode
;;   :ensure t
;;   :commands lsp
;;   :hook ((python-mode . lsp-deferred)
;;          (rust-mode . lsp-deferred)
;;          (go-mode . lsp-deferred)
;;          (js-mode . lsp-deferred)))
;;
;; (use-package lsp-ui
;;   :after lsp-mode
;;   :ensure t)

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)        ; Main Magit interface
         ("C-x M-g" . magit-dispatch))   ; Magit command palette
  :config
  ;; ✅ This is how you enable diff highlighting!
  ;; It's a VARIABLE setting, not a separate package!
  (setq magit-diff-refine-hunk t)
  
  ;; Other useful magit settings
  (setq magit-display-buffer-function
        'magit-display-buffer-same-window-except-diff-v1)

  ;; Auto-revert mode for when git changes things outside Emacs
  (global-auto-revert-mode 1)

(message "✅ Magit ready! Use C-x g to open"))

;; ============================================================
;; FIX GUI EMACS ENVIRONMENT (macOS only)
;; ============================================================

(when (eq window-system 'mac)
  ;; Fix GUI Emacs not having shell PATH
  (use-package exec-path-from-shell
    :ensure t
    :config
    (exec-path-from-shell-initialize)
    (message "✅ Fixed GUI Emacs PATH from shell")))

(require 'org)
(require 'org-capture)
(require 'org-agenda)

(defconst my-org-directory "~/org/")
(defconst my-trust-funnel-file (concat my-org-directory "trust-funnel.org"))
(defconst my-red-flags-file (concat my-org-directory "red-flags.org"))

(add-to-list 'org-agenda-files my-trust-funnel-file)
(add-to-list 'org-agenda-files my-red-flags-file)

(setq org-todo-keywords '((sequence "ST0(OBSERVE)" "ST1(TEST)" "ST2(VERIFY)" "ST3(MEET)" "ST4(TIER1)" "ST5(TIER2)" "ST6(TIER3)" "ST7(TIER4)" "|" "PASS(✓)" "FAIL(✗)" "HOLD(⏸)")))

(setq org-capture-templates
      '(("p" "Person" entry (file my-trust-funnel-file)
         "* ST0(OBSERVE) %^{Nick}\n:PROPERTIES:\n:Date: %U\n:END:\n%?" :prepend t)

        ("i" "Log" entry (clock)
         "** %U %^{Type}\n:PROPERTIES:\n:With: %^{Who}\n:END:\n%?" :clock-in t)

        ("!" "Flag" entry (file my-red-flags-file)
         "* RED FLAG %U\n:PROPERTIES:\n:Who: %^{Who}\n:END:\n%?" :immediate-finish t)))

(define-prefix-command 'my-trust-map)
(global-set-key (kbd "C-c t") 'my-trust-map)
(define-key my-trust-map (kbd "c") #'org-capture)
(define-key my-trust-map (kbd "a") #'org-agenda)
(define-key my-trust-map (kbd "f") `(lambda () (interactive) (find-file ,my-trust-funnel-file)))

(message "✅ Loaded")

;; ============================================================
;; ELISP ERROR CHECKING (REPLACES BROKEN lsp-ellsp!)
;; ============================================================

;; Option A: Flycheck (SIMPLE - works immediately!)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit))

;; Option B: Elsa (ADVANCED - optional, uncomment if desired)
;; (use-package elsa
;;   :ensure t
;;   :hook (emacs-lisp-mode . elsa-mode))
;;
;; (use-package flycheck-elsa
;;   :after (flycheck elsa)
;;   :ensure t
;;   :config
;;   (flycheck-elsa-setup))

;; ============================================================
;; LSP MODE - FOR OTHER LANGUAGES ONLY (Python, Rust, etc.)
;; NOT needed for Elisp files! Emacs handles those natively.
;; ============================================================

;; Uncomment ONLY if you work with other languages:
;; (use-package lsp-mode
;;   :ensure t
;;   :commands lsp
;;   :hook ((python-mode . lsp-deferred)
;;          (rust-mode . lsp-deferred)
;;          (go-mode . lsp-deferred)
;;          (js-mode . lsp-deferred)))
;;
;; (use-package lsp-ui
;;   :after lsp-mode
;;   :ensure t)

(use-package vterm
  :ensure t
  :config
  (setq vterm-max-scrollback 5000))
;; ============================================================
;; VTERM - Terminal Emulator (Optional - needs CMake + libvterm)
;; ============================================================
(use-package vterm
  :if (executable-find "cmake")  ; ← ONLY load if cmake exists!
  :ensure t
  :config
  (setq vterm-max-scrollback 5000)
  :bind ("C-c t" . vterm))
