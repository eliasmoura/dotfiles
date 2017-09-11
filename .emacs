;(package-initialize)
(let ((init "~/local/cfg/emacs/init.elc"))
  (if (file-exists-p init)
      (load-file init)
    (load-file (substring init 0 -1))))

(custom-set-variables
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default))))
