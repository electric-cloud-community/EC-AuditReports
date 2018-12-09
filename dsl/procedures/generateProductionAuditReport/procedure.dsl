import java.io.File

def procName = 'generateProductionAuditReport'
procedure procName, {
	step 'Config unplug',
    	  command: new File(pluginDir, "dsl/procedures/$procName/steps/configUnplug.pl").text,
    	  shell: 'ec-perl'

	step 'Set evidence link',
    	  command: new File(pluginDir, "dsl/procedures/$procName/steps/setEvidenceLink.pl").text,
    	  shell: 'ec-perl'
}
