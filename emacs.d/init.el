(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file t)
(setq package-native-compile t)
;;; some config
(setq *lisp-modes*
      '(common-lisp-mode
        emacs-lisp-mode
        lisp-interaction-mode
        emacs-lisp-mode
        lisp-mode
        scheme-mode
        racket-mode
        lfe-mode
        hy-mode
        clojure-mode
        cider-repl-mode
        racket-repl-mode
        slime-repl-mode
        inferior-lisp-mode
        mrepl-mode
        sly-mrepl-mode
        comint-mode))
(defalias 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-screen t)
(setq default-directory "~/")
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq-default cursor-type 'box)
(setq blink-cursor-blinks -1)
(setq blink-cursor-interval 0.4)
(setq scroll-conservatively 100)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(mapc (lambda (mode)
        (funcall mode -1))
      '(menu-bar-mode scroll-bar-mode tool-bar-mode))
(global-display-line-numbers-mode)
(setq create-lockfiles nil)
(global-auto-revert-mode t)
(setq auto-revert-use-notify nil)
(set-face-attribute 'default nil :height 200)
(ido-mode 1)
(setq ido-enable-flex-matching t)
; Use spaces, not tabs.
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)
;;; packages
(setq package-enable-at-startup nil)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;;; pairs
(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(straight-use-package 'rainbow-mode)
(straight-use-package 'highlight-parentheses)
(add-hook 'prog-mode-hook #'highlight-parentheses-mode)
(straight-use-package 'flash-paren)
(flash-paren-mode 1)

(show-paren-mode 1)
(setq show-paren-delay 0)

(straight-use-package 'smartparens)
(smartparens-global-mode 1)
(sp-local-pair *lisp-modes*  "'" nil :actions nil)
(sp-local-pair *lisp-modes*  "`" nil :actions nil)

;;; backup/autosave
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))
;;; clipboard
(straight-use-package 'simpleclip)
(simpleclip-mode 1)
;;; Evil
(straight-use-package 'evil)
(setq evil-move-beyond-eol t)
(evil-mode 1)
(evil-define-motion evil-jzz (count)
  "j to jzz"
  :type line
  (evil-next-line (or count 1))
  (evil-scroll-line-to-center nil))
(define-key evil-normal-state-map (kbd "j") 'evil-jzz)

(evil-define-motion evil-kzz (count)
  "k to kzz"
  :type line
  (evil-previous-line (or count 1))
  (evil-scroll-line-to-center nil))
(define-key evil-normal-state-map (kbd "k") 'evil-kzz)

;;; Which Key
(straight-use-package 'which-key)
(setq which-key-show-early-on-C-h t)
(setq which-key-idle-delay 1)
(setq which-key-idle-secondary-delay 0.05)
(which-key-mode)

;;; helm
(straight-use-package 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(with-eval-after-load 'helm
  (define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-i") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") #'helm-select-action))
;;; general.el
(straight-use-package 'general)
(setq general-default-keymaps 'evil-normal-state-map)
(general-define-key :prefix "SPC"
                    "SPC" 'helm-find-files
                    "o" 'ace-window)
(general-define-key :prefix "SPC b"
                    "b" 'helm-buffers-list
                    "k" 'kill-buffer
                    )

;;; programming

;;; company
(straight-use-package 'company)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "<tab>") #'company-select-next)
  (define-key company-active-map (kbd "TAB") #'company-select-next)
  (define-key company-active-map (kbd "C-i") #'company-select-next))
(setq company-selection-wrap-around t)
(company-tng-configure-default)
(add-hook 'after-init-hook 'global-company-mode)

;;; Common Lisp
(straight-use-package 'slime)
(setq inferior-lisp-program "ros run")
;;(straight-use-package 'slime-company)
;;(setq slime-company-completion 'fuzzy
;;      slime-company-after-completion 'slime-company-just-one-space)
(straight-use-package 'lispy)
;;; python
(straight-use-package 'pyvenv)
(setenv "WORKON_HOME" "~/.local/share/virtualenvs") ;; use the path from pipenv

;;; elixir
(straight-use-package 'elixir-mode)
(add-to-list 'exec-path "~/.local/share/elixir-ls")
(add-hook 'elixir-mode-hook #'lsp)
;;; golang
(straight-use-package 'go-mode)
(add-hook 'go-mode-hook #'lsp)
;;; nim
(straight-use-package 'nim-mode)

;;; LSP
(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-python-ms)
(setq lsp-python-ms-auto-install-server t)

;;; HTML
(straight-use-package 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(defun evil-emmet-expand-line ()
  (interactive)
  (evil-forward-char)
  (emmet-expand-line nil)
  (evil-insert nil)
  )
(define-key evil-normal-state-map (kbd ",") 'evil-emmet-expand-line)

;;; end programming


;;; Misc

(straight-use-package 'rg)

(delete-selection-mode 1)

(straight-use-package 'ace-window)
(global-set-key (kbd "M-o") 'ace-window)

(straight-use-package 'neotree)
(global-set-key (kbd "M-1") 'neotree-toggle)
(setq neo-smart-open t)

(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
;;; Terminal
(straight-use-package 'vterm)
(vterm-module-compile)
(defun toggle-vterm ()
  (interactive)
  (if (eq major-mode 'vterm-mode)
      (delete-window)
    (vterm-other-window)))
(global-set-key (kbd "M-2") 'toggle-vterm)

(straight-use-package 'undo-tree)
(global-undo-tree-mode)
(evil-set-undo-system 'undo-tree)

;;; themes
(straight-use-package 'doom-themes)
;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-sourcerer t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)
(straight-use-package 'all-the-icons)


(straight-use-package 'nyan-mode)
(nyan-mode 1)
