(require 'font-lock)
(require 'smie)

(defgroup nile nil
  "A Nile major mode."
  :group 'languages)

(defcustom nile-tab-width tab-width
  "The tab width to use when indenting."
  :type 'integer
  :group 'nile
  :safe 'integerp)

(defcustom nile-indent-tabs-mode nil
  "Indentation can insert tabs if this is t."
  :group 'nile
  :type 'boolean)

;; Highlighting

(defvar nile-keywords-regexp
  (regexp-opt '("if" "else"
                "∀" "→"
                "≠" "="
                "<:" ">>" "<" ">"
                "≥" "≤"
                "▷" "◁"
                "∧" "∨"
                "×" "⊗" "∙" "√"
                "‖"
                "~" "≈" "≉"
                "+" "-" "/" "%")))

(defvar nile-type-regexp
  (concat ":"
          "\\s-*"
          "\\([A-Z][_[:word:][:digit]]+\\)"))

(defvar nile-kernel-regexp
  (concat "\\([_[:word:][:digit:]]+\\)" ;; Kernel's name
          "\\s-*"
          "\\(\\(([^\)]*)\\)?\\)"       ;; Kernel's arguments
          "\\s-*"
          ":"
          "\\s-*"
          "\\([^>]*\\)"               ;; Inputs
          "\\s-*"
          ">>"
          "\\s-*"
          "\\(.*\\)"                    ;; Outputs
          ))

(defconst nile-font-lock-keywords
  `(
    (,nile-keywords-regexp . font-lock-keyword-face)
    (,nile-kernel-regexp
     (1 font-lock-function-name-face)
     (4 font-lock-type-face)
     (5 font-lock-type-face))
    ))

(provide 'nile-mode)

;; Keymapping

(defmacro nile-keymap (k c)
  `(define-key map (kbd (concat "C-c " ,k))
     '(lambda ()
        ""
        (interactive)
        (insert ,c))
     ))

(defmacro nile-keymap-and-back (k c)
  `(define-key map (kbd (concat "C-c " ,k))
     '(lambda ()
        ""
        (interactive)
        (insert ,c)
        (backward-char)
        )
     ))

(defvar nile-mode-map
  (let ((map (make-keymap)))
    ;; Special characters
    (nile-keymap "a" "∀")
    (nile-keymap "c" "⊗")
    (nile-keymap "r" "≈")
    (nile-keymap-and-back "s" "√()")
    (nile-keymap-and-back "d" "‖‖")

    map)
  "Keymap for Nile major mode")


;; Mode

(define-derived-mode nile-mode prog-mode "Nile"
  "Major mode for the Nile programing language."

  (setq font-lock-defaults '((nile-font-lock-keywords)))

  (set (make-local-variable 'comment-start) "--")

  ;; indentation
  (make-local-variable 'nile-tab-width)
  (make-local-variable 'nile-indent-tabs-mode)
  ;;(set (make-local-variable 'indent-line-function) 'nile-indent-line)
  ;;(set (make-local-variable 'indent-region-function) 'nile-indent-region)
  (set (make-local-variable 'tab-width) nile-tab-width)

  ;; no tabs
  (setq indent-tabs-mode nile-indent-tabs-mode)

  )

(add-to-list 'auto-mode-alist '("\\.nile\\'" . nile-mode))
(add-to-list 'auto-mode-alist '("\\.nl\\'" . nile-mode))
