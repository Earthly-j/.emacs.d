;;; my-ui.el --- UI, editing, and visual settings

;; Line numbers in code
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Auto-close brackets
(electric-pair-mode 1)

;; Paredit for Lisp
(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode . enable-paredit-mode)
         (lisp-mode . enable-paredit-mode)))

;; Elisp eval buffer keybinding
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)
(global-set-key (kbd "C-c e") 'flycheck-list-errors)

(provide 'my-ui)
;;; my-ui.el ends here
