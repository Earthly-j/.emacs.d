(use-package ox-hugo
  :ensure t
  :after ox
  :config
  ;; Automatically export to Hugo Markdown every time you save an Org file
  (org-hugo-auto-export-mode))


(provide 'ox_hugo)
