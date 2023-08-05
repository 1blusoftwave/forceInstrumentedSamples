#
# Salesforce CQRS Force Instrumented Samples+++

The Samples are an UNLOCKED package. You can edit the code as needed. Actual examples can be found in ./src/scripts/apex.
You can find documentation in ./docs directory. There will be a tutorial on setup, examples, etc. along with various videos.

# Salesforce CQRS Design Pattern+++

Command-Query Responsibility Segregation, or CSRQ, provides the ability to separate Query from Commands responsibilities using SOLID Principles. Queries retrieve information from a sink (data store) for the user. A command performs a task, such as update a sink (data store). Commands mutate state, while a Query does not. Technically, a Command does not return a value; however, the example which follows will return status. Each provides a single responsibility (Single Responsibility principle in Solid).

Documentation can be found in the _docs_ directory and [CQRS](https://github.com/bjanderson70/cqrs_dx/blob/master/docs/CQRS-Design.pdf)

## Caveat-Preemptor

The sample code is just that. There is room for much improvement and robustness. The Unit
Tests are enough to provide at least 75% code coverage. If one decides to use the code, it is AS-IS.
Finally, the code was prefixed with either cqrs_ or util_ to avoid name collision. The packaging
does not use a namespace but was tested and can be packaged as a 2GP unlocked package.

## Samples

### Command
The simplest thing to do is start with a sample command. This example is found in the source
tree (./scripts/apex/exampleCommand.apex). Please note this is a raw form and can be used
in a service supporting specific functionality (i.e., Customer Management, Lead Management,
etc.). Above, is a collection of commands, creates a Command Dispatcher, passes in the command
collection, and the dispatcher finds the appropriate handlers and executes.

```` 
// list of commands to run (default behavior is to exits on bad status on any command)
final List<cqrs_ICommand> commands = new List<cqrs_ICommand> {
    new cqrs_AuthenticationCommand('test-uid','test-password'),
    new cqrs_WriteResultCommand('test-id')
};
cqrs_ICommandResult result= new cqrs_CommandDispatcher().dispatch(commands);
System.debug('++++++++++++++++RESULTs++++++++++++++++++++++++++++');
System.debug('Command(s) Result Successful?:' + result.success());
System.debug('Command(s) Result:' + result);

````
### Query

Like the sample command there is a sample query. This example is found in the source tree
(./scripts/apex/exampleQuery.apex). Please note, this too is a raw form and can be used in a service
supporting specific functionality (i.e., Customer Management, Lead Management, etc.)

````
// set up / arrange
final List<cqrs_IQuery> queries = new List<cqrs_IQuery> {
   // get account by type ()
   new cqrs_GetAccountByTypeQuery('Enterprise')
};
Integer inx=1;
// act -- dispatcher looks up a handler and executes
final cqrs_IQueryResult result= new cqrs_QueryDispatcher().dispatch(queries);
//
// results
//
System.debug('++++++++++++++++RESULTs++++++++++++++++++++++++++++');
System.debug('Query(s) Result Successful ?:' + result.success());
System.debug('Query(s) Result Count Found :' + result.results().size());
System.debug('Query(s) Result Searched for: "' + ((cqrs_GetAccountByTypeQuery)queries[0]).theUserAccountType() + '"' );
System.debug('++++++++++++++++RECORDs++++++++++++++++++++++++++++');
//
// iterate over the results
for ( cqrs_AccountTypeRecordsDTO dto: (List<cqrs_AccountTypeRecordsDTO>)result.results() ) {
   System.debug('Query Result (' + inx++ + ') Name=' + dto.name);
}

````

Following the same flow as a command, the above is a collection of (one) query, where we
create a Query Dispatcher, pass in the query collection, and the dispatcher finds the
appropriate handlers and executes.

### Service ( which wraps commands and queries)
The Commands and Queries can be used to form a Service. The service could be Customer
Search, Customer Management, Order Management, etc. In this example, we create a
Customer Service. The Customer Service just contains a query method; it could contain a sundry
of services relevant to Customer Service.

```` 
//
// Call a Service directly -- service wraps Command and Query Behavior
//
Integer inx=1;
// The Service Name -- Note, it looks for the service based on name and running environment
// If run from anonymous window ( that is considered "Debug" mode
//
final String serviceName='Customer Service';
// our account type parameter
final String accountType = 'enterprise';
//
// get the service by name -- resolver looks for service by name and runtime environment ( this can be overloaded)
cqrs_CustomerService service = (cqrs_CustomerService) cqrs_ServiceProvider.newInstance().getService( serviceName);
//
// show some service information
System.debug('++++++++++++++++RESULTs++++++++++++++++++++++++++++');
System.debug('Service Name:' + service.name());
System.debug('Service Guid:' + service.guid());
System.debug('++++++++++++++++RECORDs++++++++++++++++++++++++++++');
//
// iterate over the results (DTO)
//
for ( cqrs_AccountTypeRecordsDTO dto: service.findAccountRecordsByAccountType(accountType)) {
  System.debug('Service Result (' + inx++ + ') Name=' + dto.name);
}
````
The above Customer Service, **cqrs_CustomerService**, uses a provider to return the service by
name. The service holds similar attributes of a Command or Query (name, guid, user-context).
Our service method, __findAccountRecordsByAccountType(accountType)__ passes in an account type,
value of __enterprise__, and gets back a collection (Data Transfer Object) of Account Type
Records.

## How to install Samples

Create your Scratch Org (or Dev Sandbox)

* (Not Recommended) SFDX installed  - sfdx force:source:deploy ./src
* Package Install - 

```` 
<Salesforce-My-Domain>/packaging/installPackage.apexp?p0=04t6g000008s8MmAAI 
```` 

The Samples are an UNLOCKED Package ( meaning you are free to edit ). There are samples already created and can
be run thru VSCode or a DevConsole. You can find those examples, in ./src/srcipts/apex.

__Note, you MUST INSTALL the Core Force Instrumentation Managed Package FIRST__

## How to install Core Force Instrumentation

Create your Scratch Org (or Dev Sandbox)

* Package Install - 

```` 
<Salesforce-My-Domain>/packaging/installPackage.apexp?p0=04t6g000008o0UtAAI 
```` 


