;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Anuvrat Parsahar"
      user-mail-address "anuvrat@essentia.dev")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;;(setq org-contact-files (list org-directory))
;; (setq org-agenda-files "~/org/" "~/org/org-roam")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; jethro's org-roam config

;; (use-package! org-roam
;;   :init
;;   (map! :leader
;;         :prefix "n"
;;         :desc "org-roam" "l" #'org-roam-buffer-toggle
;;         :desc "org-roam-node-insert" "i" #'org-roam-node-insert
;;         :desc "org-roam-node-find" "f" #'org-roam-node-find
;;         :desc "org-roam-ref-find" "r" #'org-roam-ref-find
;;         :desc "org-roam-show-graph" "g" #'org-roam-show-graph
;;         :desc "jethro/org-capture-slipbox" "<tab>" #'jethro/org-capture-slipbox
;;         :desc "org-roam-capture" "c" #'org-roam-capture)
;;   (setq org-roam-directory (file-truename "~/org-roam/")
;;         org-roam-database-connector 'sqlite-builtin
;;         org-roam-db-gc-threshold most-positive-fixnum
;;         org-id-link-to-org-use-id t)
;;   :config
;;   (org-roam-db-autosync-mode +1)
;;   (set-popup-rules!
;;     `((,(regexp-quote org-roam-buffer) ; persistent org-roam buffer
;;        :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 1)
;;       ("^\\*org-roam: " ; node dedicated org-roam buffer
;;        :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 2)))
;;   (add-hook 'org-roam-mode-hook #'turn-on-visual-line-mode)
;;   (setq org-roam-capture-templates
;;         '(("m" "main" plain
;;            "%?"
;;            :if-new (file+head "main/${slug}.org"
;;                               "#+title: ${title}\n")
;;            :immediate-finish t
;;            :unnarrowed t)
;;           ("r" "reference" plain "%?"
;;            :if-new
;;            (file+head "reference/${slug}.org" "#+title: ${title}\n")
;;            :immediate-finish t
;;            :unnarrowed t)
;;           ("a" "article" plain "%?"
;;            :if-new
;;            (file+head "articles/${slug}.org" "#+title: ${title}\n#+filetags: :article:\n")
;;            :immediate-finish t
;;            :unnarrowed t)))
;;   (defun jethro/tag-new-node-as-draft ()
;;     (org-roam-tag-add '("draft")))
;;   (add-hook 'org-roam-capture-new-node-hook #'jethro/tag-new-node-as-draft)
;;   (cl-defmethod org-roam-node-type ((node org-roam-node))
;;     "Return the TYPE of NODE."
;;     (condition-case nil
;;         (file-name-nondirectory
;;          (directory-file-name
;;           (file-name-directory
;;            (file-relative-name (org-roam-node-file node) org-roam-directory))))
;;       (error "")))
;;   (setq org-roam-node-display-template
;;         (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
;;   (require 'citar)
;;   (defun jethro/org-roam-node-from-cite (keys-entries)
;;     (interactive (list (citar-select-ref :multiple nil :rebuild-cache t)))
;;     (let ((title (citar--format-entry-no-widths (cdr keys-entries)
;;                                                 "${author editor} :: ${title}")))
;;       (org-roam-capture- :templates
;;                          '(("r" "reference" plain "%?" :if-new
;;                             (file+head "reference/${citekey}.org"
;;                                        ":PROPERTIES:
;; :ROAM_REFS: [cite:@${citekey}]
;; :END:
;; #+title: ${title}\n")
;;                             :immediate-finish t
;;                             :unnarrowed t))
;;                          :info (list :citekey (car keys-entries))
;;                          :node (org-roam-node-create :title title)
;;                          :props '(:finalize find-file))))
;;   )

;; org-roam
;; (use-package! org-roam
;;   :custom
;;   (org-roam-directory "~/org/org-roam")
;;   :config
;;   (org-roam-db-autosync-enable))

(use-package! org-contacts
  ;;:custom
  ;;org-contacts-files (list "/Users/anuvrat/org/contacts.org")
)

(setq global-page-break-lines-mode 0)

(use-package org-roam
  :diminish
  :bind (("C-c n a" . org-id-get-create)
         ("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today)
         ("C-c n r" . org-roam-ref-find)
         ("C-c n R" . org-roam-ref-add)
         ("C-c n s" . org-roam-db-sync))
  :custom
  (org-roam-database-connector 'sqlite-builtin)
  :init
  (setq org-roam-directory (file-truename "~/org/")
        org-roam-db-location "~/org/org-roam.db"
        org-roam-db-gc-threshold most-positive-fixnum
        org-roam-v2-ack t)
  (unless (file-exists-p org-roam-directory)
    (make-directory org-roam-directory t))
  :config
  (org-roam-db-autosync-enable)
  (add-to-list 'display-buffer-alist
               '("\\*org-roam\\*"
                 (display-buffer-in-direction)
                 (direction . right)
                 (window-width . 0.33)
                 (window-height . fit-window-to-buffer))))

(after! org
  (add-to-list 'org-capture-templates
             '("d" "Dream" entry
               (file+headline +org-capture-todo-file "Dream")
               "* TODO %?\n :PROPERTIES:\n :CATEGORY: dream\n :END:\n %i\n"
               :prepend t :kill-buffer t)))

(with-eval-after-load 'ox-latex
;; allow for export=>beamer by placing

;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-latex-classes
  ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[11pt]{beamer}\n
      \\mode<{{{beamermode}}}>\n
      \\usetheme{{{{beamertheme}}}}\n
      \\usecolortheme{{{{beamercolortheme}}}}\n
      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{beamerinstitute}}}}\n          
       \\subject{{{{beamersubject}}}}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

  ;; letter class, for formal letters

  (add-to-list 'org-export-latex-classes

  '("letter"
     "\\documentclass[11pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"
     
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; syntax-highlighting for pdf's
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
(setq org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

)

(after! org
  (defadvice! dan/+org--restart-mode-h-careful-restart (fn &rest args)
    :around #'+org--restart-mode-h
    (let ((old-org-capture-current-plist (and (bound-and-true-p org-capture-mode)
                                              (bound-and-true-p org-capture-current-plist))))
      (apply fn args)
      (when old-org-capture-current-plist
        (setq-local org-capture-current-plist old-org-capture-current-plist)
        (org-capture-mode +1)))))
