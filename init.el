(
 custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
 '(display-battery-mode t)
 '(display-line-numbers-type (quote relative))
 '(display-time-mode t)
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   (quote
    (try helm-projectile projectile which-key use-package)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; my_settings
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
  (setq projectile-project-search-path '("/home/shivam/debouncing_throttling/"))
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
;;(use-package tabbar
;;  :ensure t
;;  :config
;;  (tabbar-mode 1)
;;
;;)

;; For powerful search

(use-package counsel
:ensure t
)

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

;;; init.el ends here