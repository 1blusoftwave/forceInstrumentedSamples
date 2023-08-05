/**
 * Copyright 2023-2024 BSW, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http:       //www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License .
 *
 * @description       : Get API Query Handler
 * @author            : BluSoftWave
 * @group             : Sample
 * @last modified on  : 07-29-2023
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@namespaceAccessible
public virtual inherited sharing class GetAPIsQueryHandler extends blsw.QueryHandler {

    ////////////////////////////////////
    // Data Members
    ////////////////////////////////////
    private static final String TRACE_MSG               = '++ GetAPIsQuery.endPoint: ';
    private static final String QUERY_API_TAG           = 'GetAPIsQueryHandler';
    private static final String ERROR_QUERY_RESULT_MSG  = '++ GetAPIsQuery Exception Trace:';
    ////////////////////////////////////
    // Ctors
    ////////////////////////////////////
    /**
     * @description GetAPIsQueryHandler (default ctor)
     */
    @namespaceAccessible
    public GetAPIsQueryHandler() {
        super(PublicApisRepository.class,           // Repository Type
              String.class,                         // The "From" Type (what the API returns,JSON String)
              null,                                 // The "To" Type (what we want to convert the string to, if any)
              GetAPIsQueryHandler.QUERY_API_TAG);   // The Performance and Tag Information

    }

    ////////////////////////////////////
    // Public Methods
    ////////////////////////////////////

    /**
     * @description handle GetAPIsQuery
     * @param  query IQuery
     * @return IQueryResult
     */
    public virtual override blsw.IResult handle(blsw.IEntityIdentifier query) {
        // note "query" inherits from "BaseQuery", if needed user information, etc.
        blsw.IQueryResult result = null;
        List<Object> data   = null;

        try {
            //+++++++++++++++++++++++++++++
            // NOTES:
            //
            // Below are 2 different ways to
            // handle the retrieval of data:
            //
            // (1) Take information from the
            //     query data and make an
            //     explicit Http callout
            //
            // (2) Use a Repository "PublicApisRepository"
            //     explicitly for making the callout
            //
            // **Item 2 provides a better separation;
            // however, you have the choice
            //
            //=============================
            // option 1 -- Use the Query information
            // to create a Http callout
            //
            data = this.notUsingTheRepository((blsw.IQuery)query);

            //
            //=============================
            //
            // option 2 -- Use The Repository, "PublicApisRepository.class",
            // that was used in the ctor.
            //
            // data = this.getAllFreeApis(query);

            //
            // Do whatever processing is needed. Take the data from the above query
            // and process it accordingly. This is where you would take the Domain
            // data and use it either to perform some task or update/insert into
            // a Sink.

            // we consider it an error if there is no data (null || empty)
            result = new blsw.QueryResult(data != null && !data.isEmpty(),data, super.typeManager());
        } catch (Exception excp) {
            blsw.ApplicationTracer.systemLog(LoggingLevel.ERROR, GetAPIsQueryHandler.ERROR_QUERY_RESULT_MSG + excp.getStackTraceString());
            result = new blsw.QueryResult(excp);
        }
        return result;
    } // end of handle

    ///////////////////////////////////////
    // Protected Methods
    ///////////////////////////////////////
    /**
     * @description do Not Use Repository (Option 1)
     * @param query blsw.IQuery
     * @return List<Object>
     */
    protected List<Object> notUsingTheRepository(blsw.IQuery query) {
        List<Object> response       = new List<Object>();
        GetAPIsQuery apiQuery       = (GetAPIsQuery)query;
        blsw.HttpUtility callout    = new blsw.HttpUtility(apiQuery.theEndpoint(),apiQuery.httpAction());
        // tracing on?
        if ( blsw.MiscHelpers.tracerOn() ) {
            // if tracing is on, dump the contents;
            blsw.ApplicationTracer.systemLog(GetAPIsQueryHandler.TRACE_MSG + apiQuery.theEndpoint());
        }
        // make the call out
        Boolean status = callout.callOut();
        // was it succesful?
        if ( status ) {
            response.add(callout.getResponseFromRequest());
        } else if ( callout.hasException() ) {
            // rethrow the callout exception; will be caught by caller
            throw callout.httpException();
        }

        // convert to proper type, if any
        return super.mapTo(response);
    } // end of notUsingTheRepository
    /**
     * @description get Free API calls
     *
     *  We will use a Repository passing in the query information
     *  The repo would then execute the call and return back our values. If we are good with the
     *  raw form, send it along; otherwise, we map the results to the return type.
     *
     *  The base class handles much of the cross-cutting concerns. For example,
     *   + The Repository handles the query and the caching ( via Query Builder & Data Manager, resp.)
     *   + Mapping is performed by a Map Translator ( brings in the translator seeded in CMDT)
     *
     * @return  List<Object>
     */
    @TestVisible
    protected List<Object> getAllFreeApis(blsw.IQuery query) {
        GetAPIsQuery apiQuery       = (GetAPIsQuery)query;
        blsw.IRepository repo       = super.repository();
        List<Object> results        = null;

        // tracing on?
        if ( blsw.MiscHelpers.tracerOn() ) {
            // if tracing is on, dump the contents;
            blsw.ApplicationTracer.systemLog(GetAPIsQueryHandler.TRACE_MSG + apiQuery.theEndpoint());
        }
        //get information
        results = repo.get();
        // if exception; rethrow to caller
        if ( repo.hasException() ) {
            throw repo.exceptionOnCRUD();
        }
        // convert to proper type, if any
        return super.mapTo(results);

    } // end of getAllFreeApis
}// end of GetAPIsQueryHandler