(require 'ox-publish)

(setq org-publish-project-alist
      '(("my-website-content"
         :recursive t
         :base-directory "/Users/jason/my-website"        
         :publishing-directory "/Users/jason/my-website/public/"
         :publishing-function org-html-publish-to-html
         :auto-sitemap t
         :sitemap-filename "sitemap.org"
         :sitemap-title "Sitemap")
        
        ("my-website-static"
         :base-directory "/Users/jason/my-website"         
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf"
         :publishing-directory  "/Users/jason/my-website/public/"
         :recursive t
         :publishing-function org-publish-attachment)
        
        ("my-website" :components ("my-website-content" "my-website-static"))))
(provide 'ox-publishh)
