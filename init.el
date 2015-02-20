;;; package --- Summary
;;; Commentary:
;;; code:
(when (>= emacs-major-version 24)
(require 'package)
 (package-initialize)
 (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
 )

;;(setq column-number-mode t)
;;(setq line-number-mode t)
(require 'hlinum)
(hlinum-activate)
(global-linum-mode t)

(setq inhibit-startup-message t)
;;(display-time-mode 1)
;;(setq display-time-24hr-format t)

(global-set-key (kbd "C-j") 'goto-line)

(fset 'yes-or-no-p 'y-or-n-p)

(require 'xcscope)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: volatile-highlights          ;;
;;                                       ;;
;; GROUP: Editing -> Volatile Highlights ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'volatile-highlights)
(volatile-highlights-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: yasnippet                 ;;
;;                                    ;;
;; GROUP: Editing -> Yasnippet        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'yasnippet)
(yas-global-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; projectile is for project management
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;;helm is interactive framework
(require 'helm)
(require 'helm-config)
;; for speeding find
(setq projectile-enable-caching t)
;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

;;ctags
(require 'ctags)
(setq tags-revert-without-query t)				   
(global-set-key (kbd "<f7>") 'ctags-create-or-update-tags-table)
(global-set-key (kbd "M-.")  'ctags-search)

;; numbering windows and you can M-1/2/3... to switch
(require 'window-numbering)
(window-numbering-mode 1)
;;(setq window-numbering-assign-func
;;      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))

;; vim mode in emacs
(require 'evil)
(evil-mode 1)

(package-initialize)
(smartparens-global-mode t)

;;smex shows history M-x command
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;flycheck will do syntax check
(add-hook 'after-init-hook #'global-flycheck-mode)

;;company will autocomplete
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;;ws-butler+clean-aindent-mode+dtrt-indent can trim whitespace of line
;; Package: ws-butler
(require 'ws-butler)
(add-hook 'c-mode-common-hook 'ws-butler-mode)

;; Package: clean-aindent-mode
(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

;; Package: dtrt-indent
(require 'dtrt-indent)
(dtrt-indent-mode 1)

(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

(add-hook 'c-mode-common-hook   'hs-minor-mode)

;; show function args description
(require 'function-args)
(fa-config-default)

;; autocomplete with company using semantic instead of clang
(require 'cc-mode)
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)

;;(setq-local imenu-create-index-function #'ggtags-build-imenu-index)
;;(semantic-add-system-include "/home/ywolf/workspace/ctags-5.8")

;;(require 'ggtags)
;;(add-hook 'c-mode-common-hook
;;          (lambda ()
;;            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;             (ggtags-mode 1))))

(require 'helm-gtags)
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: dired+                     ;;
;;                                     ;;
;; GROUP: Files -> Dired -> Dired Plus ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'dired+)

;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: ztree  ;;
;;                 ;;
;; GROUP: No group ;;
;;;;;;;;;;;;;;;;;;;;;
;; since ztree works with files and directories, let's consider it in
;; group Files
(require 'ztree-diff)
(require 'ztree-dir)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: expand-region                       ;;
;;                                              ;;
;; GROUP: Convenience -> Abbreviation -> Expand ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'expand-region)
(global-set-key (kbd "M-m") 'er/expand-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: diff-hl                             ;;
;;                                              ;;
;; GROUP: Programming -> Tools -> Vc -> Diff Hl ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(global-diff-hl-mode)
;;(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: nyan-mode                    ;;
;;                                       ;;
;; GROUOP: Environment -> Frames -> Nyan ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; only turn on if a window system is available
;; this prevents error under terminal that does not support X
(case window-system
  ((x w32) (nyan-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: highlight-numbers         ;;
;;                                    ;;
;; GROUP: Faces -> Number Font Lock   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: highlight-paren-mode      ;;
;;                                    ;;
;; GROUP: Faces -> Number Font Lock   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'highlight-parentheses)
(add-hook 'prog-mode-hook 'highlight-parentheses-mode)

(require 'highlight-symbol)

(highlight-symbol-nav-mode)
(setq highlight-symbol-idle-delay 0.2
      highlight-symbol-on-navigation-p t)
(add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
(add-hook 'org-mode-hook (lambda () (highlight-symbol-mode)))

;; Browse source tree(such as tags in file) like windows manager in vim
(require 'sr-speedbar)
(setq sr-speedbar-width 30)  
(setq sr-speedbar-right-side nil)

;; save current session info
(require 'workgroups2)
(workgroups-mode 1)  ; put this one at the bottom of .emacs
;;; init.el ends here
