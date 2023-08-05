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
 * @description       : Process Service Handler. The services this handler processes
 *                      are found in the "SampleProcessService", which returns the items
 *                      to process via "getServices()"
 * @author            : BluSoftWave
 * @group             : Sample
 * @last modified on  : 07-27-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@namespaceAccessible
public virtual inherited sharing class SampleProcessServiceHandler extends blsw.ServiceHandler {

    ////////////////////////////////////
    // Ctors
    ////////////////////////////////////
    /**
     * @description SampleProcessServiceHandler (default ctor)
     */
    public SampleProcessServiceHandler() {
        super(SampleProcessServiceHandler.class.getName());
        // if you had wanted to convert to a specific type, i.e. "AccountTypeRecordsDTO.class"
        // then comment out the one above and uncomment this one
        // super(Account.class,Account.class,AccountTypeRecordsDTO.class,'SampleProcessServiceHandler');
    }

    /////////////////////////////////////////////
    // Public Methods
    /////////////////////////////////////////////

    /**
     * @description componentType - children SHOULD override the component type
     * @return Type class type
     */
    public virtual override Type componentType() {
        return SampleProcessServiceHandler.class;
    }

}// end of SampleProcessServiceHandler