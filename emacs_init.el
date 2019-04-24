;====================Loading path====================
(package-initialize)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))


;==========================System auto-settings====================

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "PDF Tools")
     (output-html "xdg-open"))))
 '(global-linum-mode nil)
 '(package-selected-packages
   (quote
    (magit nlinum pdf-tools yasnippet-snippets exwm company-shell company-reftex common-lisp-snippets company-irony-c-headers company-irony company-dict company-c-headers company-bibtex company-auctex company-math company use-package bind-key rainbow-delimiters doom-themes org-bullets sr-speedbar yasnippet auctex)))
 '(reftex-external-file-finders
   (quote
    (("tex" . "kpsewhich -format=.tex %f")
     ("bib" . "kpsewhich -format=.bib %f"))))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;===========================Customize settings ====================

;(desktop-save-mode 1) ;自动打开上次文件
(setq inhibit-startup-message t);关闭启动画面
;(setq global-linum-mode t); 左侧边栏显示行号
;(setq column-number-mode t);显示行列号
;(setq line-number-mode t)
(setq paren-mode t);括号匹配
;(setq show-paren-style 'parentheses);括号匹配风格
(display-time-mode t);显示时间
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)	
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill);Auctex-mode 自动换行
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTex-mode-hook  (lambda () (linum-mode t)))
 	
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

;(set-default-font "DejaVu Sans Mono Book 11")
(set-default-font "Inconsolata 12")
;(set-default-font "Monaco 12")
;(set-default-font "Consolas 12")


;==========================YASnippet=========================
(require 'yasnippet)
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

;======================= Sr_Speed_bar========================

(require 'sr-speedbar)
(setq speedbar-use-images nil)

(setq sr-speedbar-open t)
;(setq sr-speedbar-default-width t)
;(setq sr-speedbar-window t)

;(with-current-buffer sr-speedbar-buffer-name
;  (setq window-size-fixed 'width))
;======================= Org-mode ===========================

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(global-set-key "\C-ca" 'org-agenda)


;========================== Moe-Theme=============================

;(require 'powerline)
;(require 'moe-theme)

;(load-theme 'moe-light t)

;(load-theme 'moe-dark t)
;(powerline-moe-theme)

;====================Doom-Theme ====================

(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each
;; theme may have their own settings.
(load-theme 'doom-one t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme
(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;==========================Rainbow-delimiters====================
; This mode is to color parenthesis w.r.t its depth
(add-hook 'latex-mode-hook #'rainbow-delimiters-mode)
(add-hook 'c++-mode-hook #'rainbow-delimiters-mode)

;====================GDB=====================

(setq gdb-many-windows t)
(setq gdb-show-main t)

;=======================COMPANY MODE=====================
(require 'use-package)
(use-package company
	     :ensure t
	     :config
	     (setq company-idle-delay 0.35)
	     (setq company-minimum-prefix-length 2))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))
 
(use-package company-irony
	     :ensure t
	     :config
	     (require 'company)
	     (add-to-list 'company-backend 'company-irony))

(use-package irony
	     :ensure t
	     :config
	     (add-hook 'c++-mode-hook 'irony-mode)
	     (add-hook 'c-mode-hook 'irony-mode)
	     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(add-hook 'after-init-hook 'global-company-mode)
(require 'company-auctex)
(company-auctex-init)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "SPC") #'company-complete-selection))

;========================== EXWM ==========================

;(require 'exwm)
;(require 'exwm-config)
;(exwm-config-default)

					;========================CUA===============
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;=====================PDF-tools ===================
(pdf-tools-install)
;(setq auto-revert-interval 0.5)
;(setq auto-revert-verbose nil)
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;=============================nlinum mode========================

(defun my-nlinum-mode-hook ()
  (when nlinum-mode
    (setq-local nlinum-format
                (concat "%" (number-to-string
                             ;; Guesstimate number of buffer lines.
                             (ceiling (log (max 1 (/ (buffer-size) 80)) 10)))
                        "d"))))
(add-hook 'nlinum-mode-hook 'my-nlinum-mode-hook)



;================================Some mode hook==================
(add-hook 'LaTex-mode-hook 'nlinum-mode)
(add-hook 'c++-mode-hook 'nlinum-mode)
(add-hook 'c++-mode-hook #'hs-minor-mode)
(add-hook 'c++-mode-hook #'electric-pair-mode)

