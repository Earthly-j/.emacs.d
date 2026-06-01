;;; test-tts.el --- Test TTS without breaking anything
;;; Usage: emacs -l ~/.emacs.d/test-tts.el

;; Simple TTS test
(defun my-simple-tts ()
  (interactive)
  (if (use-region-p)
      (let ((text (buffer-substring-no-properties (region-beginning) (region-end))))
        (start-process "say" nil "say" text)
        (message "Speaking..."))
    (message "No region selected")))

(global-set-key (kbd "C-c tt") 'my-simple-tts)
(message "Test mode! C-c tt to speak. Restart to disable.")
