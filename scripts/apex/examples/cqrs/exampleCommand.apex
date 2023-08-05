// batches up outgoing text
List<String> outputData = new List<String>();
blsw.StopWatch m_watch  = new blsw.StopWatch();

// set the environment we want; otherwise, will default to debug in anonymous mode .
blsw.ApexEnvironment.setEnvironment(blsw.ApexConstants.ALL_CATEGORY);
// DTO == Data Transfer Object
//
// Commands (mutate-state) are seeded with the needed information. Commands
// provide a non-DB related way (DTO) to push data to the appropriate command(s).
//
List<blsw.ICommand> commands = new List<blsw.ICommand> {
    new blsw.AuthenticationCommand('test-uid','test-password'),
    new blsw.WriteResultCommand('test-id')
};



// we turn on (whether the custom setting is on/off) various
// attributes:
//  (a) ensure we resolve the handler (automaticlly, if not in custom metadata)
//  (b) event sourcing [ a means to provide state and entity information]
//  (c) metrics of the entity
//  (d) tracing informaton
//  (e) caching for performance
CustomSettingResourceMgr.customSetting()
.isHandlerExtension(true)
.isEventSourcing(true)
//.isMetrics(true)
//.isTracing(true)
.isCaching(true);
//
// Commands are dispatched to an appropriate Command Handler, The dispatcher
// uses a Resolver to find which handler consumes the commands. This way
// Command Handlers can be swapped out as needs/process change.
//

List<blsw.ICommandResult> results=  blsw.ApplicationCQRS.commandDispatcher(commands);
// how many results do we have
Integer numOfResults        = results.size();

// iterate over the results
for (Integer inx=0; inx < numOfResults; inx++ ) {
    // results
    outputData.add ((inx+1) + ') ++++++++++++++++RESULTs++++++++++++++++++++++++++++'
                    + '\nCommand(s) Result Successful ?      :' + results[inx].success()
                    + '\nCommand(s) Result Exception         :' + results[inx].theException()
                    + '\nCommand(s) Result Has Exception?    :' + results[inx].hasException()
                    + '\nCommand(s) Result Type              :' + results[inx].typeOf()
                    );
}

system.debug('[3]FINAL Duration: ' + m_watch.toString()  );