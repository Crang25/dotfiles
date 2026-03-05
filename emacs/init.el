(org-babel-load-file
  (expand-file-name
    "config.org"
    user-emacs-directory))


;; Initialize package source
;(require 'package)
;(setq package-archives '(
;                                 ("melpa" . "https://melpa.org/packages/")
;                                 ("org" . "https://orgmode.org/elpa/")
;                                 ("elpa" . "https://elpa.gnu.org/packages/")
;                                 )
;)

;(package-initialize)
;(unless package-archive-contents
;  (package-refresh-contents))
;
;(unless (package-installed-p 'use-package)
;  (package-install 'use-package))
;
;(require 'use-package)

;(setq use-package-always-ensure t)

(defvar elpaca-installer-version 0.10)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))


;; Install a package via the elpaca macro
;; See the "recipes" section of the manual for more details.

;(elpaca example-package)

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

;;When installing a package used in the init file itself,
;;e.g. a package which adds a use-package key word,
;;use the :wait recipe keyword to block until that package is installed/configured.
;;For example:
;;(use-package general :ensure (:wait t) :demand t)


(defun evil-hook ()
  (dolist (mode '(
                  custom-mode
                  eshell-mode
                  term-mode
                  ;git-rebase-mode
                  ;erc-mode
                  ;circle-server-mode
                  ;circle-chat-mode
                  ;circle-query-mode
                  ;sauron-mode
                  ))
    (add-to-list 'evil-emacs-state-modes mode)
    )
)

;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil
  :init ;; tweak evil's config before loading it
  (setq evil-want-integration t)     ; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)    ; Don't load keybindings separately
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-redo) ; This is important for proper undo/redo
  (setq evil-search-module 'evil-search) ; Use Evil's search module
  ;:hook (evil-mode . evil-hook)
  (evil-mode 1)
  :ensure t
  :demand t

  ;:config
  ;(evil-global-set-key 'motion "j" evil-next-visual-line)
)

(use-package evil-escape
  :after evil
  :ensure t
  :config
  (setq evil-escape-key-sequence "jk")  ; Use "jk" to escape use
  (setq evil-escape-delay 0.2)          ; Wait 0.2s for the second key
  (evil-escape-mode 1)
)

(use-package transient :ensure t)

(use-package magit
  :ensure t
  ;:custom
  ;(magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
)


(use-package evil-collection
    :after evil magit
    :config
    (setq evil-collection-mode-list '(dashboard dired ibuffer magit))
    (evil-collection-init)
    :ensure t
)

;; Better visual feedback
;(use-package evil-goggles
;  :after evil
;  :config
;  (evil-goggles-mode)
;  (setq evil-goggles-duration 0.100) ; Shorter animation duration
;  :ensure t)

;; Surround.vim-like functionality
;(use-package evil-surround
;  :after evil
;  :config
;  (global-evil-surround-mode 1)
;  :ensure t)

;; Commentary.vim-like functionality
;; (use-package evil-commentary
;;   :after evil
;;   :config
;;   (evil-commentary-mode)
;;   :ensure t)

(use-package general
    :after evil
    :config
    (general-evil-setup t)

    ;; set up 'SPC'(space) as the global leader key
    (general-create-definer leader-def
      :states '(normal insert visual emacs)
      :keymaps 'override
      :prefix "SPC"  ; Space as leader
      :global-prefix "C-SPC") ; Meta-Space to access leader in insert mode

    ;; leader+h clear highlights
    (leader-def
      "h" '(evil-ex-nohighlight :which-key "Clear highlights")
      "t" '(:ignore t :which-key "toggles")
      )

    ;; Normal mode mappings
    (general-nmap
      "<C-s>" 'save-buffer
      "<C-Up>" 'evil-window-decrease-height
      "<C-Down>" 'evil-window-increase-height
      "<C-Left>" 'evil-window-decrease-width
      "<C-Right>" 'evil-window-increase-width
      )

    ;; Basic editor settings matching your Neovim config
    (setq display-line-numbers-type 'relative) ; Relative line numbers
    (setq mouse-wheel-progressive-speed nil)   ; Better mouse scrolling
    (setq x-select-enable-clipboard t)         ; System clipboard integration
    (setq save-interprogram-paste-before-kill t)

    ;; Indentation
    (setq-default tab-width 2)
    (setq-default evil-shift-width 2)
    (setq-default indent-tabs-mode nil)        ; Use spaces instead of tabs
    (setq-default evil-auto-indent t)          ; Smart indentation

    ;; Visual enhancements
    (global-hl-line-mode 1)                    ; Highlight current line
    (setq search-ignore-case t)                ; Case-insensitive search
    (setq evil-ex-search-case 'smart)          ; Smart case for search
    (setq-default truncate-lines nil)          ; Enable line wrapping

    ;(leader-def
    ;  "b" '(:ignore t :wk "buffer")
    ;  "bb" '(switch-to-buffer :wk "Switch buffer")
    ;  "bk" '(kill-this-buffer :wk "Kill this buffer")
    ;  "bn" '(next-buffer :wk "Next buffer")
    ;  "bp" '(previous-buffer :wk "Previous buffer")
    ;  "br" '(revert-buffer :wk "Reload buffer")
    ;)

    :ensure t
)

(use-package hydra
  :after general
  :ensure t
  :config
  ;; Change text scale size
  (defhydra hydra-text-scale (:timeout 4)
    "scale text"
    ("j" text-scale-increase "in")
    ("k" text-scale-decrease "out")
    ("f" nil "finished" :exit t))
  
  ;; Swith between buffers
  (defhydra hydra-buffers (:timeout 4)
    "Buffers"
    ("b" counsel-switch-buffer "Switch buffer")
    ("k" kill-current-buffer "Kill buffer")
    ("n" next-buffer "Next buffer")
    ("p" previous-buffer "Previous buffer")
    ("f" nil "Exit" :exit t))
  
  ;; Resize evil's windows
  (defhydra hydra-window-resize (:timeout 4)
    "Resize Windows"
    ("h" evil-window-decrease-width "← Narrower")
    ("j" evil-window-increase-height "↓ Taller")
    ("k" evil-window-decrease-height "↑ Shorter")
    ("l" evil-window-increase-width "→ Wider")
    ("=" balance-windows "Balance")
    ("f" nil "Finish" :exit t))


  (defhydra hydra-files (:timeout 4)
    "Files"
    ("d" counsel-dired "Open Dired")
    ("f" counsel-find-file "Find file")
    ("r" counsel-recentf "Recent files")
    ("e" nil "Exit" :exit t))


  ;; Set hydra func maps
  (leader-def
    "b"   '(hydra-buffers/body :which-key "buffers")  ; <leader> b Show buffer swith toggle helper
    "f"   '(hydra-files/body :which-key "file operations") ; <leader> d Dired/file operation
    "ts"  '(hydra-text-scale/body :which-key "scale-text") ; <lead> ts inc/dec text scale size
    "w"   '(:ignore t :which-key "windows")  ; Group under <leader> w
    "w r" '(hydra-window-resize/body :which-key "resize-window")
    )
)


(use-package ivy
  ;:diminish
  :bind (("C-S-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)

         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))


(use-package counsel
  :bind (
         ("M-x" . counsel-M-x)
         ("C-x d" . counsel-dired)
         ;("C-x b" . counsel-ibuffer)
         ("C-x b" . counsel-switch-buffer)
         ("C-x C-b" . counsel-find-file)
         ;:map minibuffer-local-map
         ;("C-r" . 'counsel-minibuffer-history)
        )
  :config
  (setq ivy-initial-inputs-alist nil) ;; dont start searches with ^

  :ensure t
)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;(when (file-directory-p "~/projects")
  ;  (setq projectile-project-search-path '("~/projects" "~/.config")))
  ;(setq projectile-switch-project-action #'projectile-dired)
  (setq projectile-project-search-path '("~/projects/" "~/.config"))
  :ensure t
)

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode)
)


(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key)
)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  ;; How tall the mode-line should be. It's only respected in GUI.
  ;; If the actual char height is larger, it respects the actual height.
  (setq doom-modeline-height 35))


(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-dark-soft t)
)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))
 


;;Turns off elpaca-use-package-mode current declaration
;;Note this will cause evaluate the declaration immediately. It is not deferred.
;;Useful for configuring built-in emacs features.
(use-package emacs :ensure nil :config (setq ring-bell-function #'ignore))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("76ddb2e196c6ba8f380c23d169cf2c8f561fd2013ad54b987c516d3cabc00216"
     default))
 '(package-selected-packages nil)
 '(safe-local-variable-values '((projectile-project-run-cmd . "devbox shell"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
