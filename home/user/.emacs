(make-directory "~/.emacs.d/elpa/" t)
(let ((default-directory "~/.emacs.d/elpa"))
  (normal-top-level-add-subdirs-to-load-path))
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages") t)

(mapc
 (lambda (package)
   (unless (package-installed-p package)
     (progn (message "installing %s" package)
	    (package-refresh-contents)
	    (package-install package))))
 '(auto-complete org web-mode php-mode ac-php projectile magit company company-php po-mode))

(load "~/.emacs.d/func.el")
(load "~/.emacs.d/keys.el")
(load "~/.emacs.d/custom.el")
(load "~/.emacs.d/web.el")
(load "~/.emacs.d/php.el")
(load "~/.emacs.d/lisp.el")
(load "~/.emacs.d/ibuffer.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode -1)
 '(browse-url-browser-function (quote browse-url-default-browser))
 '(canlock-password "b9ead6428897f1cd7f97afbfcc1b5e2d095e5111")
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(custom-safe-themes
   (quote
    ("1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" default)))
 '(delete-selection-mode t)
 '(electric-indent-mode -1)
 '(electric-pair-mode 1)
 '(font-use-system-font t)
 '(indent-tabs-mode nil)
 '(menu-bar-mode nil)
 '(nyan-mode t)
 '(package-selected-packages
   (quote
    (docker-compose-mode dockerfile-mode po-mode company web-mode projectile magit company-php ac-php)))
 '(scroll-bar-mode nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(tooltip-mode -1))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "xos4" :slant normal :weight normal :height 120 :width normal)))))
