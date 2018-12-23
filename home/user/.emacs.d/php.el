(load "~/.emacs.d/windata.el")
(load "~/.emacs.d/help-dwim.el")
(load "~/.emacs.d/tree-mode.el")
(load "~/.emacs.d/php-doc.el")
(setq php-doc-directory "/usr/share/doc/php-doc/html")

(defun ywb-php-lineup-arglist-intro (langelem)
  (save-excursion
    (goto-char (cdr langelem))
    (vector (+ (current-column) c-basic-offset))))

(defun ywb-php-lineup-arglist-close (langelem)
  (save-excursion
    (goto-char (cdr langelem))
    (vector (current-column))))

(defun my-php-symbol-lookup ()
  (interactive)
  (let ((symbol (symbol-at-point)))
    (if (not symbol)
        (message "No symbol at point.")
      (browse-url (concat "http://php.net/manual-lookup.php?pattern="
                          (symbol-name symbol))))))

(defun my-php-search-to-cscart-doc ()
  (interactive)
  (let ((symbol (symbol-at-point)))
    (if (not symbol)
        (message "No symbol at point.")
      (browse-url (concat "https://docs.cs-cart.com/4.7.x/search.html?q=" (symbol-name symbol))))))

(defun my-work-mode-stuff ()
  (local-set-key (kbd "<f8>") 'my-php-search-to-cscart-doc)
  (local-set-key (kbd "<f9>") 'my-php-symbol-lookup)
  (local-set-key (kbd "C-c v") 'put-var-dump-symbol))

(defun put-var-dump-symbol ()
  (interactive)
  (let ((symbol (symbol-at-point)))
    (if (not symbol)
        (message "No symbol at point.")
      (end-of-line)
      (newline-and-indent)
      (insert (concat "var_dump($" (symbol-name symbol) ");")))))

(defun ac-php-tags ()
  (require 'ac-php)
  (require 'company-php)
  (setq ac-sources '(ac-sources-php))
  (set (make-local-variable 'eldoc-documentation-function) 'php-doc-eldoc-function)
  (company-mode t)
  (eldoc-mode 1)
  (yas-minor-mode 1)
  (electric-indent-mode 1)
  (add-to-list 'company-backends 'company-ac-php-backend)
  (local-set-key "\t" 'php-doc-complete-function)
  (define-key php-mode-map (kbd "C-]") 'ac-php-find-symbol-at-point)
  (define-key php-mode-map (kbd "C-t") 'ac-php-location-stack-back))

;; (add-hook 'php-mode-hook 'my-work-mode-stuff)
;; (add-hook 'php-mode-hook 'ac-php-tags)
;; (add-hook 'after-save-hook (lambda () (if (derived-mode-p 'php-mode) (ac-php-remake-tags))))

;; (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
;; (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))