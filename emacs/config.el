(set-face-attribute 'default nil
  :font "Hack Nerd Font"
  :height 120
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Hack Nerd Font"
  :height 120
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "Hack Nerd Font"
  :height 110
  :weight 'medium)

;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "Hack Nerd Font 18"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

;; dont show Emacs start screen
(setq inhibit-startup-message t)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(show-paren-mode 1)
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Bind C-s to save-buffer globally (outside Ivy)
(global-set-key (kbd "C-s") 'save-buffer)
(global-display-line-numbers-mode 1)       ; Show line numbers

;; disable line numbers for some modes
(dolist (mode '(
                ;org-mode-hook
                term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0)))
)

(when (display-graphic-p)
  (setq frame-background-mode 'dark) ; Assuming dark theme
  ;(load-theme 'modus-vivendi-tritanopia t) ; Or your preferred theme
  (set-face-attribute 'default nil :height 180)) ; set zoom to 170%
