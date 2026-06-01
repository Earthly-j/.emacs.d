(defun my/org-read-aloud ()
  "Read the current line or active region aloud using system TTS."
  (interactive)
  (let ((text (if (use-region-p)
                  (buffer-substring-no-properties (region-beginning) (region-end))
                (thing-at-point 'line t))))
    ;; Choose your OS below (uncomment the correct one):
    
    ;; MACOS:
    (call-process "say" nil 0 nil text)
    
    ;; LINUX (espeak):
    ;; (call-process "espeak" nil 0 nil text)
    ))
    
;; Bind it to a key in Org mode
(define-key org-mode-map (kbd "C-c C-r") 'my/org-read-aloud)

(provide 'tts)
