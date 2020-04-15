if ($promoteAction eq 'promote') {
    $commander->setProperty("/server/unplug/va", {value=>'$' . '[/plugins/EC-AuditReports/project/audit_reports/approvalAudit]'});
    $commander->setProperty("/server/unplug/vb", {value=>'$' . '[/plugins/EC-AuditReports/project/audit_reports/timingAudit]'});
    $commander->setProperty("/server/unplug/vc", {value=>'$' . '[/plugins/EC-AuditReports/project/audit_reports/evidenceAudit]'});
}
else {
    foreach ("va", "vb", "vc") {
        $commander->setProperty("/server/unplug/$_", {value=>"\$" . "[/plugins/unplug/project/v_example$_]"});
    }
}
