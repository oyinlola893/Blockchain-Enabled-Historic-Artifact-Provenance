;; Artifact Registration Contract
;; Records details and origin of historical items

(define-data-var last-artifact-id uint u0)

(define-map artifacts
  { artifact-id: uint }
  {
    name: (string-ascii 100),
    description: (string-utf8 500),
    origin-location: (string-ascii 100),
    origin-date: (string-ascii 50),
    creator: (string-ascii 100),
    owner: principal,
    registered-at: uint,
    image-uri: (optional (string-utf8 256))
  }
)

(define-read-only (get-last-artifact-id)
  (var-get last-artifact-id)
)

(define-read-only (get-artifact (artifact-id uint))
  (map-get? artifacts { artifact-id: artifact-id })
)

(define-public (register-artifact
    (name (string-ascii 100))
    (description (string-utf8 500))
    (origin-location (string-ascii 100))
    (origin-date (string-ascii 50))
    (creator (string-ascii 100))
    (image-uri (optional (string-utf8 256)))
  )
  (let
    (
      (new-id (+ (var-get last-artifact-id) u1))
    )
    (asserts! (is-eq tx-sender contract-caller) (err u403))

    (map-set artifacts
      { artifact-id: new-id }
      {
        name: name,
        description: description,
        origin-location: origin-location,
        origin-date: origin-date,
        creator: creator,
        owner: tx-sender,
        registered-at: block-height,
        image-uri: image-uri
      }
    )

    (var-set last-artifact-id new-id)
    (ok new-id)
  )
)

(define-public (update-artifact-details
    (artifact-id uint)
    (name (string-ascii 100))
    (description (string-utf8 500))
    (origin-location (string-ascii 100))
    (origin-date (string-ascii 50))
    (creator (string-ascii 100))
    (image-uri (optional (string-utf8 256)))
  )
  (let
    (
      (artifact (unwrap! (map-get? artifacts { artifact-id: artifact-id }) (err u404)))
    )
    ;; Only the owner can update details
    (asserts! (is-eq (get owner artifact) tx-sender) (err u403))

    (map-set artifacts
      { artifact-id: artifact-id }
      (merge artifact {
        name: name,
        description: description,
        origin-location: origin-location,
        origin-date: origin-date,
        creator: creator,
        image-uri: image-uri
      })
    )

    (ok true)
  )
)

