(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired"       (mode . dired-mode))
	       ("PHP"         (mode . php-mode))
               ("JavaScript"  (mode . javascript-mode))
               ("PO-files"    (mode . po-mode))
	       ("HTML"        (mode . web-mode))
	       ("XML"         (mode . nxml-mode))
	       ("SQL"         (mode . sql-mode))
	       ("Common Lisp" (mode . lisp-mode))
               ("Python"      (mode . python-mode))
	       ("Emacs"       (or
			       (name . "^\\*scratch\\*$")
			       (name . "^\\.emacs")
			       (name . "^\\*Messages\\*$")))))))

(add-hook 'ibuffer-mode-hook (lambda () (ibuffer-switch-to-saved-filter-groups "default")))
(add-hook 'ibuffer-mode-hook (lambda () (setq ibuffer-formats '((mark modified read-only " " (name 18 200 :left :elide) " " filename-and-process)))))
