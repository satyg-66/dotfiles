;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;
;;
;;                        ,d
;;                        88
;; ,adPPYba, ,adPPYYba, MM88MMM 8b       d8  ,adPPYb,d8
;; I8[    "" ""     `Y8   88    `8b     d8' a8"    `Y88
;;  `"Y8ba,  ,adPPPPP88   88     `8b   d8'  8b       88
;; aa    ]8I 88,    ,88   88,     `8b,d8'   "8a,   ,d88
;; `"YbbdP"' `"8bbdP"Y8   "Y888     Y88'     `"YbbdP"Y8
;;                                  d8'      aa,    ,88
;;                                 d8'        "Y8bbdP"


;; AUTHOR: Jonas Ingemarsson
;; DESC: Main configuration for Doom-Emacs
;; WARNING: This config file will overrite other config files, use with caution!
;; DEPENDENCIES: JetBrainsMono font (https://www.jetbrains.com/lp/mono/)

        ;; PERSONAL INFORMATION
(setq user-full-name "Jonas Ingemarsson"
      user-mail-address "ingemarsson.jonas@me.com")

        ;; FONTS
(setq doom-font (font-spec :family "JetBrainsMono" :size 13)                                   ;; Make sure to use a font that provides an italic face
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 15)
      doom-big-font (font-spec :family "JetBrainsMono" :size 24))                              ;; Enable with SPC t b
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

        ;; THEME
(setq doom-theme 'doom-dracula)                                                                ;; Default theme is 'doom-one

        ;; LINE NUMBERS
(setq display-line-numbers-type t)

        ;; ORG-AUTO-TANGLE
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

        ;; ALL THE ICONS
(use-package all-the-icons)

        ;; EMACS STARTUP WINDOW-SIZE
(add-hook 'window-setup-hook 'toggle-frame-maximized t)                                        ;; uncomment to start maximized
;;(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)                                     ;; uncomment to start fullscreen

        ;; CURSOR LOCATION
(save-place-mode 1)

        ;; UI POP-UPS
(setq use-dialog-box nil)

        ;; REVERT BUFFERS
(global-auto-revert-mode 1)                                                                    ;; revert buffers when the underlying file has changed
(setq global-auto-revert-non-file-buffers t)                                                   ;; Revert Dired and other buffers

        ;; ORG MODE TWEAKS
(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-directory "~/org/"                                                                   ;; Setting default org directory
      org-hide-emphasis-markers t)                                                             ;; Hide emphasis-markers
(setq org-src-preserve-indentation nil
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)

        ;; ENABLE HL-TODO-MODE GLOBALY
(define-globalized-minor-mode my-global-hl-todo-mode hl-todo-mode
(lambda () (hl-todo-mode 1)))
(my-global-hl-todo-mode 1)

;; (setq fancy-splash-image (concat doom-private-dir "<filename>"))                            ;; uncomment and add path to image
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

        ;; SCROLLING
(setq scroll-conservatively 101)                                                               ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3)))                                            ;; how many lines at a time
(setq mouse-wheel-progressive-speed t)                                                         ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                                                             ;; scroll window under mouse
