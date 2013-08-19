;; My gnus configuration.


(setq gnus-directory "~/gnus")
(setq message-directory "~/gnus/mail")
(setq nnml-directory "~/gnus/nnml-mail")
(setq gnus-article-save-directory "~/gnus/saved")
(setq gnus-kill-files-directory "~/gnus/scores")
(setq gnus-cache-directory "~/gnus/cache")

;; Message formatting
(defun my-message-mode-setup ()
  (setq fill-column 72)
  (turn-on-auto-fill))
(add-hook 'message-mode-hook 'my-message-mode-setup)


;; News server
(setq gnus-select-method '(nntp "news.gmane.org"))
(add-to-list 'gnus-secondary-select-methods '(nntp "news.gnus.org"))
(add-to-list 'gnus-secondary-select-methods 
	     '(nnimap "brinkster"
		      (nnimap-address "mail.johnpeck.info")))


(setq user-mail-address "john@johnpeck.info") 
(setq mail-host-address "mymail.brinkster.com")

(setq smtpmail-debug-info t)
(setq smtpmail-debug-verb t)

(setq message-kill-buffer-on-exit t)
(add-hook 'message-mode-hook 'turn-on-auto-fill)

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-default-smtp-server "mymail.brinkster.com"
      smtpmail-local-domain "mymail.brinkster.com"
      smtpmail-smtp-server "mymail.brinkster.com"
      smtpmail-smtp-service 25)





