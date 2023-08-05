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
 * @description       : Get Data from a EndPoint
 * @author            : BluSoftWave
 * @group             : Sample-Query
 * @last modified on  : 07-27-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/

@namespaceAccessible
public inherited sharing class GetAPIsQuery extends blsw.BaseQuery {
    ///////////////////////////////////
    // Data Members
    ///////////////////////////////////
    // used as a performance tag
    @TestVisible
    private static final String API_QUERY_TAG = 'CQRS-GetAPIsQuery';
    @TestVisible
    private static final String API_CALLOUT = 'https://api.publicapis.org/entries';
    @TestVisible
    private static final String HTTP_ACTION = 'GET';

    // our callout API information
    private blsw.IHttpUtility theHttpComponent  = new blsw.HttpUtility();
    private String theUrl                       = API_CALLOUT;
    private String theHttpAction                = HTTP_ACTION;

    ///////////////////////////////////
    // Ctors
    ///////////////////////////////////
    /**
     * @description Get Data from a EndPoint (default ctor)
     */
    @namespaceAccessible
    public GetAPIsQuery() {
        super(API_QUERY_TAG);
    }

    /**
     * @description Get Data from a Url and Http Action
     * @param  theUrlEndpoint String
     * @param  method         String
     */
    @namespaceAccessible
    public GetAPIsQuery(String theUrlEndpoint,String method) {
        super(API_QUERY_TAG);
        this.theEndpoint(theUrlEndpoint);
        this.httpAction(method);
    }
    /**
     * @description Get Data from a Url and Http Action
     * @param  theUrlEndpoint String
     */
    @namespaceAccessible
    public GetAPIsQuery(String theUrlEndpoint) {
        super(API_QUERY_TAG);
        this.theEndpoint(theUrlEndpoint);
    }

    /**
     * @description Get Data from a Url and Http Action
     * @param  theUrlEndpoint String
     * @param  httpMethod     String
     * @param convertToType Type (The Type to Convert the Results to !)
     */
    @namespaceAccessible
    public GetAPIsQuery(String theUrlEndpoint,String httpMethod,Type convertToType) {
        super(convertToType,API_QUERY_TAG);
        this.theEndpoint(theUrlEndpoint);
        this.httpAction(httpMethod);
    }
    /**
     * @description Get Data from a Url and Http Action
     * @param theUrlEndpoint String
     * @param httpMethod     String
     * @param convertToType  Type (The Type to Convert the Results to !)
     * @param tag String ( performance tag)
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public GetAPIsQuery(String theUrlEndpoint,String httpMethod,Type convertToType, String tag) {
        super(convertToType,tag==null?API_QUERY_TAG:tag);
        this.theEndpoint(theUrlEndpoint);
        this.httpAction(httpMethod);
    }
    ///////////////////////////////////
    // Public Methods
    ///////////////////////////////////

    /**
     * @description the User Endpoint
     * @return  String
     */
    public String theEndpoint() {
        return this.theUrl;
    }
    /**
     * @description the http action
     * @return  String
     */
    public String httpAction() {
        return this.theHttpAction;
    }

    /*+++++++++++++++++++++++++++++++++
     * Setters
     *+++++++++++++++++++++++++++++++++
     */

    /**
     * @description the User Endpoint
     * @param  usrCallApi String
     * @return GetAPIsQuery
     */
    public GetAPIsQuery theEndpoint(String usrCallApi) {
        this.theUrl= String.isEmpty(usrCallApi) ? '' : usrCallApi;
        return this;
    } // end of theEndpoint
      /**
       * @description the http Action
       * @param  action String
       * @return GetAPIsQuery
       */
    public GetAPIsQuery httpAction(String action) {
        this.theHttpAction = action;
        return this;
    } // end of httpAction

    /**
     *+++++++++++++++++++++++++++++++++
     * Misc
     *+++++++++++++++++++++++++++++++++
     */

    /**
     * @description component Type
     * @return  Type
     */
    public override Type componentType() {
        return GetAPIsQuery.class;
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
        String result = super.jsonData(),
               addOn = blsw.ApexConstants.EMPTY_STRING;
        blsw.StringBuilder sb= new blsw.StringBuilder (result);
        // is this added on to?
        if ( result != null && result.length() > 0 ) {
            addOn = blsw.ApexConstants.COMMA;
        }

        // not invoking JSON.deserialize
        return sb.append(addOn)
               .append(blsw.ApplicationDomain.PERF_PARAMS_JSON_TAG + ' : { ')
               .append('  "endPoint"   : "').append (this.theEndpoint()).append('",')
               .append('  "httpAction" : "').append (this.httpAction()).append('" ')
               .append(' } ')
               .toString();
    }  // end of jsonData

}// end of GetAPIsQuery
