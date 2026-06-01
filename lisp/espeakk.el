(defun my/multi-sensory-review ()
  "Read the card aloud, wait for me to speak it, then show answer."
  (interactive)
  (let ((question (org-entry-get (point) "ITEM")))
    ;; 1. Read the question to me (Hearing)
    (call-process "espeak" nil 0 nil question) ; Use "say" on Mac
    
    ;; 2. Hide the answer (Forcing active recall)
    (org-overview) ;; collapses the subtree
    
    ;; 3. Wait for me to speak it out loud, then show answer
    (message "Say the answer out loud NOW! (Press any key when done)")
    (read-char-exclusive) ;; Pauses Emacs until you press a key
    
    ;; 4. Reveal the answer (Vision)
    (org-show-entry)
    (message "Did you get it right?")))


(provide 'espeakk)
