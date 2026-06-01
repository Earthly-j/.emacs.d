(use-package breadcrumb
  :ensure t
  :config
  ;; 1. Tell Org to index ALL heading levels (default is only 4)
  (setq org-imenu-depth 8) 
  
  ;; 2. Force imenu to update automatically when you type new headers
  (setq imenu-auto-rescan t)
  
  ;; 3. Set the separator to look like Pic 1 (optional, but pretty)
  (setq breadcrumb-imenu-crumb-separator " > ")
  
  ;; 4. Start breadcrumb in Org mode
  :hook (org-mode . breadcrumb-mode))
(provide 'bread_crumb)
