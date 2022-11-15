;; Activate org-zotxt-mode in org-mode buffers
(add-hook 'org-mode-hook (lambda () (org-zotxt-mode 1)))
;; Change citation format to be less cumbersome in files.
;; You'll need to install mkbehr-short into your style manager first.
(eval-after-load "zotxt"
  '(setq zotxt-default-bibliography-style "mkbehr-short"))

;; out magic for latex files
(add-hook 'latex-mode-hook
          (lambda ()
            (outline-minor-mode 1)
            (setq-local outline-regexp "\\\\\\(sub\\)*section\\>")
            (setq-local outline-level (lambda () (- (outline-level) 7)))))

(provide 'init-local)
