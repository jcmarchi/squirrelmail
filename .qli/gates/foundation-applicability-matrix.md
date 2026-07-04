# Foundation Applicability Matrix

Use this matrix during project setup and before major slices.

| Trigger | Required Foundations |
|---|---|
| Any serious application | ACD, DATA discipline, Testing, Delivery, Security baseline |
| User-facing workflow | UI/UX, Testing smoke path, Accessibility baseline |
| Public route or external consumer | API, Security, Observability, Testing |
| Authenticated users | ACL, Security, DATA, Testing |
| Admin/privileged operation | ACL, Security, Observability/Audit, Testing negative cases |
| Multi-tenant or scoped data | ACL, DATA, Security, Testing isolation cases |
| File upload/download/export | DATA, API, ACL, Security, Runtime, Observability, Testing |
| Billing/payments/webhooks | API, DATA, ACL, Security, Runtime, Observability, Testing |
| Jobs/queues/schedules/cache/session | Runtime, DATA, Observability, Testing, Security if sensitive |
| Deployment/setup/config/secrets | Delivery, Security, Runtime, Testing |
| Existing project refactor | ACD, Testing, Delivery, applicable touched areas |
