def procName = 'Audit Reports'

procedure procName, {
	step 'Approval', subprocedure: 'generateApprovalAuditReport'
	step 'Evidence', subprocedure: 'generateEvidenceLinksAuditReport'
	step 'Duration', subprocedure: 'generateTaskDurationAuditReport'
}