(defvar *sources* (list
		   'lisp-mode
		   'ac-source-semantic
                   'ac-source-functions
                   'ac-source-variables
                   'ac-source-dictionary
                   'ac-source-words-in-all-buffer
                   'ac-source-files-in-current-dir))
(let (source)
  (dolist (source *sources*)
    (add-to-list 'ac-sources source)))

(add-to-list 'ac-modes 'lisp-mode)
