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
;; DEPENDENCIES: none

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

        ;; PERSONAL INFORMATION
(setq user-full-name "Jonas Ingemarsson"
      user-mail-address "ingemarsson.jonas@me.com")

        ;; FONTS
(setq doom-font (font-spec :family "Ubuntu Mono" :size 15)              ;; Make sure to use a font that provides an italic face
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "Ubuntu Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

        ;; THEME
(setq doom-theme 'doom-dracula)         ;; Default theme is 'doom-one

        ;; LINE NUMBERS
(setq display-line-numbers-type t)

        ;; DEFAULT ORG LOCATION
(setq org-directory "~/org/")

        ;; ORG-AUTO-TANGLE
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

        ;; EMACS STARTUP WINDOW-SIZE
;; Uncomment to start maximized
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Uncomment to start fullscreen
;;(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

        ;; CURSOR LOCATION
(save-place-mode 1)

        ;; UI POP-UPS
(setq use-dialog-box nil)

        ;; REVERT BUFFERS
(global-auto-revert-mode 1)                     ;; revert buffers when the underlying file has changed
(setq global-auto-revert-non-file-buffers t)    ;; Revert Dired and other buffers

        ;; HIDE EMPHASIS-MARKERS
(setq org-hide-emphasis-markers t)

        ;; ENABLE HL-TODO-MODE GLOBALY
(define-globalized-minor-mode my-global-hl-todo-mode hl-todo-mode
(lambda () (hl-todo-mode 1)))
(my-global-hl-todo-mode 1)
