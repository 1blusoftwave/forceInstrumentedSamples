
// Synopsis: This Query makes a callout. Queries retrieve data from a Sink, where a sink
//           is a location with a repository of data. Thus, if the endpoint allows consumption
//           (ie. REST) , then we can make the query.
//
// "convertTo" ...
//
// what this does is to say, convert the String (from the Get API) to a DTO.
// The DTO, called "FreeApiResultsDTO", gets register as a conversion
// and resolved as part of the process of returning back. Of course,
// you should be fine with String, it would return that (by default).
// Please note, we had to write "FreeApiResultsDTO" class and register it
// with the query. By default, ALL queries support a "convertTo" Type. This
// allows one to tailor output (viewmodel) based on a constraints (i.e. Personas).
//

// convert to class type ... this could be null!
Type convertTo      = FreeApiResultsDTO.class;
//
// Our Url . Does not require any other information (entries)
final String URL    = 'https://api.publicapis.org/random';
final String ACTION = 'GET';
//
// set the environment we want; otherwise, will default to debug in anonymous mode.
blsw.ApexEnvironment.setEnvironment(ApexConstants.ALL_CATEGORY);
//
//
// DTO == Data Transfer Object
//
// Queries are seeded with the needed information. Queries
// provide a non-DB related way (DTO) to push data to the appropriate query(s).
//
// Below contains our list of queries; please note,
// one has the ability to "convert" the query data (String)
// into a DTO. This provides an easy way to reduce the constraint
// between external forces and internal forces. Of course, if
// the "convertTo" is null, then the Response "String" is returned ( no-conversion done)!
//
List<blsw.IQuery> queries = new List<blsw.IQuery> {
    // get public apis
    //'https ://api.publicapis.org/random'
    new GetAPIsQuery(URL,ACTION,convertTo)
};
Integer jnx=1;

// batches up outgoing text
List<String> outputData = new List<String>();
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
// Queries are then dispatched to an appropriate Query Handler, The dispatcher
// uses a Resolver to find which handler consumes the commands/queries. This way
// Query Handlers can be swapped out as needs/process change.
//
// act
List<blsw.IQueryResult> results  = blsw.ApplicationCQRS.queryDispatcher().dispatch(queries);
// how many results do we have
Integer numOfResults        = results.size();

outputData.add('Query Result Found:' + numOfResults );
blsw.IQueryResult qresult;
Type convertToType;

// iterate over the results
for (Integer inx=0; inx < numOfResults; inx++ ) {

    jnx=1;
    // results
    outputData.add('++++++++++++++++RESULTs++++++++++++++++++++++++++++'
                   + '\nQuery(s) Result Successful ?:' + results[inx].success()
                   + '\nQuery(s) Result Count Found :' + results[inx].results().size()
                   + '\nQuery(s) Result Endpoint    : "' + ((GetAPIsQuery)queries[inx]).theEndpoint() + '"'
                   + '\n++++++++++++++++RECORDs++++++++++++++++++++++++++++');
    outputData.add('++++++++++++++++OUTPUTs++++++++++++++++++++++++++++');
    // iterate over queries
    qresult= results[inx];
    // get the type of the conversion used (if any)
    convertToType= qresult.typeManager().toType();

    // each query has can have results;iterate over the query results
    for ( Object obj: qresult.results() ) {
        // what was the type ( was conversion done?)
        if ( convertToType == convertTo ) {
            // it was indicated that we converted the string to a "FreeApiResultsDTO"
            FreeApiResultsDTO dto = (FreeApiResultsDTO)obj;
            outputData.add( 'Results['+ (inx+1) + '] , ' + jnx + '). Query Result :'+ dto.API);
            jnx++;
        } else {
            outputData.add( 'Results['+ (inx+1) + '] Query Result- JSON=' +  obj);
        }
    }
}
// if there were NO results ...
if ( numOfResults==0) {
    outputData.add('Query Result Found None' );
}
// dump all the output once
system.debug( string.join(outputData,'\n'));