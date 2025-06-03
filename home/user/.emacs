(make-directory "~/.emacs.d/elpa/" t)
(let ((default-directory "~/.emacs.d/elpa"))
  (normal-top-level-add-subdirs-to-load-path))

(setq inhibit-startup-screen -1
      initial-scratch-message nil)
(setq use-dialog-box nil)
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
(setq-default indent-tabs-mode nil)
(setq user-mail-address nil)
(setq byte-compile-warnings '(cl-function))

(fset 'yes-or-no-p 'y-or-n-p)

(tool-bar-mode -1)
(tooltip-mode -1)
(size-indication-mode -1)
(column-number-mode t)
(global-display-line-numbers-mode t)
(electric-pair-mode t)
(cua-mode t)

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
  (package-initialize))

(use-package dired
  :ensure nil
  :bind (:map global-map ("C-x C-d" . (lambda () (interactive) (dired "~/Sources")))))

(use-package ido
  :ensure nil
  :bind (:map global-map ("\M-x" . (lambda () (interactive) (call-interactively (intern (ido-completion-read "M-x " (all-completions "" obarray 'commandp))))))))

(use-package ibuffer
  :ensure nil
  :bind (:map global-map ("C-x C-b" . ibuffer))
  :hook ((ibuffer-mode . (lambda () (ibuffer-switch-to-saved-filter-groups "default"))))
  :config
  (setq ibuffer-saved-filter-groups
        (quote (("default"
                 ("dired"      (mode . dired-mode))
                 ("PHP"        (mode . php-mode))
                 ("Javascript" (mode . javascript-mode))
                 ("HTML"       (mode . web-mode))
                 ("Docker"     (or (mode . dockerfile-mode) (mode . docker-compose-mode)))
                 ("system"     (or (name . "^\\*scratch\\*$") (name . "^\\.emacs") (name . "^\\*Messages\\*$"))))))))

(use-package achievements
  :ensure t
  :config
  (achievements-mode))

(use-package yasnippet
  :ensure t
  :init (make-directory "~/.emacs.d/snippets" t)
  :config (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  :bind (:map global-map ("C-c e" . yas-expand)))

(use-package yasnippet-snippets :ensure t)

(use-package magit
  :ensure t
  :bind (:map global-map (("C-c b" . magit-blame-poput)
                          ("C-c c" . magit-branch-checkout)
                          ("<f12>" . magit-status))))

(use-package multiple-cursors
  :ensure t
  :bind (:map global-map ("C-c m" . mc/mark-all-like-this)))

(use-package projectile
  :ensure t
  :bind (:map global-map (("C-c f" . projectile-grep)
                          ("C-c k" . projectile-kill-buffers)))
  :config
  (setq projectile-indexing-method 'native)
  (setq projectile-enable-caching t))

(use-package web-mode
  :ensure t
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
  :mode "\\.\\(html\\|twig\\|blade\\)$'"
  :mode "\\.js$")

(use-package php-mode
  :ensure t
  :bind (:map php-mode-map
              ("<f5>" . php-mode)
              ("<f9>" . php-search-documentation))

  :mode "\\.php$"
  :mode "\\.blade\\.php$"
  :delight
  :hook (php-mode . (lambda ()
                      (electric-indent-mode t)
                      (lsp t)
                      (yas-minor-mode t)
                      (projectile-mode)))
  :config
  (setq php-doc-directory "/usr/share/doc/php-docs-20190203/en/php-chunked-xhtml")
  (setq c-default-style "psr2")

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
  
  (use-package flymake-phpstan
    :ensure t
    :requires php-mode
    :config
    (setq phpstan-executable "/root/.config/composer/vendor/phpstan/phpstan/phpstan.phar")
    (setq phpstan-level 5)
    :bind (:map php-mode-map ("<f6>" . phpstan-analyze-project))
    :hook (php-mode . (lambda () (flymake-phpstan-turn-on))))
  
  (use-package flymake-php
    :ensure t
    :requires php-mode
    :config
    (defun flymake-php-init ()
      (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
             (local (file-relative-name temp (file-name-directory buffer-file-name))))
        (list "php" (list "-f" local "-l"))))

    (add-to-list 'flymake-err-line-patterns '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))
    (add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))
    :bind (:map php-mode-map
                ("M-p" . flymake-goto-prev-error)
                ("M-n" . flymake-goto-next-error))
    :hook (php-mode . (lambda () (flymake-mode t))))
  )

(use-package vue-mode
  :ensure t
  :config
  (setq js-indent-level 2)
  :mode "\\.vue$")

(use-package pug-mode
  :ensure t
  :config
  :mode "\\.pug$")

(use-package markdown-mode
  :ensure t
  :config
  :hook (markdown-mode . (lambda () (lsp t)))
  :mode "\\.md$")

(use-package typescript-mode
  :ensure t
  :config
  :hook (typescript-mode . (lambda () (lsp t)))
  :mode "\\.ts$"
  :mode "\\.tsx$")

(use-package shell
  :ensure nil
  :hook (sh-mode . (lambda () (lsp t)))
  :mode "\\.sh$")

(use-package yaml-mode
  :ensure t
  :mode "\\.yml"
  :mode "\\.yaml")

(use-package emacs-lisp-mode
  :ensure nil
  :mode "\\.el")

(use-package company
  :ensure t
  :hook (emacs-lisp-mode . company-mode))

(use-package lsp-mode
  :ensure t
  :bind (([remap xref-find-definitions] . #'lsp-ui-peek-find-definitions)
         ([remap xref-find-references] . #'lsp-ui-peek-find-references))
  :config
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols)))

(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode))

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode)
  :init (setq all-the-icons-dired-monochrome nil))

(use-package all-the-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

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
 '(lsp-ui-doc-show-with-cursor t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(achievements company-nginx company-web composer docker-compose-mode
                  dockerfile-mode flymake-php flymake-phpcs
                  flymake-phpstan lsp-ui magit multiple-cursors
                  php-flymake pkg-info popup projectile pug-mode
                  typescript-mode vue-mode web-mode xcscope yasnippet
                  yasnippet-snippets))
 '(php-complete-function-modules
   '(bcmath bzip2 core curl exif fpm gd gettext gmp gnupg iconv intl
            language libxml mbstring memcache mongodb openssl pcntl
            pgsql posix rar simplexml soap socket sodium solr xml
            xmlwriter yaml zlib))
 '(php-manual-url 'ru)
 '(php-mode-coding-style 'psr2)
 '(phpstan-baseline-file "phpstan.phar")
 '(safe-local-variable-values
   '((phpstan-memory-limit . "256M") (phpstan-working-dir (root . "src"))))
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

(load-file "~/.emacs.d/llama.el")
