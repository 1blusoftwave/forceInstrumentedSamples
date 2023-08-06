#
# Salesforce Core Force Instrumented Samples+++

The Samples are an UNLOCKED package. You can edit the code as needed. Actual examples can be found in ./src/scripts/apex.
The examples below came from ./src/scripts/apex/cqrs and provides a easy flow.

You can find documentation in ./docs directory. There will be a tutorial on setup, examples, etc. along with various videos.

# Salesforce CQRS Design Pattern+++

Command-Query Responsibility Segregation, or CQRS, provides the ability to separate Queries from Commands responsibilities using SOLID Principles. Queries retrieve information from a sink (data store) for the user. While a Command performs a task, such as update a sink (data store). Commands mutate state, while a Query does not. Technically, a Command does not return a value; however, the example which follows will return status. Each provides a single responsibility (Single Responsibility principle in SOLID).

Documentation can be found in the _docs_ directory and [CQRS](https://github.com/1blusoftwave/forceInstrumentedSamples/tree/main/docs/CQRS-Design.pdf)

## Caveat-Preemptor

The sample code is just that. There is room for much improvement and robustness. The Unit
Tests are enough to provide at least >75% code coverage. If one decides to use the code, it is AS-IS.
Finally, the samples are packaed into an UNLOCKED package. This allows you to edit apex classes and
uninstall all the samples with a simple click!

## Samples

### Command
The simplest thing to do is start with a sample command. This example is found in the source
tree (./scripts/apex/exampleCommand.apex). Please note this is a raw form and can be used
in a service supporting specific functionality (i.e., Customer Management, Lead Management,
etc.). Above, is a collection of commands, creates a Command Dispatcher, passes in the command
collection, and the dispatcher finds the appropriate handlers and executes.

```` 
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
    new AuthenticationCommand('test-uid','test-password'),
    new WriteResultCommand('test-id')
};



// we turn on (whether the custom setting is on/off) various
// attributes:
//  (a) ensure we resolve the handler (automaticlly, if not in custom metadata)
//  (b) event sourcing [ a means to provide state and entity information - trace of execution ]
//  (c) metrics of the entity (Charts and Realtime Monitoring use this information)
//  (d) tracing informaton ( Guarded information, i.e., syslog )
//  (e) caching for performance ( use caching to improve performance of DML )
blsw.CustomSettingResourceMgr.customSetting()
.isHandlerExtension(true)
.isEventSourcing(true)
.isMetrics(true)
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

````
### Query

Like the sample command there is a sample query. This example is found in the source tree
(./scripts/apex/exampleQuery.apex). Please note, this too is a raw form and can be used in a service
supporting specific functionality (i.e., Customer Management, Lead Management, etc.)

````
// convert to class type ... this could be nill!
// what this does is to say, convert the Account (SObect) to a DTO.
// The DTO, called "AccountTypeRecordsDTO", gets register as a conversion
// and resolved as part of the process of returning back. Of course,
// shoul done be fine with Account (SObject), it would return that (by default).
Type convertTo=AccountTypeRecordsDTO.class;
// batches up outgoing text
List<String> outputData = new List<String>();
// set the environment we want; otherwise, will default to debug in anonymous mode .
blsw.ApexEnvironment.setEnvironment(blsw.ApexConstants.ALL_CATEGORY);
//
// DTO == Data Transfer Object
//
// Queries are seeded with the needed information. Queries
// provide a non-DB related way (DTO) to push data to the appropriate query(s).
//
// Below contains our list of queries; please note,
// one has the ability to "convert-" the query data (SObject)
// into a DTO. This provides an easy way to reduce the constraint
// between external forces and internal forces. Of course, if
// the "convertTo" is null, then the SObject is returned ( no-conversion done)!
//
List<blsw.IQuery> queries = new List<blsw.IQuery> {
    // get account by type ()
    //'Enterprise'
    new GetAccountByTypeQuery('enterprise',convertTo)
};
Integer jnx=1;

// we turn on (whether the custom setting is on/off) various
// attributes:
//  (a) ensure we resolve the handler (automaticlly, if not in custom metadata)
//  (b) event sourcing [ a means to provide state and entity information - trace of execution ]
//  (c) metrics of the entity (Charts and Realtime Monitoring use this information)
//  (d) tracing informaton ( Guarded information, i.e., syslog )
//  (e) caching for performance ( use caching to improve performance of DML )
blsw.CustomSettingResourceMgr.customSetting()
.isHandlerExtension(true)
.isEventSourcing(true)
.isMetrics(true)
//.isTracing(true)
.isCaching(true);

//
// Queries are then dispatched to an appropriate Query Handler, The dispatcher
// uses a Resolver to find which handler consumes the commands. This way
// Query Handlers can be swapped out as needs/process change.
//
// act
List<blsw.IQueryResult> results=  blsw.ApplicationCQRS.queryDispatcher(queries);
// how many results do we have
Integer numOfResults = results.size();

outputData.add('Query Result Found:' + numOfResults );
String name;
// iterate over the results
for (Integer inx=0; inx < numOfResults; inx++ ) {

    jnx=1;
    // results
    outputData.add('++++++++++++++++RESULTs++++++++++++++++++++++++++++'
                   + '\nQuery(s) Result Successful ?:'  + results[inx].success()
                   + '\nQuery(s) Result Count Found :'  + results[inx].results().size()
                   + '\nQuery(s) Result Exception   :'  + results[inx].theException()
                   + '\nQuery(s) Result Searched for: "'+ ((GetAccountByTypeQuery)queries[inx]).theUserAccountType() + '"'
                   + '\n++++++++++++++++RECORDs++++++++++++++++++++++++++++');
    outputData.add('++++++++++++++++OUTPUTs++++++++++++++++++++++++++++');
    // iterate over queries
    blsw.IQueryResult qresult= results[inx];
    // iterate over the results
    for ( Object obj: qresult.results() ) {
        // what was the type ( was conversion done?)
        if ( qresult.typeManager().toType() == AccountTypeRecordsDTO.class ) {
            name = ((AccountTypeRecordsDTO)obj).name;
        } else {
            name = ((Account)obj).Name;
        }

        outputData.add( 'Results['+ (inx+1) + '] Query Result (' + jnx++ + ') Name=' +  name);
    }
}
// if there were NO results ...
if ( numOfResults==0) {
    outputData.add('Query Result Found None' );
}
// dump all the output once
system.debug( string.join(outputData,'\n'));

````

Following the same flow as a command, the above is a collection of (one) query, where we
create a Query Dispatcher, pass in the query collection, and the dispatcher finds the
appropriate handlers and executes. In addition, there is a conversion that is done.

The converter allows one to have different ViewModels.

### Service ( which wraps commands and queries)
The Commands and Queries can be used to form a Service. The service could be Customer
Search, Customer Management, Order Management, etc. In this example, we create a
Customer Service. The Customer Service just contains a query method; it could contain a sundry
of services relevant to Customer Service.

```` 
// batches up outgoing text
List<String> outputData                 = new List<String>();
// set the environment we want; otherwise, will default to debug in anonymous mode.
blsw.ApexEnvironment.setEnvironment(blsw.ApexConstants.ALL_CATEGORY);
// we turn on (whether the custom setting is on/off) various
// attributes:
//  (a) ensure we resolve the handler (automaticlly, if not in custom metadata)
//  (b) event sourcing [ a means to provide state and entity information - trace of execution ]
//  (c) metrics of the entity (Charts and Realtime Monitoring use this information)
//  (d) tracing informaton ( Guarded information, i.e., syslog )
//  (e) caching for performance ( use caching to improve performance of DML )
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
List<blsw.IResult> results      =  blsw.ApplicationCQRS.serviceDispatcher(new CustomerService());
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
````
The above Customer Service, **CustomerService**, uses a provider to return the service by
name. The service holds similar attributes of a Command or Query (name, guid, user-context).
Our service method, __findAccountRecordsByAccountType(accountType)__ passes in an account type,
value of __enterprise__, and gets back a collection (Data Transfer Object) of Account Type
Records.

## How to install Core Force Instrumentation

Create your Scratch Org (or Dev Sandbox)

* Package Install - 

```` 
<Salesforce-My-Domain>/packaging/installPackage.apexp?p0=04t6g000008o0UtAAI 
```` 
## How to install Samples

Create your Scratch Org (or Dev Sandbox)

* (Not Recommended) SFDX installed  - sfdx force:source:deploy ./src
* (Recommended) Package Install - 

```` 
<Salesforce-My-Domain>/packaging/installPackage.apexp?p0=04t6g000008s8MmAAI 
```` 

The Samples are an UNLOCKED Package ( meaning you are free to edit ). There are samples already created and can
be run thru VSCode or a DevConsole. You can find those examples, in ./src/srcipts/apex.

__Note, you MUST INSTALL the Core Force Instrumentation Managed Package FIRST__




