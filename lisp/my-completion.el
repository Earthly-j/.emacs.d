;; my-completion.el --- Autocomplete and Minibuffer settings
;; ============================================================
;; CORFU SETUP (Autocomplete UI - Fast like VS Code)
;; ============================================================
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode 1)   ;; Turn ON Corfu globally
  :config
  (setq corfu-auto t)     ;; <--- MAKE SURE THIS LINE IS HERE!
  (setq corfu-auto-delay 0.0)  
  (setq corfu-auto-prefix 1)   
  (setq corfu-cycle t))

;; Safety Nets
(add-hook 'org-mode-hook (lambda () (setq-local corfu-auto nil)))
(add-hook 'minibuffer-setup-hook (lambda () (setq-local corfu-auto nil)))
;; ============================================================
;; CORFU SETUP (Autocomplete UI - Fast like VS Code)
;; ============================================================
(use-package corfu
  :ensure t               ;; <-- This tells Emacs to download it!
  :init
  (global-corfu-mode 1)   ;; Turn ON Corfu globally
  :config
  (setq corfu-auto-delay 0.0)  
  (setq corfu-auto-prefix 1)   
  (setq corfu-cycle t))

;; Safety Nets to stop Org-mode crashes
(add-hook 'org-mode-hook (lambda () (setq-local corfu-auto nil)))
(add-hook 'minibuffer-setup-hook (lambda () (setq-local corfu-auto nil)))

;; ============================================================
;; VERTICO SETUP (Minibuffer completion - Find file, M-x)
;; ============================================================
(use-package vertico
  :ensure t               ;; <-- This tells Emacs to download it!
  :init
  (vertico-mode 1))       ;; Turn ON Vertico globally

;; ============================================================
;; CAPE SETUP (Backend that feeds safe text to Corfu)
;; ============================================================
(use-package cape
  :ensure t               ;; <-- This tells Emacs to download it!
  :init
  (add-to-list 'completion-at-point-functions #'cape-dict)
  (add-to-list 'completion-at-point-functions #'cape-symbol)
  :config
  (advice-add 'cape-capf :around #'cape-wrap-purify))

(provide 'my-completion)
;;; my-completion.el ends here
