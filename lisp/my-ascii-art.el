(require 'ansi-color)
(require 'org)
(require 'subr-x) ;; Required for string-empty-p and string-trim

(defvar my/ascii-font-dir (expand-file-name "~/.emacs.d/ascii-fonts/")
  "Directory for custom figlet/toilet fonts.")

(defun my/org-make-ascii-title ()
  "Generate colored raw ASCII art based on heading level."
  (interactive)
  (if (org-at-heading-p)
      (let* ((level (org-current-level))
             (heading-text (nth 4 (org-heading-components)))
             (font-dir my/ascii-font-dir)
             (command
              (cond
               ((= level 1) (format "toilet -d %s -f cybermedium -F gay '%s'"
                                    (shell-quote-argument font-dir)
                                    (shell-quote-argument heading-text)))
               ((= level 2) (format "toilet -d %s -f slant -F metal '%s'"
                                    (shell-quote-argument font-dir)
                                    (shell-quote-argument heading-text)))
               ((= level 3) (format "toilet -d %s -f ascii9 -F metal '%s'"
                                    (shell-quote-argument font-dir)
                                    (shell-quote-argument heading-text)))
               (t (format "toilet -d %s -f smblock -F gay '%s'"
                          (shell-quote-argument font-dir)
                          (shell-quote-argument heading-text))))) ;; 3 parens: closes format, cond, command
             (ascii-art-raw (shell-command-to-string command))
             (ascii-art (with-temp-buffer
                          (insert ascii-art-raw)
                          (ansi-color-apply-on-region (point-min) (point-max))
                          (buffer-string)))) ;; 3 parens: closes with-temp-buffer, ascii-art, let* varlist
        
        (if (string-empty-p (string-trim ascii-art))
            (message "❌ Error: Generator returned nothing.")
          (save-excursion
            (end-of-line)
            (forward-line 1)
            (let ((start (point)))
              (while (and (not (eobp))
                          (not (looking-at-p "^\\*+"))
                          (not (looking-at-p "^$")))
                (forward-line 1))
              (delete-region start (point))
              (when (looking-at-p "^$") (delete-char 1)))
            (insert (concat "\n" ascii-art))))) ;; 5 parens: closes concat, insert, save-excursion, inner if, let*
    (message "❌ Cursor is not on an Org heading!"))) ;; 3 parens: closes message, outer if, defun

(define-key org-mode-map (kbd "C-c C-a") 'my/org-make-ascii-title)

(provide 'my-ascii-art)
