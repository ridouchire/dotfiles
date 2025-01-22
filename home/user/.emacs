(make-directory "~/.emacs.d/elpa/" t)
(let ((default-directory "~/.emacs.d/elpa"))
  (normal-top-level-add-subdirs-to-load-path))

(setq inhibit-startup-screen -1
      initial-scratch-message nil)
(setq use-dialog-box nil)
(setq redisplay-dont-pause t)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq auto-save-file-list nil)
(setq word-wrap t)
(setq indent-tab-mode nil)
(setq browse-url-browser-function 'browse-url-generic browse-url-generic-program "firefox")
(setq ido-virtual-buffers t)
(setq scroll-step 1)
(setq scroll-margin 10)
(setq scroll-conservatively 10000)
(setq query-replace-highlight t)
(setq gc-cons-threshold 100000000)

(fset 'yes-or-no-p 'y-or-n-p)

(tool-bar-mode -1)
(tooltip-mode -1)
(size-indication-mode -1)
(column-number-mode t)
(global-display-line-numbers-mode t)
(electric-pair-mode t)
(cua-mode t)

(global-set-key "\M-x" (lambda () (interactive) (call-interactively (intern (ido-completing-read "M-x " (all-completions "" obarray 'commandp))))))
(global-set-key (kbd "C-x C-d") (lambda () (interactive) (dired "~/Sources")))

(global-set-key (kbd "C-c w") 'whitespace-mode)
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-'") 'goto-line)
(global-set-key (kbd "C-]") 'find-tag)
(global-set-key (kbd "C-t") 'pop-tag-mark)

(define-key global-map [f1] 'delete-other-windows)
(define-key global-map [f2] 'other-window)
(define-key global-map [f3] 'split-window-vertically)
(define-key global-map [f4] 'split-window-horizontally)

(use-package package
  :config
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)
  (defvar packageList nil)
  (add-to-list 'packageList 'web-mode)
  (add-to-list 'packageList 'php-mode)
  (add-to-list 'packageList 'dockerfile-mode)
  (add-to-list 'packageList 'docker-compose-mode)
  (add-to-list 'packageList 'vue-mode)
  (add-to-list 'packageList 'pug-mode)
  (add-to-list 'packageList 'markdown-mode)
  (add-to-list 'packageList 'projectile)
  (add-to-list 'packageList 'magit)
  (add-to-list 'packageList 'multiple-cursors)
  (add-to-list 'packageList 'flymake-php)
  (add-to-list 'packageList 'lsp-mode)
  (add-to-list 'packageList 'lsp-ui)
  (add-to-list 'packageList 'company)
  (add-to-list 'packageList 'yasnippet)
  (add-to-list 'packageList 'yasnippet-snippets)
  (add-to-list 'packageList 'flymake-phpcs)
  (add-to-list 'packageList 'flymake-phpstan)
  (add-to-list 'packageList 'typescript-mode)

  (mapc #'(lambda (package)
            (unless (package-installed-p package)
              (package-install package)))
        packageList))

(use-package ibuffer
  :config
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  (setq ibuffer-saved-filter-groups
        (quote (("default"
	         ("dired"       (mode . dired-mode))
	         ("PHP"         (mode . php-mode))
	         ("JavaScript"  (mode . javascript-mode))
	         ("HTML"        (mode . web-mode))
	         ("Docker"      (or (mode . dockerfile-mode) (mode . docker-compose-mode)))
	         ("System"       (or (name . "^\\*scratch\\*$") (name . "^\\.emacs") (name . "^\\*Messages\\*$")))))))

  (add-hook 'ibuffer-mode-hook (lambda () (ibuffer-switch-to-saved-filter-groups "default")))
  (add-hook 'ibuffer-mode-hook (lambda () (setq ibuffer-formats '((mark modified read-only " " (name 18 200 :left :elide) " " filename-and-process))))))

(use-package yasnippet
  :config
  (make-directory "~/.emacs.d/snippets" t)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (global-set-key (kbd "C-c e") 'yas-expand))

(use-package magit
  :config
  (global-set-key (kbd "C-c b") 'magit-blame-popup)
  (global-set-key (kbd "C-c c") 'magit-branch-checkout)
  (define-key global-map [f12] 'magit-status))

(use-package multiple-cursors
  :config
  (global-set-key (kbd "C-c m") 'mc/mark-all-like-this))

(use-package projectile
  :config
  (global-set-key (kbd "C-c f") 'projectile-grep)
  (global-set-key (kbd "C-c k") 'projectile-kill-buffers)
  (setq projectile-indexing-method 'native)
  (setq projectile-enable-caching t)
  (projectile-global-mode))

(use-package web-mode
  :config
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
  (add-to-list 'auto-mode-alist '("\\.js$" . web-mode)))

(use-package php-mode
  :config
  (setq php-doc-directory "/usr/share/doc/php-docs-20190203/en/php-chunked-xhtml")
  (setq c-default-style "psr2")
  
  (use-package flymake-php
    :config
    
    (defun flymake-php-init ()
      (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
	     (local (file-relative-name temp (file-name-directory buffer-file-name))))
        (list "php" (list "-f" local "-l"))))
    
    (add-to-list 'flymake-err-line-patterns '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))
    (add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

    (define-key php-mode-map (kbd "M-p") 'flymake-goto-prev-error)
    (define-key php-mode-map (kbd "M-n") 'flymake-goto-next-error)
    (add-hook 'php-mode-hook (lambda () (flymake-mode t))))

  (use-package flymake-phpcs
    :config
    (setq flymake-phpcs-standart "PSR12")
    (setq flymake-phpcs-command "/root/.config/composer/vendor//squizlabs/php_codesniffer/bin/phpcs")
    (add-hook 'php-mode-hook (lambda () (flymake-phpcs-load))))

  (use-package flymake-phpstan
    :config
    (setq phpstan-executable "/root/.config/composer/vendor/phpstan/phpstan/phpstan.phar")
    (setq phpstan-level 5)
    
    (define-key php-mode-map (kbd "<f6>") 'phpstan-analyze-project)
    (add-hook 'php-mode-hook (lambda () (flymake-phpstan-turn-on))))

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

  (define-key php-mode-map (kbd "<f5>") 'php-mode)
  (define-key php-mode-map (kbd "<f9>") 'php-search-documentation)

  (add-hook 'php-mode-hook (lambda () (electric-indent-mode t) (lsp t) (yas-minor-mode t)))

  (add-to-list 'auto-mode-alist '("\\.php$" . php-mode)))

(use-package vue-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.vue$" . vue-mode))
  (setq js-indent-level 2))

(use-package pug-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.pug$" . pug-mode)))

(use-package markdown-mode
  :config
  (add-hook 'markdown-mode-hook (lambda () (lsp t)))
  (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode)))

(use-package typescript-mode
  :config
  (add-hook 'typescript-mode-hook (lambda () (lsp t)))
  (add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode)))

(add-hook 'sh-mode-hook (lambda () (lsp t)))
(add-to-list 'auto-mode-alist '("\\.sh$" . sh-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu t)
 '(ac-auto-start t)
 '(c-basic-offset 4)
 '(custom-enabled-themes '(tango-dark))
 '(flymake-phpstan-disable-c-mode-hooks nil)
 '(frame-title-format "Emacs %b" t)
 '(ignored-local-variable-values
   '((phpstan-memory-limit . "256M")
     (php-project-root . auto)))
 '(lsp-ui-doc-show-with-cursor t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(yasnippet-snippets flymake-phpcs yasnippet xcscope web-mode vue-mode typescript-mode pug-mode projectile popup pkg-info multiple-cursors magit lsp-ui flymake-phpstan flymake-php dockerfile-mode docker-compose-mode composer company))
 '(php-complete-function-modules
   '(bcmath bzip2 core curl exif fpm gd gettext gmp gnupg iconv intl language libxml mbstring memcache mongodb openssl pcntl pgsql posix rar simplexml soap socket sodium solr xml xmlwriter yaml zlib))
 '(php-manual-url 'ru)
 '(php-mode-coding-style 'psr2)
 '(phpstan-baseline-file "phpstan.phar")
 '(safe-local-variable-values
   '((projectile-project-name "MedilineERP")
     (phpstan-working-dir
      (root . "src"))))
 '(scroll-bar-mode nil)
 '(standard-indent 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)


(add-hook 'emacs-startup-hook
	  (lambda ()
	    (message "Emacs ready in %s with %d garbage collections."
		     (format "%.2f seconds"
			     (float-time
			      (time-subtract after-init-time before-init-time)))
		     gcs-done)))
