;; ============================================================
;; TRANSLATE KOREAN KEYS TO ENGLISH FOR SHORTCUTS
;; So C-ㅌ acts like C-x, M-ㅈ acts like M-w, etc.
;; ============================================================

(defvar my/korean-to-english-map
  '((?ㅂ . ?q) (?ㅈ . ?w) (?ㄷ . ?e) (?ㄱ . ?r) (?ㅅ . ?t)
    (?ㅛ . ?y) (?ㅕ . ?u) (?ㅐ . ?i) (?ㅔ . ?o) (?ㅑ . ?p)
    (?ㅁ . ?a) (?ㄴ . ?s) (?ㅇ . ?d) (?ㄹ . ?f) (?ㅎ . ?g)
    (?ㅗ . ?h) (?ㅓ . ?j) (?ㅏ . ?k) (?ㅣ . ?l)
    (?ㅋ . ?z) (?ㅌ . ?x) (?ㅊ . ?c) (?ㅍ . ?v) (?ㅠ . ?b)
    (?ㅜ . ?n) (?ㅡ . ?m))
  "Mapping of Korean characters to their QWERTY English equivalents.")

;; Apply the translation for Ctrl (C-), Meta/Option (M-), and Ctrl+Meta (C-M-)
(dolist (pair my/korean-to-english-map)
  (let ((ko (car pair))
        (en (cdr pair)))
    (define-key key-translation-map (kbd (format "C-%c" ko)) (kbd (format "C-%c" en)))
    (define-key key-translation-map (kbd (format "M-%c" ko)) (kbd (format "M-%c" en)))
    (define-key key-translation-map (kbd (format "C-M-%c" ko)) (kbd (format "C-M-%c" en)))))



(use-package sis
  :ensure t
  :config
  ;; <<< IMPORTANT: Change these to match your exact Mac input source names >>>
  ;; You can find the exact names by going to Mac System Settings -> Keyboard -> Input Sources
  (sis-ism-lazyman-config "com.apple.keylayout.ABC" "com.apple.inputmethod.Korean.2SetKorean")
  
  ;; Automatically switch to English when you press C- or M-
  (sis-global-respect-mode t)
  
  ;; Automatically switch to English when you enter the minibuffer (like M-x or C-x C-f)
  (sis-global-context-mode t)
  
  ;; Show a small cursor color change to indicate current language
  (sis-global-inline-mode t))

(provide 'inputmethod)
