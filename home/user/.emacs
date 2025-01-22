(make-directory "~/.emacs.d/elpa/" t)
(let ((default-directory "~/.emacs.d/elpa"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(defvar packagesList
  '(web-mode
    php-mode
    docker-compose-mode
    dockerfile-mode
    vue-mode
    pug-mode
    markdown-mode
    projectile
    magit
    multiple-cursors
    flymake-php
    lsp-mode
    lsp-ui
    company))

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      packagesList)

(require 'cl-lib)
(require 'lsp)
(require 'flymake)

;;
;; Key binding
;;
(global-set-key "\M-x" (lambda () (interactive) (call-interactively (intern (ido-completing-read "M-x " (all-completions "" obarray 'commandp))))))
(global-set-key (kbd "C-x C-d") (lambda () (interactive) (dired "~/Sources")))
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c s") 'magit-status)
(global-set-key (kbd "C-c b") 'magit-blame-popup)
(global-set-key (kbd "C-c c") 'magit-branch-checkout)
(global-set-key (kbd "C-c w") 'whitespace-mode)
(global-set-key (kbd "C-c m") 'mc/mark-all-like-this-dwim)
(global-set-key (kbd "C-c f") 'projectile-grep)
(global-set-key (kbd "C-c k") 'projectile-kill-buffers)
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-'") 'goto-line)
(global-set-key (kbd "C-]") 'find-tag)
(global-set-key (kbd "C-t") 'pop-tag-mark)

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
	       ("System"       (or (name . "^\\*scratch\\*$") (name . "^\\.emacs") (name . "^\\*Messages\\*$")))))))

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
      'browse-url-generic browse-url-generic-program "firefox")
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
(global-display-line-numbers-mode t)
(electric-pair-mode t)
(cua-mode t)

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
(setq php-doc-directory "/usr/share/doc/php-docs-20190203/en/php-chunked-xhtml")
(require 'php-mode)

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

(defun flymake-php-init ()
  (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
	 (local (file-relative-name temp (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))
(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

(setq c-default-style "psr2")
(setq flymake-phpcs-standart "PSR12")
(setq flymake-phpcs-command "/root/.config/composer/vendor//squizlabs/php_codesniffer/bin/phpcs")
(setq phpstan-executable "/root/.config/composer/vendor/phpstan/phpstan/phpstan.phar")
(setq phpstan-level 5)

(define-key php-mode-map (kbd "C-c v") 'php-insert-var-dump-with-symbol)
(define-key php-mode-map (kbd "<f5>") 'php-mode)
(define-key php-mode-map (kbd "<f6>") 'phpstan-analyze-project)
(define-key php-mode-map (kbd "<f9>") 'php-search-symbol-in-docs)
(define-key php-mode-map (kbd "M-p") 'flymake-goto-prev-error)
(define-key php-mode-map (kbd "M-n") 'flymake-goto-next-error)

(add-hook 'php-mode-hook (lambda ()
			   (electric-indent-mode t)
                           (lsp t)
                           (flymake-mode t)
                           (flymake-phpstan-turn-on)
                           (flymake-phpcs-load)))

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
(add-hook 'markdown-mode-hook (lambda ()
                                (lsp t)))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

;;
;; typescript
;;
(add-hook 'typescript-mode-hook (lambda ()
                                  (lsp t)))
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode))

;;
;; bash
;;
(add-hook 'sh-mode-hook (lambda ()
                          (lsp t)))
(add-to-list 'auto-mode-alist '("\\.sh$" . sh-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(flymake-phpstan-disable-c-mode-hooks nil)
 '(ignored-local-variable-values
   '((phpstan-memory-limit . "256M")
     (php-project-root . auto)))
 '(indent-tabs-mode nil)
 '(lsp-php-composer-dir
   "Do not run Composer as root/super user! See https://getcomposer.org/root for details\12/usr/bin/composer")
 '(lsp-ui-doc-show-with-cursor t)
 '(mpc-host "192.168.88.168")
 '(package-selected-packages
   '(flymake-phpcs yasnippet xcscope web-mode vue-mode typescript-mode pug-mode projectile popup pkg-info multiple-cursors magit lsp-ui flymake-phpstan flymake-php dockerfile-mode docker-compose-mode composer company))
 '(php-complete-function-modules
   '(bcmath bzip2 core curl exif fpm gd gettext gmp gnupg iconv intl language libxml mbstring memcache mongodb openssl pcntl pgsql posix rar simplexml soap socket sodium solr xml xmlwriter yaml zlib))
 '(php-manual-url 'ru)
 '(php-mode-coding-style 'psr2)
 '(phpstan-baseline-file "phpstan.phar")
 '(safe-local-variable-values '((phpstan-working-dir (root . "src"))))
 '(standard-indent 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
