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
 * @description       : Get Account By Type Query (SAMPLE)
 * @author            : BluSoftWave
 * @group             : Sample-Query
 * @last modified on  : 07-28-2023
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/

@namespaceAccessible
public virtual inherited sharing class GetAccountByTypeQuery extends blsw.BaseQuery {

    ///////////////////////////////////
    // Data Members
    ///////////////////////////////////
    // used as a performance tag
    private static final String ACCOUNT_BY_TYPE_COMMAND_TAG = 'CQRS-GetAccountByTypeQuery ';
    @TestVisible
    private static final String ACCOUNT_TYPE                = 'enterprise';
    // our account type information
    private String accountType;

    ///////////////////////////////////
    // Ctors
    ///////////////////////////////////
    /**
     * @description Get Account By Type Query (default ctor)
     */
    @namespaceAccessible
    public GetAccountByTypeQuery() {
        super(GetAccountByTypeQuery.ACCOUNT_BY_TYPE_COMMAND_TAG);
        this.theUserAccountType(ACCOUNT_TYPE);
    }
    /**
     * @description Get Account By Type Query
     * @param  theAccountType String Account Type
     */
    @namespaceAccessible
    public GetAccountByTypeQuery(String theAccountType) {
        super(GetAccountByTypeQuery.ACCOUNT_BY_TYPE_COMMAND_TAG);
        this.theUserAccountType(theAccountType);
    }
    /**
     * @description Get Account By Type Query
     * @param  theAccountType String Account Type
     * @param  toType Type
     */
    @namespaceAccessible
    public GetAccountByTypeQuery(String theAccountType, Type toType) {
        super(toType,GetAccountByTypeQuery.ACCOUNT_BY_TYPE_COMMAND_TAG);
        this.theUserAccountType(theAccountType);
    }

    ///////////////////////////////////
    // Public Methods
    ///////////////////////////////////
    /**
     * @description the User Account Type
     * @return  Account Type
     */
    public String theUserAccountType() {
        return this.accountType;
    }

    /**
     * @description component Type
     * @return  Type
     */
    public virtual override Type componentType() {
        return GetAccountByTypeQuery.class;
    }
    /**
     * @description json Data of fields
     * @return String
     */
    public override String toString() {
        return this.jsonData();
    }
    /**
     * @description json Data of fields
     * @return String
     */
    public override String jsonData() {
        // include parent data
        String result       = super.jsonData(),
               addOn        = blsw.ApexConstants.EMPTY_STRING;
        blsw.StringBuilder sb= new blsw.StringBuilder (result);

        // is this added on to?
        if ( result != null && result.length() > 0 ) {
            addOn = blsw.ApexConstants.COMMA;
        }
        // not invoking JSON.deserialize
        return sb.append(addOn)
               .append(blsw.ApplicationDomain.PERF_PARAMS_JSON_TAG + ' : { ')
               .append('  "accountType" : "').append (this.theUserAccountType()).append('"')
               .append(' } ')
               .toString();
    } // end of jsonData

    ///////////////////////////////////
    // Protected
    ///////////////////////////////////

    /**
     * @description the User Account Type
     * @param  usrAccountType String
     */
    @TestVisible
    protected void theUserAccountType(String usrAccountType) {
        this.accountType=usrAccountType;
    }
} // end of GetAccountByTypeQuery