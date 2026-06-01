;; 2. LSP Mode
(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook (dart-mode . lsp))


(use-package dap-mode
  :ensure t
  :after lsp-mode
  :config
  (dap-auto-configure-mode))



(provide 'lsp_dap)
