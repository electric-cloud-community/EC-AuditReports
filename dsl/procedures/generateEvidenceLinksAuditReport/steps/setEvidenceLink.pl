#############################################################################
#
#  generateEvidenceLinksAuditReport -- Generate pipeline stage summary link for
#     evidence links audit report
#  Copyright 2017 Electric Cloud Inc.
#
#############################################################################

$[/myProject/scripts/perlHeaderJSON]


# set pipeline stage summary link to access unplug generated report
$ec->setProperty("/myPipelineStageRuntime/ec_summary/Evidence Links Audit:", 
   '<html><a target="_blank" href="/commander/pages/unplug/un_runvb?flowRuntimeId=$[/myPipelineRuntime/flowRuntimeId]">Summary Report</a></html>');
