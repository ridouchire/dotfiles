(setq-default inferior-lisp-program "ccl")
(setq-default ac-auto-start t)
(setq-default ac-auto-show-menu t)
(setq-default c-basic-offset 4)
(setq frame-title-format "GNU Emacs: %b")
(setq dired-recursive-deletes 'top)
(setq whow-paren-style 'expression)
(setq inhibit-startup-screen -1)
(setq use-dialog-box nil)
(setq redisplay-dont-pause t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-file-list nil)
(setq linum-format "%s")
(setq linum-mode-inhibit-modes-list '(eshell-mode
                                      shell-mode
                                      erc-mode
                                      jabber-roster-mode
                                      jabber-chat-mode
                                      gnus-group-mode
                                      gnus-summary-mode
                                      gnus-article-mode))
(setq word-wrap t)
(setq indent-tab-mode nil)
(setq browse-url-browser-function 'my-browse-url-seamonkey-new-tab)
(setq indent-line-function 'insert-tab)
(setq ido-virtual-buffers t)
(setq ido-enable-flex-matching t)
(setq scroll-step 1)
(setq scroll-margin 10)
(setq scroll-conservatively 10000)
(setq search-highlight t)
(setq query-replace-highlight t)
(setq ido-enable-flex-matching t)
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
(setq tramp-default-method "ssh")
(setq max-mini-window-height 0.5)

(fset 'yes-or-no-p 'y-or-n-p)
(line-number-mode t)
(column-number-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(display-time-mode -1)
(size-indication-mode -1)
(put 'erase-buffer 'disabled nil)
(global-prettify-symbols-mode 1)
(ac-config-default)
(global-auto-complete-mode -1)
(global-display-line-numbers-mode 1)
(ido-mode 1)
