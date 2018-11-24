(defun custom-vars-projectile-mode ()
  (setq projectile-indexing-method 'native)  
  (setq projectile-enable-caching t)
  (projectile-global-mode))

(add-hook 'projectile-mode 'custom-vars-projectile-mode)
