;; install-elisp package
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
    elscreen
    popwin
    python
    auto-install
    jaunte
    color-moccur
    grep-a-lot
    undohist
    undo-tree
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
    ;;;;;;;;;;; 10_
    anything
    anything-complete
    anything-show-completion
    ipython
    anything-ipython
    yasnippet
    descbinds-anything
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
    google-maps
    helm
    helm-c-moccur
    helm-c-yasnippet
    helm-descbinds
    helm-gtags
    helm-pydoc
    helm-rails
    helm-dash
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
    perl-completion
    perlbrew
    php-mode
    python-mode
    ipython
    pysmell
    pymacs
    ruby-mode
    ruby-block
    ruby-electric
    inf-ruby
    rvm
    rsense
    scala-mode
    scss-mode
    markdown-mode
    coffee-mode
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
    blank-mode
    rainbow-delimiters
    rainbow-mode
    sequential-command
    key-combo
    sticky
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

;; install-elisp el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(setq el-get-generate-autoloads nil)

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
    (url-retrieve-synchronously
      "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
      (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/recipes")
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/my-recipes")
(el-get 'sync)

;;; define el-get repository
(setq my:el-get-packages
  '(el-get
    stripes
    popup-select-window
    widen-window
    install-elisp
    inertial-scroll
    grep-edit
    revive
    windows
    ac-anything
    auto-complete-extension
    auto-complete-yasnippet
    flymake-extension
    tempbuf
    php-completion
    sdic-inline
    sdic-inline-pos-tip
    kokopelli
    imenu-tree
    srep
    drill-instructor
    dmacro
    ddskk
    one-key
    navi2ch
    yspel
    dont-type-twice
    goby
    emacs-cake
    auto-save-buffers
    pdf-preview
    cpp-complt
    emacs-3d-demo
    keisen
    hiwin
    anything-mac-itunes
    php-doc
    python-lite
    kill-summary
    anything-c-moccur
    dired-ex-isearch
    wc-mode
    e-palette
    set-perl5lib-path
    eval-sexp-fu
    lambda-mode
    emmet-mode
    anything-howm
    esqlite
    pcsv
    git-gutter-plus
    git-gutter-fringe-plus
    ;; emacs-w3m -> autoconf error
    ;; text-translator -> bzr execute-find
    ;; anything-c-yasnippet -> 切り捨てる？(http://d.hatena.ne.jp/sugyan/20120111/1326288445)
    ;; riece
    ;; sdic
    ;; sekka
   ))
(el-get 'sync my:el-get-packages)

(provide 'init-module)
