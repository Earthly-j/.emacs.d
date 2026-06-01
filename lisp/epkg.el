;; EPKG (Package browser)
(use-package epkg
  :ensure t
  :defer t
  :bind (
	 ("C-c p l" . epkg-list-packages)
	 )
  )
(provide 'epkg)
