(defun my/rename-current-buffer-file ()
  "Rename current buffer and file, using VC (git mv) if available."
  (interactive)
  (let* ((filename (buffer-file-name))
         (dir (file-name-directory filename))
         (old-name (file-name-nondirectory filename))
         ;; Ask ONLY for the new file name, not the whole path!
         (new-name-str (read-string (format "Rename '%s' to: " old-name) old-name))
         ;; Build the full new path ourselves quietly in the background
         (new-name (expand-file-name new-name-str dir)))
    (cond
     ((not (and filename (file-exists-p filename)))
      (message "Buffer is not visiting an existing file!"))
     ((string= new-name-str "") (message "Aborted"))
     ((string= new-name filename) (message "Aborted (same name)"))
     (t
      ;; If file is under version control (like Git), use vc-rename-file
      (if (vc-backend filename)
          (vc-rename-file filename new-name)
        (rename-file filename new-name 1))
      (set-visited-file-name new-name t)
      (rename-buffer (file-name-nondirectory new-name))
      (set-buffer-modified-p nil)
      (message "File renamed to %s" new-name)))))

(global-set-key (kbd "C-c b") 'my/rename-current-buffer-file)

(provide 'renameFile)


;; Place your code here
;; [ You press C-c b ]
;;         │
;;         ▼
;; ┌──────────────────────────────────────────────────────────┐
;; │ (interactive)                                            │
;; │ Allows you to run this function via a keybinding!        │
;; └──────────────────────────────────────────────────────────┘
;;          │
;;          ▼
;; ┌──────────────────────────────────────────────────────────┐
;; │ (let* ...)  <-- The Setup & Chop Phase                   │
;; │                                                          │
;; │ The '*' means it evaluates variables TOP to BOTTOM.      │
;; │                                                          │
;; │ 1. filename    = "/Users/jason/0pinion/test.org"         │
;; │                                                          │
;; │ 2. dir         = (Chop off file name)                    │
;; │                 ➔ "/Users/jason/0pinion/"                │
;; │                                                          │
;; │ 3. old-name    = (Chop off folder path)                  │
;; │                 ➔ "test.org"                             │
;; │                                                          │
;; │ 4. new-name-str= (Ask user ONLY for the name!)           │
;; │                 Prompt: "Rename 'test.org' to: "         │
;; │                 You type: "my-notes.org"                 │
;; │                 ➔ "my-notes.org"                         │
;; │                                                          │
;; │ 5. new-name    = (Glue dir + new-name-str together)      │
;; │                 "/Users/jason/0pinion/" + "my-notes.org" │
;; │                 ➔ "/Users/jason/0pinion/my-notes.org"    │
;; ;;;└──────────────────────────────────────────────────────────┘
;;         │
;;          ▼ ;; ┌──────────────────────────────────────────────────────────┐
;; │ (cond ...)  <-- The Safety Net (Decision Tree)           │
;; │                                                          │
;; │ Emacs checks these top-to-bottom. First TRUE wins!       │
;; │                                                          │
;; │  ├─ Is there NO file?         ➔ YES ➔ [ABORT: No file!] │
;; │  ├─ Is new-name-str blank?    ➔ YES ➔ [ABORT: Canceled] │
;; │  ├─ Is new-name same as old?  ➔ YES ➔ [ABORT: Same!]    │
;; │  └─ (t) None of the above?   ➔ YES ➔ PROCEED! ─────────┐│
;; └──────────────────────────────────────────────────────────┘│
;;          │
;;          ▼
;; ┌──────────────────────────────────────────────────────────┐
;; │ RENAME PHASE                                             │
;; │                                                          │
;; │      (if (vc-backend filename)  <-- The Git Checker      │
;; │                                                          │
;; │         Is this file inside a Git repo?                  │
;; │           │                            │                 │
;; │         [YES]                        [NO]                │
;; │           │                            │                 │
;; │           ▼                            ▼                 │
;; │   (vc-rename-file)             (rename-file)             │
;; │   Does `git mv`                Does normal OS rename     │
;; │           │                            │                 │
;; │           └────────────┬───────────────┘                 │
;; │                        ▼                                 │
;; │                                                          │
;; │  1. (set-visited-file-name) ➔ Tell Emacs the new path    │
;; │  2. (rename-buffer)         ➔ Update the tab/title       │
;; │  3. (set-buffer-modified-p) ➔ Mark buffer as saved       │
;; │  4. (message)               ➔ Print "File renamed to.."  │
;; └──────────────────────────────────────────────────────────┘
;; 
