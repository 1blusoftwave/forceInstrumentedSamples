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
List<IQuery> queries = new List<IQuery> {
    // get account by type ()
    //'Enterprise'
    new GetAccountByTypeQuery('enterprise',convertTo)
};
Integer jnx=1;

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
// Queries are then dispatched to an appropriate Query Handler, The dispatcher
// uses a Resolver to find which handler consumes the commands. This way
// Query Handlers can be swapped out as needs/process change.
//
// act
List<IQueryResult> results=  ApplicationCQRS.queryDispatcher(queries);
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
    IQueryResult qresult= results[inx];
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