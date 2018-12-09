#############################################################################
#
#  generateTaskDurationAuditReport -- Generate pipeline stage summary link for
#     task duration audit report
#  Copyright 2017 Electric Cloud Inc.
#
#############################################################################

$[/myProject/scripts/perlHeaderJSON]


# set pipeline stage summary link to access unplug generated report
$ec->setProperty("/myPipelineStageRuntime/ec_summary/Task Duration Audit:", 
   '<html><a href="/commander/pages/unplug/un_run2?flowRuntimeId=$[/myPipelineRuntime/flowRuntimeId]">Summary Report</a></html>');
