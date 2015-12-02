(defvar ometa-keywords
  '(("ometa" . font-lock-keyword-face)
    ("#[a-zA-Z_\$][a-zA-Z0-9_\$]+" . font-lock-string-face)))

;; I'd probably put in a default that you want, as opposed to nil
(defvar ometa-tab-width nil "Width of a tab for MYDSL mode")

(define-derived-mode ometa-mode javascript-mode
  "OMeta"
  "OMeta is a derived mode from Javascript to edit OMeta files"

  (font-lock-add-keywords nil ometa-keywords)

  ;; (modify-syntax-entry ?# "< b" mydsl-mode-syntax-table)
  ;; (modify-syntax-entry ?\n "> b" mydsl-mode-syntax-table)
  ;;A gnu-correct program will have some sort of hook call here.
  )

(provide 'ometa-mode)
