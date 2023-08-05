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
 * @description       : Test CustomerService Functionality
 * @author            : BluSoftWave
 * @group             : Test [Example]
 * @last modified on  : 06-15-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-02-2023   BluSoftWave   Initial Version
 **/
@SuppressWarnings(',PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class CustomerServiceTest {
    ///////////////////////////////////
    // Data Members
    ///////////////////////////////////

    private static final Integer KNOWN_SERVICES_SIZE                = 3;

    private static final List<blsw.IEntityIdentifier> SPECIFIC_ITEM =new List<blsw.IEntityIdentifier> {
        new AuthenticationCommand('test-uid','test-password')
    };

    ///////////////////////////////////
    // Unit Tests
    ///////////////////////////////////

    @isTest
    static void ctorAndMiscTest(){
        // arrange
        CustomerService service = new CustomerService();

        // act  / assert
        system.assertEquals(CustomerService.class, service.componentType());
        system.assertEquals (null, service.lastServiceResult() );
        system.assertEquals (KNOWN_SERVICES_SIZE, service.getServices().size() );
    }

    @isTest
    static void ctorWithSepcificServiceTest(){
        // arrange
        CustomerService service = new CustomerService(SPECIFIC_ITEM);

        // act  / assert
        system.assertEquals(CustomerService.class, service.componentType());
        system.assertEquals (null, service.lastServiceResult() );
        system.assertEquals (SPECIFIC_ITEM.size(), service.getServices().size() );

    }
}// end of CustomerServiceTest