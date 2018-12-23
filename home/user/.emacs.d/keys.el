(global-set-key "\M-x" (lambda () (interactive) (call-interactively (intern (ido-completing-read "M-x " (all-completions "" obarray 'commandp))))))

(define-key global-map [f1] 'delete-other-windows)
(define-key global-map [f2] 'other-window)
(define-key global-map [f3] 'split-window-vertically)
(define-key global-map [f4] 'split-window-horizontally)

(define-key global-map [f6] 'sos)
(define-key global-map [f7] 'hackernews)
(define-key global-map [f12] 'magit-status)

(global-set-key [(meta shift up)] 'move-line-up)
(global-set-key [(meta shift down)] 'move-line-down)

(global-set-key (kbd "C-x C-d") (lambda () (interactive) (dired "~/Sources")))
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-S-f") 'isearch-backward)
(global-set-key (kbd "C-.") 'goto-line)
(global-set-key (kbd "C->") 'goto-char)

;; hotkeys for my work 
(global-set-key (kbd "C-c d d") (lambda () (interactive) (dired "~/Sources/dev-cart/public")))
(global-set-key (kbd "C-c d d") (lambda () (interactive) (dired "~/Sources/image-hosting")))

(global-set-key (kbd "C-c f") 'projectile-grep)
(global-set-key (kbd "C-c k") 'projectile-kill-buffers)

(global-set-key (kbd "C-c s") 'magit-status)
(global-set-key (kbd "C-c b") 'magit-blame-popup)
(global-set-key (kbd "C-c c") 'magit-branch-checkout)
(global-set-key (kbd "C-c r") 'magit-reset-hard)

(global-set-key (kbd "C-c w") 'whitespace-mode)
