;;; package --- summary
;;; Commentary:
;;; Code:

(defconst emacs-start-time (current-time))
(unless noninteractive
  (message "Loading %s..." load-file-name))
()
(add-to-list 'load-path "~/.emacs.d/plugin/use-package")
(add-to-list 'load-path "~/.emacs.d/plugin")
(add-to-list 'load-path "~/.emacs.d/lisp")
(eval-when-compile (require 'use-package))

(server-start)

;(require 'diminish)
(require 'bind-key)

;;;Show matching brackets
(show-paren-mode 1)

;;; auto close brackets
(electric-pair-mode 1)

;;;update files when changed
(global-auto-revert-mode 1)

;;;hilight the current line
(global-hl-line-mode 1)

;;;break the lines
(setq-default truncate-lines nil)
;(setq-default fill-column 79) 
;;;hide menu and toolbar
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(blink-cursor-mode -1)
(mouse-wheel-mode -1)
(tooltip-mode -1)
;;;always show the line and column number
(global-linum-mode t)
(column-number-mode t)
(fringe-mode 0)

(setq org-export-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;;(bind-key "C-c n" 'insert-user-timestamp)
(bind-key "C-c o" 'customize-option)
(bind-key "C-c O" 'customize-group)
(bind-key "C-c F" 'customize-face)

(bind-key "C-c q" 'fill-region)
(bind-key "C-c r" 'replace-regexp)
(bind-key "C-c s" 'replace-string)
(bind-key "C-c u" 'rename-uniquely)
(setq-default indent-tabs-mode nil)

(progn
  (setq x-select-enable-clipboard t
        x-select-enable-primary t
        save-interprogram-paste-before-kill t
        apropos-do-all t
        mouse-yank-at-point t
        require-final-newline t
        visible-bell t
        load-prefer-newer t
        ediff-window-setup-function 'ediff-setup-windows-plain
        save-place-file (concat user-emacs-directory "places")
        backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                 "backups")))))

(use-package let-alist :defer t :load-path "~/.emacs.d/plugin/let-alist")
(use-package dash :defer t :load-path "~/.emacs.d/plugin/dash")
(use-package ter :defer t :load-path "~/emacs.d/plugin/tern")
(use-package popwin :defer t :load-path "~/.emacs.d/plugin/popwin-el")
;;(use-package popup :defer t :load-path "~/.emacs.d/plugin/popup-el")
(use-package s :defer t :load-path "~/.emacs.d/plugin/s")

(use-package base16-atelierseaside-dark-theme
  :load-path "~/.emacs.d/plugin/base16-themes/"
  :config
  (load-theme 'base16-atelierseaside-dark-theme t))

(use-package smart-mode-line
  :load-path "~/.emacs.d/plugin/smart-mode-line"
  :init (setq sml/no-confirm-load-theme t)
  :config
  (use-package rich-minority :load-path "~/.emacs.d/plugin/rich-minority")
  (sml/setup)
  (setq sml/theme 'dark))

(use-package evil :load-path "~/.emacs.d/plugin/evil-mode"
  :init
  (require 'evil)
  :disabled t
  :config
  (define-key evil-normal-state-map ";" 'command)
  (evil-mode 1)
  (use-package evil-surround
    :load-path "~/.emacs.d/plugin/evil-surround"
    :init (require 'evil-surround)
    :config
    (global-evil-surround-mode 1))
  (cl-loop for (mode . state) in '((inferior-emacs-lisp-mode     . emacs)
                                 (org-mode                     . emacs)
                                 (pylookup-mode                . emacs)
                                 (comint-mode                  . emacs)
                                 (ebib-entry-mode              . emacs)
                                 (ebib-index-mode              . emacs)
                                 (ebib-log-mode                . emacs)
                                 (elfeed-show-mode             . emacs)
                                 (elfeed-search-mode           . emacs)
                                 (gtags-select-mode            . emacs)
                                 (shell-mode                   . emacs)
                                 (term-mode                    . emacs)
                                 (bc-menu-mode                 . emacs)
                                 (magit-branch-manager-mode    . emacs)
                                 (semantic-symref-results-mode . emacs)
                                 (rdictcc-buffer-mode          . emacs)
                                 (erc-mode                     . normal))
         do (evil-set-initial-state mode state))
  (with-eval-after-load 'evil-vars
    (setq evil-want-C-w-in-emacs-state t))
  (with-eval-after-load 'evil-maps
    (define-key evil-insert-state-map (kbd "C-w") 'evil-window-map))
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd "SPC") nil)
    (define-key evil-visual-state-map (kbd "SPC") nil)
    (define-key evil-motion-state-map (kbd "RET") nil)
    (define-key evil-visual-state-map (kbd "RET") nil)
    (define-key evil-motion-state-map (kbd "TAB") nil)
    (define-key evil-visual-state-map (kbd "TAB") nil))
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd ";") 'evil-ex)
    (define-key evil-normal-state-map (kbd ";") 'evil-ex)
    (define-key evil-visual-state-map (kbd ";") 'evil-ex)))

;;;org stuff
(use-package org
  :load-path ("~/.emacs.d/plugin/org-mode" "~/.emacs.d/plugin/org-mode/contrib/lisp")
  :bind
  (;("M-c"   . jump-to-org-agenda)
  ("M-m"   . org-smart-capture)
  ("M-M"   . org-inline-note)
  ("C-c a" . org-agenda)
  ("C-c S" . org-store-link)
  ("C-c l" . org-insert-link)
  ("C-. n" . org-velocity-read))
  :config
  (use-package org-agenda
    :config
    (setq org-agenda-files (quote ("~/writings/org/base.org"
                                   "~/writings/org/books.org"))))
  (setq org-default-notes-file (concat org-directory "~/writings/org/notes.org"))
  ;; (use-package org-smart-capture)
  (use-package org-crypt)
  (use-package org-bbdb)
  ;; (use-package org-devonthink)
  (use-package org-mac-link)
  ;; (require 'org-magit)
  (use-package org-velocity)
  (custom-set-faces
   '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t))
  (setq org-src-fontify-natively t)
  (setq org-log-done 'time)
  (setq org-log-done 'note)
  (add-hook 'org-mode-hook 'turn-on-flyspell 'append)
  (put 'upcase-region 'disabled nil)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t))
  (use-package org-bullets
    :load-path "~/.emacs.d/plugin/org-bullets"
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

  (use-package org-journal
    :load-path "~/.emacs.d/plugin/org-journal"
    :config (setq org-journal-dir "~/writings/diary/"))
  ;; (add-hook 'org-mode-hook #'(lambda () (yas-minor-mode 1)))
  (setq org-default-notes-file (concat org-directory "~/.elias/org/notes.org"))
  (setq org-todo-keywords
        '((sequence "TODO" "|" "DONE")
          (sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED")
          (sequence "|" "CANCELED")))
  (setq org-cycle-separator-lines 0)
  (setq org-id-method (quote uuidgen)))

;;; Packages
(use-package rainbow-delimiters
  :load-path "~/.emacs.d/plugin/rainbow-delimiters"
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package fic-mode
  :load-path "~/.emacs.d/plugin/fic-mode/"
  :config (add-hook 'prog-mode-hook 'fic-mode))
(use-package whitespace
  :init
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  :config
  (global-whitespace-mode t)
                                        ;(column-marker-1 80)
  )
(use-package ace-jump-mode
  :load-path "~/.emacs.d/plugin/ace-jump-mode"
  :bind ("M-h" . ace-jump-mode)
  :config
  (setq ace-jump-mode-submode-list
        '(ace-jump-char-mode
          ace-jump-word-mode
          ace-jump-line-mode)))
(use-package magit
  :load-path "~/.emacs.d/plugin/magit"
  :bind (("C-x g" . magit-status)
         ("C-x G" . magit-status-with-prefix))
  :preface
  (defun magit-monitor (&optional no-display)
    "Start git-monitor in the current directory."
    (interactive)
    (when (string-match "\\*magit: \\(.+?\\)\\*" (buffer-name))
      (let ((name (format "*git-monitor: %s*"
                          (match-string 1 (buffer-name)))))
        (or (get-buffer name)
            (let ((buf (get-buffer-create name)))
              (ignore-errors
                (start-process "*git-monitor*" buf "git-monitor"
                               "-d" (expand-file-name default-directory)))
              buf)))))

  (defun magit-status-with-prefix ()
    (interactive)
    (let ((current-prefix-arg '(4)))
      (call-interactively 'magit-status)))

  (defun lusty-magit-status (dir &optional switch-function)
    (interactive (list (if current-prefix-arg
                           (lusty-read-directory)
                         (or (magit-get-top-dir)
                             (lusty-read-directory)))))
    (magit-status-internal dir switch-function))

  (defun eshell/git (&rest args)
    (cond
     ((or (null args)
          (and (string= (car args) "status") (null (cdr args))))
      (magit-status-internal default-directory))
     ((and (string= (car args) "log") (null (cdr args)))
      (magit-log "HEAD"))
     (t (throw 'eshell-replace-command
               (eshell-parse-command
                "*git"
                (eshell-stringify-list (eshell-flatten-list args)))))))

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
(use-package flyspell
  :bind (("C-c i b" . flyspell-buffer)
         ("C-c i f" . flyspell-mode))
  :init
  (use-package ispell
    :bind (("C-c i c" . ispell-comments-and-strings)
           ("C-c i d" . ispell-change-dictionary)
           ("C-c i k" . ispell-kill-ispell)
           ("C-c i m" . ispell-message)
           ("C-c i r" . ispell-region)))
  :config
  (unbind-key "C-." flyspell-mode-map))

(use-package guide-key
  :load-path "~/.emacs.d/plugin/guide-key"
  :diminish guide-key-mode
  :commands guide-key-mode
  :defer 10
  :config
  (setq guide-key/guide-key-sequence
        '("C-."
          "C-h e"
          "C-x 4"
          "C-x 5"
          "C-x r"
          "M-o"
          "C-x"
          "C-c"
          "C-c p"
          "M-s"))
  (guide-key-mode 1))

;; Use helm isntead of default M-x
(use-package helm-grep
  :commands helm-do-grep-1
  :bind (("M-s f" . my-helm-do-grep-r)
         ("M-s g" . my-helm-do-grep))
  :preface
  (defun my-helm-do-grep ()
    (interactive)
    (helm-do-grep-1 (list default-directory)))

  (defun my-helm-do-grep-r ()
    (interactive)
    (helm-do-grep-1 (list default-directory) t)))

(use-package helm-swoop
  :load-path "~/.emacs.d/plugin/helm-swoop"
  :bind (("M-s o" . helm-swoop)
         ("M-s /" . helm-multi-swoop))
  :config
  (use-package helm-match-plugin
    :config
    (helm-match-plugin-mode 1)))

(use-package helm-descbinds
  :load-path "~/.emacs.d/plugin/helm-descbinds"
  :bind ("C-h b" . helm-descbinds)
  :init
  (fset 'describe-bindings 'helm-descbinds)
  :config
  (require 'helm-config))

(use-package helm-config
  :demand t
  :load-path "~/.emacs.d/plugin/helm"
  :bind (("C-c h"   . helm-command-prefix)
         ("C-h a"   . helm-apropos)
                                        ; ("C-h e a" . my-helm-apropos)
         ("C-x f"   . helm-multi-files)
         ("M-s b"   . helm-occur)
         ("M-s n"   . my-helm-find)
         ("M-H"     . helm-resume))

  :preface
  (defun my-helm-find ()
    (interactive)
    (helm-find nil))

  :config
  ;;(define-key remap "C-x b" 'helm-buffer-list)
  (use-package helm-command)
  (use-package helm-files)
  (use-package helm-buffers)
  (use-package helm-mode
    :diminish helm-mode
    :init
    (helm-mode 1)
    :config
    (progn
    (setf helm-adaptive-history-file (locate-user-emacs-file "local/helm")
          recentf-save-file (locate-user-emacs-file "local/recentf"))))

  ;; (use-package helm-ls-git
  ;;   :load-path "~/.emacs.d/plugin/helm-ls-git")

  (use-package helm-match-plugin
    :disabled t
    :config
    (helm-match-plugin-mode 1))

  (helm-autoresize-mode 1)

  (bind-key "<tab>" 'helm-execute-persistent-action helm-map)
  (bind-key "C-i" 'helm-execute-persistent-action helm-map)
  (bind-key "C-z" 'helm-select-action helm-map)
  (bind-key "A-v" 'helm-previous-page helm-map)

  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t)))

(use-package helm-ag
  :load-path "~/.emacs.d/plugin/helm-ag"
  :preface
  (defun projectile-helm-ag ()
    (interactive)
    (helm-do-ag-this-file (list default-directory) t)
    (helm-ag (projectile-project-root))
    :bind ("C-x s" . helm-do-ag-this-file))
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
 '(helm-ag-command-option "--all-text")
 '(helm-ag-insert-at-point (quote symbol))
 '(org-agenda-files (quote ("~/writing/org/base.org")))
 '(org-babel-load-languages
   (quote
    ((emacs-lisp . t)
     (awk . t)
     (C . t)
     (calc . t)
     (css . t)
     (gnuplot . t)
     (js . t)
     (latex . t)
     (makefile . t)
     (perl . t)
     (python . t)
     (ruby . t)
     (sh . t)
     (sql . t)
     (sqlite . t))))
 '(send-mail-function (quote mailclient-send-it)))

(use-package json-mode
  :load-path ("~/.emacs.d/plugin/json-mode")
  :mode "\\.json\\'"
  :config
  (use-package jshint-mode :load-path "~/emcas.d/plugin/jshint-mode"
    :init (add-hook 'js-mode-hook 'jshint-mode)))
(use-package js2-mode
  :load-path "~/.emacs.d/plugin/js2-mode"
  :mode "\\.js\\'"
  :config
  (use-package jshint-mode :load-path "~/emcas.d/plugin/jshint-mode"
    :init (add-hook 'js-mode-hook 'jshint-mode)))

;;; Syntax checker
(use-package flycheck
  :init (add-hook 'after-init-hook #'global-flycheck-mode)

  :load-path "~/.emacs.d/plugin/flycheck"
  :config
  ;; (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
  )
(use-package flyspell
  :bind (("C-c i b" . flyspell-buffer)
         ("C-c i f" . flyspell-mode))
  :init
  (use-package ispell
    :bind (("C-c i c" . ispell-comments-and-strings)
           ("C-c i d" . ispell-change-dictionary)
           ("C-c i k" . ispell-kill-ispell)
           ("C-c i m" . ispell-message)
           ("C-c i r" . ispell-region)))
  :config
  (unbind-key "C-." flyspell-mode-map))

(use-package smartparens
  :init (require 'smartparens-config)
  :load-path "~/.emacs.d/plugin/smartparens")

(use-package company
  :load-path
  ("~/.emacs.d/plugin/company-mode"
   "~/.emacs.d/plugin/tern/emacs"
   "~/.emacs.d/plugin/tern/bin")
  :commands company-mode
  :init
  (company-mode t)
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (use-package company-tern
    :load-path "~/.emacs.d/plugin/company-tern"
    :init
    (add-to-list 'company-backends 'company-tern)
    (add-hook 'js-mode-hook 'tern-mode))
  (setq company-idle-delay .3)
  (global-set-key (kbd "C-c /") 'company-files)
  (setq company-tooltip-limit 20)
  (setq company-tooltip-align-annotations 't))

(use-package markdown-mode
  :load-path "~/.emacs.d/plugin/markdown-mode"
  :mode (("\\`README\\.md\\'" . gfm-mode)
         ("\\.md\\'"          . markdown-mode)
         ("\\.markdown\\'"    . markdown-mode)))

(require 'saveplace)
(setq-default save-place t)
(use-package projectile
  :load-path "~/.emacs.d/plugin/projectile"
  :diminish projectile-mode
  :commands projectile-global-mode
  :defer 5
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (use-package helm-projectile
    :config
    (setq projectile-completion-system 'helm)
    (helm-projectile-on))
  (projectile-global-mode))

(autoload 'indent-according-to-mode "indent" nil t)
(autoload 'hippie-expand "hippie-exp" nil t)

(defun smart-tab (&optional arg)
  (interactive "P")
  (cond
   ((looking-back "^[-+* \t]*")
    (if (eq major-mode 'org-mode)
        (org-cycle arg)
      (indent-according-to-mode)))
   (t
    ;; Hippie also expands yasnippets, due to `yas-hippie-try-expand' in
    ;; `hippie-expand-try-functions-list'.
    (hippie-expand arg))))

;;;Twitter client
(use-package twittering-mode
  :load-path "~/.emacs.d/plugin/twittering-mode"
  :config
  (setq twittering-use-master-password t)
  (setq twittering-icon-mode t))

;;;Elfeed feed
(use-package elfeed
  :load-path ("~/.emacs.d/plugin/elfeed" "~/.emacs.d/lisp")
  :init (setf url-queue-timeout 120)
  :config
  (use-package feed-setup :load-path "~/.emacs.d/lisp")
  (setf bookmark-default-file (locate-user-emacs-file "local/bookmarks")
  :bind ("C-x w" . elfeed))

(add-hook 'elfeed-new-entry-hook
          (elfeed-make-tagger :feed-url "http://feeds.feedburner.com/meiobi"
                              :entry-title '("Cavaleiros do Zodíaco")
                              :add 'junk
                              :remove 'unread))
(add-hook 'elfeed-new-entry-hook
          (elfeed-make-tagger :feed-url "youtube\\.com"
                              :add '(video youtube)))
(autoload 'notmuch "notmuch" "notmuch mail" t)

(use-package pkgbuild-mode
  :load-path "~/.emacs.d/plugin/pkgbuild-mode"
  :config
  (setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode))
                                auto-mode-alist)))
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

(provide '.emacs)

;;; .emacs ends here
