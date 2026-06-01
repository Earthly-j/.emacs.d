;; -*- coding: utf-8 -*-
;; Emacs Lisp file to fix Mac Option key in ttyd / xterm.js
;; This maps the specific Option+Key characters to Emacs Meta commands.

;;; 1. MOVEMENT
;; Meta+b / Meta+f (Word movement)
(global-set-key "∫" 'backward-word)       ; Option+b generates ∫
(global-set-key "ƒ" 'forward-word)        ; Option+f generates ƒ

;; Meta+< / Meta+> (Buffer movement)
(global-set-key "≤" 'begi:wqnning-of-buffer) ; Option+, generates ≤
(global-set-key "≥" 'end-of-buffer)       ; Option+. generates ≥

;; Meta+v (Scroll down)
(global-set-key "√" 'scroll-down-command) ; Option+v generates √

;;; 2. EDITING / KILLING
;; Meta+d (Kill word)
(global-set-key "∂" 'kill-word)           ; Option+d generates ∂

;; Meta+k (Kill sentence) - Option+k usually generates a dead key (˚) or √. 
;; Mapping the output if it acts as a char:
(global-set-key "˚" 'kill-sentence)       ; Option+k (sometimes)

;; Meta+a / Meta+e (Sentence movement)
;; Note: Option+a is å on US keyboard. Option+e is usually a dead key (´).
;; If Option+e works as a char for you, uncomment the next line:
;; (global-set-key "´" 'forward-sentence)   ; Option+e
(global-set-key "å" 'backward-sentence)   ; Option+a

;; Meta+l / Meta+u / Meta+c (Case changes)
;; Option+u is usually a dead key (¨) and hard to map reliably.
(global-set-key "¬" 'downcase-word)       ; Option+l generates ¬
(global-set-key "ç" 'capitalize-word)     ; Option+c generates ç

;; Meta+z (Zap to char)
(global-set-key "Ω" 'zap-to-char)         ; Option+z generates Ω

;; Meta+q (Fill Paragraph)
(global-set-key "œ" 'fill-paragraph)      ; Option+q generates œ

;;; 3. KILL RING (Copy/Paste)
;; Meta+w (Copy) / Meta+y (Paste)
(global-set-key "∑" 'kill-ring-save)      ; Option+w generates ∑
(global-set-key "¥" 'yank)                ; Option+y generates ¥

;;; 4. SEARCH & HISTORY
;; Meta+s / Meta+r (Search)
(global-set-key "ß" 'isearch-forward)     ; Option+s generates ß
(global-set-key "®" 'isearch-backward)    ; Option+r generates ®

;; Meta+p / Meta+n (History)
;; Note: Option+n is a dead key (˜) on US keyboard, so it is skipped here.
(global-set-key "π" 'previous-history)    ; Option+p generates π
;; (global-set-key "˜" 'next-history)     ; Option+n (if it outputs a char)

;;; 5. COMMANDS & MISC
;; Meta+x (M-x)
(global-set-key "≈" 'execute-extended-command) ; Option+x generates ≈

;; Meta+g (Goto Line)
(global-set-key "©" 'goto-line)           ; Option+g generates ©

;; Meta+/ (Dabbrev Expand)
(global-set-key "÷" 'dabbrev-expand)     ; Option+/ generates ÷

;; Meta+? (Apropos)
(global-set-key "¿" 'apropos-command)    ; Option+? generates ¿

;; Meta+h (Mark Paragraph)
;; Option+h is sometimes ˙ (dot above). If so:
(global-set-key "˙" 'mark-paragraph)     ; Option+h

;; Meta+t (Transpose words)
(global-set-key "†" 'transpose-words)    ; Option+t generates †

(provide 'mac-option-fix)
