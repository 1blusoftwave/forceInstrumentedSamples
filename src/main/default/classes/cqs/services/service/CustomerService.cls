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
 * @description       : [Example] Customer Service
 * @author            : BluSoftWave
 * @group             : Sample
 * @last modified on  : 07-28-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-02-2023   BluSoftWave   Initial Version
 **/
@namespaceAccessible
@SuppressWarnings('sf:ConfusingTernary,PMD.FieldNamingConventions')
public virtual inherited sharing class CustomerService extends blsw.BaseService {

    /////////////////////////////////////
    // Data Members
    /////////////////////////////////////
    private static final String SERVICE_TAG = 'CQRS-CustomerService';

    // last result from calls in service
    private blsw.IResult lastResult         = null;
    // OUR SERVICES
    private List<blsw.IEntityIdentifier> customerServices   = new List<blsw.IEntityIdentifier>();
    /////////////////////////////////////
    // Ctors
    /////////////////////////////////////

    /**
     * @description CustomerService default ctor
     */
    @namespaceAccessible
    public CustomerService() {
        super(SERVICE_TAG);
        // our pre-defined services
        this.initialize();
        // let the base know our count; helps on sequence diagram (w/o, mapping is wrong)
        super.containerCount(this.getServices().size());
    }// end of ctor
    /**
     * @description CustomerService ctor. Where user defines what is in a Customer Service
     * @param  services List<blsw.IEntityIdentifier>
     */
    @namespaceAccessible
    public CustomerService(List<blsw.IEntityIdentifier> services) {
        super(SERVICE_TAG);
        // any services
        if ( services != null && !services.isEmpty() ) {
            this.customerServices.addAll(services);
            // let the base know our count; helps on sequence diagram (w/o, mapping is wrong)
            super.containerCount(this.getServices().size());
        }
    }// end of ctor
    /////////////////////////////////////
    // Public Methods
    /////////////////////////////////////
    /**
     * @description last Service Result
     * @return IResult
     */
    @namespaceAccessible
    public blsw.IResult lastServiceResult() {
        return this.lastResult;
    }// end of lastServiceResult

    /**
     * @description component Type
     * @return  Type
     */
    @namespaceAccessible
    public override Type componentType() {
        return CustomerService.class;
    }// end of componentType
    /**
     * @description get Services ( copy of ). This "handler" (CustomerServiceHandler), will
     *              call this method to determine what items to process in the chain/pipeline.
     *              Order is IMPORTANT! Each item performs a task and can pass information to the
     *              NEXT item in the chain. This is handled for you. All you have to do is set
     *              the items into the "storage" from each of the perspective  handler.
     * @return List<blsw.IEntityIdentifier>
     */
    @namespaceAccessible
    public override List<blsw.IEntityIdentifier> getServices() {
        return this.customerServices;
    }// end of getServices

    ///////////////////////////////////////
    // Protected  Methods
    ///////////////////////////////////////
    /**
     * @description last Service Result
     * @param  result IResult
     */
    @TestVisible
    @namespaceAccessible
    protected void lastServiceResult(blsw.IResult result) {
        this.lastResult=result;
    }// end of lastServiceResult

    /**
     * @description initialize our KNOWN services
     */
    @TestVisible
    @namespaceAccessible
    protected void initialize() {
        //
        // add our commands,queries, services. Each Command/Query/Service below provide  "DATA" to act upon.
        // The handler will look-up each entity below and pass the "DATA" to it.
        // For example, "AuthenticationCommand" represents the "DATA" (or DTO).
        // It MUST have a corresponding handler, "AuthenticationCommandHandler". The
        // handler will ingest the "DATA", i.e. "AuthenticationCommand". In the handler,
        // is where the processing is done (making a callout, or invoking a repo). Once the
        // processing is done, it returns a status of true/false. If there is internal data
        // to pass along, all you would do is add it to the "storage()" method from within
        // the Command/Query/Service handler. "storage()" is in the interface "IEntityIdentifier".
        //
        this.customerServices.addAll(new List<blsw.IEntityIdentifier> {
            new AuthenticationCommand('test-uid','test-password'),
            new GetAccountByTypeQuery('enterprise'),
            new WriteResultCommand('test-id')

        });
    } // end of initialize

}// end of CustomerService