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
 * @description       : GetAccountByTypeQuery  Test
 * @author            : BluSoftWave
 * @group             : CQRS
 * @last modified on  : 05-31-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@TestVisible
@SuppressWarnings('PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class GetAccountByTypeQueryTest {
    ///////////////////////////////////
    // Data Members
    ///////////////////////////////////
    static final String ENTERPISE_ID = 'Enterprise';

    ///////////////////////////////////
    // Unit Tests
    ///////////////////////////////////

    @isTest
    static void ctorAndMethodWithoutValueTest() {
        // arrange/act
        GetAccountByTypeQuery query = new GetAccountByTypeQuery();
        // assert
        system.assertNotEquals(null, query);
        system.assertEquals (GetAccountByTypeQuery.ACCOUNT_TYPE, query.theUserAccountType());
        system.assertEquals (GetAccountByTypeQuery.class, query.componentType());
    }
    @isTest
    static void ctorAndMethodWithValueTest() {
        // arrange/act
        GetAccountByTypeQuery query = new GetAccountByTypeQuery(ENTERPISE_ID);
        // assert
        system.assertNotEquals(null, query);
        system.assertEquals (ENTERPISE_ID, query.theUserAccountType());
        system.assertEquals (GetAccountByTypeQuery.class, query.componentType());
    }
}// end of GetAccountByTypeQueryTest