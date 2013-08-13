;; Tell emacs where is your personal elisp lib dir
;; this is default dir for extra packages
(add-to-list 'load-path "~/.emacs.d/")

;; Set up desktop
(setq desktop-path '("~/.emacs.d/"))
(desktop-save-mode 1)

;; Set up package archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; Configure auto completion
;;(require 'auto-complete)
;;(require 'auto-complete-config)
;;(add-to-list 'ac-modes 'LaTeX-mode)

;; Setting up TAGS
(setq tags-revert-without-query 1)

;; Setting up printing
(require 'printing)
(pr-update-menus)

;; Unique buffer names
(require 'uniquify)

;; Setting up autocomplete
;;(load "popup")

;; Frame commands
;;(load "frame-cmds")

;; For YAML mode
;;(require 'yaml-mode)
;;(add-to-list 'auto-mode-alist '("\\.yaml" . yaml-mode))

;; For taskjuggler files
;; Use perl-mode to edit taskjuggler files
;;(add-to-list 'auto-mode-alist '("\\.tjp\\'" . perl-mode))

;; For octave
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; Turn on auto-fill for octave
(add-hook 'octave-mode-hook
	  (lambda ()
	    (abbrev-mode 1)
	    (auto-fill-mode 1)
	    (if (eq window-system 'x)
		(font-lock-mode 1))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(desktop-save-mode t)
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/tasks.org")))
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
