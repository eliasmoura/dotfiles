;;; package --- SUMARY
;;; Commentary:
;;; Code:
(defconst emacs-start-time (current-time))
(unless noninteractive
  (message "Loading %s..." load-file-name))
;; This sets up the load path so that we can override it
(package-initialize nil)
;; Override the packages with the git version of Org and other packages
(eval-and-compile
  (add-to-list 'load-path "~/.emacs.d/plugin"))
(add-to-list 'load-path "~/.emacs.d/plugin")
(add-to-list 'load-path "~/.emacs.d/plugin/org-mode")
(add-to-list 'load-path "~/.emacs.d/plugin/use-package")
(add-to-list 'custom-theme-load-path "~/.emacs.d/plugin/base16-themes/")
;;(package-initialize nil)

(setq package-enable-at-startup nil)
;; (org-babel-load-file "~/.emacs.d/config.org")
(eval-when-compile
  (require 'use-package))
;(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant
;;(eval-when-compile (require 'use-package))
;;;;(require 'diminish)
;;(require 'bind-key)

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
(setq-default truncate-lines nil)
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(blink-cursor-mode -1)
(mouse-wheel-mode -1)
(tooltip-mode -1)
(global-linum-mode 0)
(column-number-mode t)
(fringe-mode 0)
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
(server-start)
(use-package whitespace
  :defer t
  :init
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  :config
  (global-whitespace-mode t))
(setq org-export-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
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

; Theme
;(use-package base16-atelierseaside-dark-theme
;:load-path "~/.emacs.d/plugin/base16-themes/"
;:config
;(load-theme 'base16-atelierseaside-dark-theme t))
(load-theme 'base16-atelierseaside-dark t)
(use-package smart-mode-line
  :load-path "~/.emacs.d/plugin/smart-mode-line"
  :init (setq sml/no-confirm-load-theme t)
  :config
  (use-package rich-minority :load-path "~/.emacs.d/plugin/rich-minority")
  (sml/setup)
  (setq sml/theme 'dark))

(setq hl-todo-keyword-faces '(("TODO" . hl-todo)
                              ("NOTE" . hl-todo)
                              ("HACK" . hl-todo)
                              ("FIXME" . hl-todo)))

(with-eval-after-load 'hl-todo
  (hl-todo-set-regexp))
;; Packages required by other packages
(use-package let-alist :defer t :load-path "~/.emacs.d/plugin/let-alist")
(use-package dash :defer t :load-path "~/.emacs.d/plugin/dash")
(use-package ter :defer t :load-path "~/emacs.d/plugin/tern")
(use-package popwin :defer t :load-path "~/.emacs.d/plugin/popwin-el")
;;(use-package popup :defer t :load-path "~/.emacs.d/plugin/popup-el")
(use-package s :defer t :load-path "~/.emacs.d/plugin/s")

;; Evil mode
(use-package evil :load-path "~/.emacs.d/plugin/evil-mode"
  :init
  (require 'evil)
  :config
  (define-key evil-normal-state-map ";" 'command)
  (evil-mode 1)
  (use-package evil-leader
    :load-path "~/.emacs.d/plugin/evil-leader/")
  (use-package evil-org
    :load-path "~/.emacs.d/plugin/evil-org-mode"
    :init (require 'evil-org)
    :config
    (define-key evil-motion-state-map " " nil)
    (define-key evil-motion-state-map (kbd "SPC c u") 'org-timestamp-up)
    (define-key evil-motion-state-map (kbd "SPC c d") 'org-timestamp-down)
    (define-key evil-motion-state-map (kbd "SPC c i") 'org-clock-in)
    (define-key evil-motion-state-map (kbd "SPC c o") 'org-clock-out))
  (use-package evil-surround
    :load-path "~/.emacs.d/plugin/evil-surround"
    :init (require 'evil-surround)
    :config
    (global-evil-surround-mode 1))
  (defface my-evil-state-emacs-face
    '((t (:background "Orange" :foreground "White")))
    "Evil Mode Emacs State Face")

  (defface my-evil-state-insert-face
    '((t (:background "DodgerBlue1" :foreground "White")))
    "Evil Mode Insert State Face")

  (defface my-evil-state-normal-face
    '((t (:background "Red" :foreground "White")))
    "Evil Mode Normal Stace Face")

  (defun evil-generate-mode-line-tag (&optional state)
    "Generate the evil mode-line tag for STATE."
    (let ((tag (evil-state-property state :tag t)))
      ;; prepare mode-line: add tooltip
      (if (stringp tag)
          (propertize tag
                      'face (cond
                             ((string= "normal" state)
                              'my-evil-state-normal-face)
                             ((string= "insert" state)
                              'my-evil-state-insert-face)
                             ((string= "emacs" state)
                              'my-evil-state-emacs-face))
                      'help-echo (evil-state-property state :name)
                      'mouse-face 'mode-line-highlight)
        tag)))
  (cl-loop for (mode . state) in '((inferior-emacs-lisp-mode     . emacs)
                                   ;;(org-mode                     . emacs)
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
  ; (with-eval-after-load 'evil-maps
    ; (define-key evil-insert-state-map (kbd "C-w") 'evil-window-map))
  (with-eval-after-load 'evil-maps
    ;; (define-key evil-motion-state-map (kbd "SPC") nil)
    ;; (define-key evil-visual-state-map (kbd "SPC") nil)
    (define-key evil-motion-state-map (kbd "RET") nil)
    (define-key evil-visual-state-map (kbd "RET") nil)
    (define-key evil-motion-state-map (kbd "TAB") nil)
    (define-key evil-visual-state-map (kbd "TAB") nil))
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd ";") 'evil-ex)
    (define-key evil-normal-state-map (kbd ";") 'evil-ex)
    (define-key evil-visual-state-map (kbd ";") 'evil-ex))
  (with-eval-after-load 'evil-maps
    (define-key evil-normal-state-map (kbd "C-w v") 'find-file-other-window)))


;; Org-mode
  (use-package org
    :load-path ("~/.emacs.d/plugin/org-mode" "~/.emacs.d/plugin/org-mode/contrib/lisp")
    :bind
    (;("M-c"   . jump-to-org-agenda)
     ("M-m"   . org-smart-capture)
     ("C-c c" . org-capture)
     ("M-M"   . org-inline-note)
     ("C-c a" . org-agenda)
     ;;("C-c S" . org-store-link)
     ;;("C-c l" . org-insert-link)
     ("C-. n" . org-velocity-read))
    :config
    (setq org-default-directory "~/writings/org")
    (setq org-directory "~/writings/org")
    (setq org-startup-folded nil)
    (defvar my/org-basic-task-template "* TODO %^{Task}
    :PROPERTIES:
    :Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}
    :END:
    Captured %<%Y-%m-%d %H:%M>
    %?

    %a

    %i
    " "Basic task data")
    (setq org-capture-templates
          `(("t" "Tasks" entry
             (file+headline "~/writings/org/organizer.org" "Tasks")
             ,my/org-basic-task-template)
            ("T" "Quick task" entry
             (file+headline "~/writings/org/organizer.org" "Tasks")
             "* TODO %^{Task}\nSCHEDULED: %t\n"
             :immediate-finish t)))

    (use-package org-agenda
      :config
      (setq org-agenda-files (quote ("~/writings/org/base.org"
                                     "~/writings/org/books.org"))))
    (setq org-default-notes-file (concat org-directory "/notes.org"))
    ;; (use-package org-smart-capture)
    (use-package org-crypt)
    (use-package org-bbdb)
    ;; (use-package org-devonthink)
    ;;(use-package org-mac-link)
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
    (setcar (nthcdr 2 org-emphasis-regexp-components) " \t\r\n\"'")
    (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
    (use-package org-journal
      :load-path "~/.emacs.d/plugin/org-journal"
      :config (setq org-journal-dir "~/writings/diary/"))
    ;; (add-hook 'org-mode-hook #'(lambda () (yas-minor-mode 1)))
    (setq org-todo-keywords
          '((sequence "TODO" "|" "DONE")
            (sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED")
            (sequence "|" "CANCELED")))
    (setq org-cycle-separator-lines 0)
    (setq org-id-method (quote uuidgen)))

;; Dired
(use-package dired
  :defer t
  :config
  (progn
    (add-hook 'dired-mode-hook #'toggle-truncate-lines)
    (setf dired-listing-switches "-alhG"
          dired-guess-shell-alist-user
          '(("\\(\\.pdf\\|\\.ps\\|\\.epub\\)\\'" "zathura")
            ("\\(\\.ods\\|\\.xlsx?\\|\\.docx?\\|\\.csv\\)\\'" "libreoffice")
            ("\\(\\.png\\|\\.jpe?g\\)\\'" "imv")
            ("\\(\\.gif\\|\\.mp4\\|\\.mkv\\)\\'" "mpv")))))
;; Flycheck

(use-package flycheck
  :defer 2
  :load-path "~/.emacs.d/plugin/flycheck"
  :config
  (setq flycheck-clang-pedantic-errors t)
  (setq flycheck-clang-language-standard "c11")
  (setq flycheck-clang-warnings '("all" "extra" "error" "shorten-64-to-32"))
  (add-hook 'c-mode-common-hook #'flycheck-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode))
(use-package flyspell
  :bind (("C-c i b" . flyspell-buffer)
         ("C-c i f" . flyspell-mode))
  :defer t
  :init
  (use-package ispell
    :bind (("C-c i c" . ispell-comments-and-strings)
           ("C-c i d" . ispell-change-dictionary)
           ("C-c i k" . ispell-kill-ispell)
           ("C-c i m" . ispell-message)
           ("C-c i r" . ispell-region)))
  :defer t
  :config
  (setq ispell-list-command "--list")
  (let ((langs '("american" "pt_BR" "russian")))
    (setq lang-ring (make-ring (length langs)))
    (dolist (elem langs) (ring-insert lang-ring elem)))
  (defun cycle-ispell-languages ()
    (interactive)
    (let ((lang (ring-ref lang-ring -1)))
      (ring-insert lang-ring lang)
      (ispell-change-dictionary lang)))
  (global-set-key [f6] 'cycle-ispell-languages)
  (unbind-key "C-." flyspell-mode-map))

;; Guidekey (show the keybinds mapped to the keycord)

(use-package guide-key
  :load-path "~/.emacs.d/plugin/guide-key"
  :diminish guide-key-mode
  :commands guide-key-mode
  :config
  (setq guide-key/guide-key-sequence
        '("C-."
          "C-h"
          "C-x 4"
          "C-x 5"
          "C-x r"
          "M-o"
          "C-x ESC"
          "C-x @"
          "C-x"
          "C-c"
          "C-c !"
          "C-c p"
          "M-s"
          "SPC"
          "SPC c"
          "z"))
  (guide-key-mode 1))

  (use-package ivy
    :load-path "~/.emacs.d/plugin/swiper"
    :config
    (use-package swiper :load-path "~/.emacs.d/plugin/swiper/")
    (require 'counsel)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-height 10)
    (setq ivy-count-format "(%d/%d) ")
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "C-h f") 'counsel-describe-function)
    (global-set-key (kbd "C-h v") 'counsel-describe-variable)
    (global-set-key (kbd "C-h l") 'counsel-load-library)
    (global-set-key (kbd "C-h i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "C-h u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (ivy-mode 1))

;;backup
(setq backup-directory-alist '(("." . "~/.emacs.d/local/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/local/auto-save-list/" t)))

(setq savehist-file "~/.emacs.d/local/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; Magit
  (use-package magit
    :load-path "~/.emacs.d/plugin/magit"
    :defer 5
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


  (use-package projectile
    :load-path "~/.emacs.d/plugin/projectile"
    :diminish projectile-mode
    :commands projectile-global-mode
    :defer 5
    :bind-keymap ("C-c p" . projectile-command-map)
    :config
    (projectile-global-mode))

;; Elfeed
  (use-package elfeed
    :load-path ("~/.emacs.d/plugin/elfeed")
    :init (setf url-queue-timeout 40)
    :config
    :bind ("C-x f" . elfeed))

    (use-package feed-setup :load-path "~/.emacs.d/lisp"
      :config (require 'feed-setup))
    (setf bookmark-default-file (locate-user-emacs-file "local/bookmarks"))
    ;;(add-hook 'elfeed-new-entry-hook
              ;;(elfeed-make-tagger :feed-url "http://feeds.feedburner.com/meiobi"
                                  ;;:entry-title '("Cavaleiros do Zodíaco")
                                  ;;:add 'junk
                                  ;;:remove 'unread))

;; Stumpwm integration
(use-package stumpwm-mode :load-path "~/.emacs.d/plugin/swm-emacs")
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

(my/defshortcut ?i "~/.emacs.d/config.org")
(my/defshortcut ?o "~/writings/org/base.org")
(my/defshortcut ?b "~/personal/business.org")
(my/defshortcut ?B "~/writings/org/books.org")
(my/defshortcut ?e "~/code/emacs-notes/tasks.org")
(my/defshortcut ?j "~/personal/journal.org")
(my/defshortcut ?C "~/personal/calendar.org")
(my/defshortcut ?q "~/personal/questions.org")

;;Rainbow delimiters
(use-package rainbow-delimiters
  :load-path "~/.emacs.d/plugin/rainbow-delimiters"
  :defer t
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package smartparens
  :init (require 'smartparens-config)
  :defer t
  :load-path "~/.emacs.d/plugin/smartparens")

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
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3f7db1a70bee5e15a3d72b016a7e05f6d813b6868e88961c46019b57d0b29452" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
