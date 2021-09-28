#lang racket/base

(require yaml)
(require (for-syntax racket/base))

(provide
 cloudformation
 metadata
 
 (except-out (all-from-out racket/base) #%module-begin)
 (rename-out  [module-begin #%module-begin]))

(define-syntax module-begin
  (syntax-rules ()
    [(_ (cloudformation parm ...)) (#%module-begin (write-yaml (cloudformation parm ...)))])
  )

(define-syntax metadata
  (syntax-rules (metadata)
    [(metadata) (list "Metadata" '())]))

(define-syntax description
  (syntax-rules (description)
    [(description) (list "Description" "AWSSB Template")]
    [(description desc) (list "Description" desc)]
    ))

(define aws-template-format-version (list "AWSTemplateFormatVerson" (date* 0 0 0 9 9 2010 4 251 #f 0 0 "UTC")))

(define-syntax cloudformation
  (syntax-rules (cloudformation)
    [(cloudformation) (apply hash (append aws-template-format-version (description)))]
    [(cloudformation desc) (apply hash (append aws-template-format-version (description desc)))]
    [(cloudformation desc body ...) (apply hash (append aws-template-format-version (description desc) body ...))]
  ))
