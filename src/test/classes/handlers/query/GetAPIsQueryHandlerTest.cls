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
 * @description       : GetAPIsQuery Handler Test
 * @author            : BluSoftWave
 * @group             : CQRS
 * @last modified on  : 07-27-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@TestVisible
@SuppressWarnings('PMD.ApexAssertionsShouldIncludeMessage')
@isTest(OnInstall=true isParallel=true)
private class GetAPIsQueryHandlerTest {

    //////////////////////////////////
    // Unit Tests
    //////////////////////////////////

    @isTest
    static void ctorTest() {
        // arrange/act/asset
        system.assertNotEquals(null, new GetAPIsQueryHandler());
    }
    @isTest
    static void handleTest() {
        // arrange
        GetAPIsQuery query          = new GetAPIsQuery();
        GetAPIsQueryHandler handler = new GetAPIsQueryHandler();
        // act
        blsw.IQueryResult result         = (blsw.IQueryResult)handler.handle(query);

        /*
         * This query will fell as this is a CALLOUT
         */
        // asset
        system.assertEquals(false, result.success());
        system.assertEquals(true, result.hasException());
        system.assertEquals(0, result.results().size());
    }

    @isTest
    static void getAllFreeApisTest() {
        // arrange
        GetAPIsQuery query          = new GetAPIsQuery();
        GetAPIsQueryHandler handler = new GetAPIsQueryHandler();
        Boolean hasException        = false;
        // act
        try {
            // this calls into the handler directly
            handler.getAllFreeApis(query);
        } catch (Exception excp) {
            hasException=true;
        }
        /*
         * This query will fell as this is a CALLOUT
         */
        // asset
        system.assertEquals(true,hasException);

    }
}// end of GetAPIsQueryHandlerTest
