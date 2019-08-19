(defun custom-vars-web-mode ()
  (electric-indent-mode 1)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-block-face t)
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-ac-sources-alist
  '(("css" . (ac-source-css-property))
    ("html" . (ac-source-words-in-buffer ac-source-abbrev)))))

(defun custom-keys-web-mode ()
  (define-key web-mode-map (kbd "C-=") 'web-mode-fold-or-unfold))

(add-hook 'web-mode-hook 'custom-keys-web-mode)
(add-hook 'web-mode-hook 'custom-vars-web-mode)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig\\'" . web-mode))


;; (require 'ac-html-csswatcher)
;; (ac-html-csswatcher-setup)
