(use-package consult
  :ensure t
  :bind (:map org-mode-map
              ("C-c s" . consult-org-heading))) ;; C-c s opens the reflect list
(provide 'consult).
