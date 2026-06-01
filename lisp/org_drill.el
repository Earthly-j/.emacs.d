(add-to-list 'load-path "-/elisp/org-mode/contrib/lisp/")
(use-package org-drill
:config (progn
(add-to-list 'org-modules 'org-drill)
(setq org-drill-add-random-noise-to-intervals-p t)
(setq org-drill-hint-separator "||")
(setq org-drill-left-cloze-delimiter "<[" ) (setq org-drill-right-cloze-delimiter "]>")
(setq org-drill-learn-fraction 0.25)))
(provide 'org_drill)

