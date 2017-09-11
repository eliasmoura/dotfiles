;;; package --- SUMARY
;;; Commentary:
;;; Code:
(defconst emacs-start-time (current-time))
(unless noninteractive
  (message "Loading %s..." load-file-name))
(eval-and-compile
  (progn
    (setq select-enable-clipboard t
          select-enable-primary t
          save-interprogram-paste-before-kill t
          apropos-do-all t
          mouse-yank-at-point t
          require-final-newline t
          visible-bell t
          load-prefer-newer t
          ediff-window-setup-function 'ediff-setup-windows-plain
          user-emacs-directory "~/local/cfg/emacs/"
          save-place-file (concat user-emacs-directory "hist_files")
          backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                   "backups")))))
  (setq auto-save-file-name-transforms '((".*" "~/local/cfg/emacs/local/auto-save-list/" t)))
  (setq savehist-file (concat user-emacs-directory "local/savehist"))
  (mapc #'(lambda (path)
            (add-to-list 'load-path
                         (expand-file-name path user-emacs-directory)))
        '("plugin" "plugin/diminish" "plugin/use-package"))
  (setq use-package-enable-imenu-support t)
  (require 'use-package))
(setq plugin-directory "~/local/cfg/emacs/plugin")
(package-initialize nil)
(require 'diminish)                ;; if you use :diminish
;; This sets up the load path so that we can override it
(setq backup-directory-alist '(("." . "~/local/tmp/emacs/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(savehist-mode 1)
(set-default 'semantic-case-fold t)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

(setq gdb-many-windows t)

(setq package-enable-at-startup nil)

(setq user-full-name "Elias Alves Moura"
      user-mail-address "eliasmoura.alves@gmail.com")

(defun display-startup-echo-area-message ()
  (message "Let the hacking begin!"))
                                        ; Cosmetics
;; Removing all unnecessary stuff and setting up a cool color scheme and mode-line
(server-start)
;; Show matching brackets
(show-paren-mode 1)
;;  auto close brackets
(electric-pair-mode 1)
;; update files when changed
(global-auto-revert-mode 1)
;; hilight the current line
(global-hl-line-mode 1)
;; break the lines
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default truncate-partial-width-windows 50) (menu-bar-mode -1)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(blink-cursor-mode -1)
(mouse-wheel-mode -1)
(tooltip-mode -1)
(global-linum-mode 0)
(add-hook 'prog-mode-hook 'linum-mode)
(column-number-mode t)
(fringe-mode 0)
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
(server-start t t)
(use-package whitespace
  :disabled t
  :defer t
  :init
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  :config
  (global-whitespace-mode t))
(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq sentence-end-double-space nil)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
(setq-default indent-tabs-mode nil)

                                        ;(setq hl-todo-keyword-faces '(("TODO"  . hl-todo)
                                        ;("NOTE"  . hl-todo)
                                        ;("HACK"  . hl-todo)
                                        ;("BUG"   . hl-todo)
                                        ;("XXX"   . hl-todo)
                                        ;("FIXME" . hl-todo)))
                                        ;
                                        ;(with-eval-after-load 'hl-todo (hl-todo-set-regexp))
;; Packages required by other packages
(use-package let-alist  :defer t :load-path "plugin/let-alist")
(use-package dash       :defer t :load-path "plugin/dash")
(use-package tern        :defer t :load-path "plugin/tern")
(use-package popwin     :defer t :load-path "plugin/popwin-el")
(use-package s          :defer t :load-path "plugin/s")
(use-package function-args :load-path "plugin/function-args"
  :config (fa-config-default))
;;(use-package popup :defer t :load-path "~/.emacs.d/plugin/popup-el")
(use-package base16-theme
  :disabled t
  :load-path ("plugin/base16-emacs" "plugin/base16-emacs/build/")
  :init
  (add-to-list 'custom-theme-load-path "~/local/cfg/emacs/plugin/base16-emacs")
  (add-to-list 'custom-theme-load-path "~/local/cfg/emacs/plugin/base16-emacs/build/")
  (load-theme 'base16-brewer t)
  )
(use-package smart-mode-line
  :load-path ("plugin/smart-mode-line" "plugin/rich-minority")
  :init
  (setq sml/no-confirm-load-theme t)
  (use-package rich-minority :load-path "plugin/rich-minority" :config)
  (setq sml/theme 'dark)
  :config
  (add-to-list 'sml/replacer-regexp-list '("^~/dev/" ":DEV:"))
  (add-to-list 'sml/replacer-regexp-list '("^~/dev/c/mixedlang/" ":ML:"))
  (add-to-list 'sml/replacer-regexp-list '("^~/arch/linux/superman/recipes/" ":PS:"))
  (add-to-list 'sml/replacer-regexp-list '("^~/local/cfg/" ":CFG:"))
  (add-to-list 'sml/replacer-regexp-list '("^~/writings/" ":WRITING:"))
  (add-to-list 'sml/replacer-regexp-list '("^~/writings/org/" ":ORG:"))
  (add-to-list 'sml/replacer-regexp-list '("^~/writings/lang-8/users/kosa/" ":KOSA:"))
  (sml/setup))

(global-set-key (kbd "C-x f") 'elfeed)

(use-package undo-tree
  :diminish undo-tree-mode
  :load-path "plugin/undo-tree/"
  :defer t
  :config
  ;; C-x u
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

;; frequently accessed files
(defvar my/refile-map (make-sparse-keymap))
(defmacro my/defshortcut (key file)
  `(progn
     (set-register ,key (cons 'file ,file))
     (define-key my/refile-map
       (char-to-string ,key)
       (lambda (prefix)
         (interactive "p")
         (let ((org-refile-targets '(((,file) :maxlevel . 6)))
               (current-prefix-arg (or current-prefix-arg '(4))))
           (call-interactively 'org-refile))))))

(my/defshortcut ?I "~/local/cfg/emacs/config.org")
(my/defshortcut ?i "~/local/cfg/emacs/init.el")
(my/defshortcut ?o "~/writings/org/base.org")
(my/defshortcut ?b "~/writings/org/business.org")
(my/defshortcut ?B "~/writings/org/books.org")
(my/defshortcut ?j "~/writings/org/journal.org")
(my/defshortcut ?C "~/writings/org/calendar.org")
(my/defshortcut ?q "~/writings/org/questions.org")
(use-package org
  :load-path ("plugin/org-mode/lisp/" "plugin/org-mode/contrib/lisp")
  :defer t
  :init
  (setq org-global-properties
        '("Effort_ALL". "0:05 0:15 0:30 1:00 2:00 3:00 4:00 5:00 6:00 7:00"))
  (setq org-export-coding-system 'utf-8)
  ;; (org-babel-load-file "~/.emacs.d/config.org")
  (setq calendar-date-style "ISO")
  (setq org-default-directory "~/writings/org")
  (setq org-directory "~/writings/org")
  (setq org-startup-folded nil)
  (setq org-startup-truncated nil)
  (setq org-log-into-drawer "LOGBOOK")
  (setq org-clock-into-drawer 1)
  :config
  (defun endless/org-ispell ()
    "Configure `ispell-skip-region-alist' for `org-mode'."
    (make-local-variable 'ispell-skip-region-alist)
    (add-to-list 'ispell-skip-region-alist '(org-property-drawer-re))
    (add-to-list 'ispell-skip-region-alist '("~" "~"))
    (add-to-list 'ispell-skip-region-alist '("=" "="))
    (add-to-list 'ispell-skip-region-alist '("^#\\+BEGIN_SRC" . "^#\\+END_SRC")))
  (add-hook 'org-mode-hook #'endless/org-ispell)

  ;;  Too many clock entries clutter up a heading.
  (defvar my/org-basic-task-template "* TODO %^{Task}
    :PROPERTIES:
    :END:
    Captured %<%Y-%m-%d %H:%M>
    %?

    %a

    %i
    " "Basic task data")
  (setq org-capture-templates
        `(("t" "Tasks" entry
           (file+headline "~/writings/org/organizer.org" "Tasks")
           "* TODO %? \n")
          ("T" "Quick task" entry
           (file+headline "~/writings/org/organizer.org" "Tasks")
           "* TODO %^{Task}\nSCHEDULED: %t\n"
           :immediate-finish t)
          ("m" "Mixedlang tasks" entry
           (file+headline "~/dev/c/mixedlang/TODOS.org" "Tasks")
           "* TODO %?\n" "todo…")
          ("i" "Idea" entry (file org-default-notes-file)
           "* %? :idea: \n" :clock-in t :clock-resume t)))

  (use-package org-agenda
    :defer t
    :init
    
    
    )
  :config
  (setq org-columns-default-format "%50ITEM(Task) %10Effort(Effort){:} %8CLOCKSUM %10TIMESTAMP_IA %10TAGS")
  (setq org-agenda-files '("~/writings/org/"))
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (use-package org-velocity
    :config
    (setq org-velocity-bucket (expand-file-name "base.org" org-directory))
    )
  (custom-set-faces
   '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t))
  (setq org-src-fontify-natively t)
  (setq org-log-done 'time)
  (setq org-log-done 'note)
  (add-hook 'org-mode-hook 'turn-on-flyspell 'append)
  (put 'upcase-region 'disabled nil)
  (setcar (nthcdr 2 org-emphasis-regexp-components) " \t\r\n\"'")
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
  ;; (add-hook 'org-mode-hook #'(lambda () (yas-minor-mode 1)))
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAITING(w@!/!)" "|" "DONE")
          (sequence "READ(r)" "READING(R!)" "HALTED(h!/!)" "|" "DONE" "GIVEUP")
          (sequence "SELF(s)" "|" "DONE(d@!)" "GIVEUP(g@)")
          (sequence "REPORT(p)" "BUG(b!@)" "KNOWNCAUSE(k@!)" "|" "FIXED(f@!)")
          (sequence "|" "CANCELED")))
  (setq org-cycle-separator-lines 1)
  )

(use-package dired
  :defer t
  :init
  (setq wdired-allow-to-change-permissions t)
  
  :config
  (progn
    (add-hook 'dired-mode-hook #'toggle-truncate-lines)
    (setf dired-listing-switches "-alhG"
          dired-guess-shell-alist-user
          '(("\\(\\.pdf\\|\\.ps\\|\\.epub\\)\\'" "zathura")
            ("\\(\\.ods\\|\\.xlsx?\\|\\.docx?\\|\\.csv\\)\\'" "libreoffice")
            ("\\(\\.png\\|\\.jpe?g\\)\\'" "imv")
            ("\\(\\.gif\\|\\.mp4\\|\\.mkv\\)\\'" "mpv"))))
  )

(use-package flycheck
  :defer 3
  :diminish t
  :load-path "plugin/flycheck"
  :config
  (use-package flycheck-irony
    :load-path "plugin/flycheck-irony"
    :config
    (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
    )
  (setq flycheck-clang-pedantic-errors t)
  (setq flycheck-clang-language-standard "c11")
  (setq flycheck-clang-warnings '("all" "extra" "error" "shorten-64-to-32"))
  (add-hook 'c-mode-common-hook #'flycheck-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flyspell
  :init
  :diminish t
  :defer 5
  :config
  
  (global-key-binding (kbd "[ s") 'flyspell-previous-command)
  (use-package ispell
    :config
    )
  (setq ispell-list-command "--list")
  (let ((langs '("american" "pt_BR" "ru")))
    (setq lang-ring (make-ring (length langs)))
    (dolist (elem langs) (ring-insert lang-ring elem)))
  (defun cycle-ispell-languages ()
    (interactive)
    (let ((lang (ring-ref lang-ring -1)))
      (ring-insert lang-ring lang)
      (ispell-change-dictionary lang)))
  (global-set-key [f6] 'cycle-ispell-languages)
  (unbind-key "C-." flyspell-mode-map))

(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-h") 'backward-delete-char-untabify)

(use-package ivy
  :load-path "plugin/swiper"
  :diminish ivy-mode
  :config
  (use-package swiper :load-path "plugin/swiper/")
  (require 'counsel)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 15)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-extra-directories nil)

  
  (ivy-mode 1)
                                        ;open directory, type "C-f"
  (defun eh-ivy-open-current-typed-path ()
    (interactive)
    (when ivy--directory
      (let* ((dir ivy--directory)
             (text-typed ivy-text)
             (path (concat dir text-typed)))
        (delete-minibuffer-contents)
        (ivy--done path))))
  )

(use-package magit
  :load-path ("plugin/magit/lisp" "plugin/with-editor")
  :defer 5
  :preface
  (setq magit-repository-directories '("~/local/cfg/emacs/plugin"))
  :init
  (add-hook 'magit-mode-hook 'hl-line-mode)
  :config
  
  (setenv "GIT_PAGER" "")
  (use-package magit-backup
    :commands magit-backup-mode
    :config
    (magit-backup-mode -1))
  (use-package magit-commit
    :config
    (remove-hook 'server-switch-hook 'magit-commit-diff))
  (unbind-key "M-h" magit-mode-map)
  (unbind-key "M-s" magit-mode-map)
  (unbind-key "M-m" magit-mode-map)
  ;; (bind-key "M-H" #'magit-show-level-2-all magit-mode-map)
  ;; (bind-key "M-S" #'magit-show-level-4-all magit-mode-map)
  (bind-key "U" #'magit-unstage-all magit-mode-map)
  (add-hook 'magit-log-edit-mode-hook
            #'(lambda ()
                (set-fill-column 72)
                (flyspell-mode)))
  (add-hook 'magit-status-mode-hook #'(lambda () (magit-monitor t))))

(use-package cc-mode
  :mode (("\\.h\\(h?\\|xx\\|pp\\)\\'" . c++-mode)
         ("\\.m\\'"                   . c-mode)
         ("\\.c\\'"                   . c-mode)
         ("\\.mm\\'" . c++-mode))
  :config
  (setq c-default-style '((java-mode . "java")
                          (awk-mode . "awk")
                          (other . "gnu")))
  (c-add-style "mine"
               '(nil
                 (c-basic-offset . 2)     ; Guessed value
                 (c-offsets-alist
                  (block-close . 0)       ; Guessed value
                  (case-label . 0)        ; Guessed value
                  (class-close . 0)       ; Guessed value
                  (cpp-define-intro . +)  ; Guessed value
                  (defun-block-intro . +) ; Guessed value
                  (defun-close . 0)       ; Guessed value
                  (defun-open . 0)        ; Guessed value
                  (else-clause . 0)       ; Guessed value
                  (inclass . +)           ; Guessed value
                  (label . *)             ; Guessed value
                  (statement . 0)         ; Guessed value
                  (statement-block-intro . +) ; Guessed value
                  (statement-case-intro . +) ; Guessed value
                  (statement-case-open . +)  ; Guessed value
                  (statement-cont . +)    ; Guessed value
                  (substatement . +)      ; Guessed value
                  (substatement-open . +) ; Guessed value
                  (topmost-intro . 0)     ; Guessed value
                  (arglist-close . c-lineup-close-paren)
                  (arglist-cont-nonempty . c-lineup-arglist)
                  (c . c-lineup-C-comments)
                  (comment-intro . c-lineup-comment)
                  (cpp-macro . -1000)
                  (inher-cont . c-lineup-multi-inher)
                  (string . -1000))))
  
  (font-lock-add-keywords 'c++-mode '(("\\<\\(assert\\|DEBUG\\)("
                                       1 font-lock-warning-face t)))
  (setq font-lock-maximum-decoration '((c-mode . 1) (c++-mode . 1) (t . 2)))
  (add-hook 'c-mode-hook 'turn-on-lock)
  )

(use-package elfeed
  :load-path ("plugin/elfeed")
  :init
  (setq elfeed-set-max-connections 5)
  (setf url-queue-timeout 40)
  (setq elfeed-search-face-alist "")
  (defface important-elfeed-entry
    '((t :foreground "#f77"))
    "Marks an important Elfeed entry.")
  (push '(important important-elfeed-entry)
        elfeed-search-face-alist)
  (defface elfeed-youtube
    '((t :foreground "#f9f"))
    "Marks YouTube videos in Elfeed."
    :group 'elfeed)
  (push '(youtube elfeed-youtube)
        elfeed-search-face-alist)
  (defface elfeed-podcast
    '((t :foreground "#31f"))
    "Marks podcast in Elfeed."
    :group 'elfeed)
  (push '(youtube elfeed-podcast)
        elfeed-search-face-alist)
  :config
  (use-package elfeed-org :load-path "plugin/elfeed-org"
    :init
    (setq rmh-elfeed-org-files (list "~/writings/org/rss.org"))
    :config
    (elfeed-org))
  (use-package feed-setup :load-path "lisp"
    :config (require 'feed-setup))
  (setf bookmark-default-file (locate-user-emacs-file "local/bookmarks"))
  
  (defun elfeed-search-tag-all-junk ()
    (elfeed-expose #'elfeed-search-tag-all 'junk)
    (elfeed-expose #'elfeed-search-tag-all 'read)
    "Add the `unread' tag to all selected entries.")
  )

(use-package ace-jump-mode
  :load-path "plugin/ace-jump-mode"
  :disabled t
  :config
  )
(use-package pkgbuild-mode
  :load-path "plugin/pkgbuild-mode"
  :disabled t
  :init
  (setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode))
                                auto-mode-alist))
  :config
  )
(use-package markdown-mode
  :load-path "plugin/markdown-mode"
  :mode (("\\`README\\.md\\'" . gfm-mode)
         ("\\.md\\'"          . markdown-mode)
         ("\\.markdown\\'"    . markdown-mode))
  :config)
(use-package simple-httpd :load-path "plugin/emacs-web-server"
  :init
  (setq httpd-root "~/local/tmp/http/")
  :config
  (httpd-start)
  )
(use-package js2-mode :load-path "plugin/js2-mode"
  :config)
(use-package skewer-mode :load-path "plugin/skewer-mode"
  :config
  (use-package skewer-html
    :config
    (add-hook 'html-mode-hook 'skewer-html-mode)
    )
  (use-package skewer-css
    :config
    (add-hook 'css-mode-hook 'skewer-css-mode)
    )
  (add-hook 'js2-mode-hook 'skewer-mode)
  )
(use-package nasm-mode :load-path "plugin/nasm-mode"
  :config
  :disabled t
  )
(use-package rainbow-delimiters
  :load-path "plugin/rainbow-delimiters"
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package smartparens
  :load-path "plugin/smartparens"
  :disabled t
  :init
  :config
  (require 'smartparens-config)
  )

(use-package slime
  :defer t
  :load-path "plugin/slime"
  :config
  (setq inferior-lisp-program "sbcl")
  ;;(slime-setup '(slime-company))
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  )
(use-package stumpwm-mode :load-path "plugin/swm-emacs"
  :config
  (setq stumpwm-shell-program "~/local/bin/stumpish")
  (load "~/local/cfg/emacs/plugin/swm-emacs/stumpwm-utils.el")
  
  )

(use-package company
  :disabled t
  :load-path
  ("plugin/company-mode"
   "plugin/tern/emacs"
   "plugin/tern/bin")
  :init
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-tooltip-limit 20)                      ;; bigger popup window
  (setq company-tooltip-align-annotations 't)          ;; align annotations to the right tooltip border
  (setq company-idle-delay .1)                         ;; decrease delay before autocompletion popup shows
  (setq company-begin-commands '(self-insert-command)) ;; start autocompletion only after typing
  (global-set-key (kbd "C-c /") 'company-files)        ;; Force complete file names on "C-c /" key
  
  
  (use-package company-tern
    :load-path "plugin/company-tern"
    :defer t
    :diminish company-tern-mode
    :config
    (add-to-list 'company-backends 'company-tern)
    (add-hook 'js-mode-hook 'tern-mode))
  (company-mode t)
  (use-package slime-company
    :load-path "plugin/slime-company"
    :config)
  )

(use-package irony
  :load-path "plugin/irony-mode/"
  :config
  (use-package company-irony :load-path "plugin/company-irony/"
    :disabled t
    :config
    (eval-after-load 'company
      '(add-to-list 'company-backends 'company-irony)))
  
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (require 'irony-cdb)
  ;; replace the `completion-at-point' and `complete-symbol' bindings in
  ;; irony-mode's buffers by irony-mode's function
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )
;; Language Dictionaries
;;https://github.com/gucong/emacs-sdcv
(use-package sdcv-mode
  :load-path "plugin/emacs-sdcv/"
  :init
  :config
  )

(use-package notmuch
  ;;:defer nil
  :init
  :config
  (defun my-notmuch-tag-purchase ()
    (interactive)
    (notmuch-search-tag '("-inbox" "+purchase") (car(notmuch-search-interactive-region)) (car (cdr(notmuch-search-interactive-region))) t))
  (defun my-notmuch-tag-payment ()
    (interactive)
    (notmuch-search-tag '("-inbox" "+payment") (car(notmuch-search-interactive-region)) (car (cdr(notmuch-search-interactive-region))) t))
  (defun my-notmuch-tag-family ()
    (interactive)
    (notmuch-search-tag '("-inbox" "+family") (car(notmuch-search-interactive-region)) (car (cdr(notmuch-search-interactive-region))) t))
  (defun my-notmuch-tag-accounts ()
    (interactive)
    (notmuch-search-tag '("-inbox" "+accounts") (car(notmuch-search-interactive-region)) (car (cdr(notmuch-search-interactive-region))) t))
  (defun my-notmuch-tag-delete ()
    (interactive)
    (notmuch-search-tag '("-inbox" "-unread" "+delete" "+deleted") (car(notmuch-search-interactive-region)) (car (cdr(notmuch-search-interactive-region))) t))
  )

(use-package irfc
  :init
  (setq irfc-directory "~/read/rfc/")
  (setq irfc-assoc-mode t) 
  :config
  )

(defun xah-toggle-margin-right ()
  "Toggle the right margin between `fill-column' or window width.
This command is convenient when reading novel, documentation."
  (interactive)
  (if (eq (cdr (window-margins)) nil)
      (set-window-margins nil 0 (- (window-body-width) fill-column))
    (set-window-margins nil 0 0)))

(when window-system
  (let ((elapsed (float-time (time-subtract (current-time)
                                            emacs-start-time))))
    (message "Loading %s...done (%.3fs)" load-file-name elapsed))

  (add-hook 'after-init-hook
            `(lambda ()
               (let ((elapsed (float-time (time-subtract (current-time)
                                                         emacs-start-time))))
                 (message "Loading %s...done (%.3fs) [after-init]"
                          ,load-file-name elapsed)))
            t))
(provide 'init)
