;; ... your code here ...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;General configuration
;;
;; Make Org mode work with .notes, which is the default org files
(add-to-list 'auto-mode-alist '("\\.notes\\'" . org-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;evil configuration
;;
(evil-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Configuration for AuCTeX
;;
(add-hook 'LaTeX-mode-hook (lambda ()
                             (TeX-fold-mode 1)))
(add-hook 'LaTeX-mode-hook #'outline-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;pyim configuration
;;
(pyim-basedict-enable)   ;拼音词库，五笔用户 *不需要* 此行设置
(setq default-input-method "pyim")
(global-set-key (kbd "C-\\") 'toggle-input-method)
(setq-default pyim-punctuation-translate-p '(yes))    ;使用全角标点。
(setq-default pyim-punctuation-translate-p '(no))     ;使用半角标点。
(setq-default pyim-punctuation-translate-p '(auto))   ;中文使用全角标点，英文使用半角标点。
(setq pyim-page-style 'one-line) ;调整 tooltip 选词框的显示样式

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;cnfonts configuration
;;
;; 让 cnfonts 在 Emacs 启动时自动生效。
(cnfonts-mode 1)
;; 添加两个字号增大缩小的快捷键，暂时没必要，字体大小基本固定
;; (define-key cnfonts-mode-map (kbd "C--") #'cnfonts-decrease-fontsize)
;; (define-key cnfonts-mode-map (kbd "C-=") #'cnfonts-increase-fontsize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;fancy-dabbrev configuration
;;
;; Enable fancy-dabbrev previews everywhere:
(global-fancy-dabbrev-mode)
;; If you want TAB to indent the line like it usually does when the cursor
;; is not next to an expandable word, use 'fancy-dabbrev-expand-or-indent
;; instead of `fancy-dabbrev-expand`:
(global-set-key (kbd "TAB") 'fancy-dabbrev-expand-or-indent)
(global-set-key (kbd "<backtab>") 'fancy-dabbrev-backward)
;; Let dabbrev searches ignore case and expansions preserve case:
(setq dabbrev-case-distinction nil)
(setq dabbrev-case-fold-search t)
(setq dabbrev-case-replace nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;yasnippets configuration
;;
;; or M-x yas-reload-all if you've started YASnippet already.
(yas-global-mode 1)
;; Use yas-minor-mode on a per-buffer basis
(add-hook 'LaTeX-mode-hook #'yas-minor-mode)
(setq yas-triggers-in-field t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;zotxt configuration
;;
;; Activate org-zotxt-mode in org-mode buffers
(add-hook 'org-mode-hook (lambda () (org-zotxt-mode 1)))
;; Change citation format to be less cumbersome in files.
;; You'll need to install mkbehr-short into your style manager first.
(eval-after-load "zotxt"
  '(setq zotxt-default-bibliography-style "mkbehr-short"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Deft configuration
;;
(setq deft-directory "~/org/notes")
(setq deft-extensions '("org"))
(setq deft-default-extension "org")
(setq deft-text-mode 'org-mode)
(setq deft-use-filter-string-for-filename t)
;; use note filenames to generate the displayed titles
(setq deft-use-filename-as-title nil)
;; enable searching for files in subdirectories
(setq deft-recursive t)
;; replace all slashes and spaces with '_'
;; and will convert the file name to lowercase:
(setq deft-file-naming-rules
      '((noslash . "_")
        (nospace . "_")))
;; automatically generated titles in new org-mode files
(setq deft-org-mode-title-prefix t)

(provide 'init-preload-local)
;;; init-preload-local.el ends here
