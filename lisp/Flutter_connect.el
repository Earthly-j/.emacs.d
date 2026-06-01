;; 1. Dart Major Mode
(use-package dart-mode
  :ensure t)

;; 2. LSP Mode
(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook (dart-mode . lsp))

;; 3. LSP Dart (Flutter integration)
(use-package lsp-dart
  :ensure t
  :after lsp-mode
  :config
  ;; (Optional) Set the Flutter SDK path manually if Emacs can't find it automatically
  ;; (setq lsp-dart-flutter-sdk-dir (expand-file-name "~/development/flutter"))
  
  ;; (Optional) Enable Flutter Widget Guides (shows UI hierarchy)
  (setq lsp-dart-flutter-widget-guides t))

;; 4. Flutter minor mode
(use-package flutter
  :ensure t
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-x" . flutter-run-or-hot-reload)))


(provide 'Flutter_connect)
