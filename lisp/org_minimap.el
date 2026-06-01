
(use-package quelpa
  :ensure t)

;; 2. Install quelpa-use-package, which adds the :quelpa keyword
(use-package quelpa-use-package
  :ensure t
  :demand t) ;; :demand t ensures it loads immediately so the keyword is recognized

(use-package org-sidebar
  :quelpa (org-sidebar :fetcher github :repo "alphapapa/org-sidebar"))
(provide 'org_minimap).
