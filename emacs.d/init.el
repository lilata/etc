(setq gc-cons-threshold 100000000)
(setq user-mjolnir-directory (concat (getenv "HOME") "/.mjolnir.d/"))

(org-babel-load-file
 (expand-file-name "config.org" user-mjolnir-directory))
(setq gc-cons-threshold 800000)
