#############################################################################
#
#  generateEvidenceLinksAuditReport -- Generate pipeline stage summary link for
#     evidence links audit report
#  Copyright 2017 Electric Cloud Inc.
#
#############################################################################

$[/myProject/scripts/perlHeaderJSON]


# config unplug to point to this report
# note: must split up $[] otherwise content gets substituted, which isn't what we want!
$ec->setProperty("/server/unplug/v3", "\$\[" . "/plugins/EC-AuditReports/project/audit_reports/evidenceAudit\]");
