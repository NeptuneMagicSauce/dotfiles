;; Undo
(global-set-key (kbd "C-u") 'undo)

;; Scrolling : Ctrl-up/down scroll 1 line
(global-set-key (kbd "C-<down>") 'scroll-up-line)
(global-set-key (kbd "C-<up>") 'scroll-down-line)

;; Change Window
(windmove-default-keybindings)

;; Paste (Yank) : use X11 buffer = selection-copy
(setq x-select-enable-primary t)

;; disable the menu bar
(menu-bar-mode -1)

;; disable the tool bar
(when (display-graphic-p) ; needed for WSL emacs-nox!
  (tool-bar-mode -1))

;; keyboard selection (mark) : invert colors
(set-face-attribute 'region nil :inverse-video t)

;; set modeline if not set not-minimum
(set-face-attribute 'mode-line nil
                    :foreground "black"
                    :background "#00BD00" ; Green
                    ;; :background "#ff9f00" ; DarkOrange
                    )

;; disable backups with ~ after filename
(setq make-backup-files nil)

(custom-set-variables
 '(inhibit-startup-screen t))
