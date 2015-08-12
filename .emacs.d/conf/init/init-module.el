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

;;; define el-get repository
(setq my:el-get-packages
  '(el-get
    stripes
    deferred
    popup-select-window
    widen-window
    install-elisp
    inertial-scroll
    grep-edit
    revive
    windows
    auto-complete-extension
    auto-complete-yasnippet
    flymake-easy
    flymake-extension
    flymake-haml
    tempbuf
    sdic-inline
    sdic-inline-pos-tip
    kokopelli
    imenu-tree
    srep
    drill-instructor
    dmacro
    ddskk
    yspel
    dont-type-twice
    goby
    emacs-cake
    auto-save-buffers
    cpp-complt
    emacs-3d-demo
    keisen
    hiwin
    php-doc
    python-lite
    kill-summary
    dired-ex-isearch
    wc-mode
    e-palette
    set-perl5lib-path
    eval-sexp-fu
    lambda-mode
    emmet-mode
    esqlite
    pcsv
    git-gutter-plus
    git-gutter-fringe-plus
    neotree
    e2wm-vcs
    highlight
    ;; emacs-w3m -> autoconf error
    ;; text-translator -> bzr execute-find
    ;; sdic
    ;; sekka
    haml-mode
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
    linum
    yalinum
    popup
    switch-window
    e2wm
    popwin
    python
    auto-install
    jaunte
    color-moccur
    grep-a-lot
    undohist
    undo-tree
    volatile-highlights
    tree-mode
    windata
    recentf-ext
    session
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
    bookmark
    anzu
    move-text
    sublimity
    nyan-mode
    ;elscreen -> https://raw.githubusercontent.com/tam17aki/elscreen/master/elscreen.el
    ;;;;;;;;;;; 10_
    ipython
    yasnippet
    auto-complete
    auto-complete-clang
    ac-helm
    pcomplete
    pos-tip
    dired+
    bf-mode
    erc
    flymake
    flymake-shell
    flymake-jshint
    flycheck
    flycheck-color-mode-line
    google-maps
    helm
    helm-c-moccur
    helm-c-yasnippet
    helm-css-scss
    helm-descbinds
    helm-gtags
    helm-pydoc
    helm-rails
    helm-dash
    helm-swoop
    mew
    multi-term
    org
    w3m
    ;;;;;;;;;;; 50_
    android-mode
    cc-mode
    hideif
    c-eldoc
    go-mode
    groovy-mode
    less-css-mode
    js2-mode
    js-comint
    lispxmp
    slime
    ac-slime
    cperl-mode
    perlbrew
    php-mode
    cake-inflector
    python-mode
    ipython
    pysmell
    rhtml-mode
    rinari
    rspec-mode
    ruby-mode
    ruby-block
    ruby-electric
    inf-ruby
    rsense
    rbenv
    rubocop
    scala-mode
    scss-mode
    markdown-mode
    coffee-mode
    json-mode
    web-mode
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
    eldoc-extension
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
    twittering-mode
    key-combo
    sticky
    key-chord
    smartrep
    expand-region
    server
    guide-key
    ))
(let ((not-installed (loop for x in install-package-list
                           when (not (package-installed-p x))
                           collect x)))
  (when not-installed (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))

(provide 'init-module)
