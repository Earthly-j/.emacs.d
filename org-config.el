(require 'org)
(require 'org-capture)
(require 'org-agenda)

(setq org-todo-keywords
      '((sequence
         "ST0(OBSERVE)" 
         "ST1(TEST)" 
         "ST2(VERIFY)" 
         "ST3(MEET)"
         "ST4(TIER1)" 
         "ST5(TIER2)" 
         "ST6(TIER3)" 
         "ST7(TIER4)"
         "|"
         "PASS(✓)" 
         "FAIL(✗)" 
         "HOLD(⏸)")))

(defconst my-org-directory "~/org/"
  "Base directory for all org-mode data files.")

(defconst my-trust-funnel-file (concat my-org-directory "trust-funnel.org")
  "Main database of people in trust funnel.")

(defconst my-red-flags-file (concat my-org-directory "red-flags.org")
  "Log of red flags and alerts.")

(defconst my-testing-protocols-file (concat my-org-directory "testing-protocols.org")
  "Reference document for testing modules.")

(add-to-list 'org-agenda-files my-trust-funnel-file)
(add-to-list 'org-agenda-files my-red-flags-file)

(add-to-list 'org-capture-templates
             '("p" "New Person - Trust Funnel" entry
               (file my-trust-funnel-file)
               "* ST0(OBSERVE) %^{Nickname} %^g
:PROPERTIES:
:Source: %^{Where met|Online/App|Community|Event|Referral}
:Date_Added: %U
:Initial_Score: %^{1-10|1|2|3|4|5|6|7|8|9|10}
:Risk_Level: %^{Low|Medium|High|Unknown}
:END:

**First Impressions:** 
%^{Initial thoughts}

**Red Flags (Immediate):**
- [ ] None observed
- [ ] Pushing for personal info too fast
- [ ] Story doesn't add up
- [ ] Love bombing / too complimentary
- [ ] Other: %^{Specify}

**Green Flags (If any):**
%^{Positive observations}

**Notes:**
%^{Additional context}

%?
"
               :empty-lines 1
               :prepend t))

(add-to-list 'org-capture-templates
             '("i" "Log Interaction" entry
               (clock)
               "** %U - %^{Interaction Type|Message|Call|Meet|Group|Other}
:PROPERTIES:
:With_Person: %^{Person nickname}
:Duration: %^{How long}
:Mood_After: %^{1-10|1|2|3|4|5|6|7|8|9|10}
:END:

**What happened:**
%^{Summary of interaction}

**Consistency Check:**
- [ ] Matches previous behavior
- [ ] Slight inconsistency noted
- [ ] Major red flag - document below
- [ ] Positive pattern reinforcement

**Observations:**
%^{Details}

**Action Items:**
- [ ] None
- [ ] Advance to next phase
- [ ] Extend current phase
- [ ] Flag for review
- [ ] Reject/Fail this candidate
"
               :clock-in t
               :clock-resume t))

(add-to-list 'org-capture-templates
             '("!" "RED FLAG - Urgent" entry
               (file my-red-flags-file)
               "* RED FLAG - %^{Date} %^g
:PROPERTIES:
:Person: %^{Who}
:Severity: %^{Critical|High|Medium|Low}
:Category: %^{Type|Inconsistency|Pushiness|Money_Request|Love_Bombing|Disrespect|Deception|Other}
:END:

**What happened:**
%^{Description}

**Evidence:**
%^{Supporting details}

**Decision Required:**
- [ ] Immediate rejection (FAIL)
- [ ] Extended observation period
- [ ] Confront/clarify
- [ ] Document and monitor
"
               :immediate-finish t))

(setq org-agenda-custom-commands
      '(
        ("T" "Trust Funnel Dashboard"
         (
          (tags-todo "ST0" ((org-agenda-overriding-header "🔍 Station 0: Observation Phase")))
          (tags-todo "ST1" ((org-agenda-overriding-header "🧪 Station 1: Testing Phase")))
          (tags-todo "ST2" ((org-agenda-overriding-header "🔎 Station 2: Verification Phase")))
          (tags-todo "ST3" ((org-agenda-overriding-header "🤝 Station 3: Meeting Phase")))
          (tags-todo "ST[4-7]" ((org-agenda-overriding-header "🔐 Active Access Tiers")))
          (tags-todo "PASS" ((org-agenda-overriding-header "✅ Trusted Humans (Fully Vetted)")))
          (tags-todo "FAIL" ((org-agenda-overriding-header "❌ Rejected (Failed Vetting)")))
          (tags-todo "HOLD" ((org-agena-overriding-header "⏸ On Hold (Pending Review)")))
          ))))

(define-prefix-command 'my-trust-map)
(global-set-key (kbd "C-c t") 'my-trust-map)

(define-key my-trust-map (kbd "c") #'org-capture)
(define-key my-trust-map (kbd "a") #'org-agenda)
(define-key my-trust-map (kbd "f") `(lambda () (interactive) (find-file ,my-trust-funnel-file)))
(define-key my-trust-map (kbd "r") `(lambda () (interactive) (find-file ,my-red-flags-file)))
(define-key my-trust-map (kbd "d") `(lambda () (interactive) (dired ,my-org-directory)))

(defun my/calculate-trust-score ()
  "Calculate composite trust score for person at point."
  (interactive)
  (let ((consistency (string-to-number (or (org-entry-get nil "Consistency_Score") "0")))
        (patience (string-to-number (or (org-entry-get nil "Patience_Score") "0")))
        (extraction (string-to-number (or (org-entry-get nil "Extraction_Score") "0"))))
    (let ((total (+ (* consistency 0.4)
                    (* patience 0.3)
                    (* extraction 0.3))))
      (org-set-property "Total_Trust_Score" (number-to-string (round total)))
      (message "📊 Trust Score: %.1f/10" total))))

(defun my/advance-trust-phase ()
  "Advance current person to next trust phase."
  (interactive)
  (let ((current (org-get-todo-state))
        (next nil)
        (min-durations '(("ST0" . 7) ("ST1" . 30) ("ST2" . 30) 
                         ("ST3" . 14) ("ST4" . 90) ("ST5" . 180) 
                         ("ST6" . 365) ("ST7" . 730))))
    (cond
     ((string= current "ST0") (setq next "ST1"))
     ((string= current "ST1") (setq next "ST2"))
     ((string= current "ST2") (setq next "ST3"))
     ((string= current "ST3") (setq next "ST4"))
     ((string= current "ST4") (setq next "ST5"))
     ((string= current "ST5") (setq next "ST6"))
     ((string= current "ST6") (setq next "ST7"))
     ((string= current "ST7") (setq next "PASS"))
     (t (error "Cannot advance from %s" current)))
    
    (when (yes-or-no-p (format "Advance %s → %s ?" current next))
      (org-todo next)
      (org-set-property "Phase_Change_Date" (format-time-string "[%Y-%m-%d %a]"))
      (message "✅ Advanced to %s" next)))))

(define-key my-trust-map (kbd "s") #'my/calculate-trust-score)
(define-key my-trust-map (kbd "N") #'my/advance-trust-phase)

(message "✅ Trust Funnel System Loaded (Literate Config)")
(message "   Data directory: %s" my-org-directory)
(message "   Press C-c t for commands")
