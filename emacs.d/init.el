(setq user-mjolnir-directory (concat (getenv "HOME") "/.mjolnir.d/"))

(org-babel-load-file
 (expand-file-name "config.org" user-mjolnir-directory))
