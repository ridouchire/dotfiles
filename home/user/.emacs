(make-directory "~/.emacs.d/elpa/" t)
(let ((default-directory "~/.emacs.d/elpa"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages") t)

(package-initialize)

(defvar packagesList
  '(auto-complete
    web-mode
    php-mode
    docker-compose-mode
    dockerfile-mode
    vue-mode
    pug-mode
    markdown-mode
    ac-php
    projectile
    magit
    company
    company-php
    flymake-php))

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      packagesList)

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

;;
;; Key binding
;;
(global-set-key "\M-x"
		(lambda ()
		  (interactive)
		  (call-interactively
		   (intern
		    (ido-completing-read "M-x " (all-completions "" obarray 'commandp))))))
(global-set-key (kbd "C-x C-d") (lambda () (interactive) (dired "~/Sources")))
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c s") 'magit-status)
(global-set-key (kbd "C-c b") 'magit-blame-popup)
(global-set-key (kbd "C-c c") 'magit-branch-checkout)
(global-set-key (kbd "C-c r") 'magit-reset-hard)
(global-set-key (kbd "C-c w") 'whitespace-mode)
(global-set-key (kbd "C-c m") 'mc/mark-all-like-this-dwim)
(global-set-key (kbd "C-c f") 'projectile-grep)
(global-set-key (kbd "C-c k") 'projectile-kill-buffers)
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-'") 'goto-line)
(global-set-key [(meta shift up)] 'move-line-up)
(global-set-key [(meta shift down)] 'move-line-down)

(define-key global-map [f1] 'delete-other-windows)
(define-key global-map [f2] 'other-window)
(define-key global-map [f3] 'split-window-vertically)
(define-key global-map [f4] 'split-window-horizontally)
(define-key global-map [f12] 'magit-status)

;;
;; ibuffer
;;
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired"       (mode . dired-mode))
	       ("PHP"         (mode . php-mode))
	       ("JavaScript"  (mode . javascript-mode))
	       ("HTML"        (mode . web-mode))
	       ("Docker"      (or (mode . dockerfile-mode) (mode . docker-compose-mode)))
	       ("Emacs"       (or (name . "^\\*scratch\\*$") (name . "^\\.emacs") (name . "^\\*Messages\\*$")))))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))
(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (setq ibuffer-formats
		  '((mark modified read-only " " (name 18 200 :left :elide) " " filename-and-process)))))

;;
;; customization
;;
(setq-default ac-auto-start t)
(setq-default ac-auto-show-menu t)
(setq-default c-basic-offset 4)
(setq frame-title-format "Emacs: %b")
(setq inhibit-startup-screen -1)
(setq use-dialog-box nil)
(setq redisplay-dont-pause t)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq auto-save-file-list nil)
(setq word-wrap t)
(setq indent-tab-mode nil)
(setq browse-url-browser-function
      'browse-url-generic browse-url-generic-program "firefox-bin")
(setq ido-virtual-buffers t)
(setq scroll-step 1)
(setq scroll-margin 10)
(setq scroll-conservatively 10000)
(setq query-replace-highlight t)

(fset 'yes-or-no-p 'y-or-n-p)

(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(size-indication-mode -1)
(column-number-mode t)
(global-linum-mode)
(electric-pair-mode)

;;
;; web-mode
;;
(require 'web-mode)
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-block-face t)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-attr-indent-offset 'standart)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-current-column-highlight t)
(setq web-mode-enable-current-element-hightlight t)
(setq web-mode-ac-sources-alist
      '(("css" . (ac-source-css-property))
        ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

(add-to-list 'auto-mode-alist '("\\.\\(html\\|twig\\)$'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

;;
;; projectile
;;
(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)

(projectile-global-mode)

;;
;; PHP
;;
(load "~/.emacs.d/libs/windata.el")
(load "~/.emacs.d/libs/help-dwim.el")
(load "~/.emacs.d/libs/tree-mode.el")
(load "~/.emacs.d/libs/php-doc.el")
(setq php-doc-directory "/usr/share/doc/php-docs-20190203/en/php-chunked-xhtml")
(require 'php-mode)
(require 'ac-php)
(require 'company-php)

(defun php-ywb-lineup-arglist-intro (langelem)
  (save-excursion
    (goto-char (cdr langelem))
    (vector (+ (current-column) c-basic-offset))))

(defun php-ywb-lineup-arglist-close (langelem)
  (save-excursion
    (goto-char (cdr langelem))
    (vector (current-column))))

(c-set-offset 'arglist-intro 'php-ywb-lineup-arglist-intro)
(c-set-offset 'arglist-close 'php-ywb-lineup-arglist-close)

(defun php-search-symbol-in-docs ()
  (interactive)
  (let ((symbol (symbol-at-point)))
    (if (not symbol)
	(message "No symbol at point")
      (browse-url (concat "https://php.net/manual-lookup.php?pattern=" (symbol-name symbol))))))

(defun php-insert-var-dump-with-symbol ()
  (interactive)
  (let ((symbol (symbol-at-point)))
    (if (not symbol)
	(message "No symbol at point")
      (end-of-line)
      (newline-and-indent)
      (insert (concat "var_dump(" (symbol-name symbol) ");")))))

(defun php-run-code ()
  (interactive)
  (compile (concat "php " (buffer-file-name (current-buffer)))))

(setq ac-sources '(ac-sources-php))
(setq c-default-style "psr2")

(set (make-local-variable 'eldoc-documentation-function) 'php-doc-eldoc-function)

(define-key php-mode-map (kbd "C-]") 'ac-php-find-symbol-at-point)
(define-key php-mode-map (kbd "C-t") 'ac-php-location-stack-back)
(define-key php-mode-map (kbd "C-c v") 'php-insert-var-dump-with-symbol)
(define-key php-mode-map (kbd "<f5>") 'php-run-code)
(define-key php-mode-map (kbd "<f9>") 'php-search-symbol-in-docs)
(define-key php-mode-map (kbd "<f6>") 'ac-php-remake-tags)
(define-key php-mode-map (kbd "C-<f6>") 'ac-php-remake-tags-all)

(local-set-key "\t" 'php-doc-complete-function)

(add-hook 'php-mode-hook 'flymake-php-load)
(add-hook 'php-mode-hook
	  (lambda ()
	    (company-mode t)
	    (eldoc-mode 1)
	    (ac-php-core-eldoc-setup)
            (yas-global-mode 1)
            (electric-indent-mode 1)
            (add-to-list 'company-backends 'company-ac-php-backend)))

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;;
;; vue-mode
;;
(add-to-list 'auto-mode-alist '("\\.vue$" . vue-mode))
(setq js-indent-level 2)

;;
;; pug-mode
;;
(add-to-list 'auto-mode-alist '("\\.pug$" . pug-mode))

;;
;; markdown-mode
;;
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

;;
;; load some libs
;;
(load "~/.emacs.d/libs/elcord.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(package-selected-packages
   '(dockerfile-mode docker-compose-mode web-mode projectile magit company-php ac-php)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
