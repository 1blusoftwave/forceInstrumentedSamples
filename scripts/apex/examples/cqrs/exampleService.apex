// batches up outgoing text
List<String> outputData                 = new List<String>();
// set the environment we want; otherwise, will default to debug in anonymous mode.
blsw.ApexEnvironment.setEnvironment(blsw.ApexConstants.ALL_CATEGORY);
// we turn on (whether the custom setting is on/off) various
// attributes:
//  (a) ensure we resolve the handler (automaticlly, if not in custom metadata)
//  (b) event sourcing [ a means to provide state and entity information]
//  (c) metrics of the entity
//  (d) tracing informaton
//  (e) caching for performance
blsw.CustomSettingResourceMgr.customSetting()
.isHandlerExtension(true)
.isEventSourcing(true)
.isMetrics(true)
//.isTracing(true)
.isCaching(true);
//
// get the service by name. A service name provides a means to process
// a collection of Commands (and/or) Queries (and/or) other Services.
// The Commands, Queries or Services are chained together to emulate a
// process. There are control mechanisms builtin too :
//
//   1) Continue of failure or exit
//   2) Pass data between items in the Pipeline
//   3) Get Performance data (on each command/query/service) -- recommended only in Debug or Test mode
//   4) Ensure items follow transactional behavior (i.e. rollback on failure)
//   5) Publish events per action (Command/Query/Service)
//
List<blsw.IResult> results      =  blsw.ApplicationCQRS.serviceDispatcher(new blsw.CustomerService());
// how many results do we have
Integer numOfResults            = results.size();

outputData.add('Service Result(s) Found:' + numOfResults );

// iterate over the results
for (Integer inx=0; inx < numOfResults; inx++ ) {

    // results
    outputData.add ((inx+1) + ') ++++++++++++++++RESULTs++++++++++++++++++++++++++++'
                    + '\nService Item Result Successful ?      :' + results[inx].success()
                    + '\nService Item Result Exception         :' + results[inx].theException()
                    + '\nService Item Result Has Exception?    :' + results[inx].hasException()
                    + '\nService Item Result Type              :' + results[inx].typeOf()
                    );
}
// if there were NO results ...
if ( numOfResults==0) {
    outputData.add('Service (Tracer) Result(s) Found None' );
}
// dump all the output once
system.debug( string.join(outputData,'\n'));