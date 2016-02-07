;; install-elisp el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(setq el-get-generate-autoloads nil)

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/recipes")
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/my-recipes")
(el-get 'sync)

(setq my:el-get-packages
  '(stripes
    deferred
    popup-select-window
    e2wm-vcs
    install-elisp
    grep-edit
    windows
    wc-mode
    flyspell
    auto-complete-extension
    dired-ex-isearch
    flymake-easy
    flymake-extension
    flymake-haml
    set-perl5lib-path
    tempbuf
    auto-save-buffers
    haml-mode
    emmet-mode
    lambda-mode
    eval-sexp-fu
    php-doc
    mmm-mode
    python-lite
    slim-mode
    kokopelli
    imenu-tree
    cpp-complt
    git-gutter-plus
    git-gutter-fringe-plus
    srep
    dont-type-twice
    drill-instructor
    dmacro
    ddskk
    ; sekka

    ))
(el-get 'sync my:el-get-packages)

;; install-elisp package
(require 'ert)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defvar install-package-list
  '(init-loader
    popup
    e2wm
    popwin
    auto-install
    jaunte
    color-moccur
    grep-a-lot
    undo-tree
    session
    volatile-highlights
    nyan-mode
    move-text
    multiple-cursors
    zlc
    hideshow
    fold-dwim
    ediff
    bm
    tramp
    minor-mode-hack
    archive-region
    open-junk-file
    migemo
    anzu
    ;;;;;;;;;;; 10_
    auto-complete
    pcomplete
    pos-tip
    dired+
    bf-mode
    flycheck
    flycheck-color-mode-line
    flymake
    flymake-shell
    flymake-jshint
    google-maps
    helm
    helm-c-moccur
    helm-c-yasnippet
    helm-css-scss
    helm-descbinds
    helm-gtags
    helm-pydoc
    helm-rails
    ac-helm
    helm-dash
    helm-swoop
    multi-term
    org
    w3m
    yasnippet
    ;;;;;;;;;;; 50_
    cc-mode
    c-eldoc
    go-mode
    groovy-mode
    web-mode
    less-css-mode
    scss-mode
    js2-mode
    js-comint
    coffee-mode
    json-mode
    lispxmp
    slime
    ac-slime
    markdown-mode
    cperl-mode
    perlbrew
    php-mode
    cake-inflector
    python
    python-mode
    ipython
    ruby-mode
    ruby-block
    ruby-electric
    inf-ruby
    rubocop
    rbenv
    rsense
    rinari
    rspec-mode
    rhtml-mode
    scala-mode
    ;;;;;;;;;;; 60_
    info
    info+
    viewer
    ;;;;;;;;;;; 70_
    which-func
    paredit
    summarye
    auto-async-byte-compile
    quickrun
    gtags
    mode-compile
    imenu+
    test-case-mode
    sr-speedbar
    xcscope
    gist
    magit
    eldoc
    ;;;;;;;;;;; 90_
    autoinsert
    calendar
    japanese-holidays
    calfw
    auto-highlight-symbol
    highlight-indentation
    hl-line
    hl-line+
    blank-mode
    rainbow-delimiters
    rainbow-mode
    sequential-command
    key-combo
    sticky
    guide-key
    key-chord
    smartrep
    expand-region
    server
    ))
(let ((not-installed (loop for x in install-package-list
			   when (not (package-installed-p x))
			   collect x)))
  (when not-installed (package-refresh-contents)
	(dolist (pkg not-installed)
	  (package-install pkg))))

(provide 'init-module)
