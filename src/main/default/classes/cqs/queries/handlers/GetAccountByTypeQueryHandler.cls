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
 * @description       : Get Account By Type Query Handler
 * @author            : BluSoftWave
 * @group             : Sample
 * @last modified on  : 07-28-2023
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/

@namespaceAccessible
public virtual inherited sharing class GetAccountByTypeQueryHandler extends blsw.QueryHandler {

    ////////////////////////////////////
    // Data Members
    ////////////////////////////////////
    private static final String TYPE_FIELD              = 'type';
    private static final String TRACE_MSG               = '++ GetAccountByTypeQuery.theUserAccountType: ';
    private static final String ERROR_QUERY_RESULT_MSG  = '++ GetAccountByTypeQuery Exception Trace:';
    private static final String TAG                     = 'GetAccountByTypeQueryHandler';

    ////////////////////////////////////
    // Ctors
    ////////////////////////////////////
    /**
     * @description GetAccountByTypeQueryHandler (default ctor)
     */
    public GetAccountByTypeQueryHandler() {
        super(AccountExampleRepository.class,Account.class,TAG);
        //
        // if you had wanted to convert to a specific type, i.e. "AccountTypeRecordsDTO.class"
        // then comment out the one above and uncomment this one ...
        //
        // super(Account.class,Account.class,AccountTypeRecordsDTO.class,TAG);
    }

    ////////////////////////////////////
    // Public Methods
    ////////////////////////////////////

    /**
     * @description handle GetAccountByTypeQuery
     * @param  query IQuery
     * @return IQueryResult
     */
    public virtual override blsw.IResult handle(blsw.IEntityIdentifier query) {
        // note "query" inherits from "BaseQuery", if needed user information, etc.
        blsw.IQueryResult result= null;
        list<Object> data       = null;

        try {
            GetAccountByTypeQuery accountTypeQuery = (GetAccountByTypeQuery)query;
            // tracing on?
            if ( blsw.MiscHelpers.tracerOn() ) {
                // if tracing is on, dump the contents;
                blsw.ApplicationTracer.systemLog(TRACE_MSG + accountTypeQuery.theUserAccountType());
            }
            // get information from the repo
            data = this.getFromAccountRepository(accountTypeQuery.theUserAccountType());
            // place the results in container, and supply the type manager, if any
            result = new blsw.QueryResult(data !=null, data, super.typeManager());
        } catch (Exception excp) {
            // send to the system log (explicit)
            blsw.ApplicationTracer.systemLog(LoggingLevel.ERROR, GetAccountByTypeQueryHandler.ERROR_QUERY_RESULT_MSG + excp.getStackTraceString());
            // bad result; pass the exception back to callee
            result = new blsw.QueryResult(excp);
        }
        return result;
    }// end of handle

    /**
     * @description get From Account Repository
     *
     *    We will use the Repository passed in the type or query
     *    The repo would then execute the call and return back our values. If we are good with the
     *    raw form (i.e. Account), send it along; otherwise, we map the results to the return type.
     *
     *    The base class handles much of the cross-cutting concerns. For example,
     *     + The Repository handles the query and the caching ( via Query Builder & Data Manager, resp.)
     *     + Mapping is performed by a Map Translator ( brings in the translator seeded in CMDT)
     *
     * @param  acctTypeValue String
     * @return List<AccountTypeRecordsDTO>
     */
    @TestVisible
    protected List<Object> getFromAccountRepository(String acctTypeValue) {
        List<Object> accts;

        // ensure we have access on the query
        super.repository()
        .queryBuilder()
        .setSystemAccessLevel();

        // if caching is enabled, the repo takes care of it
        // note, not putting in limit -- could if needed.
        // take the results from the repo and find the field we want.
        // NOTE: This could have been placed in a where Condition in the Query!
        accts = super.repository().findByField(TYPE_FIELD, acctTypeValue);

        // convert to proper type, if any
        return super.mapTo(accts);

    }// end of getFromAccountRepository

}// end of GetAccountByTypeQueryHandler