;; Font size of system
(defvar gunner/default-font-size 120)
(defvar gunner/default-variable-font-size 120)

;; Make frame transparency overridable
(defvar gunner/frame-transparency '(100 . 100))

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun gunner/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))
;; (defun gunner/eshell-at-startup()
;;   (eshell))
(add-hook 'emacs-startup-hook #'gunner/display-startup-time)
;; (add-hook 'emacs-startup-hook #'gunner/eshell-at-startup)
(add-hook 'html-mode-hook #'(lambda nil (setq sgml-xml-mode t)))

;; Initialize package sources
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(setq package-enable-at-startup nil)

(straight-use-package 'use-package)
(straight-use-package 'vertico)
(straight-use-package 'consult)
(straight-use-package 'marginalia)
(straight-use-package 'evil)
(straight-use-package 'openwith)
(straight-use-package 'orderless)
(straight-use-package 'savehist)
(straight-use-package 'which-key)
(straight-use-package 'all-the-icons)
(straight-use-package 'all-the-icons-completion)
(straight-use-package 'doom-modeline)
(straight-use-package 'doom-themes)
(straight-use-package 'modus-themes)
(straight-use-package 'embark)
(straight-use-package 'embark-consult)
(straight-use-package 'undo-tree)
(straight-use-package 'helpful)
(straight-use-package 'hydra)
(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-treemacs)
(straight-use-package 'dap-mode)
(straight-use-package 'pyvenv)
(straight-use-package 'django-mode)
(straight-use-package 'django-snippets)
(straight-use-package 'lsp-pyright)
(straight-use-package 'omnisharp-mode)
(straight-use-package 'omnisharp)
(straight-use-package 'company)
(straight-use-package 'company-box)
(straight-use-package 'projectile)
(straight-use-package 'consult-projectile)
(straight-use-package 'magit)
(straight-use-package 'forge)
(straight-use-package 'emmet-mode)
(straight-use-package 'skewer-mode)
(straight-use-package 'impatient-mode)
(straight-use-package 'minions)
(straight-use-package 'diminish)
(straight-use-package 'winum)
(straight-use-package 'yasnippet-snippets)
(straight-use-package 'dabbrev)
(straight-use-package 'ripgrep)
(straight-use-package 'rg)
(straight-use-package 'dart-mode)
(straight-use-package 'lsp-dart)
(straight-use-package 'projectile-ripgrep)
(straight-use-package 'htmlize)

;; (server-start)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar

(global-undo-tree-mode)      ; Enable undo tree mode

;; Set up the visible bell
(setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)

;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha gunner/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,gunner/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                vterm-mode-hook
                mu4e-mode-hook
                nov-mode-hook
                elfeed-show-mode-hook
                elfeed-search-mode-hook
                telega-chat-mode-hook
                telega-root-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq display-line-numbers-type 'relative)
(setenv "PATH" (concat (getenv "PATH") ":/home/ural/.local/bin"))

;; (add-hook 'eshell-mode-hook 'eshell-mode-hook-func)

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
                                        ;(setq user-emacs-directory "~/.cache/emacs")

;; keep customization in temporary folder
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))

(setq custom-file
      (if (boundp 'server-socket-dir)
          (expand-file-name "custom.el" server-socket-dir)
        (expand-file-name (format "emacs-custom-%s.el" (user-uid)) temporary-file-directory)))
(load custom-file t)
(use-package no-littering
  :straight t)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(set-face-attribute 'default nil :font "Hack" :height gunner/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Hack" :height gunner/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height gunner/default-variable-font-size :weight 'regular)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-e") 'move-end-of-line)


(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq forge-add-default-bindings nil)
  ;;(evil-set-undo-system 'undo-tree)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  ;; (define-key evil-insert-state-map (kbd "C-f") 'evil-forward-char)
  ;; (define-key evil-insert-state-map (kbd "C-b") 'evil-backward-char)
  (define-key evil-insert-state-map (kbd "C-a") 'evil-beginning-of-line)
  ;; (define-key evil-insert-state-map (kbd "C-e") 'evil-end-of-line)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(defun vi-open-line-above ()
  "Insert a newline above the current line and put point at beginning."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(defun vi-open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

(defun vi-open-line (&optional abovep)
  "Insert a newline below the current line and put point at beginning.
  With a prefix argument, insert a newline above the current line."
  (interactive "P")
  (if abovep
      (vi-open-line-above)
    (vi-open-line-below)))

(define-key global-map (kbd "C-c o") 'vi-open-line-below)
(define-key global-map (kbd "C-c O") 'vi-open-line-above)

(use-package evil-surround
  :straight t
  :config
  (global-evil-surround-mode 1))

(use-package evil-replace-with-register
  :config
  (setq evil-replace-with-register-key (kbd "gr"))
  (evil-replace-with-register-install)
  )

(use-package general
  :after evil
  :config
  (general-create-definer gunner/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "M-SPC")

  (gunner/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tl" '(consult-theme :which-key "choose theme")
    "td" '(disable-theme :which-key "disable existing theme")
    "fde" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/Emacs.org")))))

;; (use-package doom-themes
;;   :straight t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   ;; (load-theme 'doom-gruvbox t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))

(use-package modus-themes
  :ensure
  :defer 0
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-mixed-fonts nil
        modus-themes-subtle-line-numbers nil
        modus-themes-intense-mouseovers nil
        modus-themes-deuteranopia nil
        modus-themes-tabs-accented nil
        modus-themes-variable-pitch-ui nil
        modus-themes-inhibit-reload t ; only applies to `customize-set-variable' and related

        modus-themes-fringes nil ; {nil,'subtle,'intense}

        ;; Options for `modus-themes-lang-checkers' are either nil (the
        ;; default), or a list of properties that may include any of those
        ;; symbols: `straight-underline', `text-also', `background',
        ;; `intense' OR `faint'.
        modus-themes-lang-checkers nil

        ;; Options for `modus-themes-mode-line' are either nil, or a list
        ;; that can combine any of `3d' OR `moody', `borderless',
        ;; `accented', a natural number for extra padding (or a cons cell
        ;; of padding and NATNUM), and a floating point for the height of
        ;; the text relative to the base font size (or a cons cell of
        ;; height and FLOAT)
        modus-themes-mode-line nil

        ;; Options for `modus-themes-markup' are either nil, or a list
        ;; that can combine any of `bold', `italic', `background',
        ;; `intense'.
        modus-themes-markup nil

        ;; Options for `modus-themes-syntax' are either nil (the default),
        ;; or a list of properties that may include any of those symbols:
        ;; `faint', `yellow-comments', `green-strings', `alt-syntax'
        modus-themes-syntax nil

        ;; Options for `modus-themes-hl-line' are either nil (the default),
        ;; or a list of properties that may include any of those symbols:
        ;; `accented', `underline', `intense'
        modus-themes-hl-line '(intense)

        ;; Options for `modus-themes-paren-match' are either nil (the
        ;; default), or a list of properties that may include any of those
        ;; symbols: `bold', `intense', `underline'
        modus-themes-paren-match nil

        ;; Options for `modus-themes-links' are either nil (the default),
        ;; or a list of properties that may include any of those symbols:
        ;; `neutral-underline' OR `no-underline', `faint' OR `no-color',
        ;; `bold', `italic', `background'
        modus-themes-links nil

        ;; Options for `modus-themes-box-buttons' are either nil (the
        ;; default), or a list that can combine any of `flat',
        ;; `accented', `faint', `variable-pitch', `underline',
        ;; `all-buttons', the symbol of any font weight as listed in
        ;; `modus-themes-weights', and a floating point number
        ;; (e.g. 0.9) for the height of the button's text.
        modus-themes-box-buttons '(all-buttons variable-pitch (height 0.9) flat faint accented)

        ;; Options for `modus-themes-prompts' are either nil (the
        ;; default), or a list of properties that may include any of those
        ;; symbols: `background', `bold', `gray', `intense', `italic'
        modus-themes-prompts '(background subtle)

        ;; The `modus-themes-completions' is an alist that reads three
        ;; keys: `matches', `selection', `popup'.  Each accepts a nil
        ;; value (or empty list) or a list of properties that can include
        ;; any of the following (for WEIGHT read further below):
        ;;
        ;; `matches' - `background', `intense', `underline', `italic', WEIGHT
        ;; `selection' - `accented', `intense', `underline', `italic', `text-also', WEIGHT
        ;; `popup' - same as `selected'
        ;; `t' - applies to any key not explicitly referenced (check docs)
        ;;
        ;; WEIGHT is a symbol such as `semibold', `light', or anything
        ;; covered in `modus-themes-weights'.  Bold is used in the absence
        ;; of an explicit WEIGHT.
        modus-themes-completions
        '((matches . (extrabold background))
          (selection . (semibold intense accented text-also))
          (popup . (accented intense)))

        modus-themes-mail-citations nil ; {nil,'intense,'faint,'monochrome}

        ;; Options for `modus-themes-region' are either nil (the default),
        ;; or a list of properties that may include any of those symbols:
        ;; `no-extend', `bg-only', `accented'
        modus-themes-region '(no-extend)

        ;; Options for `modus-themes-diffs': nil, 'desaturated, 'bg-only
        modus-themes-diffs nil

        modus-themes-org-blocks 'grayscale ; {nil,'gray-background,'tinted-background}

        modus-themes-org-agenda ; this is an alist: read the manual or its doc string
        '((header-block . (variable-pitch regular 1.4))
          (header-date . (bold-today grayscale underline-today 1.2))
          (event . (accented italic varied))
          (scheduled . uniform)
          (habit . nil))

        modus-themes-headings ; this is an alist: read the manual or its doc string
        '((1. (background overline))
          (t . (variable-pitch bold)))

        ;; Sample for headings:

        ;;       modus-themes-headings
        ;;       '((1 . (background overline variable-pitch 1))
        ;;         (2 . (overline rainbow 0.6))
        ;;         (3 . (overline 0.5))
        ;;         (t . (monochrome)))
        )

  ;; ;; Load the theme files before enabling a theme
  (modus-themes-load-themes)
  :bind ("<f5>" . modus-themes-toggle)
  :config
  ;; Load the theme of your choice:

  (defun load-material-theme (frame)
    (select-frame frame)
    (modus-themes-load-vivendi))

  (if (daemonp)
      (add-hook 'after-make-frame-functions #'load-material-theme)
    (modus-themes-load-vivendi)))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame frame)
            (unless (display-graphic-p)
              (set-face-background 'default "unspecified-bg" (selected-frame)))))

;; Make Elisp files in that directory available to the user.
(add-to-list 'load-path "~/.emacs.d/manual-packages/pulsar")
(require 'pulsar)

;; (pulsar-setup)

(customize-set-variable
 'pulsar-pulse-functions ; Read the doc string for why not `setq'
 '(recenter-top-bottom
   move-to-window-line-top-bottom
   reposition-window
   bookmark-jump
   other-window
   delete-window
   delete-other-windows
   forward-page
   backward-page
   scroll-up-command
   scroll-down-command
   evil-scroll-up
   evil-scroll-down
   windmove-right
   windmove-left
   windmove-up
   windmove-down
   windmove-swap-states-right
   windmove-swap-states-left
   windmove-swap-states-up
   windmove-swap-states-down
   tab-new
   tab-close
   tab-next
   org-next-visible-heading
   org-previous-visible-heading
   org-forward-heading-same-level
   org-backward-heading-same-level
   outline-backward-same-level
   outline-forward-same-level
   outline-next-visible-heading
   outline-previous-visible-heading
   outline-up-heading))

(setq pulsar-pulse t)
(setq pulsar-delay 0.055)
(setq pulsar-iterations 10)
(setq pulsar-face 'pulsar-magenta)
(setq pulsar-highlight-face 'pulsar-yellow)

;; pulsar does not define any key bindings.  This is just a sample that
;; respects the key binding conventions.  Evaluate:
;;
;;     (info "(elisp) Key Binding Conventions")
;;
;; The author uses C-x l for `pulsar-pulse-line' and C-x L for
;; `pulsar-highlight-line'.
(let ((map global-map))
  (define-key map (kbd "C-c  h p") #'pulsar-pulse-line)
  (define-key map (kbd "C-c  h h") #'pulsar-highlight-line))

(use-package all-the-icons)
(use-package minions
  :hook (doom-modeline-mode . minions-mode))
(use-package diminish)
(use-package doom-modeline
  :init (doom-modeline-mode nil)
  :hook (after-init . doom-modeline-init)
  :custom-face
  (mode-line ((t (:height 0.85))))
  (mode-line-inactive ((t (:height 0.85))))
  :custom 
  (doom-modeline-height 15)
  (doom-modeline-bar-width 6)
  (doom-modeline-lsp t)
  ;; (doom-modeline-github nil)
  ;; (doom-modeline-mu4e nil)
  ;; (doom-modeline-irc nil)
  (doom-modeline-minor-modes t)
  (doom-modeline-persp-name nil)
  (doom-modeline-buffer-file-name-style 'truncate-except-project)
  (doom-modeline-major-mode-icon nil))

(defun gunner/minibuffer-backward-kill (arg)
  "When minibuffer is completing a file name delete up to parent
folder, otherwise delete a character backward"
  (interactive "p")
  (if minibuffer-completing-file-name
      ;; Borrowed from https://github.com/raxod502/selectrum/issues/498#issuecomment-803283608
      (if (string-match-p "/." (minibuffer-contents))
          (zap-up-to-char (- arg) ?/)
        (delete-minibuffer-contents))
    (delete-backward-char arg)))

(use-package vertico
  :init
  (vertico-mode)
  :bind (:map minibuffer-local-map
              ("<backspace>" . gunner/minibuffer-backward-kill))
  :custom
  (vertico-cycle t)
  (vertico-resize t)
  :config
  (with-eval-after-load 'evil
    (define-key vertico-map (kbd "M-TAB") 'vertico-exit-input)
    (define-key vertico-map (kbd "C-j") 'vertico-next)
    (define-key vertico-map (kbd "C-k") 'vertico-previous)
    (define-key vertico-map (kbd "M-h") 'vertico-directory-up))
  )

;;; Orderless
(use-package orderless
  :init
  (setq completion-styles '(orderless partial-completion)
        orderless-smart-case t
        completion-category-overrides nil
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))


  ;;; Savehist
(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :init
  (marginalia-mode)
  :custom
  (marginalia-align 'right)
  :config
  (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  )


;; All-the-icon-completion
(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))

(defun gunner/get-project-root()
  (when (fboundp 'projectile-project-root)
    (projectile-projecct-root)))

(use-package consult
  :bind
  (("C-M-j" . consult-buffer)
   ("C-M-k" . consult-imenu)
   ("C-s" . consult-line)
   :map minibuffer-local-map
   ("C-r" . consult-history))
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :custom
  (consult-project-root-function #'gunner/get-project-root)
  (completion-in-region-function #'consult-completion-in-region)
  )

(use-package embark
  :straight t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C->" . embark-act)
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command))

;;Embark Which Key indicator

(defun embark-which-key-indicator ()
  "An embark indicator that displays keymaps using which-key.
The which-key help message will show the type and value of the
current target followed by an ellipsis if there are further
targets."
  (lambda (&optional keymap targets prefix)
    (if (null keymap)
        (which-key--hide-popup-ignore-command)
      (which-key--show-keymap
       (if (eq (plist-get (car targets) :type) 'embark-become)
           "Become"
         (format "Act on %s '%s'%s"
                 (plist-get (car targets) :type)
                 (embark--truncate-target (plist-get (car targets) :target))
                 (if (cdr targets) "…" "")))
       (if prefix
           (pcase (lookup-key keymap prefix 'accept-default)
             ((and (pred keymapp) km) km)
             (_ (key-binding prefix 'accept-default)))
         keymap)
       nil nil t (lambda (binding)
                   (not (string-suffix-p "-argument" (cdr binding))))))))

(setq embark-indicators
      '(embark-which-key-indicator
        embark-highlight-indicator
        embark-isearch-highlight-indicator))

(defun embark-hide-which-key-indicator (fn &rest args)
  "Hide the which-key indicator immediately when using the completing-read prompter."
  (which-key--hide-popup-ignore-command)
  (let ((embark-indicators
         (remq #'embark-which-key-indicator embark-indicators)))
    (apply fn args)))

(advice-add #'embark-completing-read-prompter
            :around #'embark-hide-which-key-indicator)

(use-package which-key
  :init
  (setq which-key-use-C-h-commands nil) ;; disable C-h which key help
  :defer 0
  :config
  (define-key which-key-mode-map (kbd "C-x <f5>") 'which-key-C-h-dispatch) ;;  remaped C-h to f5
  (which-key-mode)
  (setq which-key-idle-delay 1))

(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h F") #'helpful-function)
(global-set-key (kbd "C-c C-d") #'helpful-at-point)
(global-set-key (kbd "C-h C") #'helpful-command)

(use-package transpose-frame
  :defer t)

(use-package emojify
  :hook (erc-mode . emojify-mode)
  :commands emojify-mode
  :straight t
  :config
  )

(use-package hydra
  :defer t)

(defhydra hydra-windows-nav (:color red)
  ("s" shrink-window-horizontally "shrink horizontally" :column "Sizing")
  ("d" evil-window-decrease-height "shrink vertically")
  ("e" enlarge-window-horizontally "enlarge horizontally")
  ("a" evil-window-increase-height "enlarge vertically")
  ("b" balance-windows "balance window height")
  ("m" maximize-window "maximize current window")
  ("M" minimize-window "minimize current window")

  ("H" split-window-below "split horizontally" :column "Split management")
  ("v" split-window-right "split vertically")
  ("c" delete-window "delete current window")
  ("o" delete-other-windows "delete-other-windows")

  ("z" ace-window "ace window" :color blue :column "Navigation")
  ("h" windmove-left "← window")
  ("j" windmove-down "↓ window")
  ("k" windmove-up "↑ window")
  ("l" windmove-right "→ window")

  ("B" transpose-frame "transpose-frame" :column "Transpose")
  ("V" flip-frame "Flip verticaly")
  ("F" flop-frame "Flip horizontally")
  ("S" rotate-frame "Rotate 180 degrees")
  ("U" rotate-frame-clockwise "Rotate 90 degrees clockwise")
  ("P" rotate-frame-anticlockwise "Rotate 90 degrees ant-clockwise")

  ("u" winner-undo "Winner undo" :column "Windmove")
  ("r" winner-redo "Winner redo")
  ("q" nil "quit menu" :color blue :column nil))

(gunner/leader-keys
  "w" '(hydra-windows-nav/body :which-key "Windows Navigation"))

(defhydra hydra-scale-text (:color red)
  ("j" text-scale-increase "increase" :column "Text Scale")
  ("k" text-scale-decrease "decrease")
  ("q" nil "quit menu" :color blue :column nil))

(gunner/leader-keys
  "s" '(hydra-scale-text/body :which-key "Text Scaling"))

;; frame step forward
(with-eval-after-load 'mpv
  (defun mpv-frame-step ()
    "Step one frame forward."
    (interactive)
    (mpv--enqueue '("frame-step") #'ignore)))


;; frame step backward
(with-eval-after-load 'mpv
  (defun mpv-frame-back-step ()
    "Step one frame backward."
    (interactive)
    (mpv--enqueue '("frame-back-step") #'ignore)))


;; mpv take a screenshot
(with-eval-after-load 'mpv
  (defun mpv-screenshot ()
    "Take a screenshot"
    (interactive)
    (mpv--enqueue '("screenshot") #'ignore)))


;; mpv show osd
(with-eval-after-load 'mpv
  (defun mpv-osd ()
    "Show the osd"
    (interactive)
    (mpv--enqueue '("set_property" "osd-level" "3") #'ignore)))


;; add a newline in the current document
(defun end-of-line-and-indented-new-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))


;; hydra --------------------------------------------------------------------------------------------------

(defhydra hydra-mpv (:color red)
  ("h" mpv-seek-backward "seek back -5" :column "Seek")
  ("j" mpv-seek-backward "seek back -60")
  ("k" mpv-seek-forward "seek forward 60")
  ("l" mpv-seek-forward "seek forward 5")
  ("," mpv-frame-back-step "back frame" :column "Actions")
  ("." mpv-frame-step "forward frame")
  ("SPC" mpv-pause "pause")
  ("q" mpv-kill "quit mpv")
  ("p" mpv-play "play")
  ("s" mpv-screenshot "Screenshots" :column "General")
  ("i" my/mpv-insert-playback-position "insert playback position")
  ("o" mpv-osd "show the osd")
  ("n" end-of-line-and-indented-new-line "insert a newline")
  ("|" nil "quit menu" :color blue :column nil)
  )


(gunner/leader-keys
  "m" '(hydra-mpv/body :which-key "Mpv control"))

(defun gunner/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :straight t
  :commands (org-capture org-agenda)
  :hook (org-mode . gunner/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/Dropbox/OrgFiles/Tasks.org"
          "~/Dropbox/OrgFiles/Habits.org"
          "~/Dropbox/OrgFiles/Birthdays.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
        '(("Archive.org" :maxlevel . 1)
          ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
        '((:startgroup)
                                        ; Put mutually exclusive tags here
          (:endgroup)
          ("@errand" . ?E)
          ("@home" . ?H)
          ("@work" . ?W)
          ("agenda" . ?a)
          ("planning" . ?p)
          ("publish" . ?P)
          ("batch" . ?b)
          ("note" . ?n)
          ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))
            (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

          ("n" "Next Tasks"
           ((todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))))

          ("W" "Work Tasks" tags-todo "+work-email")

          ;; Low-effort next actions
          ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
           ((org-agenda-overriding-header "Low Effort Tasks")
            (org-agenda-max-todos 20)
            (org-agenda-files org-agenda-files)))

          ("w" "Workflow Status"
           ((todo "WAIT"
                  ((org-agenda-overriding-header "Waiting on External")
                   (org-agenda-files org-agenda-files)))
            (todo "REVIEW"
                  ((org-agenda-overriding-header "In Review")
                   (org-agenda-files org-agenda-files)))
            (todo "PLAN"
                  ((org-agenda-overriding-header "In Planning")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "BACKLOG"
                  ((org-agenda-overriding-header "Project Backlog")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "READY"
                  ((org-agenda-overriding-header "Ready for Work")
                   (org-agenda-files org-agenda-files)))
            (todo "ACTIVE"
                  ((org-agenda-overriding-header "Active Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "COMPLETED"
                  ((org-agenda-overriding-header "Completed Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "CANC"
                  ((org-agenda-overriding-header "Cancelled Projects")
                   (org-agenda-files org-agenda-files)))))))

  (define-key global-map "\C-cc" 'org-capture)
  (setq org-capture-templates
        `(("t" "Tasks / Projects")
          ("tt" "Task" entry (file+olp "~/.emacs.d/OrgFiles/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

          ("r" "Randmon")
          ("rn" "Notes" entry
           (file+olp+datetree "~/Dropbox/OrgFiles/Notes.org")
           "\n* %<%I:%M %p> - Notes :notes:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)
          ("rq" "Questions" entry
           (file+olp+datetree "~/Dropbox/OrgFiles/Questions.org")
           "\n* %<%I:%M %p> - Questions:questions:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)
          ("rw" "Words" entry (file+olp "~/Dropbox/OrgFiles/Words.org")
           "* %?\n  %U\n  %a\n  %i" :empty-lines 1)

          ("j" "Journal Entries")
          ("jj" "Journal" entry
           (file+olp+datetree "~/Dropbox/OrgFiles/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
          ("jm" "Meeting" entry
           (file+olp+datetree "~/Dropbox/OrgFiles/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

          ("w" "Workflows")
          ("we" "Checking Email" entry (file+olp+datetree "~/Dropbox/OrgFiles/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

          ("m" "Metrics Capture")
          ("mw" "Weight" table-line (file+headline "~/Dropbox/OrgFiles/Metrics.org" "Weight")
           "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj")))

  (gunner/org-font-setup))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun gunner/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . gunner/org-mode-visual-fill))

(defun gunner/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("cl" . "src c"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

;; Automatically tangle our Emacs.org config file when we save it
(defun gunner/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'gunner/org-babel-tangle-config)))

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "import" nil nil nil filename)
  (insert (concat "[[" filename "]]"))
  (org-display-inline-images))

(use-package org-download
  :hook (dired-mode-hook . org-download-enable))

(use-package org-pomodoro
  :straight t
  :commands (org-pomodoro)
  :config
  (setq
   org-pomodoro-length 25
   org-pomodoro-short-break-length 5
   org-pomodoro-start-sound-p nil
   org-pomodoro-finished-sound-p nil
   org-pomodoro-clock-break t)
  (setq alert-user-configuration (quote ((((:category . "org-pomodoro")) libnotify nil)))))

(use-package evil-org
  :straight t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-roam
  :straight t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Documents/RoamNotes")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  (org-roam-setup))

(use-package org-tree-slide
  :custom (org-image-actual-width nil))

(use-package hide-mode-line)

(defun gunner/presentation-setup ()
  ;; Hide the mode line
  (hide-mode-line-mode 1)

  ;; Display images inline
  (org-display-inline-images) ;; Can also use org-startup-with-inline-images

  ;; Scale the text.  The next line is for basic scaling:
  (setq text-scale-mode-amount 3)
  (text-scale-mode 1))

;; This option is more advanced, allows you to scale other faces too
;; (setq-local face-remapping-alist '((default (:height 2.0) variable-pitch)
;;                                    (org-verbatim (:height 1.75) org-verbatim)
;;                                    (org-block (:height 1.25) org-block))))

(defun gunner/presentation-end ()
  ;; Show the mode line again
  (hide-mode-line-mode 0)

  ;; Turn off text scale mode (or use the next line if you didn't use text-scale-mode)
  ;; (text-scale-mode 0)

  ;; If you use face-remapping-alist, this clears the scaling:
  (setq-local face-remapping-alist '((default variable-pitch default))))

(use-package org-tree-slide
  :hook ((org-tree-slide-play . gunner/presentation-setup)
         (org-tree-slide-stop . gunner/presentation-end))
  :custom
  (org-tree-slide-slide-in-effect t)
  (org-tree-slide-activate-message "Presentation started!")
  (org-tree-slide-deactivate-message "Presentation finished!")
  (org-tree-slide-header t)
  (org-tree-slide-breadcrumbs " > ")
  (org-image-actual-width nil))

(use-package ox-reveal
  :config
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"))

;; Add extensions
(use-package cape
  ;; Bind dedicated completion commands
  :bind (("C-c x p" . completion-at-point) ;; capf
         ("C-c x t" . complete-tag)        ;; etags
         ("C-c x d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c x f" . cape-file)
         ("C-c x k" . cape-keyword)
         ("C-c x s" . cape-symbol)
         ("C-c x a" . cape-abbrev)
         ("C-c x i" . cape-ispell)
         ("C-c x l" . cape-line)
         ("C-c x w" . cape-dict)
         ("C-c x &" . cape-sgml)
         ("C-c x r" . cape-rfc1345))
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;; (add-to-list 'completion-at-point-functions #'cape-symbol)
  ;; (add-to-list 'completion-at-point-functions #'cape-line)
  )

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-quit-at-boundary t)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect-first t)    ;; Disable candidate preselection
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  (corfu-echo-documentation t) ;; Disable documentation in the echo area
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; You may want to enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since dabbrev can be used globally (M-/).
  :init
  (global-corfu-mode)

  :bind
  (:map corfu-map
        ("S-SPC" . corfu-insert-separator)
        ("C-j" . corfu-next)
        ("C-k" . corfu-previous)
        ([backtab]. corfu-previous)
        ("TAB" . corfu-complete)
        ("C-l" . corfu-complete)
        ("<escape>" . corfu-quit)
        ("RET" . corfu-insert)
        ("C-M-g" . corfu-quit))

  :config
  (advice-add 'corfu--setup :after 'evil-normalize-keymaps)
  (advice-add 'corfu--teardown :after 'evil-normalize-keymaps)
  (evil-make-overriding-map corfu-map)

  ;; Enable corfu in minibuffer
  (defun corfu-enable-in-minibuffer ()
    "Enable Corfu in the minibuffer if `completion-at-point' is bound."
    (when (where-is-internal #'completion-at-point (list (current-local-map)))
      ;; (setq-local corfu-auto nil) Enable/disable auto completion
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)

  ;; Corfu Insert and Send

  (defun corfu-insert-and-send ()
    (interactive)
    ;; 1. First insert the completed candidate
    (corfu-insert)
    ;; 2. Send the entire prompt input to the shell
    (cond
     ((and (derived-mode-p 'eshell-mode) (fboundp 'eshell-send-input))
      (eshell-send-input))
     ((derived-mode-p 'comint-mode)
      (comint-send-input))))

  (define-key corfu-map "\r" #'+corfu-insert-and-send)
  )

(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(use-package corfu-doc
  ;; NOTE 2022-02-05: At the time of writing, `corfu-doc' is not yet on melpa
  :straight t
  :after corfu
  :hook (corfu-mode . corfu-doc-mode)
  :general (:keymaps 'corfu-map
                     ;; This is a manual toggle for the documentation popup.
                     [remap corfu-show-documentation] #'corfu-doc-toggle ; Remap the default doc command
                     ;; Scroll in the documentation window
                     "M-n" #'corfu-doc-scroll-up
                     "M-p" #'corfu-doc-scroll-down)
  :custom
  (corfu-doc-delay 1.0)
  (corfu-doc-max-width 30)
  (corfu-doc-max-height 20)

  ;; NOTE 2022-02-05: I've also set this in the `corfu' use-package to be
  ;; extra-safe that this is set when corfu-doc is loaded. I do not want
  ;; documentation shown in both the echo area and in the `corfu-doc' popup.
  (corfu-echo-documentation t))

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package keycast
  :config
  ;; This works with doom-modeline, inspired by this comment:
  ;; https://github.com/tarsius/keycast/issues/7#issuecomment-627604064
  (define-minor-mode keycast-mode
    "Show current command and its key binding in the mode line."
    :global t
    (if keycast-mode
        (add-hook 'pre-command-hook 'keycast--update t)
        (remove-hook 'pre-command-hook 'keycast--update)))

  (add-to-list 'global-mode-string '("" keycast-mode-line " ")))

(use-package avy
  :config
  (gunner/leader-keys
   "j"   '(:ignore t :which-key "jump")
   "jj"  '(avy-goto-char :which-key "jump to char")
   "jw"  '(avy-goto-word-0 :which-key "jump to word")
   "jl"  '(avy-goto-line :which-key "jump to line")))

(use-package popper
  :straight t ; or :straight t
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          "^\\*vterm.*\\*$"  vterm-mode
          help-mode
          compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1)
  :config
  (setq popper-group-function #'popper-group-by-projectile)
  (setq popper-window-height 12)
  )

(use-package mpv
  :init
  )

(use-package openwith
  :custom
  (setq openwith-associations
        (list
         (list (openwith-make-extension-regexp
                '("mpg" "webm" "mpeg" "mp3" "mp4"
                  "avi" "wmv" "wav" "mov" "flv"
                  "ogm" "ogg" "mkv"))
               "mpv"
               '(file))
         (list (openwith-make-extension-regexp
                '("xbm" "pbm" "pgm" "ppm" "pnm"
                  "png" "gif" "bmp" "tif" "jpeg")) ;; Removed jpg because Telega was
               ;; causing feh to be opened...
               "nsxiv"
               '(file))
         (list (openwith-make-extension-regexp
                '("pdf"))
               "zathura"
               '(file))))
  :defer t
  :init
  (openwith-mode)
  )

(use-package pomidor
  :straight t
  :bind (("<f12>" . pomidor))
  :config
  (setq pomidor-sound-tick nil
        pomidor-sound-tack nil)
  (setq alert-default-style 'libnotify)
  (setq pomidor-seconds (* 25 60)) ; 25 minutes for the work period
  (setq pomidor-break-seconds (* 5 60)) ; 5 minutes break time
  (setq pomidor-breaks-before-long 4) ; wait 4 short breaks before long break
  (setq pomidor-long-break-seconds (* 20 60)) ; 20 minutes long break time
  :hook (pomidor-mode . (lambda ()
                          (display-line-numbers-mode -1) ; Emacs 26.1+
                          (setq left-fringe-width 0 right-fringe-width 0)
                          (setq left-margin-width 2 right-margin-width 0)
                          ;; force fringe update
                          (set-window-buffer nil (current-buffer)))))

(defun gunner/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :custom
  (lsp-completion-provider :none) ;; we use Corfu!

  :commands (lsp lsp-deferred)

  :hook
  (lsp-completion-mode . my/lsp-mode-setup-completion)
  (lsp-mode . gunner/lsp-mode-setup)
  (sh-mode . lsp)
  (css-mode . lsp)
  (dart-mode . lsp)
  (csharp-mode . lsp)
  :init
  (defun my/orderless-dispatch-flex-first (_pattern index _total)
    (and (eq index 0) 'orderless-flex))

  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'

  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless))) ;; Configure orderless

  ;; Optionally configure the first word as flex filtered.
  (add-hook 'orderless-style-dispatchers #'my/orderless-dispatch-flex-first nil 'local)

  ;; Optionally configure the cape-capf-buster.
  (setq-local completion-at-point-functions (list (cape-capf-buster #'lsp-completion-at-point)))

  :config
  (lsp-enable-which-key-integration t)
  )

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package consult-lsp)

(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  ;; :custom
  ;; (lsp-enable-dap-auto-configure nil)
  ;; :config
  ;; (dap-ui-mode 1)
  :commands dap-debug
  :config
  ;; Set up Node debugging
  (require 'dap-node)
  (dap-node-setup) ;; Automatically installs Node debug adapter if needed

  ;; Bind `C-c l d` to `dap-hydra` for easy access
  (general-define-key
   :keymaps 'lsp-mode-map
   :prefix lsp-keymap-prefix
   "d" '(dap-hydra t :wk "debugger")))

(use-package python-mode
  :straight t
  ;; :hook (python-mode . lsp-deferred)
  :custom
  ;; NOTE: Set these if Python 3 is called "python3" on your system!
  ;; (python-shell-interpreter "python3")
  ;; (dap-python-executable "python3")
  (dap-python-debugger 'debugpy)
  :config
  (require 'dap-python)
  )

(gunner/leader-keys
  "l"  '(:ignore t :which-key "Python Shell Send")
  "lf" '(python-shell-send-file :which-key "Python Shell Send File")
  "ld" '(python-shell-send-defun :which-key "Python Shell Send Defun")
  "lb" '(python-shell-send-buffer :which-key "Python Shell Send Buffer")
  "lr" '(python-shell-send-region :which-key "python shell Send Region"))

(use-package pyvenv
  :after python-mode
  :config
  (pyvenv-mode 1))
;; (use-package lsp-jedi
;;   :ensure t
;;   :config
;;   (with-eval-after-load "lsp-mode"
;;     (add-to-list 'lsp-disabled-clients 'pyls)
;;     (add-to-list 'lsp-enabled-clients 'jedi)))

(use-package django-mode
  :straight t
  :defer 40)

(use-package djangonaut
  :straight t
  :defer 42)

(use-package lsp-pyright
  :straight t
  :after python-mode
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp)))  ; or lsp-deferred
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-disabled-clients 'pyls)))


(add-hook 'python-mode-hook
          (lambda ()
            (setq flycheck-python-pylint-executable "/usr/bin/pylint")
            (setq flycheck-pylintrc "/home/ural/.config/pylintrc")))

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/" "~/.emacs.d/straight/repos/yasnippet-snippets/snippets/"))
  (yas-global-mode 1))

(use-package projectile
  :diminish projectile-mode
  ;; :custom ((projectile-completion-system 'default))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired)
  :config (projectile-mode)
  (gunner/leader-keys
    "pf" 'consult-projectile-find-file
    "ps" 'consult-projectile-switch-project
    "pF" 'consult-ripgrep 
    "pl" 'consult-lsp-symbols 
    "pb" 'consult-projectile-switch-to-buffer
    "pc" 'projectile-compile-project
    "pd" 'projectile-dired
    "pd" 'consult-projectile-find-dir
    "pr" 'projectile-run-project
    "pv" 'projectile-run-vterm))

(use-package consult-projectile
  :hook
  (marginalia-mode . consult-projectile))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; optional: this is the evil state that evil-magit will use
;; (setq evil-magit-state 'normal)
;; optional: disable additional bindings for yanking text
;; (setq evil-magit-use-y-for-yank nil)
;; (require 'evil-magit)

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
(use-package forge
  :straight t
  :init
  (setq forge-add-default-bindings nil))

(show-paren-mode 1)
(use-package smartparens-config
  :straight smartparens
  :hook
  (emacs-lisp-mode . smartparens-mode)
  (lsp-mode . smartparens-mode)
  (org-mode . smartparens-mode)
  :config
  (sp-with-modes 'org-mode
    (sp-local-pair "=" "=" :wrap "C-=")))

(use-package evil-smartparens
  :straight t
  :after smartparens
  :hook
  (smartparens-enabled-hook . evil-smartparens-mode)
  )

(add-hook 'html-mode-hook 'lsp)
(add-hook 'html-mode-hook 'skewer-html-mode)

(add-hook 'sgml-mode-hook 'emmet-mode) 
 (add-hook 'html-mode-hook 'emmet-mode)
 (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces.
(setq emmet-expand-jsx-className? t) ;; default nil

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-livedown"))
;; (require 'livedown)

(use-package lua-mode
  :straight t
  :hook (lsp . lua-mode)
  :mode ("\\.lua\\'" . lua-mode)
  :interpreter ("lua" . lua-mode)
  )

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

;; Assuming usage with dart-mode
(use-package dart-mode
  :custom
  (dart-sdk-path (concat (getenv "HOME") "/flutter/bin/cache/dark-sdk/")
   dart-format-on-save t))

(use-package hover
  :straight  t
  :after dart-mode
  :bind (:map hover-minor-mode-map
              ("C-M-z" . #'hover-run-or-hot-reload)
              ("C-M-x" . #'hover-run-or-hot-restart)
              ("C-M-p" . #'hover-take-screenshot))
  :init
  (setq hover-flutter-sdk-path (concat (getenv "HOME") "/flutter") ; remove if `flutter` is already in $PATH
        hover-command-path (concat (getenv "GOPATH") "/bin/hover") ; remove if `hover` is already in $PATH
        hover-hot-reload-on-save t
        hover-screenshot-path (concat (getenv "HOME") "/Pictures")
        hover-screenshot-prefix "my-prefix-"
        hover-observatory-uri "http://my-custom-host:50300"
        hover-clear-buffer-on-hot-restart t)
  (hover-minor-mode 1))

(use-package dumb-jump
  :straight t)

(defhydra hydra-dumb-jump (:color pink :columns 3)
  "Dumb Jump"
  ("g" dumb-jump-go "Go")
  ("o" dumb-jump-go-other-window "Other window")
  ("b" dumb-jump-back "Back")
  ("l" dumb-jump-quick-look "Look")
  ("e" dumb-jump-go-prefer-external "External")
  ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
  ("q" nil "Quit" :color blue))

(gunner/leader-keys
  "d" '(hydra-dumb-jump/body :which-key "Dumb Jump"))

(use-package hideshow
  :hook ((prog-mode . hs-minor-mode)))

(defun toggle-fold ()
  (interactive)
  (save-excursion
    (end-of-line)
    (hs-toggle-hiding)))

(use-package flyspell-correct
  :bind ("C-M-," . flyspell-correct-at-point)
  ("C-M-q" . flyspell-auto-correct-word )
  :config
  (dolist (hook '(text-mode-hook))
    (add-hook hook (lambda () (flyspell-mode 1))))
  (dolist (hook '(change-log-mode-hook log-edit-mode-hook))
    (add-hook hook (lambda () (flyspell-mode -1))))
  ;; find aspell and hunspell automatically
  (cond
   ((executable-find "aspell")
    (setq ispell-program-name "aspell")
    (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")))
   ((executable-find "hunspell")
    (setq ispell-program-name "hunspell")
    (setq ispell-extra-args '("-d en_US")))
   ))

(use-package consult-flyspell
  :straight (consult-flyspell :type git :host gitlab :repo "OlMon/consult-flyspell" :branch "master")
  :config
  ;; default settings
  (setq consult-flyspell-select-function nil
        consult-flyspell-set-point-after-word t
        consult-flyspell-correct-function 'flyspell-correct-at-point
        consult-flyspell-always-check-buffer nil))

(use-package dictionary
  :straight t)

(use-package mw-thesaurus
  :straight t
  :defer t
  :config
  (setq mw-thesaurus--api-key "67d977d5-790b-412e-a547-9dbcc2bcd525")
  (add-hook 'mw-thesaurus-mode-hook (lambda () (define-key evil-normal-state-local-map (kbd "q") 'mw-thesaurus--quit)))
  )

(use-package powerthesaurus
  :straight t)

(use-package winum
  :bind (:map winum-keymap
              ("C-~" . winum-select-window-by-number)
              ("C-²" . winum-select-window-by-number)
              ("M-9" . winum-select-window-0-or-10)
              ("M-1" . winum-select-window-1)
              ("M-2" . winum-select-window-2)
              ("M-3" . winum-select-window-3)
              ("M-4" . winum-select-window-4)
              ("M-5" . winum-select-window-5)
              ("M-6" . winum-select-window-6)
              ("M-7" . winum-select-window-7)
              ("M-8" . winum-select-window-8))
  :init
  (winum-mode))

(winner-mode)

(straight-use-package 'emms)
(use-package emms
  :config
  (require 'emms-setup)
  (require 'emms-player-mpd)
  (setq emms-player-list '(emms-player-mpd))
  (add-to-list 'emms-info-functions 'emms-info-mpd)
  (add-to-list 'emms-player-list 'emms-player-mpd)

  ;; Socket is not supported
  (setq emms-player-mpd-server-name "localhost")
  (setq emms-player-mpd-server-port "6600")
  (setq emms-player-mpd-music-directory "/data/music")
  (emms-all)
  (emms-default-players))

(setq emms-source-file-default-directory (expand-file-name "~/Music/"))

(setq emms-player-mpd-server-name "localhost")
(setq emms-player-mpd-server-port "6600")
(setq emms-player-mpd-music-directory "~/Music")
(add-to-list 'emms-info-functions 'emms-info-mpd)
(add-to-list 'emms-player-list 'emms-player-mpd)
(emms-player-mpd-connect)

(setq emms-info-asynchronously nil)
(setq emms-playlist-buffer-name "*Music*")

(use-package lyrics-fetcher
  :straight t
  :after (emms)
  :config
  (setq lyrics-fetcher-genius-access-token "23O2v8mDgs8O7bbKTmYXV-RUbmxXkCkxuDKD-W7CSkqIXreOXedNk3yaZ_LSpj74"))

;; (require 'dashboard)
;; (dashboard-setup-startup-hook)
;; Or if you use use-package
(use-package dashboard
  :straight t
  :init
  (openwith-mode -1)
  :config
  (dashboard-setup-startup-hook)

  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

  ;; Set the title
  (setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
  ;; Set the banner
  (setq dashboard-startup-banner 'logo)
  ;; Value can be
  ;; 'official which displays the official emacs logo
  ;; 'logo which displays an alternative emacs logo
  ;; 1, 2 or 3 which displays one of the text banners
  ;; "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer

  ;; Content is not centered by default. To center, set
  (setq dashboard-center-content t)

  ;; To disable shortcut "jump" indicators for each section, set
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-items '((recents  . 5)
                          ;; (bookmarks . 5)
                          (projects . 5)
                          ;; (agenda . 5)
                          ;; (registers . 5)
                          ))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    ;; (bookmarks . "book")
                                    ))
  (setq dashboard-set-navigator t)
  ;; Format: "(icon title help action face prefix suffix)"
  ;; (setq dashboard-navigator-buttons
  ;;   `(;; line1
  ;;     ((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
  ;;      "Homepage"
  ;;      "Browse homepage"
  ;;      (lambda (&rest _) (browse-url "homepage")))
  ;;     ("★" "Star" "Show stars" (lambda (&rest _) (show-stars)) warning)
  ;;     ("?" "" "?/h" #'show-help nil "<" ">"))
  ;;      ;; line 2
  ;;     ((,(all-the-icons-faicon "linkedin" :height 1.1 :v-adjust 0.0)
  ;;       "Linkedin"
  ;;       ""
  ;;       (lambda (&rest _) (browse-url "homepage")))
  ;;      ("⚑" nil "Show flags" (lambda (&rest _) (message "flag")) error))))

  ;; (setq dashboard-set-init-info t)
  ;; (setq dashboard-init-info "This is an init message!")
  (setq dashboard-set-footer nil)
  ;; (setq dashboard-footer-messages '("Dashboard is pretty cool!"))
  ;; (setq dashboard-footer-icon (all-the-icons-octicon "dashboard"
  ;; :height 1.1
  ;; :v-adjust -0.05
  ;; :face 'font-lock-keyword-face))
  (setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
  ;;     (add-to-list 'dashboard-items '(agenda) t)
  ;;     (setq dashboard-week-agenda t)
  ;;     (setq dashboard-filter-agenda-entry 'dashboard-no-filter-agenda)


  )

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(defun my-nov-font-setup ()
  (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                           :height 1.0))
(add-hook 'nov-mode-hook 'my-nov-font-setup)

(setq nov-text-width 80)

(setq nov-text-width t)
(setq visual-fill-column-center-text t)
(add-hook 'nov-mode-hook 'visual-line-mode)
(add-hook 'nov-mode-hook 'visual-fill-column-mode)

(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "bash") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode)
  (vterm-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  ;;(setq display-line-numbers -1)
  ;; (setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(when (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "powershell.exe")
  (setq explicit-powershell.exe-args '()))

(defun gunner/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :after eshell)

(use-package eshell
  :hook (eshell-first-time-mode . gunner/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

(setq telega-use-images 't)
(setq telega-emoji-use-images t)

(use-package telega
  :init
  (setq emojify-mode t)
  :defer 6
  :load-path  "~/telega.el"
  :commands (telega)
  :config
  (setq telega-filter-button-width 20)
  ;; ("\\.pdf\\'" . default) is already member in `org-file-apps'
  ;; Use "xdg-open" to open files by default
  (setq telega-completing-read-function 'completing-read)
  (setcdr (assq t org-file-apps-gnu) 'browse-url-xdg-open)
  (setq telega-open-file-function 'org-open-file)
  )
;; (setq telega-user-use-avatars nil
;; telega-use-tracking-for '(any pin unread)
;; telega-chat-use-markdown-formatting t
;; telega-completing-read-function #'ivy-completing-read
;; telega-msg-rainbow-title nil
;; telega-chat-fill-column 75)
;; (add-hook 'after-init-hook #'global-emojify-mode)
(add-hook 'telega-load-hook
          (lambda ()
            (define-key global-map (kbd "C-c t") telega-prefix-map)))

(use-package mu4e
    :ensure nil
    ;; :load-path "/usr/share/emacs/site-lisp/mu4e/"
    ;; :defer 20 ; Wait until 20 seconds after startup
    :config

    ;; This is set to 't' to avoid mail syncing issues when using mbsync
    (setq mu4e-change-filenames-when-moving t)

    ;; Refresh mail using isync every 10 minutes
    (setq mu4e-update-interval (* 10 60))
    (setq mu4e-get-mail-command "mbsync -a")
    (setq mu4e-maildir "~/.mail")

    (setq mu4e-drafts-folder "/gmail/[Gmail]/Drafts")
    (setq mu4e-sent-folder   "/gmail/[Gmail]/Sent Mail")
    (setq mu4e-refile-folder "/gmail/[Gmail]/All Mail")
    (setq mu4e-trash-folder  "/gmail/[Gmail]/Trash")

(setq mu4e-maildir-shortcuts
    '((:maildir "/gmail/Inbox"    :key ?i)
      (:maildir "/gmail/[Gmail]/Sent Mail" :key ?s)
      (:maildir "/gmail/[Gmail]/Trash"     :key ?t)
      (:maildir "/gmail/[Gmail]/Drafts"    :key ?d)
      (:maildir "/gmail/[Gmail]/All Mail"  :key ?a))))

(use-package tracking
  :defer t
  :config
  (setq tracking-faces-priorities '(all-the-icons-pink
                                    all-the-icons-lgreen
                                    all-the-icons-lblue))
  (setq tracking-frame-behavior nil))

(setq erc-server "irc.libera.chat"
      erc-nick "uralgunners"
      erc-user-full-name "Ural Shrestha"
      erc-track-shorten-start 8
      erc-autojoin-channels-alist '(("irc-libera.chat" "#systemcrafters" "##soccers"))
      erc-kill-buffer-on-part t
      erc-auto-query 'bury)

;;functions to support syncing .elfeed between machines
;;makes sure elfeed reads index from disk before launching
(defun bjm/elfeed-load-db-and-open ()
  "Wrapper to load the elfeed db from disk before opening"
  (interactive)
  (elfeed)
  (elfeed-db-load)
  (elfeed-goodies/setup)
  (elfeed-search-update--force)
  (elfeed-update))

;;write to disk when quiting
(defun bjm/elfeed-save-db-and-bury ()
  "Wrapper to save the elfeed db to disk before burying buffer"
  (interactive)
  (elfeed-db-save)
  (quit-window))

(defun yt-dl-it (url)
  "Downloads the URL in an async shell"
  (let ((default-directory "~/Videos"))
    (async-shell-command (format "youtube-dl %s" url))))

(defun mpv-it (url)
  "Play the URL in an async shell"
  (let ((default-directory "~/Videos"))
    (async-shell-command (format "mpv %s" url))))

(defun elfeed-youtube-dl (&optional use-generic-p)
  "Youtube-DL link"
  (interactive "P")
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (yt-dl-it it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

(defun elfeed-mpv (&optional use-generic-p)
  "mpv link"
  (interactive "P")
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (mpv-it it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; (define-key elfeed-search-mode-map (kbd "d") 'elfeed-youtube-dl)
;; (define-key elfeed-search-mode-map (kbd "D") 'elfeed-mpv)

(setq elfeed-db-directory "~/Dropbox/elfeeddb")
(use-package elfeed
  :straight t
  :commands (elfeed)
  :bind (:map elfeed-search-mode-map
              ("q" . bjm/elfeed-save-db-and-bury)
              ("Q" . bjm/elfeed-save-db-and-bury))
  :config
  (setq elfeed-search-feed-face ":foreground #fff :weight bold")
  )

(use-package elfeed-org
  :after (elfeed)
  :straight t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/Dropbox/elfeed.org")))

(use-package elfeed-goodies
  :straight t
  :hook (elfeed-show-mode-hook . visual-line-mode)
  :config
  (elfeed-goodies/setup)
  (setq elfeed-goodies/entry-pane-size 0.8)
  (setq elfeed-goodies/entry-pane-position 'top)
  (evil-define-key 'normal elfeed-show-mode-map
    (kbd "J") 'elfeed-goodies/split-show-next
    (kbd "K") 'elfeed-goodies/split-show-prev)
  (evil-define-key 'normal elfeed-search-mode-map
    (kbd "J") 'elfeed-goodies/split-show-next
    (kbd "K") 'elfeed-goodies/split-show-prev)
  (setq elfeed-goodies/search-header '((:left  ((:feed-name . 9)
                                                (:tags . 12)
                                                (:entry-title . 20))
                                               :right ((:filter . 0)
                                                       (:status . 0)
                                                       )
                                               )))
  ;; (setq elfeed-goodies/search-header '((:feed-name) (:tags) (:entry-title)
  ;;                                      (:empty . :fill)
  ;;                                      (:filter) (:status) (:db-date)))
  )

(setq browse-url-generic-program (executable-find "firefox")
      browse-url-browser-function 'browse-url-generic
      browse-url-generic-args '("-private-window"))
(use-package engine-mode
  :init
  (engine-mode t)
  :config
  (engine/set-keymap-prefix (kbd "C-x e"))

  ;; Search Engine
  (defengine duckduckgo
    "https://duckduckgo.com/?q=%s"
    :keybinding "d")

  (defengine github
    "https://github.com/search?ref=simplesearch&q=%s"
    :keybinding "g")

  (defengine google-maps
    "http://maps.google.com/maps?q=%s"
    :docstring "Mappin' it up."
    :keybinding "m")

  (defengine project-gutenberg
    "http://www.gutenberg.org/ebooks/search/?query=%s"
    :keybinding "b")

  (defengine stack-overflow
    "https://stackoverflow.com/search?q=%s"
    :keybinding "s")

  (defengine youtube
    "http://www.youtube.com/results?aq=f&oq=&search_query=%s"
    :keybinding "y")

  (defengine wolfram-alpha
    "http://www.wolframalpha.com/input/?i=%s"
    :keybinding "x")

  (defengine twitter
    "https://twitter.com/search?q=%s"
    :keybinding "t")

  (defengine archwiki
    "https://wiki.archlinux.org/?search=%s"
    :keybinding "a")

  (defengine urbandictionary
    "https://www.urbandictionary.com/define.php?term=%s"
    :keybinding "u")

  (defengine invidious
    "https://invidious.flokinet.to/search?q=%s"
    :keybinding "i")

  (defengine wikipedia
    "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
    :keybinding "w"
    :docstring "Searchin' the wikis.")
  )

(use-package dired
  :straight nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-single
  :commands (dired dired-jump))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :commands (dired dired-jump)
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "nsxiv")
                                ("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
