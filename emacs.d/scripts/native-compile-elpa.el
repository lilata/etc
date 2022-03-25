#!emacs --script
;; natively compile .el files in the elpa directory
;; needs to enable native compilation when emacs is compiled
(native-compile-async "~/.emacs.d/elpa/" 'recursively)
(while (or comp-files-queue
           (> (comp-async-runnings) 0))
       (sleep-for 1))
