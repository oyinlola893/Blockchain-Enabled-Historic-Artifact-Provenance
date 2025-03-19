;; Authentication Verification Contract
;; Validates expert assessments of authenticity

(define-map authentications
  { artifact-id: uint, verifier: principal }
  {
    is-authentic: bool,
    confidence-score: uint,
    verification-date: uint,
    methodology: (string-utf8 500),
    verifier-credentials: (string-utf8 500),
    report-uri: (optional (string-utf8 256))
  }
)

(define-map verifiers
  { address: principal }
  {
    name: (string-ascii 100),
    organization: (string-ascii 100),
    credentials: (string-utf8 500),
    active: bool
  }
)

(define-data-var admin principal tx-sender)

(define-read-only (get-authentication (artifact-id uint) (verifier principal))
  (map-get? authentications { artifact-id: artifact-id, verifier: verifier })
)

(define-read-only (get-verifier (address principal))
  (map-get? verifiers { address: address })
)

(define-public (register-verifier
    (name (string-ascii 100))
    (organization (string-ascii 100))
    (credentials (string-utf8 500))
  )
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))

    (map-set verifiers
      { address: tx-sender }
      {
        name: name,
        organization: organization,
        credentials: credentials,
        active: true
      }
    )

    (ok true)
  )
)

(define-public (verify-artifact
    (artifact-id uint)
    (is-authentic bool)
    (confidence-score uint)
    (methodology (string-utf8 500))
    (verifier-credentials (string-utf8 500))
    (report-uri (optional (string-utf8 256)))
  )
  (let
    (
      (verifier (unwrap! (map-get? verifiers { address: tx-sender }) (err u404)))
    )
    ;; Ensure the verifier is active
    (asserts! (get active verifier) (err u403))

    ;; Ensure confidence score is between 0 and 100
    (asserts! (<= confidence-score u100) (err u400))

    (map-set authentications
      { artifact-id: artifact-id, verifier: tx-sender }
      {
        is-authentic: is-authentic,
        confidence-score: confidence-score,
        verification-date: block-height,
        methodology: methodology,
        verifier-credentials: verifier-credentials,
        report-uri: report-uri
      }
    )

    (ok true)
  )
)

(define-public (update-verifier-status (address principal) (active bool))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))

    (let
      (
        (verifier (unwrap! (map-get? verifiers { address: address }) (err u404)))
      )
      (map-set verifiers
        { address: address }
        (merge verifier { active: active })
      )

      (ok true)
    )
  )
)

(define-public (set-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (var-set admin new-admin)
    (ok true)
  )
)

