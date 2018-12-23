(provide 'func)

(defun move-line-up ()
    (interactive)
    (transpose-lines 1)
    (forward-line -2)
    (indent-according-to-mode))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(defun google ()
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
         (buffer-substring (region-beginning) (region-end))
       (read-string "Google: "))))))

(defun eshell-life-is-too-much ()
  "Kill the current buffer (or bury it).  Good-bye Eshell."
  (interactive)
  (if (not eshell-kill-on-exit)
      (bury-buffer)
    (kill-buffer (current-buffer))))

(defun prelude-open-with (arg)
  (interactive "P")
  (when buffer-file-name
    (shell-command (concat
                    (cond
                     ((and (not arg) (eq system-type 'darwin)) "open")
                     ((and (not arg) (member system-type '(gnu gnu/linux gnu/kfreebsd))) "xdg-open")
                     (t (read-shell-command "Open current file with: ")))
                    " "
                    (shell-quote-argument buffer-file-name)))))

(defun my-add-pretty-lambda ()
  (setq prettify-symbols-alist
	'(
	  ("lambda" . 955)
	  ("map" . 8614)
	  ("not" . ?¬)
	  (">=" . ?≥)
	  ("and" . ?∧)
	  ("or" . ?∨))))

(defun open-in-browser()
  (interactive)
  (let ((filename (buffer-file-name)))
    (browse-url (concat "file://" filename))))

(defun my-browse-url-seamonkey-new-tab (url &optional new-window)
      ;; new-window ignored                                                         
      "Open URL in a new tab in Seamonkey."
      (interactive (browse-url-interactive-arg "URL: "))
      (unless
          (string= ""
                   (shell-command-to-string
                    (concat "palemoon -remote 'openURL(" url ",new-tab)'")))
        (message "Starting Palemoon...")
        (start-process (concat "palemoon " url) nil "palemoon" url)
        (message "Starting Palemoon...done")))
