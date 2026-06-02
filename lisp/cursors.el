(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-a" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))


(provide 'cursors)
