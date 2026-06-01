;; ============================================================
;; VERTICO: Completion in the Minibuffer (Find file, M-x, etc.)
;; ============================================================
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)) ;; Turn on Vertico globally

;; ============================================================
;; SAVEHIST: Makes Vertico remember your last choices
;; ============================================================
(use-package savehist
  :ensure t
  :init
  (savehist-mode 1))


(provide 'vertico)
