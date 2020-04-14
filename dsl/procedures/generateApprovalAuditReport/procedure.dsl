import java.io.File

def procName = 'generateApprovalAuditReport'
procedure procName, {
	step 'Set evidence link',
    	  command: new File(pluginDir, "dsl/procedures/$procName/steps/setEvidenceLink.pl").text,
    	  shell: 'ec-perl'
}
