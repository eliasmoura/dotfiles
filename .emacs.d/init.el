(defconst emacs-start-time (current-time))
(unless noninteractive
  (message "Loading %s..." load-file-name))
;; This sets up the load path so that we can override it
(package-initialize nil)
;; Override the packages with the git version of Org and other packages
(add-to-list 'load-path "~/.emacs.d/plugin")
(add-to-list 'load-path "~/.emacs.d/plugin/org-mode")
;; Load the rest of the packages
(package-initialize nil)

(setq package-enable-at-startup nil)
(org-babel-load-file "~/.emacs.d/config.org")
