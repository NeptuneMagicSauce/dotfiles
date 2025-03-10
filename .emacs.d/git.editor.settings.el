(load-file "~/.emacs.d/min-settings.el")

(defun save-buffer-and-quit ()
  (interactive)
  (save-buffer)
  (kill-emacs))

(bind-key* "C-x C-c" 'save-buffer-and-quit)
