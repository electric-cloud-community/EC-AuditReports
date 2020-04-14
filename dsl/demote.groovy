import groovy.transform.BaseScript
import com.electriccloud.commander.dsl.util.BasePlugin

//noinspection GroovyUnusedAssignment
@BaseScript BasePlugin baseScript

def pluginName = args.pluginName
def pluginKey = getProject("/plugins/$pluginName/project").pluginKey
def pluginDir = getProperty("/projects/$pluginName/pluginDir").value

modifyProperty "/server/unplug/v1", value: '$[/plugins/unplug/project/v_example1]'
modifyProperty "/server/unplug/v2", value: '$[/plugins/unplug/project/v_example2]'
modifyProperty "/server/unplug/v3", value: '$[/plugins/unplug/project/v_example3]'

cleanup(pluginKey, pluginName)

return "Plugin $pluginKey demoted"
