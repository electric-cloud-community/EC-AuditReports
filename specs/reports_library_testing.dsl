def myProject = "Reports Library Testing"

project myProject, {
  // Supporting procedures - must come first as they are a dependency of testing pipelines
  procedure 'Validate Installation', {
    step 'Check installation', {
      broadcast = '0'
      command = 'echo \"Installation validated\"'
      errorHandling = 'failProcedure'
    }
  }

  // Approval audit report testing pipelines
  pipeline 'Approval Audit Testing', {
    stage 'DEV', {
      gate 'PRE', {
      }

      gate 'POST', {
        task 'User Approval', {
          errorHandling = 'stopOnError'
          gateType = 'POST'
          notificationTemplate = 'ec_default_gate_task_notification_template'
          taskType = 'APPROVAL'
          approver = [
            'admin',
          ]
        }

        task 'Procedure Approval', {
          errorHandling = 'continueOnError'
          gateType = 'POST'
          subprocedure = 'Validate Installation'
          subproject = 'Reports Library Testing'
          taskProcessType = null
          taskType = 'PROCEDURE'
        }

        task 'Conditional Approval', {
          errorHandling = 'stopOnError'
          gateCondition = '$[/javascript myPipelineRuntime.testsPassed == \"100\"]'
          gateType = 'POST'
          taskType = 'CONDITIONAL'
        }
      }

      task 'Set testing results', {
        actualParameter = [
          'commandToRun': 'ectool setProperty /myPipelineRuntime/testsPassed 100',
        ]
        errorHandling = 'stopOnError'
        subpluginKey = 'EC-Core'
        subprocedure = 'RunCommand'
        taskType = 'COMMAND'
      }
    }

    stage 'QA', {
      gate 'PRE', {
        task 'QA approval', {
          errorHandling = 'stopOnError'
          gateType = 'PRE'
          notificationTemplate = 'ec_default_gate_task_notification_template'
          taskType = 'APPROVAL'
          approver = [
            'admin',
          ]
        }
      }

      gate 'POST', {
      }
    }

    stage 'PROD', {
      gate 'PRE', {
        task 'QA lead approval', {
          errorHandling = 'stopOnError'
          gateType = 'PRE'
          notificationTemplate = 'ec_default_gate_task_notification_template'
          taskType = 'APPROVAL'
          approver = [
            'admin',
          ]
        }

        task 'QA director approval', {
          errorHandling = 'stopOnError'
          gateType = 'PRE'
          notificationTemplate = 'ec_default_gate_task_notification_template'
          taskType = 'APPROVAL'
          approver = [
            'admin',
          ]
        }

        task 'VP Engineering approval', {
          errorHandling = 'stopOnError'
          gateType = 'PRE'
          notificationTemplate = 'ec_default_gate_task_notification_template'
          taskType = 'APPROVAL'
          approver = [
            'admin',
          ]
        }
      }

      gate 'POST', {
      }
  
      task 'Generate approval audit report', {
        errorHandling = 'stopOnError'
        subprocedure = 'Generate approval audit report'
        subproject = 'Reports Library'
        taskType = 'PROCEDURE'
      }
    }
  }
}
