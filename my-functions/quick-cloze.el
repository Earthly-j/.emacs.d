(defun my/org-cloze-wrap ()
  "Wrap the selected text or word at point in {{c1::...}}"
  (interactive)  ;; <-- This is what makes it a command! Don't miss it.
  (let ((bounds (if (use-region-p)
                    (cons (region-beginning) (region-end))
                  (bounds-of-thing-at-point 'word))))
    (when bounds
      (save-excursion
        (goto-char (cdr bounds))
        (insert "}}")
        (goto-char (car bounds))
        (insert "{{c1::")))))

(define-key org-mode-map (kbd "C-c w") 'my/org-cloze-wrap)

(provide 'quick-cloze)
