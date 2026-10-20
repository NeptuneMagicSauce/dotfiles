;;  -*- lexical-binding: t -*-

;; undo
(global-set-key (kbd "C-u") 'undo)

;; scrolling : Ctrl-up/down scroll 1 line
(global-set-key (kbd "C-<down>") 'scroll-up-line)
(global-set-key (kbd "C-<up>") 'scroll-down-line)

;; goto-line
(global-set-key (kbd "M-g") 'goto-line)

;; change window
(windmove-default-keybindings)

;; paste (yank) : use X11 buffer = selection-copy
(setq x-select-enable-primary t)

;; disable the menu bar
(menu-bar-mode -1)

;; disable the tool bar
(when (display-graphic-p) (tool-bar-mode -1))

;; selection (mark) : invert colors
(custom-set-faces '(region ((t (:inverse-video t)))))

;; modeline
(set-face-attribute 'mode-line nil :foreground "#444444"
                    :background "#54AFFF") ; active buffer is light black on blue
(set-face-attribute 'mode-line-inactive nil :foreground "#888888"
                    :background "#D3D7CF") ; inactive buffer is light black on light white
(custom-set-faces '(mode-line-buffer-id ((t (
                                             ; filename is black
                                             :foreground "black" :weight normal :inherit nil)))))

;; disable backups with ~ after filename
(setq make-backup-files nil)

;; no startup screen
(custom-set-variables '(inhibit-startup-screen t))

;; mouse support in terminal
(unless (display-graphic-p)
  (xterm-mouse-mode t)
  (global-set-key [wheel-up] 'scroll-down-line)
  (global-set-key [wheel-down] 'scroll-up-line)
  )

;; theme
(load-theme 'tango-dark t)
