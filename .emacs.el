;; -*- emacs-lisp -*-
;;
;; ===================================================================
;; Fichier ~/.emacs (fichier de configuration d'Emacs)
;; Sébastien Dinot <sebastien.dinot@free.fr>
;; Time-stamp: <2021-07-22 22:56:08>
;; ===================================================================
;;
;; ===================================================================
;;
;; Quelques commandes bien utiles que j'ai tendance à oublier à cause
;; des raccourcis que je définis :
;;
;; C-_ :
;;   Annulation de la dernière commande exécutée
;; C-x k :
;;   Clore un tampon d'édition (par défaut, le courant)
;; C-x C-right arrow :
;;   Passer au tampon d'édition suivant dans la liste
;; C-x C-left arrow :
;;   Passer au tampon d'édition précédent dans la liste
;; C-q <code ascii> RET :
;;   Insertion du caractère dont le code ASCII est indiqué à la suite
;;   de la séquence C-q. Par défaut, le code ASCII est exprimé en
;;   octal. Par exemple, pour insérer un espace insécable, dont le
;;   code ASCII est (0xa0 en hexa, 160 en décimal et 0240 en octal),
;;   il faut taper « C-q 2 4 0 RET ». Pour pouvoir fournir la valeur
;;   décimale, il faut modifier la variable read-quoted-char-radix :
;;   (setq read-quoted-char-radix 10)
;;   Ceci fait, pour insérer le même espace insécable, on tapera
;;   désormais « C-q 1 6 0 RET »
;; M-g g <numéro de ligne> RET :
;;   Positionner le curseur sur la ligne <numéro de ligne>.
;;
;; ===================================================================


;; Ajouter mon répertoire personnel à la liste des chemins de
;; recherche des modules.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(if (file-exists-p "~/.emacs.d/lisp")
  (setq load-path (cons (concat "~/.emacs.d/lisp") load-path))
)


;; Par défaut, lorsqu'Emacs est lancé dans un terminal, il ne s'adapte
;; pas à la configuration du terminal et du clavier et ne procède donc
;; à aucune conversion des entrées/sorties. Les lignes ci-dessous lui
;; demandent de le faire en se basant sur les locales.
(when (not window-system)
  (set-language-environment 'UTF-8)
  (set-keyboard-coding-system 'utf-8-unix)
  (set-terminal-coding-system 'utf-8-unix)
)


;; Mise en évidence des caractères invisibles tels que les espaces
;; normaux et insécables, les tabulations et les retours à la ligne,
;; les espaces insérés avant des tabulations et les espaces superflus
;; en fin de ligne.
;; (progn
;;   ;; Mode à utiliser avec Emacs 22
;;   ;; http://emacswiki.org/cgi-bin/wiki/BlankMode
;;   (require 'blank-mode)
;;   ;; Le mode n'est pas actif par défaut, on l'active donc...
;;   (global-blank-mode)
;;   ;; ... y compris dans le mode texte où la coloration syntaxique
;;   ;; est inhibée par défaut
;;   (add-hook 'text-mode-hook 'blank-mode-on)
;;   ;; On met en évidence tous les caractères invisibles hormis les
;;   ;; fins de ligne (newline)
;;   (setq blank-chars '(tabs spaces trailing lines space-before-tab))
;;   ;; La mise en évidence se limite à une coloration, aucune
;;   ;; caractère de substitution (mark) n'est inséré.
;;   (setq blank-style '(color))
;;   ;; Style utilisé pour les espaces normaux (pas de mise en évidence)
;;   (set-face-background 'blank-space-face nil)
;;   (set-face-foreground 'blank-space-face "black")
;;   ;; Style utilisé pour les espaces insécables
;;   (set-face-background 'blank-hspace-face "PaleGreen")
;;   (set-face-foreground 'blank-hspace-face "black")
;;   ;; Style utilisé pour les espaces insérés à gauche d'une tabulation
;;   (set-face-background 'blank-space-before-tab-face "orange")
;;   (set-face-foreground 'blank-space-before-tab-face "black")
;;   ;; Style utilisé pour les tabulations
;;   (set-face-background 'blank-tab-face "lemonchiffon")
;;   (set-face-foreground 'blank-tab-face "black")
;;   ;; Style utilisé pour les espaces superflus en fin de ligne
;;   (set-face-background 'blank-trailing-face "gold")
;;   (set-face-foreground 'blank-trailing-face "black")
;;   ;; Style utilisé pour les lignes trop longues
;;   (set-face-background 'blank-line-face "snow2")
;;   (set-face-foreground 'blank-line-face "black")
;;   )

;; Conversion de l'encodage des données lors d'un copier / coller
;; depuis d'autres logiciels sous X.
;; La valeur « compound-text-with-extensions » fait disparaître le
;; problème des conversions de lettres accentuées :
;;   é => ^[%/1\200\214iso8859-15^B
;; Cette fonction n'existe qu'à partir de la version 21 d'Emacs.
(if (>= emacs-major-version 21)
  (setq selection-coding-system 'compound-text-with-extensions)
)


;; Lorsqu'une ligne est plus large que la fenêtre d'affichage, je veux
;; qu'Emacs me l'affiche sur autant de lignes que nécessaire plutôt
;; que de masquer la partie qui dépasse à droite de l'écran. Pour que
;; ce comportement vaille en toute circonstance, il est nécessaire de
;; fixer deux variables.
;; - truncate-lines : comportement dans un tampon occupant toute la
;;   largeur de la fenêtre
;; - truncate-partial-width-windows : comportement dans un tampon
;;   n'occupant qu'une fraction de la largeur de la fenêtre (par
;;   exemple, après un découpage horizontal C-x 3).
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)


;; Lorsqu'on lance Emacs, crée un nouveau tampon (vide) ou ouvre un
;; fichier dont Emacs n'arrive pas à déterminer le type, il bascule
;; par défaut dans le mode fondamental « lisp-interaction-mode ». Ce
;; choix n'est pas pertinent (pour moi du moins) et je préfère qu'il
;; opte dans ce cas pour le mode texte.
;; Au lancement d'Emacs :
(setq initial-major-mode 'text-mode)
;; A la création d'un tampon ou l'ouverture d'un fichier de type non
;; reconnu :
(setq default-major-mode 'text-mode)


;; Faire apparaître la position du curseur dans la ligne modale
(setq column-number-mode t)
(setq line-number-mode t)


;; Afficher l'heure dans la barre d'état (format 24 heures)
(display-time)
(setq display-time-24hr-format t)


;; Curseur clignotant
(blink-cursor-mode t)


;; Selon les règles typographiques françaises, le point final d'une
;; phrase n'est suivi que d'un seul espace (contre deux dans la
;; tradition anglo-saxonne). Il est utile qu'Emacs le sache pour
;; formater correctement les textes.
(setq sentence-end-double-space nil)


;; On peut insérer un caractère « spécial » ne correspondant à aucune
;; touche du clavier en tapant la séquence « C-q <code ascii> RET ».
;; Par défaut, Emacs attend la valeur octale du code ASCII mais je
;; connais mieux les valeurs décimales. Autant qu'Emacs s'adapte...
(setq read-quoted-char-radix 10)


;; Configuration spécifique à une utilisation sous X-Window
;; (if window-system
;;     (progn
;;       ;; Taille par défaut de la fenêtre 100 x 60 caractères.
;;       ;; Pour ajouter un positionnement (en pixels), il faut saisir la
;;       ;; ligne suivante :
;;       ;; (setq initial-frame-alist
;;       ;;       '((top . 1) (left . 1) (width . 100) (height . 60)))
;;       (setq initial-frame-alist '((width . 100) (height . 60)))

;;       ;; Personnalisation du curseur
;;       (setq default-cursor-type '(bar . 2))
;;       (set-cursor-color "red")

;;       ;; Suppression de la barre d'icônes
;;       (tool-bar-mode 0)
;;       ; (menu-bar-mode 0)

;;       ;; Taille de la police employée sous X
;;       (set-default-font "-*-fixed-medium-r-*-*-*-110-*-*-*-*-iso10646-*")
;;     )
;; )


;; Inhiber l'affichage du message d'accueil
(setq inhibit-startup-message t)


;; C'est fastidieux de taper « yes » pour confirmer, raccourcissons
;; cela à « y » (idem pour « no », désormais « n »).
(fset 'yes-or-no-p 'y-or-n-p)


;; Supprimer les fichiers de sauvegarde en quittant.
;; (vous savez, ces fameux fichiers dont le nom se termine par « ~ »)
(setq make-backup-files nil)


;; Sauvegarde des historiques (fichiers ouverts, fonctions invoquées,
;; expressions rationnelles saisies, etc.) d'une session à l'autre.
;;(require 'session)
;;(add-hook 'after-init-hook 'session-initialize)
;;(setq session-initialize '(de-saveplace session places keys menus))
;;(desktop-save-mode 1)


;; La flèche de direction vers le bas ne doit pas étendre le fichier
;; en fin de tampon (seul un retour chariot explicite le fait).
(setq next-line-add-newlines nil)


;; Laisser le curseur en place lors d'un défilement par pages. Par
;; défaut, Emacs place le curseur en début ou fin d'écran selon le
;; sens du défilement.
(setq scroll-preserve-screen-position t)


;; Si cette variable est différente de 'nil', lorsque l'on est à la
;; fin d'une ligne, le déplacement vertical du curseur s'accompagne
;; d'un déplacement horizontal pour atteindre la fin de la ligne
;; courante. Si cette variable vaut 'nil', le déplacement est
;; strictement vertical.
(setq track-eol nil)


;; Colorisation syntaxique maximale dans tous les modes
(require 'font-lock)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)


;; Montrer la correspondance des parenthèses (systématiquement et non
;; seulement après la frappe)
(require 'paren)
(show-paren-mode t)
(setq blink-matching-paren t)
(setq blink-matching-paren-on-screen t)
(setq show-paren-style 'expression)
(setq blink-matching-paren-dont-ignore-comments t)


;; Mise en surbrillance de la zone sélectionnée
(transient-mark-mode 1)


;; Lorsqu'on saisit un texte alors qu'une zone est sélectionnée, cette
;; dernière est écrasée par le texte saisi.
(delete-selection-mode 1)


;; Ne pas remplacer les espaces par des tabulations
(setq-default indent-tabs-mode nil)


;; Fonction remplaçant toutes les tabulations du tampon courant par le
;; nombre d'espaces qui ne modifie pas la mise en page apparente
;; (étrangement, la fonction native d'Emacs ne s'applique qu'à une
;; région, pas à un tampon entier).
(defun untabify-buffer ()
  "Untabify the entire buffer."
  (interactive)
  (untabify (point-min) (point-max))
)


;; Si le support des images est activé alors les afficher lorsqu'on
;; les ouvre.
(if (fboundp 'auto-image-file-mode)
  (auto-image-file-mode 1)
)


;; Chiffrement à la volée
;; (require 'mailcrypt-init)
;; (mc-setversion "gpg")
;; (setq mc-gpg-user-id "sebastien.dinot@free.fr")
;; (setq mc-passwd-timeout 600)


;; Lorsque le fichier est sauvegardé, demander s'il faut ajouter un
;; saut de ligne final lorsqu'il est absent et effacer les espaces
;; superflus en fin de ligne.
(setq require-final-newline 'query)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
;;(setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
;;(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace


;; Par défaut, lors du reformatage du texte (M-q), Emacs ne respecte
;; pas les règles typographiques françaises qui veulent qu'un signe de
;; ponctuation double soit placé sur la même ligne que le mot qui le
;; précède, malgré l'espace (fine) qui le sépare de ce mot. Les
;; déclarations suivantes corrigent le problème. Merci à Matthieu Moy
;; pour la précieuse astuce (http://www-verimag.imag.fr/~moy/emacs/).
(defun my-fill-nobreak-predicate ()
  (save-match-data
    (or (looking-at "[ \t]*[])}»!?;:]")
        (looking-at "[ \t]*\\.\\.\\.")
        (save-excursion
          (skip-chars-backward " \t")
          (backward-char 1)
          (looking-at "[([{«]")
        )
    )
  )
)
(setq fill-nobreak-predicate 'my-fill-nobreak-predicate)


;; Lorsque le curseur atteint la fin de la fenêtre, le contenu se
;; déplace d'une seule ligne et non d'une demi-fenêtre.
(setq scroll-step 1)


;; Conserver une seule ligne de contexte lors d'un déplacement d'une
;; page dans le contenu (appui sur « page up » ou « page down »)
(setq next-screen-context-lines 1)


;; L'outil de correction orthographique « ispell » doit utiliser le
;; thésaurus français.
;;(require 'ispell)
;;(setq ispell-dictionary "francais")


;; Nom français des jours et mois affichés dans le calendrier
;; (cf. M-x calendar)
(setq european-calendar-style t)
(setq calendar-week-start-day 1)
(defvar calendar-day-name-array
  ["dimanche" "lundi" "mardi" "mercredi" "jeudi" "vendredi" "samedi"])
(defvar calendar-day-abbrev-array
  ["dim" "lun" "mar" "mer" "jeu" "ven" "sam"])
(defvar calendar-month-name-array
  ["janvier" "février" "mars" "avril" "mai" "juin"
   "juillet" "août" "septembre" "octobre" "novembre" "décembre"])
(defvar calendar-month-abbrev-array
  ["jan" "fév" "mar" "avr" "mai" "jun"
   "jul" "aoû" "sep" "oct" "nov" "déc"])


;; Avant de sauvegarder un fichier, rechercher (par défaut, dans les 8
;; premières lignes) un marqueur d'horodate de modification et, s'il
;; existe, l'actualiser.
(add-hook 'write-file-hooks 'time-stamp)
;; Format de l'horodate insérée (syntaxe propre à Emacs).
(setq time-stamp-format "%:y-%02m-%02d %02H:%02M:%02S")
;; Motif à rechercher (avec, en préfixe et suivi d'un slash, le nombre
;; de lignes à scruter à partir du haut du fichier). A la réflexion,
;; je préfère conserver le motif par défaut car la normalisation a des
;; avantages. (c:
; (setq time-stamp-pattern "20/Modifié le %%$")


;; Insertion de date au format AAAA-MM-JJ
;; (defun insert-iso-date-string ()
;;   "Insert a nicely formated date string."
;;   (interactive)
;;   (insert (format-time-string "%Y-%m-%d")))
;; ;; La séquence « C-c d » insère la date
;; (global-set-key [(control c) (d)] 'insert-iso-date-string)


;; Insertion de date en clair JJ Mois AAAA
(defun insert-text-date-string ()
  "Insert a nicely formated date string."
  (interactive)
  (insert (format-time-string "%d %B %Y")))
;; La séquence « C-c S-d » insère la date
(global-set-key [(control c) (shift d)] 'insert-text-date-string)


;; Insertion d'horodate au format AAAA-MM-JJ HH:NN:SS
(defun insert-iso-time-string ()
  "Insert a nicely formated timestamp string."
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))
;; La séquence « C-c t » insère l'horodate
(global-set-key [(control c) (t)] 'insert-iso-time-string)


;; Insertion d'horodate au format AAAA-MM-JJ HH:NN:SS
(defun insert-text-time-string ()
  "Insert a nicely formated timestamp string."
  (interactive)
  (insert (format-time-string "%d %B %Y à %H:%M:%S")))
;; La séquence « C-c S-t » insère l'horodate
(global-set-key [(control c) (shift t)] 'insert-text-time-string)


;; Surcharge de la séquence « C-x k ». Au lieu de demander le nom du
;; tampon à détruire, elle détruit systématiquement le tampon courant.
(global-set-key [(control x) (k)] 'kill-this-buffer)

;; Switch entre multi frames
(icomplete-mode 1)

;;(require 'ido)
;;(ido-mode t)
(global-set-key [(control shift right)] 'next-multiframe-window)
(global-set-key [(control shift left)] 'previous-multiframe-window)

;; « F6 » <=> aller à la ligne précisée ensuite (alternative à la
;;            séquence « M-g g »)
;;(global-set-key [f6]  'goto-line)


;; F9       <=> remplacement interactif simple.
;; Shift-F9 <=> remplacement interactif intégrant des expressions
;;              régulières.
(global-set-key [f9]         'query-replace)
(global-set-key [(shift f9)] 'query-replace-regexp)


;; A partir de la version 21 d'Emacs, les séquences de touches
;; ci-dessous ont le comportement défini ici. Les déclarations qui
;; suivent sont donc inutiles mais je les garde tout de même sous le
;; coude pour le cas où...
;;
;; Suppr.      <=> Supprimer le caractère sous le curseur
;; Backspace   <=> Supprimer le caractère précédent le curseur
;; Home        <=> Début de ligne
;; End         <=> Fin de ligne
;; Ctrl + Home <=> Début du document
;; Ctrl + End  <=> Fin du document
;;
;; (global-set-key [delete] 'delete-char)
;; (global-set-key [backspace] 'delete-backward-char)
;; (global-set-key [home] 'beginning-of-line)
;; (global-set-key [end]  'end-of-line)
;; (global-set-key [(control home)] 'beginning-of-buffer)
;; (global-set-key [(control end)]  'end-of-buffer)


;; Effacement des caractères blancs (y compris les nouvelles lignes)
;; jusqu'au prochain caractère non blanc. Cette fonction est bien
;; utile après un copier-coller de puis Netscape.
(defun trim-whitespace () (interactive)
  "Effacer les caracteres blancs jusqu'au prochain non blanc"
  (save-excursion
    (if (re-search-forward "[  \t\r\n]*[^  \t\r\n]" nil t)
      (delete-region (match-beginning 0) (- (point) 1))
    )
  )
)
(global-set-key [f10] 'trim-whitespace)


;; F11        <=> Masquer le bloc de code courant
;; F12        <=> Montrer le bloc de code courant
;; Meta + F11 <=> Masquer tous les blocs de code
;; Meta + F12 <=> Montrer tous les blocs de code
(global-set-key [f11] 'hs-hide-block)
(global-set-key [f12] 'hs-show-block)
(global-set-key [(meta f11)] 'hs-hide-all)
;; FIXME: Pourquoi cette association ne fonctionne-t'elle pas alors
;; qu'invoquée explicitement, la commande « hs-show-all » fonctionne
;; parfaitement.
(global-set-key [(meta f12)] 'hs-show-all)


;; ===================================================================
;; =====   Interaction avec la souris                            =====
;; ===================================================================

;; Lors d'un « copier-coller » à la souris, insérer le texte au niveau
;; du point cliqué et non à la position du curseur texte.
(setq mouse-yank-at-point nil)


;; Prise en charge de la molette de la souris.
;; Utilisée seule, la rotation de la molette provoque un défilement de
;; 5 lignes par cran. Combinée à la touche Shift, le défilement est
;; réduit à une ligne. Combinée à la touche Control, le défilement
;; s'effectue page (1 hauteur de fenêtre) par page.
(require 'mwheel)
(mouse-wheel-mode 1)


;; Si le mode précédent n'est pas disponible, décommenter les lignes
;; qui suivent pour le remplacer.
;;
;; Molette seule <=> déplacement de cinq lignes
;; (defun up-slightly () (interactive) (scroll-up 5))
;; (defun down-slightly () (interactive) (scroll-down 5))
;; (global-set-key [mouse-4] 'down-slightly)
;; (global-set-key [mouse-5] 'up-slightly)
;;
;; Molette + Shift <=> déplacement d'une ligne
;; (defun up-one () (interactive) (scroll-up 1))
;; (defun down-one () (interactive) (scroll-down 1))
;; (global-set-key [S-mouse-4] 'down-one)
;; (global-set-key [S-mouse-5] 'up-one)
;;
;; Molette + Control <=> déplacement d'une page
;; (defun up-a-lot () (interactive) (scroll-up))
;; (defun down-a-lot () (interactive) (scroll-down))
;; (global-set-key [C-mouse-4] 'down-a-lot)
;; (global-set-key [C-mouse-5] 'up-a-lot)


;; ===================================================================
;; =====   Edition de code C/C++                                 =====
;; ===================================================================

;; Charger le mode C/C++
(require 'cc-mode)

; Activation systématique du mode mineur HS dans les modes C/C++
(add-hook 'c-mode-common-hook 'hs-minor-mode t)

;; Le module ctypes permet d'ajouter à la liste des types de données
;; C/C++ des types non reconnus par défaut. Ces types sont alors
;; connus et gérés par le module de colorisation syntaxique.
;;(require 'ctypes)


;; Chargement du fichier décrivant les types C/C++ non reconnus par
;; défaut (~/elisp/ctypes).
(defun my-ctypes-load-hook ()
  (ctypes-read-file "~/.elisp/ctypes" nil t t)
)
(add-hook 'ctypes-load-hook 'my-ctypes-load-hook)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/src/emacs-modes/custom-modes"))


;; cscope
;;(require 'xcscope)
;;(require 'ascope)

(setq cscope-command-args "-q")

(global-set-key [(control x) (g)] 'cscope-find-this-symbol)
(global-set-key [(control x) (j)] 'cscope-find-global-definition)

;;(global-set-key [(control x) (g)] 'ascope-find-this-symbol)
;;(global-set-key [(control x) (j)] 'ascope-find-global-definition)


;; ===================================================================
;; =====   Edition de code XML                                   =====
;; ===================================================================

;; (require 'nxml-mode)
;; (add-hook 'nxml-mode-hook
;;           (lambda ()
;;             (setq fill-column 78)
;;           )
;; )

;; (fset 'xml-mode 'nxml-mode)


;; ===================================================================
;; =====   Mode d'édition préféré par type de fichier            =====
;; ===================================================================

; Sélection du mode d'édition en fonction du motif satisfait par le
; nom du fichier.
(setq auto-mode-alist
  (append
    '(("\\.sh\\'" . sh-mode)
      ("bash" . sh-mode)
      ("profile" . sh-mode)
      ("Makefile\\'" . makefile-mode)
      ("makefile\\'" . makefile-mode)
      ("\\.mk\\'" . makefile-mode)
      ;;("\\.c\\'"  . c-mode)
      ("\\.h\\'"  . c-mode)
      ("\\.cc\\'" . c++-mode)
      ("\\.hh\\'" . c++-mode)
      ("\\.cpp\\'"  . c++-mode)
      ("\\.hpp\\'"  . c++-mode)
      ("\\.pgc\\'"  . c++-mode) ; Fichiers « Embedded PostgreSQL in C »
      ("\\.p[lm]\\'" . cperl-mode)
      ("\\.el\\'" . emacs-lisp-mode)
      ("\\.emacs\\'" . emacs-lisp-mode)
      ("\\.l\\'" . lisp-mode)
      ("\\.lisp\\'" . lisp-mode)
      ("\\.txt\\'" . text-mode)
      ("\\.sgml\\'" . nxml-mode)
      ("\\.xml\\'" . nxml-mode)
      ("\\.xsl\\'" . nxml-mode)
      ("\\.svg\\'" . nxml-mode)
      ("\\.[sx]?html?\\'" . nxml-mode)
      ("\\.tpl\\'" . nxml-mode)
      ("\\.php\\'" . php-mode)
      ("\\.inc\\'" . php-mode)
      ("\\.awk\\'" . awk-mode)
      ("\\.tex\\'" . latex-mode)
      )
     auto-mode-alist
  )
)

(defun start-ide-skel ()
  (require 'tabbar)
     (require 'ide-skel)

     (ide-skel-show-right-view-window)
     ;; optional, but useful - see Emacs Manual
     (partial-completion-mode)
     (icomplete-mode)

     ;; for convenience
     (global-set-key [f4] 'ide-skel-proj-find-files-by-regexp)
     (global-set-key [f5] 'ide-skel-proj-grep-files-by-regexp)
     (global-set-key [f10] 'ide-skel-toggle-left-view-window)
     (global-set-key [f11] 'ide-skel-toggle-bottom-view-window)
     (global-set-key [f12] 'ide-skel-toggle-right-view-window)
     (global-set-key [C-next] 'tabbar-backward)
     (global-set-key [C-prior]  'tabbar-forward))

;;(if window-system
;;    (start-ide-skel))

;; Ruby
(setq ruby-indent-level 8)


;; Vala
;; C# mode (used for vala!)
;; (autoload 'vala-mode "vala-mode" "Major mode for editing Vala code." t)
;; (add-to-list 'auto-mode-alist '("\\.vala$" . vala-mode))
;; (add-to-list 'auto-mode-alist '("\\.vapi$" . vala-mode))
;; (add-to-list 'file-coding-system-alist '("\\.vala$" . utf-8))
;; (add-to-list 'file-coding-system-alist '("\\.vapi$" . utf-8))

(autoload 'vala-mode "vala-mode" "Major mode for editing Vala code." t)
(add-to-list 'auto-mode-alist '("\\.vala$" . vala-mode))
(add-to-list 'auto-mode-alist '("\\.vapi$" . vala-mode))
(add-to-list 'file-coding-system-alist '("\\.vala$" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.vapi$" . utf-8))

;; Javascript
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(js-indent-level 2)
 '(safe-local-variable-values
   '((eval progn
           (c-set-offset 'innamespace '0)
           (c-set-offset 'inline-open '0)
           (c-set-offset 'member-init-intro '0))
     (eval progn
           (c-set-offset 'innamespace '0)
           (c-set-offset 'inline-open '0)
           (c-set-offset 'member-init-intro '0)
           (c-set-offset 'member-init-cont '0))
     (eval progn
           (c-set-offset 'innamespace '0)
           (c-set-offset 'inline-open '0)
           (c-set-offset 'member-init-cont 0))
     (eval progn
           (c-set-offset 'innamespace '0)
           (c-set-offset 'inline-open '0))
     (eval progn
           (c-set-offset 'innamespace '3)
           (c-set-offset 'inline-open '3))
     (whitespace-line-column . 80)
     (eval ignore-errors
           (require 'whitespace)
           (whitespace-mode 1))
     (whitespace-line-column . 79)
     (whitespace-style face indentation)
     (eval progn
           (c-set-offset 'case-label '0)
           (c-set-offset 'innamespace '0)
           (c-set-offset 'inline-open '0)))))

;; OMeta
(require 'ometa-mode)

;; Nile
(require 'nile-mode)

;; Coffeescript
(require 'coffee-mode)


;; Peg/Leg
(require 'leg-mode)
(require 'peg-mode)

(add-to-list 'auto-mode-alist '("\\.leg$" . leg-mode))
(add-to-list 'auto-mode-alist '("\\.peg$" . peg-mode))

;;(require 'blank-mode)

;;(add-hook 'vala-mode-hook #'wisent-csharp-default-setup)

;; (require 'csharp-mode)

;; (defcustom vala-mode-hook nil
;;   "*Hook called by `vala-mode'."
;;   :type 'hook
;;   :group 'c)

;; Vala
;; (defun vala-mode ()
;;   "Vala hack."
;;   (interactive)
;; ;  (kill-all-local-variables)
;; ;  (c-initialize-cc-mode t)
;;   (vala-mode)
;;   (setq mode-name "Vala")
;;   (run-hooks 'c-mode-common-hook)
;;   (c-set-style "linux")
;;   (setq indent-tabs-mode t)
;;   (setq c-basic-offset 8)
;;   (setq tab-width 8)
;; ; auto stuff isn't good yet
;;   (c-toggle-auto-newline -1)
;;   (c-toggle-hungry-state -1)
;;   (run-hooks 'vala-mode-hook))

;(add-to-list 'auto-mode-alist '("\\.vala\\'" . vala-mode))

;; If you have CEDET or Semantic loaded, uncomment this line
;(semantic-load-enable-code-helpers)

(setq vc-handled-backends nil)

(defun insert-rpm-header ()
  "Insert the RPM changelog header for me."
  (interactive)
  (insert "* "
          (format-time-string "%a %b %d %Y")
          " "
          (user-full-name)
          " "
          "<lionel.g.landwerlin@linux.intel.com>"
          " - "
          "\n- \n\n"
          )
  (end-of-line -1)
)


(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Java shit
(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 8
                                  tab-width 8
                                  indent-tabs-mode t)))

;; CTS shit
(c-add-style "cts"
             '("gnu"
               (c-offsets-alist . ((substatement-open . 0)))
               (c-basic-offset . 4)))

(defconst cts-c-regexp
  (concat "/\\(VK-GL-CTS\\|vulkancts\\)/.*\\(?:c\\|cc\\|h\\|cpp\\|hpp\\|inl\\)\\'"))

(defun maybe-set-cts-c-style ()
  (when (and (buffer-file-name)
             (string-match cts-c-regexp (buffer-file-name)))
    (c-set-style "cts")
    (setq tab-width 4)
    (setq indent-tabs-mode t)))

(add-hook 'c-mode-hook 'maybe-set-cts-c-style)
(add-hook 'c++-mode-hook 'maybe-set-cts-c-style)
