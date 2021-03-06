(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (nord-theme)))
 '(custom-safe-themes
   (quote
    ("7f6d4aebcc44c264a64e714c3d9d1e903284305fd7e319e7cb73345a9994f5ef" default)))
 '(display-battery-mode t)
 '(display-line-numbers-type (quote relative))
 '(display-time-mode t)
 '(elpy-rpc-backend "jedi" t)
 '(global-display-line-numbers-mode t)
 '(nil nil t)
 '(package-selected-packages
   (quote
    (go-mode typescript-mode htmlize ox-reveal epresent nord-theme dumb-jump emms tabbar treemacs try helm-projectile projectile which-key use-package)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 (menu-bar-mode -1)
 (tool-bar-mode -1)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; my_settings

;; stop making back-up files by emacs
(setq make-backup-files nil)

;; stop making lock-files by emacs
(setq create-lockfiles nil)

;; set maximum indentation for description lists
(setq org-list-description-max-indent 5)

;; prevent demoting heading also shifting text inside sections
(setq org-adapt-indentation nil)

(setq inhibit-splash-screen t)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))


;; package_settings

(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn ""))
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
      )
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

(use-package try
:ensure t)

(use-package which-key
:ensure t
:config
(which-key-mode))


(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-project-search-path '( "~/tripock_projects/backend"))
  (projectile-mode +1))

(use-package helm-projectile
  :ensure t
 )

;; Org mode stuff
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
 )


;; If you like the tabbar
(use-package tabbar
  :ensure t
  :config
  (tabbar-mode 1)

)

;; For powerful search

(use-package counsel
:ensure t
)


(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-display-style 'fancy))


(use-package swiper
:ensure t
:config
(progn
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; enable this if you want `swiper' to use it
  ;; (setq search-default-mode #'char-fold-to-regexp)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
  )
)


(use-package auto-complete
:ensure t
:init
(progn
  (ac-config-default)
  (global-auto-complete-mode t)
 )
)


;; flycheck
(use-package flycheck
:ensure t
:init (global-flycheck-mode))


(setq py-python-command "python3")
(setq python-shell-interpreter "python3")

(use-package elpy
:ensure t
:custom (elpy-rpc-backend "jedi")
:config
(elpy-enable))

(use-package virtualenvwrapper
:ensure t
:config
(venv-initialize-interactive-shells)
(venv-initialize-eshell)
)


(use-package web-mode
:ensure t
:config
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode))
(setq web-mode-engines-alist
'(("django"    . "\\.html\\'")))
(setq web-mode-ac-sources-alist
'(("css" . (ac-source-css-property))
("vue" . (ac-source-words-in-buffer ac-source-abbrev))
("html" . (ac-source-words-in-buffer ac-source-abbrev))))
(setq web-mode-enable-auto-closing t))
(setq web-mode-enable-auto-quoting t)


;; add magit for git
(use-package magit
  :ensure t
  :pin melpa)


;; Javascript packages
(use-package js2-mode
:ensure t
:ensure ac-js2
:init
(progn
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
))

(use-package js2-refactor
:ensure t
:config 
(progn
(js2r-add-keybindings-with-prefix "C-c C-m")
(add-hook 'js2-mode-hook #'js2-refactor-mode)))

(use-package tern
:ensure tern
:ensure tern-auto-complete
:config
(progn
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;(tern-ac-setup)
))

;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)


;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
	  '(json-jsonlist)))

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)


;; Dired for project directory structure
(setq dired-dwim-target t)

(use-package dired-narrow
:ensure t
:config
(bind-key "C-c C-n" #'dired-narrow)
(bind-key "C-c C-f" #'dired-narrow-fuzzy)
(bind-key "C-x C-N" #'dired-narrow-regexp)
)

(use-package dired-subtree :ensure t
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))


;; Using helm package to narrow down search
(use-package helm
:demand t
:config
  (helm-mode 1)
)

;; for file browser use  treemacs
(use-package treemacs
:ensure t
:defer t
:config
 (progn
  (setq treemacs-follow-after-init          t
        treemacs-width                      35
        treemacs-indentation                2
        treemacs-git-integration            t
        treemacs-collapse-dirs              3
        treemacs-silent-refresh             nil
        treemacs-change-root-without-asking nil
        treemacs-sorting                    'alphabetic-desc
        treemacs-show-hidden-files          t
        treemacs-never-persist              nil
        treemacs-is-never-other-window      nil
        treemacs-goto-tag-strategy          'refetch-index)

 (treemacs-follow-mode t)
 (treemacs-filewatch-mode t))
 :bind
 (:map global-map
   ([f8]        . treemacs-toggle)
   ([f9]        . treemacs-projectile-toggle)
   ("<C-M-tab>" . treemacs-toggle)
   ("M-0"       . treemacs-select-window)
   ("C-c 1"     . treemacs-delete-other-windows)
))


;; using emms to play music
(use-package emms-setup
  :init
  (add-hook 'emms-player-started-hook 'emms-show)
  (setq emms-show-format "Playing: %s")
  :config
  (emms-standard)
  (emms-default-players))


;; use dumb-jump to go to function definition
(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
	 ("M-g b" . dumb-jump-back)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config 
  ;; (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
:init
(dumb-jump-mode)
  :ensure
)


;; rename file function
(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(global-set-key (kbd "C-c r")  'rename-file-and-buffer)


(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (shell . t)
   (python . t)
   (R . t)
   (ditaa . t)
   (perl . t)
   (gnuplot t)
   ))


;; to set your default coding system to utf-8.( eg:  each of them encountered characters it couldn’t encode: iso-latin-1-unix cannot encode these: _’)
(prefer-coding-system 'utf-8)


;; To switch between different windows use ace-windo
(use-package ace-window
      :ensure t
      :config
      (setq aw-scope 'frame) ;; was global
      (global-set-key (kbd "C-x O") 'other-frame)
      (global-set-key (kbd "C-x o") 'ace-window))

;; spell check
(add-hook 'mu4e-compose-mode-hook
        (defun my-do-compose-stuff ()
           "My settings for message composition."
           (set-fill-column 72)
           (flyspell-mode)))



;; open new untitled buffer in a new frame 
(defun lunaryorn-new-buffer-frame ()
  "Create a new frame with a new empty buffer."
  (interactive)
  (let ((buffer (generate-new-buffer "untitled")))
    (set-buffer-major-mode buffer)
    (display-buffer buffer '(display-buffer-pop-up-frame . nil))))
(global-set-key (kbd "C-c n") #'lunaryorn-new-buffer-frame)

;;open new untitled buffer in a new window
(defun new-buffer-window ()
  "Create a new frame with a new empty buffer."
  (interactive)
  (let ((buffer (generate-new-buffer "untitled")))
    (set-buffer-major-mode buffer)
    (display-buffer buffer '(display-buffer-pop-up-window . nil))))
(global-set-key (kbd "C-c w") #'new-buffer-window)


;; epresent: Simple presentation mode for emacs org-mode.


;; reveal.js to create presentation slides
;; Reveal.js is a framework for creating good-looking HTML presentations
;; Org-Reveal exports your Org documents to reveal.js presentations.
(use-package ox-reveal
  :ensure t
  :config
    (require 'ox-reveal)
    (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
    (setq org-reveal-mathjax t)
)


;; htmlize -> This package converts the buffer text and the associated decorations to HTML
(use-package htmlize
  :ensure t)

;;; init.el ends here
