;;; my-tts.el --- Simple TTS with highlighting
;;; Just add this file and it works

(defvar my-tts-overlay nil)

(defun my-tts-speak-region (start end)
  "Speak text with word-by-word highlighting"
  (interactive "r")
  (let ((words (split-string (buffer-substring-no-properties start end) " " t)))
    (dolist (word words)
      (when (and word (> (length word) 0))
        (save-excursion
          (goto-char (point-min))
          (when (search-forward word nil t 1)
            (let ((ov (make-overlay (- (point) (length word)) (point))))
              (overlay-put ov 'face '(:background "#4a90d9" :foreground "white" :bold t))
              (shell-command (format "say %s" (shell-quote-argument word)) nil t)
              (sit-for 0.3)
              (delete-overlay ov))))))
    (message "Done")))

(global-set-key (kbd "C-c tk") 'my-tts-speak-region)

(provide 'my-tts)
