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
        '("plugin" "plugin/diminish.el" "plugin/use-package"))
  (setq use-package-enable-imenu-support t)
  (require 'use-package))
(setq plugin-directory "~/local/cfg/emacs/plugin")
(package-initialize nil)
(use-package diminish :load-path "plugin/diminish.el")                ;; if you use :diminish
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
;(server-start)
;; Show matching brackets
(show-paren-mode 1)
;;  auto close brackets
(electric-pair-mode 1)
;; update files when changed
(global-auto-revert-mode 1)
;; hilight the current line
(global-hl-line-mode t)
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
(setq confirm-kill-processes nil)

(display-time-mode 1)
(setq display-time-24hr-format t)


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

(use-package base16-theme
  :load-path ("plugin/base16-emacs" "plugin/base16-emacs/build/")
  :init
  (add-to-list 'custom-theme-load-path "~/local/cfg/emacs/plugin/base16-emacs")
  (add-to-list 'custom-theme-load-path "~/local/cfg/emacs/plugin/base16-emacs/build/")
  (load-theme 'base16-brewer t)
  ;; Set the cursor color based on the evil state
  (defvar my/base16-colors base16-brewer-colors)
  (setq evil-emacs-state-cursor   `(,(plist-get my/base16-colors :base0D) box)
      evil-insert-state-cursor  `(,(plist-get my/base16-colors :base0D) bar)
      evil-motion-state-cursor  `(,(plist-get my/base16-colors :base0E) box)
      evil-normal-state-cursor  `(,(plist-get my/base16-colors :base0B) box)
      evil-replace-state-cursor `(,(plist-get my/base16-colors :base08) box)
      evil-visual-state-cursor  `(,(plist-get my/base16-colors :base09) box))
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
  :config
  (setq org-agenda-files (list "~/writings/org/base.org"
                             "~/writings/org/books.org" 
                             "~/writings/org/questions.org" 
                             "~/writings/org/routine.org" 
                             "~/writings/org/agenda.org")))

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
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  
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

(use-package elfeed
  :load-path ("plugin/elfeed")
  :disabled
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

(use-package pkgbuild-mode
  :load-path "plugin/pkgbuild-mode"
  :disabled 0
  :init
  (setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode))
                                auto-mode-alist))
  :config
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

;; Language Dictionaries
;;https://github.com/gucong/emacs-sdcv
(use-package sdcv-mode
  :load-path "plugin/sdcv-mode/"
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
  :disabled
  (setq irfc-directory "~/read/rfc/")
  (setq irfc-assoc-mode t) 
  :config
  )

(use-package evil :load-path "plugin/evil"
  :config
  (evil-mode 1)
  (setq evil-emacs-state-modes nil)
  (setq evil-insert-state-modes nil)
  (setq evil-motion-state-modes nil)
   ;; change mode-line color by evil state
   (lexical-let ((default-color (cons (face-background 'mode-line)
                                      (face-foreground 'mode-line))))
     (add-hook 'post-command-hook
       (lambda ()
         (let ((color (cond ((minibufferp) default-color)
                            ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                            ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
                            ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
                            (t default-color))))
           (set-face-background 'mode-line (car color))
           (set-face-foreground 'mode-line (cdr color))))))

   ;; org-mode stuff
   (evil-global-set-key 'normal (kbd "<SPC>") nil)
   (evil-global-set-key 'motion (kbd "<SPC>") nil)
   (evil-global-set-key 'normal
                        (kbd "<SPC>l") 'org-store-link
                        
                      )
   (define-key global-map (kbd "C-c a") 'org-agenda)
   )
;  (setq evil-emacs-state-cursor   `(,(plist-get my/base16-colors :base0D) box)
;      evil-insert-state-cursor  `(,(plist-get my/base16-colors :base0D) bar)
;      evil-motion-state-cursor  `(,(plist-get my/base16-colors :base0E) box)
;      evil-normal-state-cursor  `(,(plist-get my/base16-colors :base0B) box)
;      evil-replace-state-cursor `(,(plist-get my/base16-colors :base08) box)
;      evil-visual-state-cursor  `(,(plist-get my/base16-colors :base09) box))


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
