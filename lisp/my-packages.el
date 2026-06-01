;;; my-packages.el --- External packages and tools

;; Flycheck (Syntax checking)
(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  )

;; EPKG (Package browser)
(use-package epkg
  :ensure t
  :defer t
  :bind (
	 ("C-c p l" . epkg-list-packages)
	 )
  )

;; Config.org Loader
(let (
      (config-org "~/.emacs.d/config.org")
     )
  (when
      (file-exists-p config-org)
    (org-babel-load-file
     (expand-file-name config-org)
			 )
    )
  )

(provide 'my-packages)
;;; my-packages.el ends here
