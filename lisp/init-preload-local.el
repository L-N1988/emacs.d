;; ... your code here ...



;;; General configuration

;; Make Org mode work with .notes, which is the default org files
(add-to-list 'auto-mode-alist '("\\.notes\\'" . org-mode))
;; Set emacs font size
;; (set-face-attribute 'default nil :height 280)




;;; citar configuration

(use-package citar
  :bind (("C-c b" . citar-insert-citation)
         :map minibuffer-local-map
         ("M-b" . citar-insert-preset))
  :custom
  (citar-bibliography '("~/org/notes/biblio.bib")))

(use-package citar
  :no-require
  :custom
  (org-cite-global-bibliography '("~/org/notes/biblio.bib"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  (citar-bibliography org-cite-global-bibliography)
  ;; optional: org-cite-insert is also bound to C-c C-x C-@
  :bind
  (:map org-mode-map :package org ("C-c b" . #'org-cite-insert)))

(setq citar-at-point-function 'embark-act)

(setq citar-templates
      '((main . "${author editor:30}     ${date year issued:4}     ${title:48}")
        (suffix . "          ${=key= id:15}    ${=type=:12}    ${tags keywords:*}")
        (preview . "${author editor} (${year issued date}) ${title}, ${journal journaltitle publisher container-title collection-title}.\n")
        (note . "Notes on ${author editor}, ${title}")))


;;; DIY functions

(defun webdav-sync-active ()
  "use curl and webdav to synchronize modified files continuouly"
  (interactive)
  (async-shell-command "zsh ~/org/notes/sync_active.sh")
  )

(defun webdav-sync-all ()
  "use curl and webdav to synchronize all files at one time"
  (interactive)
  (shell-command "zsh ~/org/notes/sync_all.sh")
  )



;;; evil configuration

(evil-mode 1)



;;; org-mode face configuration
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'variable-pitch-mode)
;; (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-code nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-block nil :inherit 'fixed-pitch)




;;; Configuration for AuCTeX

(add-hook 'LaTeX-mode-hook (lambda ()
                             (TeX-fold-mode 1)))
(add-hook 'LaTeX-mode-hook #'outline-minor-mode)



;;; pyim configuration

(pyim-basedict-enable)   ;拼音词库，五笔用户 *不需要* 此行设置
(setq default-input-method "pyim")
(global-set-key (kbd "C-\\") 'toggle-input-method)
(setq-default pyim-punctuation-translate-p '(yes))    ;使用全角标点。
(setq-default pyim-punctuation-translate-p '(no))     ;使用半角标点。
(setq-default pyim-punctuation-translate-p '(auto))   ;中文使用全角标点，英文使用半角标点。
(setq pyim-page-style 'one-line) ;调整 tooltip 选词框的显示样式



;;; cnfonts configuration

;; 让 cnfonts 在 Emacs 启动时自动生效。
(cnfonts-mode 1)
;; 不同的标题，使用的字体大小也不同
;; (setq cnfonts-use-face-font-rescale t)
;; 添加两个字号增大缩小的快捷键，暂时没必要，字体大小基本固定
;; (define-key cnfonts-mode-map (kbd "C--") #'cnfonts-decrease-fontsize)
;; (define-key cnfonts-mode-map (kbd "C-=") #'cnfonts-increase-fontsize)



;;; fancy-dabbrev configuration

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



;;; yasnippets configuration

;; or M-x yas-reload-all if you've started YASnippet already.
(yas-global-mode 1)
;; Use yas-minor-mode on a per-buffer basis
(add-hook 'LaTeX-mode-hook #'yas-minor-mode)
(setq yas-triggers-in-field t)



;;; zotxt configuration

;; Activate org-zotxt-mode in org-mode buffers
(add-hook 'org-mode-hook (lambda () (org-zotxt-mode 1)))
;; Change citation format to be less cumbersome in files.
;; You'll need to install mkbehr-short into your style manager first.
(eval-after-load "zotxt"
  '(setq zotxt-default-bibliography-style "mkbehr-short"))



;;; Deft configuration

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
(defun cm/deft-parse-title (file contents)
  "Parse the given FILE and CONTENTS and determine the title.
  If `deft-use-filename-as-title' is nil, the title is taken to
  be the first non-empty line of the FILE.  Else the base name of the FILE is
  used as title."
  (let ((begin (string-match "^#\\+[tT][iI][tT][lL][eE]: .*$" contents)))
    (if begin
        (string-trim (substring contents begin (match-end 0)) "#\\+[tT][iI][tT][lL][eE]: *" "[\n\t ]+")
      (deft-base-filename file))))

(advice-add 'deft-parse-title :override #'cm/deft-parse-title)

(setq deft-strip-summary-regexp
      (concat "\\("
              "[\n\t]" ;; blank
              "\\|^#\\+[[:alpha:]_]+:.*$" ;; org-mode metadata
              "\\|^:PROPERTIES:\n\\(.+\n\\)+:END:\n"
              "\\)"))



;;; org-roam configuration

(setq org-roam-directory "~/org/notes")
(define-key global-map (kbd "C-c n l") 'org-roam-buffer-toggle)
(define-key global-map (kbd "C-c n f") 'org-roam-node-find)
(define-key global-map (kbd "C-c n g") 'org-roam-graph)
(define-key global-map (kbd "C-c n i") 'org-roam-node-insert)
(define-key global-map (kbd "C-c n c") 'org-roam-capture)
;; Dailies
(define-key global-map (kbd "C-c n j") 'org-roam-dailies-capture-today)
;; If you're using a vertical completion framework, you might want a more informative completion interface
(setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
;; Activate org-roam-db-autosync in org-mode buffers
(add-hook 'org-mode-hook (lambda () (org-roam-db-autosync-mode 1)))



;;; org-superstar configuration

;; prettify org-mode headers
(setq org-superstar-special-todo-items t)
(add-hook 'org-mode-hook (lambda ()
                           (org-superstar-mode 1)))


(provide 'init-preload-local)
;;; init-preload-local.el ends here
